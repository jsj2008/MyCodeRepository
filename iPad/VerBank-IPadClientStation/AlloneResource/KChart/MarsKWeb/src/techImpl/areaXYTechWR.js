/**
 * 畫在下半部的技術指標 WR - 威廉指標
 */
var AreaXYTechWR = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'WR', IN_tech_area_id );
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechWR.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechWR.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
        };


    /**
     * 畫出此區
     */
    AreaXYTechWR.prototype._doPaintForAreaTech =

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
    AreaXYTechWR.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            this._paintDragon( 'wr', p['color'], p['lineWidth'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechWR.prototype._paintYAxis =

        function() {
            var left = this._mars_k.getTicksAreaWidthExcludeYAxis();
            this._ctx.clearRect( left, 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
            this._ctx.textAlign = AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN;
            this._ctx.textBaseline = "middle";
            this._ctx.fillStyle = this._y_axis_fill_style_text_scale;
            this._ctx.font = AreaXYTech.prototype.Y_AXIS_FONT_SCALE;
            var x = left + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.fillText( this._scale_format.format(this._value_high), x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.fillText( this._scale_format.format(50), x, this.getYFromValue(50) );
            this._ctx.fillText( this._scale_format.format(this._value_low), x, this._height-AreaXYTech.prototype.MARGIN_BOTTOM );
        };

    /**
     * 5條水平線 - high, 80, 50, 20, low
     */
    AreaXYTechWR.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.beginPath();
            this._ctx.moveTo( 0, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.lineTo( x, AreaXYTech.prototype.MARGIN_TOP );
            var y = this.getYFromValue( 50 );
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            y = this._height - AreaXYTech.prototype.MARGIN_BOTTOM;
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            this._ctx.stroke();
        };


    /**
     * 全部重算
     */
    AreaXYTechWR.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            for( var index in allTicks )
                if( index >= period-1 ) {
                    var periodLow = Number.POSITIVE_INFINITY;
                    var periodHigh = Number.NEGATIVE_INFINITY;
                    for( var i=index-period+1; i<=index; ++i ) {
                        if( allTicks[i].low < periodLow )
                            periodLow = allTicks[i].low;
                        if( allTicks[i].high > periodHigh )
                            periodHigh = allTicks[i].high;
                    }
                    this.getElement(index).setValue( 'wr', 100 * (periodHigh - allTicks[index].close) / (periodHigh - periodLow) );
                }
                else
                    this.getElement(index).wr = null;
        };


    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechWR.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.wr )
                rv[''] = { 'value': this._scale_format.format(e.wr), 'color': this.getParams()['color']};
            return rv;
        }
