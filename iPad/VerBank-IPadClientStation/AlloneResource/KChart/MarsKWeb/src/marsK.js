/**
 * K線圖
 *
 * 建議..不要直接由此建構實例... 請改用 MarsK.prototype.getInstance 取得實例
 *
 * @param IN_dom_canvas_id
 * @param IN_msg_callback - MarsK主動產生事件(或使用者對其內部元件進行操作)時的訊息回呼函式
 * @constructor
 */
var MarsK = function( IN_dom_canvas_id, IN_type, IN_locale_url_root, IN_msg_callback )
{
    this._dom_canvas = document.getElementById( IN_dom_canvas_id );
    this._dom_canvas.style['backgroundColor'] = 'inherit'; // Very important for getComputedStyle for background-color of css.
    this._dom_canvas.oncontextmenu = function() { return false;};
    this._ctx = this._dom_canvas.getContext('2d');
    this._type = IN_type;
    this._has_volume = true;
    this._msg_callback = IN_msg_callback;
    this._tick_width = MarsK.prototype.TICK_WIDTH_DEF;
    this.tickWidthChangeListener_ = null;
    this._visible_area_left = null; // 可視區域起始 x 座標
    this._visible_tick_index_range = {'begin':0, 'end':0}; // inclusive begin, exclusive end
    this._max_visible_area_left = 0; // max value 可視區域起始 x 座標
    
    this._focus_tick = null;
    this._all_ticks = [];
    this._area_x_scroll = new AreaXScroll( this, MarsK.prototype.DEF_X_SCROLL_VISIBLE, MarsK.prototype.DEF_X_SCROLL_SHOW_OVERVIEW );
    this._area_ticks = new AreaXYTicks( this );
    this._area_x_axis = new AreaXAxis( this );
    this._area_corner_right_top = new AreaCorner( this );
    this._area_corner_right_bottom = new AreaCorner( this );
    this._area_tech_insts = [];
    this._areas_of_tech = [];
    this._areas_of_fixed = [ this._area_x_scroll, this._area_ticks, this._area_x_axis, this._area_corner_right_top, this._area_corner_right_bottom ];
    this._areas = this._areas_of_fixed.slice(0);
    
    this._visibled_area_x_scroll = true;
    this._visibled_area_ticks = true;

    this._paint_data_is_dirty = false;
    
    this._caption = null;
    this._decimal_digits = null;
    this._decimal_format = null;
    
    this._dom_of_locale_script = null;
    this._i18n_lang = null;
    this._locale_url_root = null;
    this._timezone_offset_in_minutes = null; // UTC timezone offset, 480 is meaning 8 * 60(min) -> '+0800' (east-asia timezone).
    this._timezone = null; // UTC timezone offset, ex: "+0800"

    this.setLocaleURLRoot( IN_locale_url_root);

    try {
        this.setLocale( 'en-US');
    }
    catch (err) {
        console.error( err);
    }

    //this.setLocale( 'zh-TW');
    this.setDecimalDigits( 2);
    this.setTimezoneOffsetInMinutes( MarsKUtility.prototype.getTimezoneMinutes());
    
    Drawer.prototype.initStatic( this );

    this._init();
};

