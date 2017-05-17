var TechElement = function()
{
    this._painting_high = Number.NEGATIVE_INFINITY;
    this._painting_low = Number.POSITIVE_INFINITY;
};


    /**
     * 回傳畫出這個 element 會參考到的 Y 軸最大值
     */
    TechElement.prototype.getPaintingHigh =

        function() {
            return this._painting_high;
        };


    /**
     * 回傳畫出這個 element 會參考到的 Y 軸最小值
     */
    TechElement.prototype.getPaintingLow =

        function() {
            return this._painting_low;
        };


    /**
     * 設定某個屬性值, 並更新 _painting_low 和 _painting_high
     */
    TechElement.prototype.setValue =

        function( IN_field, IN_value ) {
            this[IN_field] = IN_value;
            if( IN_value > this._painting_high )
                this._painting_high = IN_value;
            if( IN_value < this._painting_low )
                this._painting_low = IN_value;
        };