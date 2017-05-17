var AreaXYTechVolume = function( IN_mars_k, IN_tech_area_id)
{
    this._initAreaTech( IN_mars_k, 'VOL', IN_tech_area_id);
};

AreaXYTechVolume.prototype = new AreaXYTech();
AreaXYTechVolume.prototype.constructor = AreaXYTechVolume;


/**
 * 前置工作 of _doPaintForAreaTech
 */
AreaXYTechVolume.prototype._doPrepareDataForPaint =

    function() {
        var L_all_ticks = this._mars_k.getAllTicks();
        var L_value_high = Number.NEGATIVE_INFINITY;
        var L_visible_tick_index_range = this._mars_k.getVisibleTickIndexRange();
        for (var i = L_visible_tick_index_range.begin; i < L_visible_tick_index_range.end; ++i) {
            var L_the_tick = L_all_ticks[i];
            var L_volume = L_the_tick['volume'];
            if (L_volume > L_value_high) {
                L_value_high = L_volume;
            }
        }
        
        this._value_high = L_value_high;
        this._value_low = 0;
        this._pixels_per_value = this._getYRatio();
        this._y_horizon = this._value_high * this._pixels_per_value + AreaXYTech.prototype.MARGIN_TOP;
    };
        
/**
 * 畫出此區
 */
AreaXYTechVolume.prototype._doPaintForAreaTech = function( IN_layer)
{
    switch (IN_layer)
    {
        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
            break;
                    
        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:            
            this._paintHorizontalGrids();
            this._paintContent();
            this._paintYAxis();
            break;

        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD:

            break;

        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS:
            this._paintFocus( this._mars_k.getPriceDecimalFormat());
            break;
    }
};

AreaXYTechVolume.prototype._paintHorizontalGrids = function()
{
    var L_x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;
    var L_y_of_zero_volume = this._height-AreaXYTech.prototype.MARGIN_BOTTOM;
    
    var L_ctx = this._ctx;
    L_ctx.strokeStyle = this.getGridColor();
    L_ctx.beginPath();
    L_ctx.moveTo( 0, AreaXYTech.prototype.MARGIN_TOP );
    L_ctx.lineTo( L_x, AreaXYTech.prototype.MARGIN_TOP );    
    
    L_ctx.moveTo( 0, L_y_of_zero_volume);
    L_ctx.lineTo( L_x, L_y_of_zero_volume);
    
    L_ctx.stroke();
};

AreaXYTechVolume.prototype._paintContent = function( IN_max_volume)
{    
    var L_params = this.getParams();
    var L_translate_x = 0.5 + (-this._mars_k.getVisibleAreaLeft());
    var L_translate_y = 0.5;

    this._ctx.translate( L_translate_x, L_translate_y );
     
    // 畫出Tick的量。
    this._ctx.fillStyle = L_params['colorVolume'];
    var L_candle_width = this._mars_k.getCandleWidth();

    var L_all_ticks = this._mars_k.getAllTicks();
    var L_visible_tick_index_range = this._mars_k.getVisibleTickIndexRange();
    for (var i = L_visible_tick_index_range.begin; i < L_visible_tick_index_range.end; ++i) {
        var L_the_tick = L_all_ticks[i];
        var L_volume_of_tick = L_the_tick['volume'];
        var L_y = this.getYFromValue( L_volume_of_tick);
                
        this._ctx.fillRect( L_the_tick['candleLeft'], L_y, L_candle_width, this._y_horizon - L_y );
    }

    this._ctx.translate( -L_translate_x, -L_translate_y );
};

/*
 * 畫 Y 軸
 */
AreaXYTechVolume.prototype._paintYAxis = function()
{
    var L_left = this._mars_k.getTicksAreaWidthExcludeYAxis();        
    var L_x = L_left + AreaXYTech.prototype.Y_AXIS_TEXT_POSITION;

    var L_ctx = this._ctx;
    L_ctx.clearRect( L_left, 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
    L_ctx.textAlign = AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN;
    L_ctx.textBaseline = "middle";
    L_ctx.fillStyle = this._y_axis_fill_style_text_scale;
    L_ctx.font = AreaXYTech.prototype.Y_AXIS_FONT_SCALE;
    L_ctx.fillText( this._value_high, L_x, AreaXYTech.prototype.MARGIN_TOP );
    L_ctx.fillText( 0, L_x, this._height - AreaXYTech.prototype.MARGIN_BOTTOM );
};

    /**
     * 回傳對應目前游標位置需顯示的動態內容
     */
    AreaXYTechVolume.prototype._getPaintValues =

        function( IN_tick_index)
        {
            var tick = this._mars_k.getAllTicks()[IN_tick_index];
            if( ! tick )
                return null;
            var rv = {};
            rv[''] = { 'value': tick.volume, 'color': this.getParams()['colorVolume']};
            return rv;
        }
