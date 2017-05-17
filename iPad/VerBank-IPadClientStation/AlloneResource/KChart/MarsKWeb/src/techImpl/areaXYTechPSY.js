/**
 * 畫在下半部的技術指標 PSY - 心理線
 *
 */
var AreaXYTechPSY = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'PSY', IN_tech_area_id );
    this._y_horizon = null;
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechPSY.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechPSY.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
            this._y_horizon = this.getYFromValue( 50 );
        };


    /**
     * 畫出此區
     */
    AreaXYTechPSY.prototype._doPaintForAreaTech =

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
    AreaXYTechPSY.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );
            this._paintDragon( 'psy', this.getParams()['color'], this.getParams()['lineWidth'], visibleRange, allTicks );
            this._paintDragon( 'psyMA', this.getParams()['colorMA'], this.getParams()['lineWidthMA'], visibleRange, allTicks );
            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸刻度
     */
    AreaXYTechPSY.prototype._paintYAxis =

        function() {
            var left = this._mars_k.getTicksAreaWidthExcludeYAxis();
            this._ctx.clearRect( left, 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
            this._ctx.textAlign = AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN;
            this._ctx.textBaseline = "middle";
            this._ctx.fillStyle = this._y_axis_fill_style_text_scale;
            this._ctx.font = AreaXYTech.prototype.Y_AXIS_FONT_SCALE;
            var x = left + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.fillText( this._scale_format.format(this._value_high), x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.fillText( this._scale_format.format(50), x, this._y_horizon );
            this._ctx.fillText( this._scale_format.format(this._value_low), x, this._height-AreaXYTech.prototype.MARGIN_BOTTOM );
        };

    /**
     * 3條水平線 - high, 0, low
     */
    AreaXYTechPSY.prototype._paintHorizontals =

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
    AreaXYTechPSY.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            var periodMA = this.getParams()['periodMA'];
            var nRaising = 0;
            var periodSum = 0;
            for( var i in allTicks ) {
                var element = this.getElement( i );
                if( i >= period ) {
                    element.setValue( 'psy', 100*nRaising/period );
                    var tick = allTicks[i - period];
                    if( tick.close > tick.open ) // 漲
                        -- nRaising;
                    if( i < period + periodMA ) {
                        periodSum += element.psy;
                        element.psyMa = null;
                    }
                    else {
                        element.setValue( 'psyMA', periodSum/periodMA );
                        periodSum += (element.psy - this.getElement(i-period).psy);
                    }
                }
                else
                    element.psy = element.psyMA = null;
                if( allTicks[i].close > allTicks[i].open ) // 漲
                    ++ nRaising;
            }
        };

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechPSY.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.psy )
                rv['PSY'] = { 'value': this._scale_format.format(e.psy), 'color': this.getParams()['color']};
            if( e.psyMA )
                rv['MA'] = { 'value': this._scale_format.format(e.psyMA), 'color': this.getParams()['colorMA']};
            return rv;
        }
