/**
 * 畫在下半部的技術指標 KDJ - 隨機指標
 */
var AreaXYTechKDJ = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'KDJ', IN_tech_area_id );
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechKDJ.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechKDJ.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
        };


    /**
     * 畫出此區
     */
    AreaXYTechKDJ.prototype._doPaintForAreaTech =

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
    AreaXYTechKDJ.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            this._paintDragon( 'k', p['colorK'], p['lineWidthK'], visibleRange, allTicks );
            this._paintDragon( 'd', p['colorD'], p['lineWidthD'], visibleRange, allTicks );
            this._paintDragon( 'j', p['colorJ'], p['lineWidthJ'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechKDJ.prototype._paintYAxis =

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
     * 3條水平線 - high, 50, low
     */
    AreaXYTechKDJ.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.beginPath();
            var y = this.getYFromValue( this._value_high );
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            y = this.getYFromValue( 50 );
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
    AreaXYTechKDJ.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            for( var index in allTicks ) {
                var element = this.getElement( index );
                if( index >= period-1 ) {
                    var periodLow = Number.POSITIVE_INFINITY;
                    var periodHigh = Number.NEGATIVE_INFINITY;
                    for( var j=index-period+1; j<index; ++j ) {
                        if( allTicks[j].low < periodLow )
                            periodLow = allTicks[j].low;
                        if( allTicks[j].high > periodHigh )
                            periodHigh = allTicks[j].high;
                    }
                    // rsv value between 1, 100
                    var rsv = periodHigh===periodLow? 100 :
                        allTicks[index].close===periodLow? 1 :
                        100 * (allTicks[index].close - periodLow) / (periodHigh - periodLow);
                    var prevElement = this.getElement( index - 1 );
                    element.setValue( 'k', rsv * 1/3 + prevElement.k * 2/3 );
                    element.setValue( 'd', element.k * 1/3 + prevElement.d * 2/3 );
                    element.setValue( 'j', 3*element.d - 2*element.k );
                }
                else
                    element.k = element.d = element.j = 50;
            }
        };


    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechKDJ.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.k )
                rv['K'] = { 'value': this._scale_format.format(e.k), 'color': this.getParams()['colorK']};
            if( e.d )
                rv['D'] = { 'value': this._scale_format.format(e.d), 'color': this.getParams()['colorD']};
            if( e.j )
                rv['J'] = { 'value': this._scale_format.format(e.j), 'color': this.getParams()['colorJ']};
            return rv;
        }
