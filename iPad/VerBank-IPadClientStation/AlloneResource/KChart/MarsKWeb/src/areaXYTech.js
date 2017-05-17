var AreaXYTech = function()
{

};

AreaXYTech.prototype = new AreaXY();
AreaXYTech.prototype.constructor = AreaXYTech;

// Constants.
AreaXYTech.prototype.UI_TOOLBUTTONS = [
    { 'name': 'remove', 'img_id': 'img_close'},
    { 'name': 'configure', 'img_id': 'img_config'}
];

AreaXYTech.prototype.MARGIN_TOP = AreaXYTech.prototype.UI_TOOLBAR_HEIGHT + 5;
AreaXYTech.prototype.MARGIN_BOTTOM = 10;

AreaXYTech.prototype.CURSOR_DEFAULT = 'default';
AreaXYTech.prototype.FONT_TYPE_NAME = '12px Arial';
AreaXYTech.prototype.Y_AXIS_FONT_SCALE = '12px Arial'; // Y軸價格刻度文字字型
AreaXYTech.prototype.Y_AXIS_FONT_LABEL = '13px Arial'; // Y軸浮動價格標籤文字字型
AreaXYTech.prototype.Y_AXIS_TEXT_ALIGN = 'left'; // Y軸價格刻度文字水平對齊方式
AreaXYTech.prototype.Y_AXIS_TEXT_POSITION = 3; // Y軸價格刻度文字起始 x 座標
AreaXYTech.prototype.Y_AXIS_FLOATING_LABEL_SHADOW_BLUR = 15; // 滑鼠垂直位置浮動價格標籤陰影厚度

AreaXYTech.prototype._initAreaTech = function( IN_mars_k, IN_tech_type, IN_tech_area_id)
{
    this._tech_area_id = IN_tech_area_id;
    
    var L_is_draggable = true;
    var L_is_zoomable = null;
    this._initAreaXY( IN_mars_k, L_is_draggable, L_is_zoomable, IN_tech_type, AreaXYTech.prototype.MARGIN_TOP, AreaXYTech.prototype.MARGIN_BOTTOM);
    
    // Init elements.
    var L_elements = this._elements = [];
    var L_all_ticks = this._mars_k.getAllTicks();
    for (var i = 0; i < L_all_ticks.length; ++i) {
        L_elements.push( new TechElement());
    }
    
//MarsKUtility.prototype.anchorProfile();
    this.doEvaluateAll();
//    var cost = MarsKUtility.prototype.anchorProfile();    
//console.log( this._mars_k.i18n( this.getDefinition()['name_i18n']) + ' cost: ' + cost );
};

AreaXYTech.prototype.doEvaluateAll = function()
{
    if (this._doEvaluateAll) {
        this._doEvaluateAll();
    }
};

AreaXYTech.prototype.doPrepareDataForPaint = function()
{
    if (this._doPrepareDataForPaint) {
        this._doPrepareDataForPaint();
    }
};

AreaXYTech.prototype._doPaintForXY = function( IN_layer) 
{
    var L_ctx = this._ctx;
    switch (IN_layer)
    {
        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
            if (this.isIndependentTechnicalIndex()) {
                this._paintVerticalGrids(); // area.js
            }
            break;
                    
        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:
            break;

        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD:
            this._paintSplitBar();
            break;

        case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS:
            break;
    }

    if (this._doPaintForAreaTech) {
        this._ctx.translate( 0.5, 0.5 );
        this._doPaintForAreaTech( IN_layer);
        this._ctx.translate( -0.5, -0.5 );
    }
};

AreaXYTech.prototype.procMouseDown = function( IN_x, IN_y ) 
{
    var L_button_name = this.checkPointerInToolbutton( IN_x, IN_y);
    if (L_button_name != null) {
        switch (L_button_name)
        {
            case 'remove':
                var L_this = this;
                setTimeout(
                    function()
                    {
                        L_this._mars_k.removeTechArea( L_this._tech_area_id);
                    }
                );
                break;
                
            case 'configure':
                this._mars_k.postMessage(
                    {
                        'type': 'configure',
                        'value': {
                            'area_xy': this,
                        }
                    }
                );
                break;
                
            default:
                debugger;
        }
    }
};

AreaXYTech.prototype.procMouseMove = function( IN_relative_px, IN_relative_py, IN_evt_which ) 
{
    var L_cursor;
    if (this.checkPointerInToolbutton( IN_relative_px, IN_relative_py) != null) {
        L_cursor = AreaXY.prototype.CURSOR_IN_BUTTON;
    }
  
    return L_cursor;
};

