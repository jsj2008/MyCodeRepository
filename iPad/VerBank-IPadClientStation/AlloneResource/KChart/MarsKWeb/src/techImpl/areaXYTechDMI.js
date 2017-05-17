/**
 * 畫在下半部的技術指標 DMI - 動向指標
 */
var AreaXYTechDMI = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'DMI', IN_tech_area_id );
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechDMI.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechDMI.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
        };


    /**
     * 畫出此區
     */
    AreaXYTechDMI.prototype._doPaintForAreaTech =

        function( IN_layer ) {
            switch (IN_layer) {
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
                    this._paintHorizontals();
                    break;
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:
                    this._paintContent();
                    break;
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS:
                    this._paintFocus( this._scale_format );
                    break;
            }
        };


    /**
     * 畫出此區的主要內容
     */
    AreaXYTechDMI.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            this._paintDragon( 'dip', p['colorDmiPositive'], p['lineWidthDmiPositive'], visibleRange, allTicks );
            this._paintDragon( 'din', p['colorDmiNegative'], p['lineWidthDmiNegative'], visibleRange, allTicks );
            this._paintDragon( 'adx', p['colorADX'], p['lineWidthADX'], visibleRange, allTicks );
            this._paintDragon( 'adxr', p['colorADXR'], p['lineWidthADXR'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechDMI.prototype._paintYAxis =

        function() {
            var left = this._mars_k.getTicksAreaWidthExcludeYAxis();
            this._ctx.clearRect( left, 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
            this._ctx.textAlign = AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN;
            this._ctx.textBaseline = "middle";
            this._ctx.fillStyle = this._y_axis_fill_style_text_scale;
            this._ctx.font = AreaXYTech.prototype.Y_AXIS_FONT_SCALE;
            var x = left + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.fillText( this._scale_format.format(this._value_high), x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.fillText( this._scale_format.format(this._value_low), x, this._height-AreaXYTech.prototype.MARGIN_BOTTOM );
        };

    /**
     * 條水平線 - high, low
     */
    AreaXYTechDMI.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.beginPath();
            var y = this.getYFromValue( this._value_high );
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            y = this.getYFromValue( this._value_low );
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            this._ctx.stroke();
        };


    /**
     * 全部重算
     */
    AreaXYTechDMI.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            if( allTicks.length == 0 )
                return;

            var element = this.getElement( 0 );
            element.tr = allTicks[0].high - allTicks[0].low;
            element.dmp = element.dmn = element.dx = 0;
            element.dip = element.din = element.adx = element.dxr = null;

            var period = this.getParams()['period'];
            var sumTr=0, sumDmp=0, sumDmn=0, sumDx=0, sumAdx=0;
            for( var i=1; i<allTicks.length; ++i ) {
                element = this.getElement( i );
                var prevTick = allTicks[i-1];
                var tick = allTicks[i];
                element.dx = 0;
                element.adx = 0;
                element.tr = Math.max(tick.high, prevTick.close) - Math.min(tick.low, prevTick.close);
                element.dmp = tick.high - prevTick.high;
                element.dmn = prevTick.low - tick.low;
                element.dmp = element.dmp>0 && element.dmp>element.dmn? element.dmp : 0;
                element.dmn = element.dmn>0 && element.dmn>element.dmp? element.dmn : 0;
                sumTr += element.tr;
                sumDmp += element.dmp;
                sumDmn += element.dmn;
                if( i < period ) {
                    element.dip = element.din = element.adx = element.adxr = null;
                    continue;
                }
                var eleBeyondPeriod = this.getElement( i - period );
                sumTr -= eleBeyondPeriod.tr;
                sumDmp -= eleBeyondPeriod.dmp;
                sumDmn -= eleBeyondPeriod.dmn;
                var dip = 100 * (sumDmp / period) / (sumTr / period);
                var din = 100 * (sumDmn / period) / (sumTr / period);
                if( dip < 0 )
                    dip = 0;
                if( din < 0 )
                    din = 0;
                element.setValue( 'dip', dip );
                element.setValue( 'din', din );

                element.dx = 100 * Math.abs(element.dip - element.din) / (element.dip + element.din);
                sumDx += element.dx;
                if( i < period*2 ) {
                    element.adx = element.adxr = null;
                    continue;
                }
                sumDx -= eleBeyondPeriod.dx;
                element.setValue( 'adx', sumDx / period );

                sumAdx += element.adx;
                if( i < period*3 ) {
                    element.adxr = null;
                    continue;
                }
                sumAdx -= eleBeyondPeriod.adx;
                element.setValue( 'adxr', sumAdx / period );
            }
        };


    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechDMI.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.dip )
                rv['DMI+'] = { 'value': this._scale_format.format(e.dip), 'color': this.getParams()['colorDmiPositive']};
            if( e.din )
                rv['DMI-'] = { 'value': this._scale_format.format(e.din), 'color': this.getParams()['colorDmiNegative']};
            if( e.adx )
                rv['ADX'] = { 'value': this._scale_format.format(e.adx), 'color': this.getParams()['colorADX']};
            if( e.adxr )
                rv['ADXR'] = { 'value': this._scale_format.format(e.adxr), 'color': this.getParams()['colorADXR']};
            return rv;
        }
