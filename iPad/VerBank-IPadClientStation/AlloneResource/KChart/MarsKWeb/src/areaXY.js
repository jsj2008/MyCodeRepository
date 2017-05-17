/**
 * 圖表類區域，所有跟Tick有關的圖表皆屬此區
 * 
 * AreaXY比起Area而言，因為為了繪製不同的圖表增加了param的屬性。
 */
var AreaXY = function( IN_mars_k )
{
    
}
AreaXY.prototype = new Area();
AreaXY.prototype.constructor = AreaXY;

AreaXY.prototype.PARAM_TYPE_COUNTER = 0;
AreaXY.prototype.PARAM_TYPES = {
    'NUMBER': AreaXY.prototype.PARAM_TYPE_COUNTER++,
    'ENUM': AreaXY.prototype.PARAM_TYPE_COUNTER++,
    'COLOR': AreaXY.prototype.PARAM_TYPE_COUNTER++,
    'BOOLEAN': AreaXY.prototype.PARAM_TYPE_COUNTER++,
};

AreaXY.prototype.UI_TOOLBAR_TOP = 5;
AreaXY.prototype.UI_TOOLBAR_LEFT = 5;
AreaXY.prototype.UI_TOOLBAR_HEIGHT = 20;
AreaXY.prototype.UI_TOOLBUTTON_WIDTH = 15;
AreaXY.prototype.UI_TOOLBUTTON_HEIGHT = 15;
AreaXY.prototype.UI_TOOLBUTTON_SPACING = 5;
AreaXY.prototype.CURSOR_IN_BUTTON = 'pointer';
AreaXY.prototype.CURSOR_DRAWN_MOUSEOVER = 'pointer';


AreaXY.prototype._initAreaXY = function( IN_mars_k, IN_is_draggable, IN_is_zoomable, IN_type, IN_margin_top, IN_margin_bottom)
{
    this.setType( IN_type);
    
    if (IN_is_zoomable == null) {
        IN_is_zoomable = this.isIndependentTechnicalIndex();
    }
    
    this._initArea( IN_mars_k, IN_is_draggable, IN_is_zoomable);
    
    this._margin_top = IN_margin_top;
    this._margin_bottom = IN_margin_bottom;
    
    this._value_high = null;
    this._value_low = null;
    this._pixels_per_value = null;
    
    this._tool_bar_vertical_ordering = 0;
};

AreaXY.prototype._refreshColorsForArea = function()
{
    var bgColor = window.getComputedStyle( this._dom_canvas)['backgroundColor'];
    this._color_bg = bgColor;
    this._color_title = MarsKUtility.prototype.getContrastiveColor( bgColor, 0.8 );
    this._color_label = MarsKUtility.prototype.getContrastiveColor( bgColor, 1 );
};