AreaXYTech.prototype.procMouseOut = function() 
{
    this._mars_k.paint();
};

AreaXYTech.prototype.procTouchEnd = function( IN_relative_px, IN_relative_py) 
{
    this.procMouseDown( IN_relative_px, IN_relative_py);
};

AreaXYTech.prototype._setType = function( IN_type)
{
    // TODO - Check type.
    this._type = IN_type;
    return true;
};

AreaXYTech.prototype.getId = function()
{
    return this._tech_area_id;
};

AreaXYTech.prototype._getDefinition = function()
{
    return this.getTechnicalIndexDefinition();
}

AreaXYTech.prototype.getTechnicalIndexDefinition = function()
{
    return AreaXYTech.prototype.DEFINITIONS[this._type];
};

AreaXYTech.prototype.isIndependentTechnicalIndex = function()
{
    var L_declaration = AreaXYTech.prototype.DEFINITIONS[this._type];
    if (L_declaration) {
        return L_declaration['independent'];
    }
};

/**
 * 取得第 IN_index 個 element
 */
AreaXYTech.prototype.getElement =

    function( IN_index ) {
        return this._elements[IN_index];
    };
    
/**
 * 刪除所有tick
 */
AreaXYTech.prototype.removeAllTicks =
        
    function()
    {
        this._elements = [];
    };

/**
 * 從左邊加入 ticks
 */
AreaXYTech.prototype.insertTicks = 

    function( IN_arr_ticks) {
        var L_number_of_tick = IN_arr_ticks.length;
        var L_elements = this._elements;
        for (var i = 0; i < L_number_of_tick; ++i) {
             L_elements.unshift( new TechElement());
        }
       
        this.doEvaluateAll();
    };
   
/**
 * 從右邊加入 ticks
 */
AreaXYTech.prototype.appendTicks = 

    function( IN_arr_ticks) {
        var L_number_of_tick = IN_arr_ticks.length;
        var L_elements = this._elements;
        for (var i = 0; i < L_number_of_tick; ++i) {
             L_elements.push( new TechElement());
        }

        this.doEvaluateAll();
    };


/**
 * 更新最後一根 tick
 */
AreaXYTech.prototype.updateLastTick  =

    function() {
        this.doEvaluateAll();
    };

/**
 * 決定下半部(獨立指標區)可視區域的 Y 軸高/低值
 */
AreaXYTech.prototype._determineVisibleRangeHighLow =

    function() {
        var visibleRange = this._mars_k.getVisibleTickIndexRange();
        this._value_high = Number.NEGATIVE_INFINITY;
        this._value_low = Number.POSITIVE_INFINITY;
        var beginIndex = visibleRange.begin>0? visibleRange.begin-1 : 0;
        for( var i=beginIndex; i<visibleRange.end; ++i ) {
            var element = this._elements[i];
            if( element.getPaintingHigh() > this._value_high )
                this._value_high = element.getPaintingHigh();
            if( element.getPaintingLow() < this._value_low )
                this._value_low = element.getPaintingLow();
        }
        this._pixels_per_value = this._value_high!=this._value_low? this._getYRatio() : 0;
    };

/**
 * 以傳入的欄位, 在可視區域內畫出一條龍(重覆的 moveTo + lineTo)
 */
AreaXYTech.prototype._paintDragon =

    function( IN_field, IN_style, IN_line_width, IN_visible_range, IN_all_ticks ) {
        if( IN_all_ticks.length == 0 )
            return;
        this._ctx.strokeStyle = IN_style;
        this._ctx.beginPath();
        this._ctx.lineWidth = IN_line_width*1 + 0.5;
        var i = IN_visible_range.begin>0? IN_visible_range.begin-1 : 0;
        do {
            var element = this.getElement( i );
            if( ! element )
                return;
        }
        while( this.getElement(i++)[IN_field] == null );
        i--;

        var invokerOfGetYFromValue = this.isIndependentTechnicalIndex()? this : this._mars_k.getAreaTicks();
        this._ctx.moveTo( IN_all_ticks[i].cx, AreaXYTech.prototype.getYFromValue.call( invokerOfGetYFromValue, this.getElement(i)[IN_field]) );
        while( ++i < IN_visible_range.end )
            this._ctx.lineTo( IN_all_ticks[i].cx, AreaXYTech.prototype.getYFromValue.call( invokerOfGetYFromValue, this.getElement(i)[IN_field]) );
        this._ctx.stroke();
    };

