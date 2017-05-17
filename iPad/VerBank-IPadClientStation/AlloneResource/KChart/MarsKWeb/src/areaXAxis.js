/**
 * X 時間軸
 *
 *
 */
var AreaXAxis = function( IN_mars_k )
{
    this._initArea( IN_mars_k, true, true);

    this.setType( this._mars_k.getType() );
    this._area_ticks = this._mars_k.getAreaTicks();
    this._occupied = new Uint32Array(100000);
    this._occupied_size = 0;
    this._tick_amount_changed = true; // tick 數量增減? (需重新產生刻度)
    this._tick_width_changed = true; // x軸比例改變? (需重新產生刻度)
    this._type_changed = true; // 時間類型改變? (需重新產生刻度)
}

AreaXAxis.prototype = new Area();
AreaXAxis.prototype.constructor = AreaXAxis;
AreaXAxis.prototype.BETWEEN_SCALE_HALF = 30; // 刻度間距 * 1/2
AreaXAxis.prototype.FLOATING_LABEL_SHADOW_BLUR = 15; // 滑鼠水平位置浮動時間標籤陰影厚度
AreaXAxis.prototype.DF_Y = 'yyyy'; // 跨年
AreaXAxis.prototype.DF_YM = 'yyyy/MM'; // 跨月
AreaXAxis.prototype.DF_MD = 'MM/dd'; // 跨日
AreaXAxis.prototype.DF_H = 'hh'; // 跨小時
AreaXAxis.prototype.DF_M = 'MM'; // 月線
AreaXAxis.prototype.DF_D = 'dd'; // 日線
AreaXAxis.prototype.DF_H = 'hh'; // 小時線
AreaXAxis.prototype.DF_HM = 'mm'; // 分線
AreaXAxis.prototype.FONT_LABEL = '13px Arial';
AreaXAxis.prototype.FONT_SCALE = '12px Arial';
AreaXAxis.prototype.TEXT_ALIGN = 'center'; // X軸時間刻度文字水平對齊方式
AreaXAxis.prototype.TYPE_SPANS = { // 各類型對應的跨越 (優先畫出的大刻度)
    'M': ['getUTCFullYear'],
    'W': ['getUTCFullYear', 'getUTCMonth'],
    'D': ['getUTCFullYear', 'getUTCMonth'],
    'H': ['getUTCFullYear', 'getUTCMonth', 'getUTCDate'],
    'm': ['getUTCFullYear', 'getUTCMonth', 'getUTCDate', 'getUTCHours']
};
AreaXAxis.prototype.FMT_SCALE_ALL_SPANS = { // 各種跨越的日期格式
    'getUTCFullYear': 'yyyy',
    'getUTCMonth': 'yyyy/MM',
    'getUTCDate': 'MM/dd',
    'getUTCHours': 'hh:00',
    'getUTCMinutes': 'mm'
};
AreaXAxis.prototype.FONT_SCALE_ALL_SPANS = {
    'getUTCFullYear': '16px Arial bold',
    'getUTCMonth': '15px Arial bold',
    'getUTCDate': '14px Arial bold',
    'getUTCHours': '13px Arial bold'
};
AreaXAxis.prototype.Y_SCALE_ALL_SPANS = {
    'getUTCFullYear': 6,
    'getUTCMonth': 4,
    'getUTCDate': 3,
    'getUTCHours': 2
};
AreaXAxis.prototype.CONTRAST_SCALE_ALL_SPANS = {
    'getUTCFullYear': 1,
    'getUTCMonth': 0.8,
    'getUTCDate': 0.6,
    'getUTCHours': 0.5
};