AreaXY.prototype.doPaint = function( IN_layer) 
{
    if (this.constructor === AreaXYTicks && !this._mars_k.isVisibledForAreaTicks()) {
        // Tick區被隱藏了，不需要畫有關此區的任何東西。
        return;
    }
    else {
        var L_definitions = this.getDefinition();
        if (L_definitions['independent'] == false && !this._mars_k.isVisibledForAreaTicks()) {
            return;
        }
    }
    
    switch (IN_layer)
    {
        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
            break;
                    
        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:
            break;

        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD:
            var L_toolbar_y = AreaXY.prototype.UI_TOOLBAR_TOP + this._tool_bar_vertical_ordering * AreaXY.prototype.UI_TOOLBAR_HEIGHT;
            var L_toolbar_center_y = L_toolbar_y + AreaXY.prototype.UI_TOOLBUTTON_HEIGHT * 0.5;

            var L_ctx = this._ctx;

            // Draw toolbar buttons.
            var L_toolbuttons = this.UI_TOOLBUTTONS;
            var L_left = AreaXY.prototype.UI_TOOLBAR_LEFT;
            for (var i in L_toolbuttons) {
                var L_the_button = L_toolbuttons[i];
                var L_img_id = L_the_button['img_id'];
                if (L_img_id != null) {
                    var L_dom_image = document.getElementById( L_img_id);
                    if (L_dom_image != null) {
                        L_ctx.drawImage( L_dom_image, L_left, L_toolbar_y, AreaXY.prototype.UI_TOOLBUTTON_WIDTH, AreaXY.prototype.UI_TOOLBUTTON_HEIGHT);
                    }
                }
                
                L_left += AreaXY.prototype.UI_TOOLBUTTON_WIDTH + AreaXY.prototype.UI_TOOLBUTTON_SPACING;
            }
            
           // Draw name of technical index.
            var fgColor = this._color_title;
            L_ctx.fillStyle = fgColor;
            L_ctx.textBaseline = 'middle';
            L_ctx.textAlign = 'left';
            var L_definition = this.getDefinition();
            var L_area_xy_name;
            if (this.constructor === AreaXYTicks) {
                // Tick區
                var L_caption = this._mars_k.getCaption();
                if (L_caption != null) {
                    L_ctx.font = '15px Arial bold';
                    L_area_xy_name = L_caption;
                }
                else {
                    L_ctx.font = '12px Arial';
                    L_area_xy_name = '[ ' + this._mars_k.i18n( L_definition['name_i18n']) + ' ]';
                }
            }
            else {
                // 技術指標區
                L_ctx.font = '12px Arial';
                L_area_xy_name = '[ ' + this._mars_k.i18n( L_definition['name_i18n']) + ' ]';
            }
            
            L_ctx.fillText( L_area_xy_name, L_left, L_toolbar_center_y);
            L_left += L_ctx.measureText( L_area_xy_name).width + 10;
                        
            // Draw params.
            L_ctx.font = '12px Arial';
            var L_param_definitions = L_definition['params'];
            var L_params = this._params;
            for (var L_param_name in L_params) {
                var L_declaration_of_param = L_param_definitions[L_param_name];
                if (L_declaration_of_param == undefined) {
                    continue;
                }

                var L_definition_of_param = L_declaration_of_param[1];
                if (L_definition_of_param == undefined) {
                    continue;
                }

                if (L_definition_of_param['showInArea'] == false) {
                    continue;
                }
                
                // Draw param name.
                var L_param_alias_name = this._mars_k.i18n( L_definition_of_param['alias_i18n']);
                var L_param_display_name = (L_param_alias_name != null) ? L_param_alias_name : L_param_name;
                var L_str = L_param_display_name;
                if (L_param_display_name.length > 0) {
                    L_str += ': ';
                }
                L_ctx.fillStyle = fgColor;
                L_ctx.fillText( L_str, L_left, L_toolbar_center_y);
                L_left += L_ctx.measureText( L_str).width;
                
                // Draw param value.
                switch (L_definition_of_param['type'])
                {
                    case AreaXY.prototype.PARAM_TYPES['NUMBER']:
                    case AreaXY.prototype.PARAM_TYPES['ENUM']:
                        var L_param_value = L_params[L_param_name];
                        L_ctx.fillText( L_param_value, L_left, L_toolbar_center_y);
                        L_left += L_ctx.measureText( L_param_value).width;
                        break;
                        
                    case AreaXY.prototype.PARAM_TYPES['COLOR']:
                        var L_param_value = L_params[L_param_name];
                        var L_size = 14;
                        L_ctx.fillStyle = L_param_value;
                        L_ctx.fillRect( L_left, L_toolbar_y, L_size, L_size);
                        L_left += L_size;
                        break;
                }
                
                L_left += 12;
            }
            
            // Draw values.
            if (this._getPaintValues) {
                var L_focus_tick_index = this._mars_k.getFocusTickIndex();
                var L_paint_values = this._getPaintValues( L_focus_tick_index);
                if (L_paint_values) {
                    for (var L_name in L_paint_values) {
                        var L_paint_value = L_paint_values[L_name];
                        var L_value = L_paint_value['value'];
                        var L_color = L_paint_value['color'];
                        L_ctx.fillStyle = fgColor;
                        L_ctx.fillText( L_name, L_left, L_toolbar_center_y);
                        L_left += L_ctx.measureText( L_name).width + 5;
                        
                        L_ctx.fillStyle = L_color;
                        L_ctx.fillText( L_value, L_left, L_toolbar_center_y);
                        L_left += L_ctx.measureText( L_value).width + 10;
                    }
                }
            }
    } // End of Switch.
    
    if (this._doPaintForXY) {
        this._doPaintForXY( IN_layer);
    }
};

    /**
     * 畫出游標移動 (畫出目前滑鼠位置水平線, 垂直線由外框MarsK負責畫)
     */
    AreaXY.prototype._paintFocus =

        function( IN_decimal_format_for_y_value) {
            if( this._mouse_moving_position == null ) {
                return;
            }
            
            var L_ctx = this._ctx;
            L_ctx.strokeStyle = MarsK.prototype.FOCUS_LINE_COLOR;
            // 滑鼠在此區, 畫水平線和浮動價格標籤
            L_ctx.beginPath();

            var yAxisLeft = this._mars_k.getTicksAreaWidthExcludeYAxis();
            var y = Math.floor( this._mouse_moving_position.y );
            // 水平線
            L_ctx.strokeStyle = MarsK.prototype.FOCUS_LINE_COLOR;
            L_ctx.moveTo( 0, y );
            L_ctx.lineTo( yAxisLeft, y );
            // 標籤
            var price = this.getValueFromY( y );
            var bgColor = this._color_bg;
            L_ctx.fillStyle = bgColor;
            L_ctx.shadowBlur = AreaXYTicks.prototype.Y_AXIS_FLOATING_LABEL_SHADOW_BLUR;
            L_ctx.shadowColor = this._y_axis_label_shadow_color;
            L_ctx.fillRect( yAxisLeft+3, y-8, MarsK.prototype.WIDTH_Y_AXIS-6, 16 );
            L_ctx.fillStyle = this._color_label;
            L_ctx.font = AreaXYTicks.prototype.Y_AXIS_FONT_LABEL;
            L_ctx.textBaseline = "middle";
            L_ctx.textAlign = AreaXYTicks.prototype.Y_AXIS_TEXT_ALIGN;
            L_ctx.fillText( IN_decimal_format_for_y_value.format( price), yAxisLeft + 4, y );
            L_ctx.shadowBlur = 0;
            L_ctx.stroke();
        };

