/**
 * 畫在下半部的技術指標 AO - 動量震動指標
 */
var AreaXYTechAO = function( IN_mars_k, IN_tech_area_id )
{
    this._initAreaTech( IN_mars_k, 'AO', IN_tech_area_id );
    this._y_horizon = null;
    this._pole_width = null;
    this._scale_format = new DecimalFormat( '0.0####' );
};
AreaXYTechAO.prototype = new AreaXYTech();


    /**
     * 前置工作 of _doPaintForAreaTech
     */
    AreaXYTechAO.prototype._doPrepareDataForPaint =

        function() {
            this._determineVisibleRangeHighLow();
            this._y_horizon = this.getYFromValue( 0 );
            this._pole_width = this._mars_k.getCandleWidth();;
        };


    /**
     * 畫出此區
     */
    AreaXYTechAO.prototype._doPaintForAreaTech =

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
    AreaXYTechAO.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );

            var params = this.getParams();
            var i = visibleRange.begin;
            while( i<visibleRange.end && this.getElement(i)['ao']==null )
                ++i;
            var prevAo = Number.NEGATIVE_INFINITY;
            while( i < visibleRange.end ) {
                var value = this.getElement(i)['ao'];
                var y = this.getYFromValue( value );
                this._ctx.fillStyle = params[ value>prevAo? 'colorIncrease' : 'colorDecrease' ];
                if( y > this._y_horizon )
                    this._ctx.fillRect( allTicks[i].cx-this._pole_width/2, y, this._pole_width, this._y_horizon-y );
                else
                    this._ctx.fillRect( allTicks[i].cx-this._pole_width/2, this._y_horizon, this._pole_width, y-this._y_horizon );
                prevAo = value;
                ++i;
            }

            this._ctx.translate( visibleAreaLeft, 0 );
            this._paintYAxis();
        };

    /**
     * Y 軸
     */
    AreaXYTechAO.prototype._paintYAxis =

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
    AreaXYTechAO.prototype._paintHorizontals =

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
    AreaXYTechAO.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var periodShort = this.getParams()['periodShort'];
            var periodLong = this.getParams()['periodLong'];
            var sumShort = 0;
            var sumLong = 0;
            for( var i in allTicks ) {
                var tick = allTicks[i];
                var element = this.getElement( i );
                element.mid = (tick.high + tick.low) / 2;
                sumShort += element.mid;
                sumLong += element.mid;
                element.ao = null;
                if( i >= periodShort ) {
                    sumShort -= this.getElement(i - periodShort).mid;
                    if( i >= periodLong ) {
                        sumLong -= this.getElement( i - periodLong).mid;
                        element.setValue( 'horizon', 0 );
                        element.setValue( 'ao', sumShort/periodShort - sumLong/periodLong );
                    }
                }
            }
        };


    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechAO.prototype._getPaintValues =

        function( IN_tick_index) {
            var e = this.getElement(IN_tick_index);
            if( ! e )
                return null;
            var rv = {};
            if( e.ao )
                rv[''] = { 'value': this._scale_format.format(e.ao), 'color': this.getParams()['color']};
            return rv;
        }
