/**
 * 畫在 tick 區的布林通道 (Bollinger Bands)
 */
var AreaXYTechTicksBollingerBand = function( IN_mars_k, IN_tech_area_id)
{
    this._initAreaTechTicks( IN_mars_k, 'BOLLINGER_BAND', IN_tech_area_id);
};
AreaXYTechTicksBollingerBand.prototype = new AreaTechTicks();


    /**
     * 畫出此區
     */
    AreaXYTechTicksBollingerBand.prototype._doPaintForAreaTech =

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
    AreaXYTechTicksBollingerBand.prototype._paintContent =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            var allTicks = this._mars_k.getAllTicks();
            var areaTicks = this._mars_k.getAreaTicks();

            var i = visibleRange.begin>0? visibleRange.begin-1 : 0;
            while( i<this._elements.length && this.getElement(i)['upper'] == null )
                ++i;
            if( i == this._elements.length )
                return;
            var beginIndex = i;

            this._ctx.fillStyle = this.getParams()['colorFill'];
            this._ctx.lineWidth = this.getParams()['lineWidth'];
            this._ctx.translate( -visibleAreaLeft, 0 );
            this._ctx.beginPath();
            this._ctx.moveTo( allTicks[i].cx, this._mars_k.getAreaTicks().getYFromValue(this.getElement(i)['upper']) );
            while( ++i < visibleRange.end )
                this._ctx.lineTo( allTicks[i].cx, this._mars_k.getAreaTicks().getYFromValue(this.getElement(i)['upper']) );
            while( --i >= beginIndex )
                this._ctx.lineTo( allTicks[i].cx, this._mars_k.getAreaTicks().getYFromValue(this.getElement(i)['lower']) );
            this._ctx.closePath();
            this._ctx.fill();

            this._paintDragon( 'upper', this.getParams()['colorBorder'], this.getParams()['lineWidth'], visibleRange, allTicks );
            this._paintDragon( 'lower', this.getParams()['colorBorder'], this.getParams()['lineWidth'], visibleRange, allTicks );

            this._ctx.translate( visibleAreaLeft, 0 );
        };


    /**
     * 全部重算
     */
    AreaXYTechTicksBollingerBand.prototype._doEvaluateAll =

        function() {
            var allTicks = this._mars_k.getAllTicks();
            var period = this.getParams()['period'];
            var k = this.getParams()['k'];
            var periodSumMA = 0;
            var periodSumDiffSquare = 0;
            var e0 = this.getElement( 0 );
            e0.diffSquare = 0; // 標準差的平方
            e0.upper = e0.lower = e0.ma = null;
            for( var i=1; i<allTicks.length; ++i ) {
                var prevElement = this.getElement(i - 1);
                periodSumMA += allTicks[i - 1].close;
                periodSumDiffSquare += prevElement.diffSquare;
                var p = i<period? i : period;
                var sd = Math.pow( periodSumDiffSquare/p, 0.5 );
                var element = this.getElement( i );
                element.setValue( 'ma', periodSumMA / p );
                element.setValue( 'upper', element.ma + k*sd );
                element.setValue( 'lower', element.ma - k*sd );
                element.diffSquare = Math.pow( allTicks[i].close-element.ma, 2 );
                if( i >= period ) {
                    periodSumMA -= allTicks[i - period].close;
                    periodSumDiffSquare -= this.getElement(i - period).diffSquare;
                }
            }
        };