/*
 * 檢查座標點在哪個工具列按鈕上
 */
AreaXY.prototype.checkPointerInToolbutton = function( IN_pointer_x, IN_pointer_y)
{ 
    var L_toolbuttons = this.UI_TOOLBUTTONS;
    if (L_toolbuttons == null) {
        return null;
    }
    
    var L_button_x = AreaXY.prototype.UI_TOOLBAR_LEFT;
    var L_button_y = AreaXY.prototype.UI_TOOLBAR_TOP + this._tool_bar_vertical_ordering * AreaXY.prototype.UI_TOOLBAR_HEIGHT;
    
    for (var i in L_toolbuttons) {
        var L_the_button = L_toolbuttons[i];
        var L_button_name = L_the_button['name'];
        if (L_button_name != null) {        
            if (IN_pointer_x > L_button_x && 
                IN_pointer_x < L_button_x + AreaXY.prototype.UI_TOOLBUTTON_WIDTH &&
                IN_pointer_y > L_button_y && 
                IN_pointer_y < L_button_y + AreaXY.prototype.UI_TOOLBUTTON_HEIGHT
            ){
                return L_button_name;
            }
        }
        
        L_button_x += AreaXY.prototype.UI_TOOLBUTTON_WIDTH + AreaXY.prototype.UI_TOOLBUTTON_SPACING;        
    }
    
    return null;
};

