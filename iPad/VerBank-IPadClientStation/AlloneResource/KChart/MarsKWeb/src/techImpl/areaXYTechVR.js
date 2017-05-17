/**
 * 畫在下半部的技術指標 VR - 容量指標
 *
 * http://www.pmf.com.tw/newversion/prodclass/researchreport_14_c.php?ShowType=3
 */
var AreaXYTechVR = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'VR', IN_tech_area_id );
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechVR.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechVR.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
        };


    /**
     * 畫出此區
     */
    AreaXYTechVR.prototype._doPaintForAreaTech =

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
    AreaXYTechVR.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );
            this._paintDragon( 'vr', this.getParams()['color'], this.getParams()['lineWidth'], visibleRange, allTicks );
            this._paintDragon( 'vrMA', this.getParams()['colorMA'], this.getParams()['lineWidthMA'], visibleRange, allTicks );
            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸刻度
     */
    AreaXYTechVR.prototype._paintYAxis =

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
     * 2條水平線 - high, low
     */
    AreaXYTechVR.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.beginPath();
            this._ctx.moveTo( 0, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.lineTo( x, AreaXYTech.prototype.MARGIN_TOP );
            var y = this._height - AreaXYTech.prototype.MARGIN_BOTTOM;
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            this._ctx.stroke();
        };


    /**
     * 全部重算
     */
    AreaXYTechVR.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            if( allTicks.length < 2 )
                return;
            var period = this.getParams()['period'];
            var periodMA = this.getParams()['periodMA'];
            var sumRaising = 0, sumShedding = 0, sumUnchanged = 0;
            var sumVR = 0;
            for( var i in allTicks ) {
                var element = this.getElement( i );
                if( i >= period ) {
                    element.setValue( 'vr', 100 * (sumRaising+sumUnchanged/2) / (sumShedding+sumUnchanged/2) );

                    if( i >= period+periodMA ) {
                        element.setValue( 'vrMA', sumVR / periodMA );
                        sumVR -= this.getElement(i - periodMA).vr;
                    }
                    else
                        element.vrMA = null;
                    sumVR += element.vr;

                    var tick0 = allTicks[i - period];
                    if( tick0.close > tick0.open ) // 漲
                        sumRaising -= tick0.volume;
                    else if( tick0.close < tick0.open ) // 跌
                        sumShedding -= tick0.volume;
                    else // 平
                        sumUnchanged -= tick0.volume;
                }
                else
                    element.vr = element.vrMA = null;

                var tick = allTicks[i];
                if( tick.close > tick.open ) // 漲
                    sumRaising += tick.volume;
                else if( tick.close < tick.open ) // 跌
                    sumShedding += tick.volume;
                else // 平
                    sumUnchanged += tick.volume;
            }
        };


    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechVR.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.vr )
                rv['VR'] = { 'value': this._scale_format.format(e.vr), 'color': this.getParams()['color']};
            if( e.vrMA )
                rv['MA'] = { 'value': this._scale_format.format(e.vrMA), 'color': this.getParams()['colorMA']};
            return rv;
        }
