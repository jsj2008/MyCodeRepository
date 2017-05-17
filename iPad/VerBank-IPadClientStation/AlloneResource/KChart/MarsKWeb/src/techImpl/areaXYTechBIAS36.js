/**
 * 畫在下半部的技術指標 3-6 BIAS (三六乖離)
 *
 * http://www.moneydj.com/kmdj/wiki/wikiviewer.aspx?keyid=acfefe17-fea4-4ac0-a8dc-403e23116873
 */
var AreaXYTechBIAS36 = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'BIAS36', IN_tech_area_id );
    this._scale_format = new DecimalFormat( '#####0.0#' );
    this._y_horizon = null;
};
AreaXYTechBIAS36.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechBIAS36.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
            this._y_horizon = this._value_high * this._pixels_per_value + AreaXYTech.prototype.MARGIN_TOP;
        };


    /**
     * 畫出此區
     */
    AreaXYTechBIAS36.prototype._doPaintForAreaTech =

        function( IN_layer) {
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
     * 3條水平線 - high, 0, low
     */
    AreaXYTechBIAS36.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis();
            this._ctx.beginPath();
            this._ctx.moveTo( 0, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.lineTo( x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.moveTo( 0, this._y_horizon );
            this._ctx.lineTo( x, this._y_horizon );
            var y = this._height-AreaXYTech.prototype.MARGIN_BOTTOM;
            this._ctx.moveTo( 0, y );
            this._ctx.lineTo( x, y );
            this._ctx.stroke();
        };


    /**
     * 畫出此區的主要內容
     */
    AreaXYTechBIAS36.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            this._paintDragon( 'bias36', p['color'], p['lineWidth'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };


    /**
     * Y 軸
     */
    AreaXYTechBIAS36.prototype._paintYAxis =

        function() {
            var left = this._mars_k.getTicksAreaWidthExcludeYAxis();
            this._ctx.clearRect( left, 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
            this._ctx.textAlign = AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN;
            this._ctx.textBaseline = "middle";
            this._ctx.fillStyle = this._y_axis_fill_style_text_scale;
            this._ctx.font = AreaXYTech.prototype.Y_AXIS_FONT_SCALE;
            var x = left + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.fillText( this._scale_format.format(this._value_high), x, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.fillText( '0', x, this._y_horizon );
            this._ctx.fillText( this._scale_format.format(this._value_low), x, this._height-AreaXYTech.prototype.MARGIN_BOTTOM );
        };

    /**
     * 全部重算
     */
    AreaXYTechBIAS36.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var periodShort = 3;
            var periodLong = 6;
            var sumShort = 0;
            var sumLong = 0;
            for( var i in allTicks ) {
                var element = this.getElement( i );
                element.bias36 = null;
                sumShort += allTicks[i].close;
                sumLong += allTicks[i].close;
                if( i >= periodShort ) {
                    sumShort -= allTicks[i - periodShort].close;
                    if( i >= periodLong ) {
                        sumLong -= allTicks[i - periodLong].close;
                        element.setValue( 'bias36', sumShort/periodShort - sumLong/periodLong );
                    }
                }
            }
        };

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechBIAS36.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.bias36 )
                rv[''] = { 'value': this._scale_format.format(e.bias36), 'color': this.getParams()['color']};
            return rv;
        }