AreaXAxis.prototype._refreshColorsForArea = function()
{
    var bgColor = window.getComputedStyle(this._dom_canvas)['backgroundColor'];
    this._color_background = bgColor;
    this._fill_style_text_scale = MarsKUtility.prototype.getContrastiveColor( bgColor, 0.6 );
    this._fill_style_text_scale_span = MarsKUtility.prototype.getContrastiveColor( bgColor, 0.8 );
    this._label_shadow_color = MarsKUtility.prototype.getContrastiveColor( bgColor, 0.7 );
};


    AreaXAxis.prototype.appendTicks =

        function( IN_arr_ticks ) {
            this._tick_amount_changed = true;
        };

    AreaXAxis.prototype.insertTicks =

        function( IN_arr_ticks ) {
            this._tick_amount_changed = true;
        };

    AreaXAxis.prototype.removeAllTicks =

        function() {
            this._tick_amount_changed = true;
        };

    AreaXAxis.prototype.setTickWidthChanged =

        function() {
            this._tick_width_changed = true;
        };

    AreaXAxis.prototype.setType =

        function( IN_type ) {
            this._type = IN_type.charAt(0);
            this._fmt_scale = // 一般刻度的時間格式
                this._type=='M'? AreaXAxis.prototype.DF_M
                : this._type=='W'? AreaXAxis.prototype.DF_D
                : this._type=='D'? AreaXAxis.prototype.DF_D
                : this._type=='H'? AreaXAxis.prototype.DF_H
                : AreaXAxis.prototype.DF_HM; // 'm'
        };



    /**
     * 畫出此區
     */
    AreaXAxis.prototype.doPaint =

        function( IN_layer) {
            switch (IN_layer)
            {
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
                    break;
                    
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:
                    this._ctx.clearRect( 0, 0, this.getWidth(), this.getHeight() );
                    this._ctx.textAlign = 'center'; // 固定不變
                    this._ctx.textBaseline = 'hanging'; // 固定不變

                    // this._ctx.font = AreaXAxis.prototype.FONT_SCALE;
                    // this._ctx.fillStyle = this._fill_style_text_scale_span;
                    // this._ctx.strokeStyle = 'white';
                    this._ctx.textBaseline = "top";

                    var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
                    this._ctx.translate( -visibleAreaLeft, 0 );
                    this._ctx.translate( 0.5, 0.5 );
                    var visibleRange = this._mars_k.getVisibleTickIndexRange();
                    var L_all_ticks = this._mars_k.getAllTicks();
                    for( var i=visibleRange.begin; i<visibleRange.end; ++i ) {
                        var tick = L_all_ticks[i];
                        if( tick.xScale ) {
                            //var s = tick.time.format( tick.xScale.format );
                            var s = tick.time.formatWithTimezoneOffsetInMinutes( tick.xScale.format, this._mars_k.getTimezoneOffsetInMinutes() );
                            this._ctx.font = tick.xScale.font;
                            this._ctx.fillStyle = MarsKUtility.prototype.getContrastiveColor( this._color_background, tick.xScale.contrast );
                            this._ctx.fillText( s, tick.cx, 2+tick.xScale.yFix );
                        }
                    }
                    this._ctx.translate( -0.5, -0.5 );
                    this._ctx.translate( visibleAreaLeft, 0 );
                    break;
                    
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD:
                    
                    break;
                    
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS:
                    this._paintFocus();
                    break;
            }        
        };


    /**
     * 畫出游標移動 (畫出目前滑鼠位置的浮動時間標籤)
     */
    AreaXAxis.prototype._paintFocus =

        function() {
            var L_focus_tick = this._mars_k.getFocusTick();
            if (L_focus_tick != null) {
                var L_visible_area_left = this._mars_k.getVisibleAreaLeft();
                this._ctx.translate( -L_visible_area_left, 0 );
                this._ctx.translate( 0.5, 0.5 );
                this._ctx.font = AreaXAxis.prototype.FONT_LABEL;
                this._ctx.textAlign = 'center';
                this._ctx.textBaseline = "middle";
                this._ctx.shadowBlur = AreaXAxis.prototype.FLOATING_LABEL_SHADOW_BLUR;
                this._ctx.shadowColor = this._label_shadow_color;
                var bgColor = window.getComputedStyle(this._dom_canvas)['backgroundColor'];
                this._ctx.fillStyle = bgColor;
                var L_ktype = this._mars_k.getType();
                var L_time_type = L_ktype.substr( 0, 1);
                var L_format_label;
                switch (L_time_type) 
                {
                    case 'M': // 月線.
                        L_format_label = 'yyyy/MM';
                        break;

                    case 'W': // 周線.
                    case 'D': // 日線.
                        L_format_label = 'yyyy/MM/dd';
                        break;
                        
                    default:
                        L_format_label = 'yyyy/MM/dd hh:mm';
                }

                var s = L_focus_tick.time.formatWithTimezoneOffsetInMinutes( L_format_label, this._mars_k.getTimezoneOffsetInMinutes());
                var w = this._ctx.measureText(s).width + 10;
                this._ctx.fillRect( L_focus_tick.cx - w/2, 2, w, this.getHeight()-4 );
                this._ctx.fillStyle = MarsKUtility.prototype.getContrastiveColor( bgColor, 1 );
                this._ctx.fillText( s, L_focus_tick.cx, this.getHeight()/2 );
                this._ctx.translate( -0.5, -0.5 );
                this._ctx.translate( L_visible_area_left, 0 );
                this._ctx.shadowBlur = 0;
            }
        };


    /**
     * 決定所有應該畫出來的刻度
     */
    AreaXAxis.prototype.generateScales =

        function() {
            if( this._tick_width_changed===false && this._tick_amount_changed===false && this._type_changed===false )
                return;
            else
                this._tick_width_changed = this._tick_amount_changed = this._type_changed = false;

            this._ctx.font = AreaXAxis.prototype.FONT_SCALE;
            var L_all_ticks = this._mars_k.getAllTicks();
            var L_number_of_tick = L_all_ticks.length;
            if (L_number_of_tick == 0 ) {
                return;
            }
            
            for( var i = 0; i < L_number_of_tick; ++i) {
                L_all_ticks[i].xScale = null;
            }
            
            this._occupied_size = 0;
            
            if (L_number_of_tick < 2) {
                return;
            }

            var tickBegin = L_all_ticks[ 0 ];
            var tickEnd = L_all_ticks[ L_number_of_tick - 1 ];
            
            var timezoneOffsetInMinutes = this._mars_k.getTimezoneOffsetInMinutes();
            var offsetTimeOfBegin = tickBegin.time.offsetDateByTimezoneOffsetInMinutes( timezoneOffsetInMinutes);
            var offsetTimeOfEnd = tickEnd.time.offsetDateByTimezoneOffsetInMinutes( timezoneOffsetInMinutes);
            
            if( offsetTimeOfBegin.getUTCFullYear() != offsetTimeOfEnd.getUTCFullYear() ) // 跨年
                this._generateSpans( 'getUTCFullYear' );
            else if( offsetTimeOfBegin.getUTCMonth() != offsetTimeOfEnd.getUTCMonth() ) // 跨月
                this._generateSpans( 'getUTCMonth' );
            else if( offsetTimeOfBegin.getUTCDate() != offsetTimeOfEnd.getUTCDate() ) // 跨日
                this._generateSpans( 'getUTCDate' );
            else if( offsetTimeOfBegin.getUTCHours() != offsetTimeOfEnd.getUTCHours() ) // 跨小時
                this._generateSpans( 'getUTCHours' );
            // 畫出最小刻度(數量最多,不存入this._occupied,只和前1個tick比較)
            var prevOccupiedX = null;
            
            var L_font = AreaXAxis.prototype.FONT_SCALE;
            var L_format = this._fmt_scale;
            for( var i = 0; i < L_number_of_tick; ++i) {
                var tick = L_all_ticks[i];
                var x1 = tick.cx - AreaXAxis.prototype.BETWEEN_SCALE_HALF;
                var x2 = tick.cx + AreaXAxis.prototype.BETWEEN_SCALE_HALF;
                if( ! this._isOccupied(x1, x2) ) {
                    if( !prevOccupiedX || x1>prevOccupiedX ) {
                        prevOccupiedX = x2;
                        tick.xScale = {
                            'font': L_font,
                            'format': L_format,
                            'contrast': 0.4,
                            'yFix':0
                        };
                    }
                }
            }
        };


    /**
     * 印出時間跨越, 並將佔據的位置加入 IN_occupied_x
     */
    AreaXAxis.prototype._generateSpans =

        function( IN_getter_on_Date ) {
            if( -1 == AreaXAxis.prototype.TYPE_SPANS[this._type].indexOf(IN_getter_on_Date) ) // 不處理最小刻度(效能)
                return;
            
            //var timezoneOffsetInMinutes = this._mars_k.getTimezoneOffsetInMinutes();
            var df = AreaXAxis.prototype.FMT_SCALE_ALL_SPANS[ IN_getter_on_Date ];
            var index = 0;
            var L_all_ticks = this._mars_k.getAllTicks();
            var L_number_of_tick = L_all_ticks.length;
            var n1 = L_all_ticks[ index ].time[ IN_getter_on_Date ]();
            //var n1 = L_all_ticks[ index ].time.offsetDateByTimezoneOffsetInMinutes( timezoneOffsetInMinutes)[ IN_getter_on_Date ](); // 此處正確的時間應該是經過時區偏移，但是在此時間只被用於相對的比較，基於效能考量不做時區偏移。
            while( ++index < L_number_of_tick ) {
                var tick = L_all_ticks[ index ];
                var n2 = tick.time[ IN_getter_on_Date ]();
                //var n2 = tick.time.offsetDateByTimezoneOffsetInMinutes( timezoneOffsetInMinutes)[ IN_getter_on_Date ](); // 此處正確的時間應該是經過時區偏移，但是在此時間只被用於相對的比較，基於效能考量不做時區偏移。
                if( n1 != n2 ) {
                    n1 = n2;
                    var x1 = tick.cx - AreaXAxis.prototype.BETWEEN_SCALE_HALF;
                    var x2 = tick.cx + AreaXAxis.prototype.BETWEEN_SCALE_HALF;
                    if( ! this._isOccupied(x1, x2) ) {
                        tick.xScale = {
                            'font':AreaXAxis.prototype.FONT_SCALE_ALL_SPANS[IN_getter_on_Date],
                            'format':df,
                            'contrast':AreaXAxis.prototype.CONTRAST_SCALE_ALL_SPANS[IN_getter_on_Date],
                            'yFix':AreaXAxis.prototype.Y_SCALE_ALL_SPANS[IN_getter_on_Date]
                        };
                        this._occupied[ this._occupied_size++ ] = x1;
                        this._occupied[ this._occupied_size++ ] = x2;
                    }
                }
            }
            if( IN_getter_on_Date == 'getUTCFullYear' )
                this._generateSpans( 'getUTCMonth' );
            else if( IN_getter_on_Date == 'getUTCMonth' )
                this._generateSpans( 'getUTCDate' );
            else if( IN_getter_on_Date == 'getUTCDate' )
                this._generateSpans( 'getUTCHours' );
        };

    /**
     * 傳入的 x 區間是否已被佔用
     */
    AreaXAxis.prototype._isOccupied =

        function( IN_x1, IN_x2 ) {
            for( var i=0; i<this._occupied_size; i+=2 )
                if( IN_x1<=this._occupied[i+1] && IN_x2>=this._occupied[i] )
                    return true;
            return false;
        };
