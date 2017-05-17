/**
 * 畫在 tick 區的移動平均線 (Moving Average)
 */
var AreaXYTechTicksMA = function( IN_mars_k, IN_tech_area_id)
{
    this._initAreaTechTicks( IN_mars_k, 'MA', IN_tech_area_id);
};
AreaXYTechTicksMA.prototype = new AreaTechTicks();


    /**
     * 畫出此區
     */
    AreaXYTechTicksMA.prototype._doPaintForAreaTech =
            
        function( IN_layer) {
            switch (IN_layer) {
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
                    break;
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:
                    this._paintContent();
                    break;
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD:
                    break;
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS:
                    break;
            }
                    
        };


    /**
     * 畫出此區的主要內容
     */
    AreaXYTechTicksMA.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();

            this._ctx.translate( -visibleAreaLeft, 0 );
            var params = this.getParams();
            this._paintDragon( 'ma', params['color'], params['lineWidth'], visibleRange, allTicks );
            this._ctx.translate( visibleAreaLeft, 0 );
        };


    AreaXYTechTicksMA.prototype._getPaintValues =
            
        function( IN_tick_index)
        {
            var L_element = this.getElement( IN_tick_index);
            if (! L_element) {
                return null;
            }
            
            var L_value_of_ma = L_element['ma'];
            if (! L_value_of_ma) {
                return null;
            }
            
            var L_params = this.getParams();
            return {
                '': { 'value': this._mars_k.getFormattedPrice( L_value_of_ma), 'color': L_params['color']},
            };
        }

    /**
     * 全部重算
     */
    AreaXYTechTicksMA.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            var periodSum = 0;
            for( var i in allTicks ) {
                if( i < period ) {
                    periodSum += allTicks[i].close;
                    this.getElement( i ).setValue( 'ma', undefined ); // 參數 'period' 可能修改變大, 必須清除頭段element中的 'ma'
                }
                else {
                    this.getElement( i ).setValue( 'ma', periodSum / period ); //  = element._painting_high = element._painting_low = periodSum / period;
                    periodSum = periodSum - allTicks[i-period].close + allTicks[i].close;
                }
            }
        };
