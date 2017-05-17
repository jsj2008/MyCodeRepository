/**
 * 畫在下半部的技術指標 CCI - 順勢指標
 */
var AreaXYTechCCI = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'CCI', IN_tech_area_id );
    this._y_horizon = null;
    this._pole_width = null;
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechCCI.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechCCI.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
            this._y_horizon = this.getYFromValue( 0 );
            this._pole_width = this._mars_k.getCandleWidth();;
        };


    /**
     * 畫出此區
     */
    AreaXYTechCCI.prototype._doPaintForAreaTech =

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
    AreaXYTechCCI.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            if( this.getParams()['type'] == 'line' )
                this._paintDragon( 'cci', p['color'], p['lineWidth'], visibleRange, allTicks );
            else // pole
                this._paintBiDirPoles( 'cci', p['color'], p['color'], this._pole_width, visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechCCI.prototype._paintYAxis =

        function() {
            var left = this._mars_k.getTicksAreaWidthExcludeYAxis();
            this._ctx.clearRect( left, 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
            this._ctx.textAlign = AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN;
            this._ctx.textBaseline = "middle";
            this._ctx.fillStyle = this._y_axis_fill_style_text_scale;
            this._ctx.font = AreaXYTech.prototype.Y_AXIS_FONT_SCALE;
            var x = left + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.fillText( this._scale_format.format(this._value_high), x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.fillText( this._scale_format.format(0), x, this.getYFromValue(0) );
            this._ctx.fillText( this._scale_format.format(this._value_low), x, this._height-AreaXYTech.prototype.MARGIN_BOTTOM );
        };

    /**
     * 5條水平線 - high, 100, 0, -100, low
     */
    AreaXYTechCCI.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.beginPath();
            this._ctx.moveTo( 0, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.lineTo( x, AreaXYTech.prototype.MARGIN_TOP );
            var y = this.getYFromValue( 0 );
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            y = this._height - AreaXYTech.prototype.MARGIN_BOTTOM;
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            this._ctx.stroke();

            this._ctx.strokeStyle = MarsKUtility.prototype.getContrastiveColor( this.getParams()['color'], 0.38 );
            this._ctx.beginPath();
            y = this.getYFromValue( 100 );
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            y = this.getYFromValue( -100 );
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            this._ctx.stroke();
        };


    /**
     * 全部重算
     */
    AreaXYTechCCI.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            var sumTp = 0;
            for( var index in allTicks ) {
                var tick = allTicks[index];
                var element = this.getElement( index );
                element.tp = (tick.high + tick.low + tick.close) / 3;
                sumTp += element.tp;
                if( index >= period-1 ) {
                    var tpAvg = sumTp / period;
                    sumTp -= this.getElement(index-period+1).tp;
                    var sumDiff = 0;
                    for( var j=index-period+1; j<=index; ++j )
                        sumDiff += Math.abs(this.getElement(j).tp - tpAvg);
                    var md = sumDiff / period;
                    element.setValue('horizon', 0);
                    element.setValue('cci', (element.tp - tpAvg) / (0.015 * md));
                }
                else
                    element.cci = null;
            }
        };

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechCCI.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.cci )
                rv[''] = { 'value': this._scale_format.format(e.cci), 'color': this.getParams()['color']};
            return rv;
        }
