/**
 * 畫在下半部的技術指標 MTM - 動量指標
 */
var AreaXYTechMTM = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'MTM', IN_tech_area_id );
    this._y_horizon = null;
    this._pole_width = null;
    this._scale_format = new DecimalFormat( '#####0.0###' );
};
AreaXYTechMTM.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechMTM.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
            this._y_horizon = this.getYFromValue( 0 );
            this._pole_width = this._mars_k.getCandleWidth();;
        };


    /**
     * 畫出此區
     */
    AreaXYTechMTM.prototype._doPaintForAreaTech =

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
    AreaXYTechMTM.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var p = this.getParams();
            if( this.getParams()['type'] == 'line' )
                this._paintDragon( 'mtm', p['color'], p['lineWidth'], visibleRange, allTicks );
            else // pole
                this._paintBiDirPoles( 'mtm', p['color'], p['color'], this._pole_width, visibleRange, allTicks );
            this._paintDragon( 'mtmMA', p['colorMA'], p['lineWidth'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechMTM.prototype._paintYAxis =

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
     * 3條水平線 - high, 0, low
     */
    AreaXYTechMTM.prototype._paintHorizontals =

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
        };


    /**
     * 全部重算
     */
    AreaXYTechMTM.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            var periodMA = this.getParams()['periodMA'];
            var periodSum = 0;
            for( var index in allTicks ) {
                var element = this.getElement( index );
                if( index >= period ) {
                    element.setValue( 'mtm', allTicks[index].close - allTicks[index-period].close );
                    if( index < period + periodMA ) {
                        periodSum += element.mtm;
                        element.mtmMA = null;
                    }
                    else {
                        element.setValue( 'mtmMA', periodSum/periodMA );
                        periodSum += (element.mtm - this.getElement(index-period).mtm);
                    }
                }
                else {
                    element.setValue( 'mtm', 0 ); // 讓 0 有機會成為上下極限值
                    element.mtm = element.mtmMA = null;
                }
            }
        };

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechMTM.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.mtm )
                rv['MTM'] = { 'value': this._scale_format.format(e.mtm), 'color': this.getParams()['color']};
            if( e.mtmMA )
                rv['MA'] = { 'value': this._scale_format.format(e.mtmMA), 'color': this.getParams()['colorMA']};
            return rv;
        }