MarsK.prototype.WIDTH_Y_AXIS = 80; // 各區域 Y 軸寬度需統一
MarsK.prototype.HEIGHT_X_AXIS = 30; // X 時間軸的高度
MarsK.prototype.DEF_X_SCROLL_VISIBLE = true; // 預設顯示水平捲動軸
MarsK.prototype.DEF_X_SCROLL_SHOW_OVERVIEW = true; // 預設水平捲動軸顯示全域圖
MarsK.prototype.HEIGHT_X_SCROLL_OVERVIEW = 55; // 水平捲動軸預設高度 - 全域圖模式
MarsK.prototype.HEIGHT_X_SCROLL_NORMAL = 20; // 水平捲動軸預設高度 - 一般捲動軸模式
MarsK.prototype.TOUCH_ZOOM_START_THRESHOLD = 15; // 觸控縮放時2點距離大於此值時開始進行Zoom的判定
MarsK.prototype.TOUCH_ZOOM_GAP_THRESHOLD = 4; // 觸控縮放時2點距離大於此值時觸發Zoom的動作
MarsK.prototype.ZOOM_ALIGNMENT = 'right'; // or left
MarsK.prototype.TICK_WIDTH_DEF = 16; // 包含間隙的 tick 寬度預設值
MarsK.prototype.TICK_WIDTH_MIN = 1;
MarsK.prototype.TICK_WIDTH_MAX = 168;
MarsK.prototype.FOCUS_LINE_COLOR = 'rgb( 128, 128, 128)';
MarsK.prototype.MARGIN_HORIZONTAL = 100; // 左右留白寬度 (pixels) (兩側捲動到底才生效)
MarsK.prototype.CANDLE_WIDTH_RATIO = 0.5; // 蠟燭寬度與tick總寬度的比例
MarsK.prototype.GRID_CONTRAST = 0.2; // 格線對比度
MarsK.prototype.MAX_NUMBER_OF_INDEPENDENT_TECH_AREA = 5; // 獨立區域技術指標的最大限制數量
MarsK.prototype.MAX_NUMBER_OF_TICKS_TECH_AREA = 5; // Ticks區域技術指標的最大限制數量
MarsK.prototype.MAX_HEIGHT_RATIO_OF_ALL_INDEPENDENT_TECH_AREAS = 0.65;
MarsK.prototype.MIN_HEIGHT_RATIO_OF_ALL_INDEPENDENT_TECH_AREAS = 0.3;
MarsK.prototype.AREA_PAINT_LAYER_COUNTER = 0;
MarsK.prototype.AREA_PAINT_LAYERS = {
    LAYER_1_AREA_GRID: MarsK.prototype.AREA_PAINT_LAYER_COUNTER++,
    LAYER_2_AREA_CONTENT: MarsK.prototype.AREA_PAINT_LAYER_COUNTER++,
    LAYER_3_AREA_DASHBOARD: MarsK.prototype.AREA_PAINT_LAYER_COUNTER++,
    LAYER_4_FOCUS: MarsK.prototype.AREA_PAINT_LAYER_COUNTER++,
};


    /** 回傳時間類型 */
    MarsK.prototype.getType = function() { return this._type; };

    /**
     * 設定時間類型,
     *
     * 'M'=月線, 'W'=週線, 'D'=日線/週線, 'Hx'=x小時線, 'mx'=x分線
     */
    MarsK.prototype.setType =

        function( IN_type ) {
            this._type = IN_type;
            this._area_x_axis.setType( IN_type );
        };

    /**
     * 設定語言檔的URL Root
     */
    MarsK.prototype.setLocaleURLRoot =
        
        function( IN_locale_url_root) {
            this._locale_url_root = IN_locale_url_root;
        };
    
    /**
     * 設定地區語系
     */
    MarsK.prototype.setLocale = 

        function( IN_locale, IN_callback) 
        {
            var L_locale = IN_locale.replace( /(.*)[-_](.*)/, function( $0, $1, $2) { return $1.toLowerCase() + '-' + $2.toUpperCase();});
            
            var L_this = this;
            var L_async = true;
            var L_url = this._locale_url_root + 'lang_' + L_locale + '.js';
            var L_xhr = new XMLHttpRequest();
            L_xhr.onreadystatechange = function()
            {
                if (L_xhr.readyState !== 4) {
                    return;
                }
                
                if (L_xhr.status == 200) {
                    // add the returned content to a newly created script tag
                    var L_dom_of_script = document.createElement( 'script');
                    L_dom_of_script.type = "text/javascript";
                    L_dom_of_script.text = L_xhr.responseText;
                    document.getElementsByTagName('head')[0].appendChild( L_dom_of_script);

                    L_this._i18n_lang = MarsKI18N;
                    
                    // 重新繪圖來套用新的語言檔。
                    L_this.paint();
                    
                    if (IN_callback) {
                        IN_callback.call( L_this, IN_locale, true);
                    }
                }
                else {
                    if (IN_callback) {
                        IN_callback.call( L_this, IN_locale, false);
                    }
                }
            };

            L_xhr.open( 'GET', L_url, L_async);            
            L_xhr.send();
        };
        
    MarsK.prototype.i18n = 
            
        function( IN_i18n_key)
        {
            return this._i18n_lang ? this._i18n_lang[IN_i18n_key] : '---';
        };

    MarsK.prototype.isVisibledForAreaXScroll = function() { return this._visibled_area_x_scroll;};
    MarsK.prototype.isVisibledForAreaTicks = function() { return this._visibled_area_ticks;};

    MarsK.prototype.setVisibledForAreaXScroll = 
        function( IN_is_visibled)
        {
            this._visibled_area_x_scroll = IN_is_visibled;
            this._reshapeAreas();
            this._paint_data_is_dirty = true;
        };
        
    MarsK.prototype.setVisibledForAreaTicks = 
        function( IN_is_visibled)
        {
            this._visibled_area_ticks = IN_is_visibled;
            this._reshapeAreas();
            this._paint_data_is_dirty = true;
        };

    /**
     * 依照傳入的畫圖模式, 進入畫圖狀態
     *
     * @param IN_mode 模式, see drawer.js
     */
    MarsK.prototype.startDrawing =

        function( IN_mode ) {
            this._area_ticks.startDrawing( IN_mode );
        };

    /**
     * 刪除所有的畫圖
     */
    MarsK.prototype.removeAllDrawns =

        function() {
            this._area_ticks.removeAllDrawns();
        };
        
    /*
     * 重設色彩樣式(當Canvas的背景色改變就需要重設K線圖相關的色彩樣式)
     */
    MarsK.prototype.refreshColors =
        function()
        {
            for (var i in this._areas) {
                this._areas[i].refreshColors();
            }
        };

    MarsK.prototype.setTickStyleToCandle = function() { this._area_ticks.setType( 'OHLC_CANDLE'); this.paint();};
    MarsK.prototype.setTickStyleToBar = function() { this._area_ticks.setType( 'OHLC_BAR'); this.paint();};
    MarsK.prototype.setTickStyleToLine = function() { this._area_ticks.setType( 'OHLC_LINE'); this.paint();};

    MarsK.prototype.getAvailableTechs =
        
        function()
        {
            var L_available_techs = {};
            for (var L_type in AreaXYTech.prototype.DEFINITIONS) {
                var L_definition = AreaXYTech.prototype.DEFINITIONS[L_type];
                if (L_definition['useVolume'] && L_definition['useVolume'] != this._has_volume) {
                    // Use volume but MarsK has no volume.
                    continue;
                }
                
                L_available_techs[L_type] = L_definition;
            }
            return L_available_techs;
        };



    /**
     * 重新計算所有 ticks 各自的最高/最低價格(含tick區指標)
     *
     * 呼叫時機: 加入/移除 AreaTechTicks
     *
     */
    MarsK.prototype.evalAllKTicksPaintingPriceHighLow =

        function() {
            for( var i in this._all_ticks )
                this._all_ticks[i].evalPaintingPriceHighLow( this._areas_of_tech, i );
            
            this._paint_data_is_dirty = true;
        };


    /**
     * 新增技術指標區域 
     * 
     */
    MarsK.prototype.addTechArea =
            
        function( IN_tech_type) {
            var L_technical_index = AreaXYTech.prototype.DEFINITIONS[IN_tech_type];
            if (! L_technical_index) {
                return null;
            }
            
            var L_number_of_independent_tech_area = 0;
            var L_number_of_ticks_tech_area = 0;
            for (var i in this._area_tech_insts) {
                var L_area_tech = this._area_tech_insts[i]['inst'];
                if (L_area_tech.isIndependentTechnicalIndex()) {
                    ++L_number_of_independent_tech_area;
                }
                else {
                    ++L_number_of_ticks_tech_area;
                }
            }
            
            var L_is_independent_tech_area = L_technical_index['independent'];
            if (L_is_independent_tech_area) {
                if (L_number_of_independent_tech_area >= MarsK.prototype.MAX_NUMBER_OF_INDEPENDENT_TECH_AREA) {
                    return null;
                }
            }
            else {
                if (L_number_of_ticks_tech_area >= MarsK.prototype.MAX_NUMBER_OF_TICKS_TECH_AREA) {
                    return null;
                }
            }         
    
            var L_func_get_constructor = L_technical_index['getConstructor'];
            if (! L_func_get_constructor) {
                return null;
            }

            var L_constructor = L_func_get_constructor();
            if (L_constructor == null) {
                return null;
            }
            
            var L_id = L_technical_index['name'] + '_' + Date.now().toString(36) + '_' + Math.random();
            var L_area_tech = new L_constructor( this, L_id );
            this._area_tech_insts.push(
                {
                    'id': L_id,
                    'inst': L_area_tech,
                }
            );

            this._updateTechArea();

            if( L_is_independent_tech_area == false )
                this.evalAllKTicksPaintingPriceHighLow();

            this._paint_data_is_dirty = true;
            this.paint();
            return L_id;
        };

    /**
     * 移除所有技術指標區
     */
    MarsK.prototype.removeAllTechAreas = 

        function() {
            this._area_tech_insts.length = 0;
            this._paint_data_is_dirty = true;
            this.paint();
        }
        
    /**
     * 移除技術指標區域 
     * 
     */
    MarsK.prototype.removeTechArea =
            
        function( IN_tech_area_id) {
            if (this._area_tech_insts.length === 0) {
                return false;
            }
            
            var L_area_tech_insts = this._area_tech_insts;
            var L_updated = false;
            var L_removed_tech_area_is_independent_tech_area;
            for (var i in L_area_tech_insts) {
                var L_area_tech_inst = L_area_tech_insts[i];
                if (L_area_tech_inst['id'] === IN_tech_area_id) {
                    var L_area_tech = L_area_tech_inst['inst'];
                    L_removed_tech_area_is_independent_tech_area = L_area_tech.isIndependentTechnicalIndex();
                    L_area_tech_insts.splice( i, 1); // Remove it from array.
                    L_updated = true;
                    break;
                }
            }
            
            if (L_updated) {
                this._updateTechArea();
            }
            
            if( L_removed_tech_area_is_independent_tech_area === false ) {
                this.evalAllKTicksPaintingPriceHighLow();
            }
            
            this._paint_data_is_dirty = true;
            this.paint();
            return true;
        };
        
    /**
     * 刷新指標區域（改指標的參數或Style必須呼叫）
     * 
     */
    MarsK.prototype.refreshTechArea =
            
        function( IN_tech_area_id) {
            if (this._area_tech_insts.length === 0) {
                return false;
            }
            
            var L_area_tech_insts = this._area_tech_insts;
            var L_area_tech;
            var L_is_independent_tech_area;
            for (var i in L_area_tech_insts) {
                var L_area_tech_inst = L_area_tech_insts[i];
                if (L_area_tech_inst['id'] === IN_tech_area_id) {
                    L_area_tech = L_area_tech_inst['inst'];
                    L_is_independent_tech_area = L_area_tech.isIndependentTechnicalIndex();
                    break;
                }
            }
            
            if( L_is_independent_tech_area === false ) {
                this.evalAllKTicksPaintingPriceHighLow();
            }
            
            this._paint_data_is_dirty = true;
            this.paint();
            return true;
        };
        
    MarsK.prototype.getTechArea =
            
        function( IN_tech_area_id)
        {
            if (this._area_tech_insts.length >  0) {            
                var L_area_tech_insts = this._area_tech_insts;
                for (var i in L_area_tech_insts) {
                    var L_area_tech_inst = L_area_tech_insts[i];
                    if (L_area_tech_inst['id'] === IN_tech_area_id) {
                        return L_area_tech_inst['inst'];
                    }
                }
            }
            
            return null;
        };
        
    MarsK.prototype._updateTechArea = 

        function()
        {
            var L_area_tech_insts = this._area_tech_insts;
            var L_area_techs = this._areas_of_tech = [];
            for (var i in L_area_tech_insts) {
                var L_area_tech = L_area_tech_insts[i];
                L_area_techs.push( L_area_tech['inst']);
            }
            this._areas = this._areas_of_fixed.concat( L_area_techs);

            this._reshapeAreas();
        };
        
    MarsK.prototype.postMessage = 
            
        function( IN_msg)
        {
            this._msg_callback( IN_msg);
        };

    /*
     * 清除所有繪圖區中有cache圖形的部分。(當tick區的bar顏色改變後就需要清除才能重繪)
     */
     MarsK.prototype.cleanPaintCache =

        function()
        {
            this._area_x_scroll.cleanPaintCache();
        };

    /*
     * 請求繪圖動作
     */
    MarsK.prototype.paint =
        
        function()
        {
            var L_this = this;
            if( this._painting ) {
                return false;
            }
            
            this._painting = true;
            setTimeout(
                function(){
                    L_this._paint();
                    L_this._painting = false;
                },
                0
            );

            return true;
        };

    /**
     * 繪圖起點
     */
    MarsK.prototype._paint =

        function() {
            this._ctx.clearRect( 0, 0, this._dom_canvas.width, this._dom_canvas.height );
    
            if( this._all_ticks.length == 0 )
                return;

            this._confineVisibleArea();
            
            if (this._paint_data_is_dirty) {
                this._paint_data_is_dirty = false;
                
                // 繪圖資料已經被改變，呼叫所有AreagetFormattedPrice重新準備繪圖資料
                var L_areas = this._areas;
                for (var i in L_areas) {
                    var L_the_area = L_areas[i];
                    if (L_the_area.doPrepareDataForPaint) {
                        L_the_area.doPrepareDataForPaint();
                    }
                }
            }

            var L_areas = this._areas;
            for (var i in L_areas)
                L_areas[i].paint( MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID );
            
            for (var i in L_areas)
                L_areas[i].paint( MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT );
            
            for (var i in L_areas)
                L_areas[i].paint( MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD );
            
            // 畫出滑鼠焦點十字線中的垂直線及浮動標籤
            if( this._focus_tick ) {
                var visibleAreaLeft = this.getVisibleAreaLeft();
                this._ctx.translate( -visibleAreaLeft + 0.5, 0.5 );
                this._ctx.beginPath();
                this._ctx.lineWidth = 1;
                this._ctx.strokeStyle = MarsK.prototype.FOCUS_LINE_COLOR;
                this._ctx.moveTo( this._focus_tick.cx + this._area_ticks._x, this._area_ticks._y );
                this._ctx.lineTo( this._focus_tick.cx + this._area_ticks._x, this._dom_canvas.height );
                this._ctx.stroke();
                this._ctx.translate( visibleAreaLeft - 0.5, -0.5 );
                for (var i in L_areas)
                    L_areas[i].paint( MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS );
            }
        };


    MarsK.prototype.getDomCanvas = function() { return this._dom_canvas; }
    MarsK.prototype.getContext = function() { return this._ctx; };
    MarsK.prototype.getAreaTicks = function() { return this._area_ticks; }
    MarsK.prototype.getFocusTick = function() { return this._focus_tick; }
    MarsK.prototype.getFocusTickIndex = function() { return this._focus_tick_index; }    
    MarsK.prototype.getAllTicks = function() { return this._all_ticks; }
    MarsK.prototype.getType = function() { return this._type; }
    MarsK.prototype.getCaption = function() { return this._caption; }
    MarsK.prototype.setCaption = function( IN_caption) { this._caption = IN_caption; }
    MarsK.prototype.getHasVolume = function() { return this._has_volume;}
    MarsK.prototype.setHasVolume = function( IN_has_volume) { this._has_volume = IN_has_volume;}

    MarsK.prototype.getDecimalDigits = function() { return this._decimal_digits; }
    MarsK.prototype.setDecimalDigits = function( IN_decimal_digits)
    { 
        this._decimal_digits = IN_decimal_digits;
        var dfString = '#,###,###,##0.';
        for( var i=0; i<this._decimal_digits; ++i )
            dfString += '0';
        this._decimal_format = new DecimalFormat( dfString );
    };
    
    MarsK.prototype.getTimezone = function() { return this._timezone;};
    MarsK.prototype.getTimezoneOffsetInMinutes = function() { return this._timezone_offset_in_minutes;};
    MarsK.prototype.setTimezoneOffsetInMinutes = function( IN_timezone_offset_in_minutes) {        
        var L_sign = (IN_timezone_offset_in_minutes >= 0) ? '+' : '-';
        this._timezone = L_sign + MarsKUtility.prototype.leadingZero( Math.floor( Math.abs( IN_timezone_offset_in_minutes) / 60), 2) + '00';        
        this._timezone_offset_in_minutes = IN_timezone_offset_in_minutes;
        this._paint_data_is_dirty = true;
    }
         
    
    MarsK.prototype.getFormattedPrice = function( price ) { return this._decimal_format.format(price); }
    MarsK.prototype.getPriceDecimalFormat = function() { return this._decimal_format; }
    
        
   /** 左邊 ticks 區域的寬度 */
    MarsK.prototype.getTicksAreaWidthExcludeYAxis =

        function() {
            return this._dom_canvas.width - MarsK.prototype.WIDTH_Y_AXIS;
        };

    /**
     * 傳入 X 座標值, 取得對應的 tick
     */
    MarsK.prototype.getTickFromX =

        function( IN_x ) {
            return this._all_ticks[ this.getTickIndexFromX(IN_x) ];
        };

    /**
     * 傳入 X 座標值, 取得對應的 tick index
     */
    MarsK.prototype.getTickIndexFromX =

        function( IN_x ) {
            var rv = Math.floor( (IN_x - MarsK.prototype.MARGIN_HORIZONTAL) / this._tick_width );
            return rv<0? 0 : rv>=this._all_ticks.length? this._all_ticks.length-1 : rv;
        };

    /**
     * 傳入 tick index, 取得對應 tick 起始 X 座標值
     */
    MarsK.prototype.getXFromTickIndex =

        function( IN_index ) {
            return Math.ceil( MarsK.prototype.MARGIN_HORIZONTAL + IN_index * this._tick_width );
        };
        
    /*
     * 取得 tick 的繪製基準 X 座標之最大可能值
     */
    MarsK.prototype.getMaxVisibleAreaLeft = 
            
        function() {
            return this._max_visible_area_left;
        };

    /**
     * 取得 ticks 的繪製基準 X 座標
     */
    MarsK.prototype.getVisibleAreaLeft =

        function() {
            return this._visible_area_left;
        };

    /**
     * 改變 ticks 的繪製基準 X 座標
     */
    MarsK.prototype.setVisibleAreaLeft =

        function( IN_newDatumX ) {
            if (IN_newDatumX == null) {
                this._visible_area_left = null;
            }
            else {
                this._visible_area_left = Math.floor( IN_newDatumX );
            }
        };

    /**
     * 回傳 begin/end index of visible ticks
     */
    MarsK.prototype.getVisibleTickIndexRange =

        function() {
            return this._visible_tick_index_range;
        };      

    /** 取得單一 tick 寬度 */
    MarsK.prototype.getTickWidth =

        function() {
            return this._tick_width;
        };

    /** 取得 tick 內的蠟蠋寬度 (we draw the candle from x=0 within a tick) */
    MarsK.prototype.getCandleWidth =

        function() {
            var rv = Math.round( this.getTickWidth() * MarsK.prototype.CANDLE_WIDTH_RATIO );
            return rv<1? 1 : rv;
        };

    /** 設定一次至少顯示幾根 ticks */
    MarsK.prototype.setSizeOfVisibleTicks =

        function( IN_size ) {
            this.setTickWidth( this._dom_canvas.width / (IN_size+1) );
            this.paint();
        };

    /** 改變單一 tick 寬度 */
    MarsK.prototype.setTickWidth =

        function( IN_newTickWidth ) {
            var visibleAreaLeft;
            this._tick_width = IN_newTickWidth;
            this._area_x_scroll._ctx_bg = null; // repaint bg of x-scroll
            if( MarsK.prototype.ZOOM_ALIGNMENT == 'left' )
                visibleAreaLeft = this.getXFromTickIndex( this._visible_tick_index_range.begin );
            else { // 'right'
                var indexRight = this._visible_tick_index_range.end - (this._visible_tick_index_range.end==this._all_ticks.length?0:1);
                visibleAreaLeft = this.getXFromTickIndex(indexRight) - this.getTicksAreaWidthExcludeYAxis();
            }
            this.setVisibleAreaLeft( visibleAreaLeft ); // this.getXFromTickIndex(visibleIndexLeft) );
            this._area_x_axis.setTickWidthChanged();
            this._computeAllTicksCoordinates();
        };

    /** 回傳畫出全部 ticks 的總寬度 */
    MarsK.prototype.getTotalWidth =

        function() {
            return MarsK.prototype.MARGIN_HORIZONTAL*2 + this._tick_width * this._all_ticks.length;
        };
        
    MarsK.prototype.setFocusTick =
            
        function( IN_relative_x)
        {
            this._focus_tick_index = -1;
            this._focus_tick = null;
            if (IN_relative_x != null) {
                this._focus_tick_index = this.getTickIndexFromX( this.getVisibleAreaLeft() + IN_relative_x);
                this._focus_tick = this._all_ticks[this._focus_tick_index];
                if( this._focus_tick ) {
                    var xFocusTick = this._focus_tick.cx - this._visible_area_left;
                    if( xFocusTick < 0 || xFocusTick > this._area_ticks._width-MarsK.prototype.WIDTH_Y_AXIS ) {
                        this._focus_tick_index = -1;
                        this._focus_tick = null;
                    }

                }
            }
        };


    //================================================================================================================
    // 滑鼠 & 觸控
    //================================================================================================================

    /**
     * 鼠鍵被按下(不分左右)
     */
    MarsK.prototype.mouseDown =

        function( IN_evt ) {
            // IN_evt.preventDefault();
            
            var L_areas = this._areas;
            for( var i in  L_areas) {
                var L_the_area = L_areas[i];
                if( L_the_area.isHit(IN_evt) ) {
                    L_the_area.mouseDown( IN_evt );
                }
            }
        };

    /**
     * 滑鼠移動中
     */
    MarsK.prototype.mouseMove =

        function( IN_evt ) {    
            var L_applied_cursor;
            var L_areas = this._areas;
            for( var i in L_areas ) {
                var L_the_area = L_areas[i];
                if( L_the_area.isHit(IN_evt) ) {
                    var L_cursor = L_the_area.mouseMove( IN_evt );
                    if (L_applied_cursor === undefined && L_cursor != null) {
                        L_applied_cursor = L_cursor;
                    }
                }
                else {
                    L_the_area.mouseOut( IN_evt );
                }
            }

            // Determine focus tick by areaTicks or areaTechs.
            var L_mouse_moving_in_ticks_area = this._area_ticks.getMouseMovingPosition();
            if( L_mouse_moving_in_ticks_area == null )
                for (var i in this._areas_of_tech) {
                    L_mouse_moving_in_ticks_area = this._areas_of_tech[i].getMouseMovingPosition();
                    if (L_mouse_moving_in_ticks_area != null)
                        break;
                }

            this.setFocusTick( L_mouse_moving_in_ticks_area ? L_mouse_moving_in_ticks_area.x : null);

            this.paint();
            
            this._dom_canvas.style.cursor = L_applied_cursor ? L_applied_cursor : 'default';
        };

    /**
     * 鼠鍵被放開
     */
    MarsK.prototype.mouseUp =

        function( IN_evt ) {
            for( var i in this._areas )
                if( this._areas[i].isHit(IN_evt) ) {
                    this._areas[i].mouseUp( IN_evt );
                }
        };

    /**
     * 滑鼠移出
     */
    MarsK.prototype.mouseOut =

        function( IN_evt ) {
            for( var i in this._areas )
                this._areas[i].mouseOut( IN_evt );
        };

    /**
     * 滑鼠滾輪轉動
     */
    MarsK.prototype.mouseWheel =

        function( IN_evt ) {
            IN_evt.preventDefault();
            for( var i in this._areas )
                if( this._areas[i].isHit(IN_evt) ) {
                    this._areas[i].mouseWheel( IN_evt );
                }
        };

    /**
     * 開始觸摸螢幕
     */
    MarsK.prototype.touchStart =

        function( IN_evt ) {            
            for( var i in this._areas )
                if( this._areas[i].isHit(IN_evt) ) {
                    this._areas[i].touchStart( IN_evt );
                }
        };

    /**
     * 觸控移動中
     */
    MarsK.prototype.touchMove =

        function( IN_evt ) {
            IN_evt.preventDefault();
            for( var i in this._areas )
                if( this._areas[i].isHit(IN_evt) ) {
                    this._areas[i].touchMove( IN_evt );
                }
        };

    /**
     * 離開觸控螢幕 (未考慮剩餘觸控點數量)
     */
    MarsK.prototype.touchEnd =

        function( IN_evt ) {
            IN_evt.preventDefault();
            for( var i in this._areas )
                if( this._areas[i].isHit(IN_evt) ) {
                    this._areas[i].touchEnd( IN_evt );
                }
        };

    /**
     * 鍵盤
     */
    MarsK.prototype.keyDown =

        function( IN_evt ) {
            for( var i in this._areas )
                if( this._areas[i].procKeyDown ) {
                    this._areas[i].procKeyDown( IN_evt );
                }
        };


    /**
     * 執行水平縮放
     */
    MarsK.prototype.zoomAndPaint =

        function( IN_bool_zoomIn ) {
            var newTickWidth = IN_bool_zoomIn? this.getTickWidth() * 1.1 : this.getTickWidth() * 0.92;
            newTickWidth = newTickWidth < MarsK.prototype.TICK_WIDTH_MIN ? MarsK.prototype.TICK_WIDTH_MIN
                : newTickWidth > MarsK.prototype.TICK_WIDTH_MAX ? MarsK.prototype.TICK_WIDTH_MAX
                : newTickWidth;
                
            if( newTickWidth != this.getTickWidth() ) {
                this.setTickWidth( newTickWidth );
                this.paint();
                if( this.tickWidthChangeListener_ != null )
                    this.tickWidthChangeListener_.call( this, newTickWidth );
            }
        };
        
    /** 設定水平比例改變的回呼函式 */
    MarsK.prototype.setTickWidthChangeListener =

        function( callback ) {
            this.tickWidthChangeListener_ = callback;
        };
    
    MarsK.prototype.resize = function( IN_width, IN_height)
    {   
        if (this._dom_canvas.width == IN_width && this._dom_canvas.height == IN_height) {
            return;
        }
        
        this._dom_canvas.width = IN_width;
        this._dom_canvas.height = IN_height;
        
        this._reshapeAreas();
        
        var L_areas = this._areas;
        for( var i in L_areas ) {
            L_areas[i].resize();
        }
        
        this._paint_data_is_dirty = true; // Resize may cause y-axis scaling changed.
        this.paint();
    };
    
    MarsK.prototype.resizeToClientSize = function()
    {
        var L_dom_canvas = this._dom_canvas;
        return this.resize( L_dom_canvas.clientWidth, L_dom_canvas.clientHeight);
    };


    //================================================================================================================
    // 以下函式 "不應該" 由別處叫用
    //================================================================================================================

    /**
     * 初始化
     */
    MarsK.prototype._init =

        function() {
            // 註冊輸入事件
            var L_dom_canvas = this._dom_canvas;
            
            var L_event_name_of_mousewheel = ( 'onmousewheel' in L_dom_canvas ) ? 'mousewheel' : 'DOMMouseScroll'; // MouseWheel is not a standard event.
            MarsKUtility.prototype.registerEvent( L_dom_canvas, L_event_name_of_mousewheel, this, MarsK.prototype.mouseWheel);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'mousedown', this, MarsK.prototype.mouseDown);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'mousemove', this, MarsK.prototype.mouseMove);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'mouseup', this, MarsK.prototype.mouseUp);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'mouseout', this, MarsK.prototype.mouseOut);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'touchstart', this, MarsK.prototype.touchStart);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'touchmove', this, MarsK.prototype.touchMove);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'touchend', this, MarsK.prototype.touchEnd);
            MarsKUtility.prototype.registerEvent( L_dom_canvas, 'keydown', this, MarsK.prototype.keyDown);

            // 當滑鼠移出整個document範圍時(IE).
            MarsKUtility.prototype.registerEvent( 
                document, 
                'mouseout', 
                this, 
                function( IN_event)
                {
                    MarsK.prototype.mouseUp.call( this, IN_event);
                    MarsK.prototype.mouseOut.call( this, IN_event);
                }
            );
    
            this.resizeToClientSize();
            this._reshapeAreas(); // 決定各區域位置及大小
            this.paint();
        };

    /*
     * 決定可視區域範圍
     */
    MarsK.prototype._confineVisibleArea =

        function() {            
            var L_tick_area_width_exclude_y_axis = this.getTicksAreaWidthExcludeYAxis();  
            this._max_visible_area_left = this.getTotalWidth() - L_tick_area_width_exclude_y_axis;
            if (this._max_visible_area_left < 0) {
                this._max_visible_area_left = 0;
            }
            
            if( this._visible_area_left == null )
                this._visible_area_left = this._max_visible_area_left; // 預設顯示最右邊(最近期)的 ticks
            else if( this._visible_area_left < 0 )
                this._visible_area_left = 0;
            else if( this._visible_area_left > this._max_visible_area_left)
                this._visible_area_left = this._max_visible_area_left;

            // Reserve previous range for dirty checking.
            var L_prev_tick_index_range_begin;
            var L_prev_tick_index_range_end;
            if (this._visible_tick_index_range) {
                L_prev_tick_index_range_begin = this._visible_tick_index_range.begin;
                L_prev_tick_index_range_end = this._visible_tick_index_range.end;
            }

            var L_visible_tick_index_range = this._visible_tick_index_range;
            L_visible_tick_index_range.begin = this.getTickIndexFromX( this._visible_area_left );
            L_visible_tick_index_range.end = this.getTickIndexFromX( this._visible_area_left + L_tick_area_width_exclude_y_axis ) + 1;
            if( L_visible_tick_index_range.begin < 0 )
                L_visible_tick_index_range.begin = 0;
            if( L_visible_tick_index_range.end > this._all_ticks.length )
                L_visible_tick_index_range.end = this._all_ticks.length;        

            // Dirty checking by visible tick index range for paint data preparing.
            if (L_visible_tick_index_range.begin !== L_prev_tick_index_range_begin || L_visible_tick_index_range.end !== L_prev_tick_index_range_end) {
                this._paint_data_is_dirty = true;
            }
        };

    /*
     * 重新決定目前顯示於畫面的所有 ticks 各項座標值
     * 回傳顯示範圍 [indexBegin, indexEnd] (包含兩端)
     */
    MarsK.prototype._computeAllTicksCoordinates =

        function() {
            var L_all_ticks = this._all_ticks;
            var candleWidth = this.getCandleWidth();
            var tickWidth = this.getTickWidth();
            var L_number_of_tick = L_all_ticks.length;
            for( var idx = 0; idx < L_number_of_tick; ++idx) {
                var tick = L_all_ticks[ idx ];
                //tick.x = Math.floor( this.getXFromTickIndex(idx) ); // getXFromTickIndex回傳的已經是經過Math.ceil的了，所以拿到用下行取代看看。
                tick.x = this.getXFromTickIndex(idx);
                tick.candleLeft = Math.floor( tick.x + (tickWidth - candleWidth)/2 );
                tick.cx = Math.round( tick.candleLeft + candleWidth/2 );
                tick.rising = tick.open <= tick.close;
            }
//MarsKUtility.prototype.anchorProfile();
            this._area_x_axis.generateScales();
            this._paint_data_is_dirty = true;
//console.log( 'Cost: ' + MarsKUtility.prototype.anchorProfile());
        };
        

    /**
     * 依目前 canvas 尺寸決定各區域位置及大小
     */
    MarsK.prototype._reshapeAreas =

        function() {
            // 計算獨立顯示之技術指標區與Tick區分到的高度比例。
            var L_area_techs = this._areas_of_tech;
            var L_max_number_of_independent_tech_area = MarsK.prototype.MAX_NUMBER_OF_INDEPENDENT_TECH_AREA;
            var L_number_of_independent_tech_area = 0;
            for (var i in L_area_techs) {
                var L_the_area_tech = L_area_techs[i];
                if (L_the_area_tech.isIndependentTechnicalIndex()) {
                    ++L_number_of_independent_tech_area;
                }
            }
            
            var L_height_ratio_of_all_area_techs;
            if (L_number_of_independent_tech_area >= 1) {
                L_height_ratio_of_all_area_techs = (L_number_of_independent_tech_area - 1) / (L_max_number_of_independent_tech_area - 1) * (MarsK.prototype.MAX_HEIGHT_RATIO_OF_ALL_INDEPENDENT_TECH_AREAS - MarsK.prototype.MIN_HEIGHT_RATIO_OF_ALL_INDEPENDENT_TECH_AREAS) + MarsK.prototype.MIN_HEIGHT_RATIO_OF_ALL_INDEPENDENT_TECH_AREAS;
            }
            else {
                L_height_ratio_of_all_area_techs = 0;
            }
            
            var L_height_ratio_of_ticks_area = 1 - L_height_ratio_of_all_area_techs;
            
            // Reshape all areas.
            var L_canvas_width = this._dom_canvas.width;
            var L_canvas_height = this._dom_canvas.height;
            
            // AreaXScroll.
            var L_area_height_x_scroll;
            var L_area_width_x_scroll = L_canvas_width - MarsK.prototype.WIDTH_Y_AXIS;
            if (this._visibled_area_x_scroll) {
                L_area_height_x_scroll = !this._area_x_scroll.isVisible()? 0 : this._area_x_scroll.isOverviewMode()? MarsK.prototype.HEIGHT_X_SCROLL_OVERVIEW:MarsK.prototype.HEIGHT_X_SCROLL_NORMAL;
                
                this._area_x_scroll.reshape( 0, 0, L_area_width_x_scroll, L_area_height_x_scroll );
                
                // AreaCorner - Right-Top.
                this._area_corner_right_top.reshape( L_area_width_x_scroll, 0, MarsK.prototype.WIDTH_Y_AXIS, this._area_x_scroll.getHeight() );
            }
            else {
                L_area_height_x_scroll = 0;
                L_area_width_x_scroll = 0;
                this._area_x_scroll.reshape( 0, 0, L_area_width_x_scroll, 0);
                
                // AreaCorner - Right-Top.
                this._area_corner_right_top.reshape( L_area_width_x_scroll, 0, MarsK.prototype.WIDTH_Y_AXIS, 0 );
            }

            // AreaXYTicks.
            var L_area_height_ticks;
            var L_area_height_of_tick_area;
            if (this._visibled_area_ticks) {
                L_area_height_ticks = L_canvas_height - L_area_height_x_scroll - MarsK.prototype.HEIGHT_X_AXIS;
                L_area_height_of_tick_area = Math.floor( L_area_height_ticks * L_height_ratio_of_ticks_area );
                this._area_ticks.reshape( 0, this._area_x_scroll.getHeight(), L_canvas_width, L_area_height_of_tick_area );
            }
            else {
                L_area_height_ticks = 0;
                L_area_height_of_tick_area = 0;
                this._area_ticks.reshape( 0, this._area_x_scroll.getHeight(), L_canvas_width, 0);
            }
            
            // AreaXAxis.
            var L_area_top_x_axis = this._area_x_scroll.getHeight() + this._area_ticks.getHeight();
            this._area_x_axis.reshape( 0, L_area_top_x_axis, L_area_width_x_scroll, MarsK.prototype.HEIGHT_X_AXIS );
            
            // AreaCorner - Right-Bottom.
            this._area_corner_right_bottom.reshape( L_area_width_x_scroll, L_area_top_x_axis, MarsK.prototype.WIDTH_Y_AXIS, MarsK.prototype.HEIGHT_X_AXIS );
            
            var L_area_tech_top = L_area_top_x_axis + MarsK.prototype.HEIGHT_X_AXIS;
            var L_height_of_tech_areas = L_canvas_height - L_area_height_x_scroll - MarsK.prototype.HEIGHT_X_AXIS - L_area_height_of_tick_area;// L_area_height_ticks * L_height_ratio_of_all_area_techs;
            var L_height_of_independent_tech_area = L_number_of_independent_tech_area >= 1 ? Math.floor(L_height_of_tech_areas / L_number_of_independent_tech_area) : null;
            var L_vertical_ordering_of_tech_ticks = 1;
            for (var i in L_area_techs) {
                var L_area_tech = L_area_techs[i];
                if (L_area_tech.isIndependentTechnicalIndex()) {
                    L_area_tech.reshape( 0, L_area_tech_top, L_canvas_width, L_height_of_independent_tech_area);
                    L_area_tech_top += L_height_of_independent_tech_area;    
                }
                else {
                    if (this._visibled_area_ticks) {
                        L_area_tech.reshape( 0, this._area_x_scroll.getHeight(), L_canvas_width, L_area_height_of_tick_area );
                        L_area_tech.setToolbarVerticalOrdering( L_vertical_ordering_of_tech_ticks++);
                    }
                    else {
                        // Tick被隱藏的話，畫在tick區的技術指標也就要被隱藏。
                        L_area_tech.reshape( 0, L_area_tech_top, L_canvas_width, 0);
                    }
                }                
            }
        };
        
    /**
     * 刪除所有tick
     */
    MarsK.prototype.removeAllKTicks =
        
        function()
        {
            this._all_ticks = [];
            this._computeAllTicksCoordinates();
            
            var L_areas = this._areas;
            for ( var i in L_areas ) {
                var L_area = L_areas[i];
                var L_func = L_area.removeAllTicks;
                if (L_func) {
                    L_func.call( L_area);
                }
            }
        };

    /**
     * 從左邊加入 ticks
     */
    MarsK.prototype.insertKTicks =

        function( IN_arr_ticks ) {
            for( var i=IN_arr_ticks.length-1; i>-1; --i )
                this._all_ticks.unshift( IN_arr_ticks[i] );
            this._computeAllTicksCoordinates();
            
            var L_areas = this._areas;
            for ( var i in L_areas ) {
                var L_area = L_areas[i];
                var L_func = L_area.insertTicks;
                if (L_func) {
                    L_func.call( L_area, IN_arr_ticks);
                }
            }
        };

    /**
     * 從右邊加入 ticks
     */
    MarsK.prototype.appendKTicks =

        function( IN_arr_ticks ) {
            for( var i in IN_arr_ticks )
                this._all_ticks.push( IN_arr_ticks[i] );
            this._computeAllTicksCoordinates();

            var L_areas = this._areas;
            for ( var i in L_areas ) {
                var L_area = L_areas[i];
                var L_func = L_area.appendTicks;
                if (L_func) {
                    L_func.call( L_area, IN_arr_ticks);
                }
            }
        };

    MarsK.prototype.getLastKTick =

        function() {
            if( this._all_ticks.length > 0 ) {
                return this._all_ticks[this._all_ticks.length - 1];
            }
            return null;
        };

    /**
     * 更新最後一根 tick
     */
    MarsK.prototype.updateLastKTick =

        function( IN_last_tick ) {
            if( this._all_ticks.length > 0 ) {
                this._all_ticks[this._all_ticks.length - 1] = IN_last_tick;
                this._computeAllTicksCoordinates();

                var L_areas = this._areas;
                for ( var i in L_areas ) {
                    var L_area = L_areas[i];
                    var L_func = L_area.updateLastTick;
                    if (L_func) {
                        L_func.call( L_area );
                    }
                }
            }
        };


    //
    // temp function to create dummy ticks
    //
    MarsK.prototype.insertDummyTicks =

        function() {
            var dir = 1;
            var price = 103.68;
            var now = Date.now();
            var tmpArray = [];
            for( var i=0; i<5000; ++i ) {
                var diff = 0.1 * Math.random();
                var reverse = Math.random()>0.6;
                dir *= reverse? -1 : 1;
                price += diff * dir;
                var tick = new KTick();
                var tall = MarsKUtility.prototype.round( 0.2 * Math.random(), this._decimal_digits );
                tick.high = MarsKUtility.prototype.round( price + tall/2, this._decimal_digits );
                tick.low = MarsKUtility.prototype.round( price - tall/2, this._decimal_digits );
                tick.open = MarsKUtility.prototype.round( tick.high - tall*Math.random(), this._decimal_digits );
                tick.close = MarsKUtility.prototype.round( tick.low + tall*Math.random(), this._decimal_digits );
                tick.rising = tick.open <= tick.close;
                tick.time = new Date( now );
                tick.volume = Math.floor( Math.random() * 10000);
                tick.paintingPriceHigh = tick.high;
                tick.paintingPriceLow = tick.low;
                tmpArray.splice( 0, 0, tick );
                now -= 60*60000; // 1h
            }
            this.appendKTicks( tmpArray );
        };
    
    /*
     * 保存所有設定至JSON (不包含Tick及相關資料)
     */
    MarsK.prototype.saveToJson = 
            
        function()
        {
            // 基本設定
            var L_json = {
                //'has_volume': this.getHasVolume(),
                'visibled_area_x_scroll': this._visibled_area_x_scroll,
                'visibled_area_ticks': this._visibled_area_ticks,
                'area_ticks': {
                    'params': this._area_ticks.getParams()
                },
            };
    
            // 技術指標區
            var L_json_area_techs = L_json['area_techs'] = [];
            var L_areas_of_tech = this._areas_of_tech;
            for (var i in L_areas_of_tech) {
                var L_area_tech = L_areas_of_tech[i];
                L_json_area_techs.push(
                    {
                        'type': L_area_tech.getType(),
                        'params': L_area_tech.getParams(),
                    }
                );
            }
            
            return JSON.stringify( L_json);
        };
     
    /*
     * 從JSON物件套用之前保存的設定 (不包含Tick及相關資料)
     */
    MarsK.prototype.restoreFromJson =
            
        function( IN_json)
        {
            var L_json = (typeof IN_json == 'string') ? JSON.parse( IN_json) : IN_json;

            // 清除原本的技術指標。
            this.removeAllTechAreas();

            // 基本設定
            //this.setHasVolume( L_json['has_volume']);
            this.setVisibledForAreaXScroll( L_json['visibled_area_x_scroll']);
            this.setVisibledForAreaTicks( this._visibled_area_ticks = L_json['visibled_area_ticks']);
            
            this._area_ticks.setParams( L_json['area_ticks']['params']);
            
            // 技術指標區
            var L_json_area_techs = L_json['area_techs'];
            for (var i in L_json_area_techs) {
                var L_json_area_tech = L_json_area_techs[i];
                
                // Add area tech by type.
                var L_area_tech_type = L_json_area_tech['type'];
                var L_area_id = this.addTechArea( L_area_tech_type);
                
                // Set params.
                var L_area_tech = this.getTechArea( L_area_id);
                L_area_tech.setParams( L_json_area_tech['params']);
            }
        };