AreaXY.prototype.getType = function()
{
    return this._type;
};

AreaXY.prototype.setType = function( IN_type)
{
    if (this._setType && this._setType( IN_type)) {
        // 設置參數初始值
        this._params = {};
        var L_definition = this.getDefinition();
        if (L_definition != undefined) {
            var L_params = L_definition['params'];
            for (var L_param_name in L_params) {
                var L_the_param = L_params[L_param_name];
                var L_default_value = L_the_param[0];
                //var L_definition = L_the_param[1];
                this._params[L_param_name] = L_default_value;
            }
        }

        return true;
    }
    return false;
};

/**
 * 取得此XYArea區域Instance的詳細定義表
 */
AreaXY.prototype.getDefinition = function()
    {
        if (this._getDefinition) {
            return this._getDefinition();
        }
        return null;
    };

AreaXY.prototype.getParams = function()
{
    return this._params;
};

AreaXY.prototype.setParam = function( IN_param_name, IN_value)
{
    var L_definition = this.getDefinition();
    if (L_definition == undefined) {
        return false;
    }
    
    var L_definitions_of_params = L_definition['params'];
    var L_definitions_of_param = L_definitions_of_params[IN_param_name];
    if (L_definitions_of_param == undefined) {
        return false;
    }
    
    var L_default_value_of_param = L_definitions_of_param[0];
    var L_definition_of_param = L_definitions_of_param[1];
    var L_final_value;
    switch (L_definition_of_param['type']) 
    {
        case AreaXY.prototype.PARAM_TYPES['NUMBER']:
            if (IN_value < L_definition_of_param['min'] || IN_value > L_definition_of_param['max']) {
                debugger;
                return false;
            }
            L_final_value = parseFloat( IN_value);
            break;
            
        case AreaXY.prototype.PARAM_TYPES['ENUM']:
            var L_param_enum = L_definition_of_param['enum'];
            var L_the_value_is_existing = false;
            for (var i in L_param_enum) {
                if (L_param_enum[i] === IN_value) {
                    L_the_value_is_existing = true;
                    break;
                }
            }
            
            if (L_the_value_is_existing === false) {
                debugger;
                return false;
            }
            L_final_value = IN_value;
            break;
            
        case AreaXY.prototype.PARAM_TYPES['COLOR']:
            L_final_value = IN_value;
            break;
    }
    
    this._params[IN_param_name] = L_final_value;
    return true;
};

AreaXY.prototype.setParams = 
    
    function( IN_params)
    {
        for (var L_param_name in IN_params) {
            this.setParam( L_param_name, IN_params[L_param_name]);
        }
    };

/**
 * 1單位 value 對應多少 Y pixels
 */
AreaXY.prototype._getYRatio =

    function() {
        return (this._height - this._margin_top - this._margin_bottom) / (this._value_high - this._value_low);
    };


/**
 * 由 value 轉為 Y 座標
 */
AreaXY.prototype.getYFromValue =

    function( IN_value ) {
        return Math.floor( this._margin_top + (this._value_high - IN_value) * this._pixels_per_value);
    };

/**
 * 由 Y 座標轉為 value
 */
AreaXY.prototype.getValueFromY =

    function( IN_y ) {
        return this._value_high - (IN_y - this._margin_top) / this._pixels_per_value;
    };

/**
 * 設定工具列顯示的垂直座標順序
 */
AreaXY.prototype.setToolbarVerticalOrdering =
    
    function( IN_ordering) {
        this._tool_bar_vertical_ordering = IN_ordering;
    };

/**
 * 取得工具列顯示的垂直座標順序
 */
AreaXY.prototype.getToolbarVerticalOrdering =
    
    function() {
        return this._tool_bar_vertical_ordering;
    };
