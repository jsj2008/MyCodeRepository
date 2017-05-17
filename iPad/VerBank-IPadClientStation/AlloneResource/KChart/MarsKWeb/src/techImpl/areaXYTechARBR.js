/**
 * 畫在下半部的技術指標 ARBR - 人氣意願指標
 *
 * http://baike.baidu.com/view/977790.htm
 */
var AreaXYTechARBR = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'ARBR', IN_tech_area_id );
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechARBR.prototype = new AreaXYTech();
AreaXYTechARBR.MAX_ABS_AR = 300; // in case the denominator is approaching zero.. we regulate the extreme results
AreaXYTechARBR.MAX_ABS_BR = 800;


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechARBR.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
        };


    /**
     * 畫出此區
     */
    AreaXYTechARBR.prototype._doPaintForAreaTech =

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
    AreaXYTechARBR.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            this._paintDragon( 'ar', p['colorAR'], p['lineWidthAR'], visibleRange, allTicks );
            this._paintDragon( 'br', p['colorBR'], p['lineWidthBR'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechARBR.prototype._paintYAxis =

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
    AreaXYTechARBR.prototype._paintHorizontals =

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
    AreaXYTechARBR.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            var periodSumHO = 0; // high - open
            var periodSumOL = 0; // open - low
            var periodSumHPC = 0; // high - prev close
            var periodSumPCL = 0; // prev close - low
            for( var i=1; i<allTicks.length; ++i ) {
                var element = this.getElement( i );
                periodSumHO += allTicks[i].high - allTicks[i].open;
                periodSumOL += allTicks[i].open - allTicks[i].low;
                periodSumHPC += allTicks[i].high - allTicks[i-1].close;
                periodSumPCL += allTicks[i-1].close - allTicks[i].low;
                if( i > period ) {
                    periodSumHO -= allTicks[i-period].high - allTicks[i-period].open;
                    periodSumOL -= allTicks[i-period].open - allTicks[i-period].low;
                    periodSumHPC -= allTicks[i-period].high - allTicks[i-period-1].close;
                    periodSumPCL -= allTicks[i-period-1].close - allTicks[i-period].low;
                }
                if( i >= period ) {
                    var ar = 100 * periodSumHO / periodSumOL;
                    var br = 100 * periodSumHPC / periodSumPCL;
                    if( Math.abs(ar) > AreaXYTechARBR.MAX_ABS_AR )
                        ar = ar>0? AreaXYTechARBR.MAX_ABS_AR : -AreaXYTechARBR.MAX_ABS_AR;
                    if( Math.abs(br) > AreaXYTechARBR.MAX_ABS_BR )
                        br = br>0? AreaXYTechARBR.MAX_ABS_BR : -AreaXYTechARBR.MAX_ABS_BR;
                    element.setValue( 'ar', ar );
                    element.setValue( 'br', br );
                }
                else
                    element.ar = element.br = null;
            }
        };

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechARBR.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.ar )
                rv.AR = { 'value': this._scale_format.format(e.ar), 'color': this.getParams()['colorAR']};
            if( e.br )
                rv.BR = { 'value': this._scale_format.format(e.br), 'color': this.getParams()['colorBR']};
            return rv;
        }
