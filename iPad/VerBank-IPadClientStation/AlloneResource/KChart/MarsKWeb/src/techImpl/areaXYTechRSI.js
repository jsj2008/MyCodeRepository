/**
 * 畫在下半部的技術指標 RSI - 相對強弱指標
 */
var AreaXYTechRSI = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'RSI', IN_tech_area_id );
    this._scale_format = new DecimalFormat( '#####0.0#' );
};
AreaXYTechRSI.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechRSI.prototype._doPrepareDataForPaint =

        function() {
            this._value_high = 100;
            this._value_low = 0;
            this._pixels_per_value = this._getYRatio();
        };


    /**
     * 畫出此區
     */
    AreaXYTechRSI.prototype._doPaintForAreaTech =

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
    AreaXYTechRSI.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            this._paintDragon( 'rsiShort', p['colorShort'], p['lineWidthShort'], visibleRange, allTicks );
            this._paintDragon( 'rsiLong', p['colorLong'], p['lineWidthLong'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechRSI.prototype._paintYAxis =

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
    AreaXYTechRSI.prototype._paintHorizontals =

        function() {
            this._ctx.lineWidth = 1;
            this._ctx.strokeStyle = this.getGridColor();
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
            this._ctx.beginPath();
            this._ctx.moveTo( 0, AreaXYTech.prototype.MARGIN_TOP );
            this._ctx.lineTo( x, AreaXYTech.prototype.MARGIN_TOP );
            var y50 = this.getYFromValue(50);
            this._ctx.moveTo( 0, y50 );
            this._ctx.lineTo( x, y50 );
            var y0 = this._height - AreaXYTech.prototype.MARGIN_BOTTOM;
            this._ctx.moveTo( 0, y0 );
            this._ctx.lineTo( x, y0 );
            this._ctx.stroke();
        };


    /**
     * 全部重算
     */
    AreaXYTechRSI.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            if( allTicks.length < 2 )
                return;
            var periodShort = this.getParams()['periodShort'];
            var periodLong = this.getParams()['periodLong'];
            var sumRisingShort = 0;
            var sumRisingLong = 0;
            var sumFallingShort = 0;
            var sumFallingLong = 0;
            var element = this.getElement(0);
            element.rsiShort = element.rsiLong = null;
            element.diffRising = element.diffFalling = 0;
            for( var i=1; i<allTicks.length; ++i ) {
                element = this.getElement( i );
                var diff = allTicks[i].close - allTicks[i-1].close;
                element.diffRising = diff>0? diff : 0;
                element.diffFalling = diff<0? -diff : 0;
                sumRisingShort += element.diffRising;
                sumFallingShort += element.diffFalling;
                sumRisingLong += element.diffRising;
                sumFallingLong += element.diffFalling;
                if( i >= periodShort ) {
                    sumRisingShort -= this.getElement(i - periodShort).diffRising;
                    sumFallingShort -= this.getElement(i - periodShort).diffFalling;
                    if( i >= periodLong ) {
                        sumRisingLong -= this.getElement(i - periodLong).diffRising;
                        sumFallingLong -= this.getElement(i - periodLong).diffFalling;
                    }
                }
                var pShort = i<periodShort? i+1 : periodShort;
                var pLong = i<periodLong? i+1 : periodLong;
                var avgRisingShort = sumRisingShort / pShort;
                var avgFallingShort = sumFallingShort / pShort;
                var avgRisingLong = sumRisingLong / pLong;
                var avgFallingLong = sumFallingLong / pLong;
                element.rsiShort = 100 * avgRisingShort / (avgRisingShort+avgFallingShort);
                element.rsiLong = 100 * avgRisingLong / (avgRisingLong+avgFallingLong);
            }
        };

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechRSI.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.rsiShort )
                rv['short'] = { 'value': this._scale_format.format(e.rsiShort), 'color': this.getParams()['colorShort']};
            if( e.rsiLong )
                rv['long'] = { 'value': this._scale_format.format(e.rsiLong), 'color': this.getParams()['colorLong']};
            return rv;
        }
