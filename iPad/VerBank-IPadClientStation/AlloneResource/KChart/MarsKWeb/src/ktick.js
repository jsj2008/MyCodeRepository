var KTick = function()
{
    //  以下皆為公開屬性, 外部直接存取, 有緣再改為私有屬性
    this.high = null; // number
    this.low = null; // number
    this.open = null; // number
    this.close = null; // number
    this.rising = null; // boolean
    this.time = null; // Date
    this.volume = null; // number
};

    /**
     *
     */
    KTick.prototype.clone =

        function( ktick ) {
            var rv = new KTick();
            rv.high = ktick.high;
            rv.low = ktick.low;
            rv.open = ktick.open;
            rv.close = ktick.close;
            rv.rising = ktick.rising;
            rv.time = ktick.time;
            rv.volume = ktick.volume;
            return rv;
        };

    /**
     * merge, except the 'time' filed
     */
    KTick.prototype.merge =
    
        function( ktick ) {
            if( ktick.high > this.high )
                this.high = ktick.high;
            if( ktick.low < this.low )
                this.low = ktick.low;
            if( ktick.time.getTime() > this.time.getTime() )
                this.close = ktick.close;
            else if( ktick.time.getTime() < this.time.getTime() )
                this.open = ktick.open;
            this.volume += ktick.volume;
        };


    /**
     * 重新計算這個 tick 的最高/最低價格(含tick區指標)
     *
     * 呼叫時機: init, 加入/移除 AreaTechTicks
     *
     */
    KTick.prototype.evalPaintingPriceHighLow =

        function( IN_all_tech_areas, IN_index ) {
            this.paintingPriceHigh = 0;
            this.paintingPriceLow = Number.POSITIVE_INFINITY;
            if( this.high > this.paintingPriceHigh )
                this.paintingPriceHigh = this.high;
            if( this.low < this.paintingPriceLow )
                this.paintingPriceLow = this.low;
            for( var i in IN_all_tech_areas ) {
                var L_tech_area = IN_all_tech_areas[i];
                
                if (L_tech_area.isIndependentTechnicalIndex() == false) {
                    var element = L_tech_area.getElement( IN_index );

                    if( element.getPaintingHigh() > this.paintingPriceHigh )
                        this.paintingPriceHigh = element.getPaintingHigh();
                    if( element.getPaintingLow() < this.paintingPriceLow )
                        this.paintingPriceLow = element.getPaintingLow();
                }
            }
        };

    /**
     * @fixme do it at init()
     */
    KTick.prototype.avgHL =

        function() {
            return (this.high + this.low) / 2;
        };

    /**
     * @fixme do it at init()
     */
    KTick.prototype.avgHLC =

        function() {
            return (this.high + this.low + this.close) / 3;
        };

    /**
     * @fixme do it at init()
     */
    KTick.prototype.avgOHLC =

        function() {
            return (this.open + this.high + this.low + this.close) / 4;
        };


    /**
     * 以傳入的 (K棒時間, 第1筆tick價, 第1筆tick量) 建立一根 KTick
     * @param IN_ktick_time 這根 KTick 的時間欄位
     * @param IN_first_tick_price 這根 KTick 的第一筆成交價
     * @param IN_first_tick_volume 這根 KTick 的第一筆成交量
     */
    KTick.prototype.create =

        function( IN_ktick_time, IN_first_tick_price, IN_first_tick_volume ) {
            var ktick = new KTick();
            ktick.time = IN_ktick_time;
            ktick.open = ktick.close = ktick.high = ktick.low = IN_first_tick_price;
            ktick.volume = IN_first_tick_volume;
            ktick.evalPaintingPriceHighLow();
            return ktick;
        };

    /**
     * 以傳入的量/價來更新這個 KTick
     */
    KTick.prototype.update =

        function( IN_price, IN_volume ) {
            if( IN_price > this.high )
                this.high = IN_price;
            if( IN_price < this.low )
                this.low = IN_price;
            this.close = IN_price;
            this.volume += IN_volume;
            this.evalPaintingPriceHighLow();
        };