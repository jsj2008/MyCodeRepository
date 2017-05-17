/**
 * 畫在下半部的技術指標 OBV - 能量潮
 *
 * http://www.pmf.com.tw/newversion/prodclass/researchreport_14_b.php?ShowType=3
 */
var AreaXYTechOBV = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'OBV', IN_tech_area_id );
    this._y_horizon = null;
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechOBV.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechOBV.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
            this._y_horizon = this.getYFromValue( 0 );
        };


    /**
     * 畫出此區
     */
    AreaXYTechOBV.prototype._doPaintForAreaTech =

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
    AreaXYTechOBV.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );
            this._paintDragon( 'obv', this.getParams()['color'], this.getParams()['lineWidth'], visibleRange, allTicks );
            this._paintDragon( 'obvMA', this.getParams()['colorMA'], this.getParams()['lineWidthMA'], visibleRange, allTicks );
            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸刻度
     */
    AreaXYTechOBV.prototype._paintYAxis =

        function() {
            var left = this._mars_k.getTicksAreaWidthExcludeYAxis();
            this._ctx.clearRect( left, 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
            this._ctx.textAlign = AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN;
            this._ctx.textBaseline = "middle";
            this._ctx.fillStyle = this._y_axis_fill_style_text_scale;
            this._ctx.font = AreaXYTech.prototype.Y_AXIS_FONT_SCALE;
            var x = left + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.fillText( this._scale_format.format(this._value_high), x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.fillText( this._scale_format.format(0), x, this._y_horizon );
            this._ctx.fillText( this._scale_format.format(this._value_low), x, this._height-AreaXYTech.prototype.MARGIN_BOTTOM );
        };

    /**
     * 3條水平線 - high, 0, low
     */
    AreaXYTechOBV.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.beginPath();
            this._ctx.moveTo( 0, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.lineTo( x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.moveTo( 0, this._y_horizon );
            this._ctx.lineTo( x, this._y_horizon );
            var y = this._height - AreaXYTech.prototype.MARGIN_BOTTOM;
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            this._ctx.stroke();
        };


    /**
     * 全部重算
     */
    AreaXYTechOBV.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            if( allTicks.length < 2 )
                return;
            var period = this.getParams()['period'];
            var periodMA = this.getParams()['periodMA'];
            var sumVolume = 0, sumObv = 0;
            var element = this.getElement(0);
            element.vol = 0;
            element.obv = 0;
            for( var i=1; i<allTicks.length; ++i ) {
                element = this.getElement( i );
                element.vol = allTicks[i].close > allTicks[i-1].close? allTicks[i].volume : -allTicks[i].volume;
                sumVolume += element.vol;
                if( i >= period )
                    sumVolume -= this.getElement(i - period).vol;
                element.setValue( 'obv', sumVolume );
                sumObv += element.obv;
                if( i >= periodMA )
                    sumObv -= this.getElement(i - periodMA).obv;
                var p = i<periodMA? i+1 : periodMA;
                element.setValue( 'obvMA', sumObv/p );
            }
        };

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechOBV.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.obv )
                rv['OBV'] = { 'value': this._scale_format.format(e.obv), 'color': this.getParams()['color']};
            if( e.obvMA )
                rv['MA'] = { 'value': this._scale_format.format(e.obvMA), 'color': this.getParams()['colorMA']};
            return rv;
        }