/**
 * 以傳入的欄位, 在可視區域內畫出由地平線(數值0)向上或向下伸出的柱狀
 * (目前只有下半部技術指標會用到)
 */
AreaXYTech.prototype._paintBiDirPoles =

    function( IN_field, IN_style_positive, IN_style_negative, IN_pole_width, IN_visible_range, IN_all_ticks ) {
        var yHorizon = this.getYFromValue( 0 );
        var i = IN_visible_range.begin;

        while( i<IN_visible_range.end && this.getElement(i)[IN_field]==null )
            ++i;

        while( i < IN_visible_range.end ) {
            var value = this.getElement(i)[IN_field];
            var y = this.getYFromValue( value );
            var cx = IN_all_ticks[i].cx;
            if( y > yHorizon ) {
                this._ctx.fillStyle = IN_style_positive;
                this._ctx.fillRect( IN_all_ticks[i].cx-IN_pole_width/2, y, IN_pole_width, yHorizon-y );
            }
            else {
                this._ctx.fillStyle = IN_style_negative;
                this._ctx.fillRect( IN_all_ticks[i].cx-IN_pole_width/2, yHorizon, IN_pole_width, y-yHorizon );
            }
            ++i;
        }
    };



AreaXYTech.prototype.DEFINITIONS = {
    'MA': {
            'name_i18n': 'AREA_XY_TECH_MA_NAME',
            'independent': false,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechTicksMA;},
            'params': {
                'period': [ 20, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_MA_PARAM_PERIOD'}],
                'color': [ 'rgba(0,88,200,0.8)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_MA_PARAM_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_MA_PARAM_LINE_WIDTH'}],
            },
        },
    'BOLLINGER_BAND': {
            'name_i18n': 'AREA_XY_TECH_BOLLINGER_BAND_NAME',
            'independent': false,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechTicksBollingerBand;},
            'params': {
                'period': [ 20, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_BOLLINGER_BAND_PARAM_PERIOD'}],
                'k': [ 2, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_BOLLINGER_BAND_PARAM_K'}],
                'colorBorder': [ 'rgb(6,64,102)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_BOLLINGER_BAND_PARAM_BORDER_COLOR'}],
                'colorFill': [ 'rgba(13,200,247,0.1)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_BOLLINGER_BAND_PARAM_FILL_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_BOLLINGER_BAND_PARAM_LINE_WIDTH'}],
            },
        },
    'AO': {
            'name_i18n': 'AREA_XY_TECH_AO_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechAO;},
            'params': {
                'periodShort': [ 6, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_AO_PARAM_PERIOD_SHORT'}],
                'periodLong': [ 34, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_AO_PARAM_PERIOD_LONG'}],
                'colorIncrease': [ 'rgb(168,0,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_AO_PARAM_INCREASE_COLOR'}],
                'colorDecrease': [ 'rgb(0,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_AO_PARAM_DECREASE_COLOR'}],
            },
        },
    'ARBR': {
            'name_i18n': 'AREA_XY_TECH_ARBR_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechARBR;},
            'params': {
                'period': [ 26, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_ARBR_PARAM_PERIOD'}],
                'colorAR': [ 'rgb(168,0,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_ARBR_PARAM_AR_COLOR'}],
                'colorBR': [ 'rgb(0,168,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_ARBR_PARAM_BR_COLOR'}],
                'lineWidthAR': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_ARBR_PARAM_AR_LINE_WIDTH'}],
                'lineWidthBR': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_ARBR_PARAM_BR_LINE_WIDTH'}],
            },
        },
    'ATR': {
            'name_i18n': 'AREA_XY_TECH_ATR_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechATR;},
            'params': {
                'period': [ 14, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_ATR_PARAM_PERIOD'}],
                'color': [ 'rgb(168,128,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_ATR_PARAM_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_ATR_PARAM_LINE_WIDTH'}],
            },
        },
    'BIAS': {
            'name_i18n': 'AREA_XY_TECH_BIAS_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechBIAS;},
            'params': {
                'period': [ 6, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_BIAS_PARAM_PERIOD'}],
                'color': [ 'rgb(168,128,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_BIAS_PARAM_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_BIAS_PARAM_LINE_WIDTH'}],
            },
        },
    'BIAS36': {
            'name_i18n': 'AREA_XY_TECH_BIAS36_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechBIAS36;},
            'params': {
                'color': [ 'rgb(168,99,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_BIAS36_PARAM_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_BIAS36_PARAM_LINE_WIDTH'}],
            },
        },
    'CCI': {
            'name_i18n': 'AREA_XY_TECH_CCI_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechCCI;},
            'params': {
                'period': [ 14, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_CCI_PARAM_PERIOD'}],
                'color': [ 'rgb(168,128,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_CCI_PARAM_COLOR'}],
                'type': [ 'line', {'type': AreaXY.prototype.PARAM_TYPES['ENUM'], 'enum':['line','pole'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_CCI_PARAM_TYPE'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_CCI_PARAM_LINE_WIDTH'}],
            },
        },
    'DMI': {
            'name_i18n': 'AREA_XY_TECH_DMI_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechDMI;},
            'params': {
                'period': [ 14, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_DMI_PARAM_PERIOD'}],
                'colorDmiPositive': [ 'rgb(0,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_DMI_POSITIVE_COLOR'}],
                'colorDmiNegative': [ 'rgb(168,0,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_DMI_NEGATIVE_COLOR'}],
                'colorADX': [ 'rgb(168,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_ADX_COLOR'}],
                'colorADXR': [ 'rgb(0,168,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_ADXR_COLOR'}],
                'lineWidthDmiPositive': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_DMI_POSITIVE_LINE_WIDTH'}],
                'lineWidthDmiNegative': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_DMI_NEGATIVE_LINE_WIDTH'}],
                'lineWidthADX': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_ADX_LINE_WIDTH'}],
                'lineWidthADXR': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_DMI_PARAM_ADXR_LINE_WIDTH'}],
            },
        },
    'KDJ': {
            'name_i18n': 'AREA_XY_TECH_KDJ_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechKDJ;},
            'params': {
                'period': [ 9, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_KDJ_PARAM_PERIOD'}],
                'colorK': [ 'rgb(168,0,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_KDJ_PARAM_K_COLOR'}],
                'colorD': [ 'rgb(168,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_KDJ_PARAM_D_COLOR'}],
                'colorJ': [ 'rgb(0,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_KDJ_PARAM_J_COLOR'}],
                'lineWidthK': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_KDJ_PARAM_K_LINE_WIDTH'}],
                'lineWidthD': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_KDJ_PARAM_D_LINE_WIDTH'}],
                'lineWidthJ': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_KDJ_PARAM_J_LINE_WIDTH'}],
            },
        },
    'MACD': {
            'name_i18n': 'AREA_XY_TECH_MACD_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechMACD;},
            'params': {
                'periodShort': [ 12, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_PERIOD_SHORT'}],
                'periodLong': [ 26, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_PERIOD_LONG'}],
                'periodSignal': [ 9, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_PERIOD_SIGNAL'}],
                'colorDiff': [ 'rgb(0,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_DIFF_COLOR'}],
                'colorDem': [ 'rgb(168,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_DEM_COLOR'}],
                'lineWidthDiff': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_DIFF_LINE_WIDTH'}],
                'lineWidthDem': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_DEM_LINE_WIDTH'}],
                'colorPositive': [ 'rgb(255,0,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_POSITIVE_COLOR'}],
                'colorNegative': [ 'rgb(0,0,255)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_MACD_PARAM_NEGATIVE_COLOR'}],
            },
        },
    'MTM': {
            'name_i18n': 'AREA_XY_TECH_MTM_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechMTM;},
            'params': {
                'period': [ 10, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_MTM_PARAM_MTM_PERIOD'}],
                'color': [ 'rgb(0,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_MTM_PARAM_MTM_COLOR'}],
                'periodMA': [ 10, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_MTM_PARAM_MTM_MA_PERIOD'}],
                'colorMA': [ 'rgb(0,168,168)', { 'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_MTM_PARAM_MTM_MA_COLOR'}],
                'type': [ 'pole', {'type': AreaXY.prototype.PARAM_TYPES['ENUM'], 'enum':['line','pole'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_MTM_PARAM_TYPE'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_MTM_PARAM_LINE_WIDTH'}],
            },
        },
    'OBV': {
            'name_i18n': 'AREA_XY_TECH_OBV_NAME',
            'independent': true,
            'useVolume': true,
            'getConstructor': function() { return AreaXYTechOBV;},
            'params': {
                'period': [ 12, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_OBV_PARAM_OBV_PERIOD'}],
                'periodMA': [ 20, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_OBV_PARAM_MA_PERIOD'}],
                'color': [ 'rgb(168,128,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_OBV_PARAM_OBV_COLOR'}],
                'colorMA': [ 'rgb(168,0,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_OBV_PARAM_MA_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_OBV_PARAM_OBV_LINE_WIDTH'}],
                'lineWidthMA': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_OBV_PARAM_MA_LINE_WIDTH'}],
            },
        },
    'PSY': {
            'name_i18n': 'AREA_XY_TECH_PSY_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechPSY;},
            'params': {
                'period': [ 6, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_PSY_PARAM_PSY_PERIOD'}],
                'periodMA': [ 12, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_PSY_PARAM_MA_PERIOD'}],
                'color': [ 'rgb(88,168,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_PSY_PARAM_PSY_COLOR'}],
                'colorMA': [ 'rgb(128,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n':'AREA_XY_TECH_PSY_PARAM_MA_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_PSY_PARAM_PSY_LINE_WIDTH'}],
                'lineWidthMA': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_PSY_PARAM_MA_LINE_WIDTH'}],
            },
        },
    'ROC': {
            'name_i18n': 'AREA_XY_TECH_ROC_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechROC;},
            'params': {
                'period': [ 10, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_ROC_PARAM_PERIOD'}],
                'color': [ 'rgb(168,99,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_ROC_PARAM_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_ROC_PARAM_LINE_WIDTH'}],
            },
        },
    'RSI': {
            'name_i18n': 'AREA_XY_TECH_RSI_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechRSI;},
            'params': {
                'periodShort': [ 6, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_RSI_PARAM_SHORT_PERIOD'}],
                'periodLong': [ 12, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_RSI_PARAM_LONG_PERIOD'}],
                'colorShort': [ 'rgb(0,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_RSI_PARAM_SHORT_COLOR'}],
                'colorLong': [ 'rgb(168,0,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_RSI_PARAM_LONG_COLOR'}],
                'lineWidthShort': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_RSI_PARAM_SHORT_LINE_WIDTH'}],
                'lineWidthLong': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_RSI_PARAM_LONG_LINE_WIDTH'}],
            },
        },
    'RSI Smooth': {
            'name_i18n': 'AREA_XY_TECH_RSI_SMOOTH_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechRSISmooth;},
            'params': {
                'period': [ 14, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_RSI_SMOOTH_PARAM_PERIOD'}],
                'color': [ 'rgb(0,168,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_RSI_SMOOTH_PARAM_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n':'AREA_XY_TECH_RSI_SMOOTH_PARAM_LINE_WIDTH'}],
            },
        },
    'VOL': {
            'name_i18n': 'AREA_XY_TECH_VOL_NAME',
            'independent': true,
            'useVolume': true,
            'getConstructor': function() { return AreaXYTechVolume;},
            'params': {
                'colorVolume': [ 'rgb( 240, 215, 96)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_VOL_PARAM_COLOR'}],
            },
        },
    'VR': {
            'name_i18n': 'AREA_XY_TECH_VR_NAME',
            'independent': true,
            'useVolume': true,
            'getConstructor': function() { return AreaXYTechVR;},
            'params': {
                'period': [ 24, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_VR_PARAM_VR_PERIOD'}],
                'periodMA': [ 6, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_VR_PARAM_MA_PERIOD'}],
                'color': [ 'rgb(168,99,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_VR_PARAM_VR_COLOR'}],
                'colorMA': [ 'rgb(0,88,88)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_VR_PARAM_MA_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_VR_PARAM_VR_LINE_WIDTH'}],
                'lineWidthMA': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_VR_PARAM_MA_LINE_WIDTH'}],
            },
        },
    'WR': {
            'name_i18n': 'AREA_XY_TECH_WR_NAME',
            'independent': true,
            'useVolume': false,
            'getConstructor': function() { return AreaXYTechWR;},
            'params': {
                'period': [ 14, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 500, 'showInArea': true, 'alias_i18n': 'AREA_XY_TECH_WR_PARAM_PERIOD'}],
                'color': [ 'rgb(168,99,168)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_WR_PARAM_COLOR'}],
                'lineWidth': [ 1, { 'type': AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min': 1, 'max': 10, 'showInArea': false, 'alias_i18n': 'AREA_XY_TECH_WR_PARAM_LINE_WIDTH'}],
            },
        },
};