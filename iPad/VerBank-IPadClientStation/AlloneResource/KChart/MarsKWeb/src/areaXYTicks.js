/**
 * 上半部 Ticks, 含Y軸(價格軸)
 *
 *
 */
var AreaXYTicks = function( IN_mars_k )
{
    var tickType = 'OHLC_CANDLE'; // 'OHLC_BAR', 'OHLC_LINE'
    this._initAreaXY( IN_mars_k, true, true, tickType, AreaXYTicks.prototype.MARGIN_VERTICAL, AreaXYTicks.prototype.MARGIN_VERTICAL);
    this._visible_price_high = 0; // the highest price among all displaying ticks
    this._pixels_per_value = 0; // current price:pixel ratio
    this._y_scales = []; // 畫出的 Y 軸刻度

    this._tap_relative_px = null;
    this._tap_relative_py = null;    

    this._drawing = null; // 正在進行中的畫圖模式, null=無
    this._drawns = []; // 所有已完成的畫圖結果
};
AreaXYTicks.prototype = new AreaXY();
AreaXYTicks.prototype.constructor = AreaXYTicks;
AreaXYTicks.prototype.MARGIN_VERTICAL = 30; // 上下留白高度 (pixels)
AreaXYTicks.prototype.Y_AXIS_MIN_SCALE_GAP_PIXELS = 38; // Y軸價格刻度最小間距 (pixels)
AreaXYTicks.prototype.Y_AXIS_FONT_SCALE = '12px Arial'; // Y軸價格刻度文字字型
AreaXYTicks.prototype.Y_AXIS_FONT_LABEL = '13px Arial'; // Y軸浮動價格標籤文字字型
AreaXYTicks.prototype.Y_AXIS_TEXT_ALIGN = 'left'; // Y軸價格刻度文字水平對齊方式
AreaXYTicks.prototype.Y_AXIS_TEXT_POSITION = 3; // Y軸價格刻度文字起始 x 座標
AreaXYTicks.prototype.Y_AXIS_FLOATING_LABEL_SHADOW_BLUR = 15; // 滑鼠垂直位置浮動價格標籤陰影厚度

AreaXYTicks.prototype.UI_TOOLBUTTONS = [
    { 'name': null, 'img_id': null},
    { 'name': 'configure', 'img_id': 'img_config'}
];


    /**
     * 依照傳入的畫圖模式, 進入畫圖狀態
     *
     * @param IN_mode 模式, see drawer.js
     */
    AreaXYTicks.prototype.startDrawing =

        function( IN_mode ) {
            this._drawing = Drawer.prototype.createTechDrawer( this._mars_k, IN_mode );
            this._is_draggable = this._drawing==null; // 畫圖中 disable 時間軸拖曳
        };

    /**
     * 刪除所有的畫圖
     */
    AreaXYTicks.prototype.removeAllDrawns =

        function() {
            this._drawns = [];
            this._mars_k.paint();
        };

    /**
     * 是否正在畫圖狀態?
     */
    AreaXYTicks.prototype.isDrawing =

        function() {
            return this._drawing != null;
        };

    /**
     * 儲存目前的畫圖結果並離開畫圖狀態
     */
    AreaXYTicks.prototype.saveAndStopDrawing =

        function() {
            this._drawns.push( this._drawing );
            this.stopDrawing();
        };

    /**
     * 離開畫圖狀態
     */
    AreaXYTicks.prototype.stopDrawing =

        function() {
            this._drawing = null;
            this._is_draggable = true;
            this._mars_k.paint();
        };



    AreaXYTicks.prototype.doPrepareDataForPaint =
            
        function()
        {
            // 注意：目前計算結果仍然是放在Tick裡面，如果能放在Element裡面的話程式會更有一致性(的樣子)。
            var L_all_ticks = this._mars_k.getAllTicks();
            if( L_all_ticks.length == 0 )
                return;

            this._value_high = 0;
            this._value_low = Number.POSITIVE_INFINITY;
            var tallestCandle = 0;
            var L_visible_tick_index_range = this._mars_k.getVisibleTickIndexRange();
            for( var i = L_visible_tick_index_range.begin; i < L_visible_tick_index_range.end; ++i ) {
                var tick = L_all_ticks[ i ];
                if( tick.paintingPriceHigh > this._value_high )
                    this._value_high = tick.paintingPriceHigh;
                if( tick.paintingPriceLow < this._value_low )
                    this._value_low = tick.paintingPriceLow;
                if( tick.high-tick.low > tallestCandle )
                    tallestCandle = tick.high - tick.low;
            }

            var priceRange = this._value_high - this._value_low;
            var minPriceRange = Math.max( 1.5 * tallestCandle, Number.EPSILON);
            if( priceRange < minPriceRange ) {
                priceRange = minPriceRange;
            }

            // Determine pixels per price.
            this._pixels_per_value = (this.getHeight() - 2 * AreaXYTicks.prototype.MARGIN_VERTICAL) / priceRange;
            
            for( var idx = L_visible_tick_index_range.begin; idx < L_visible_tick_index_range.end; ++idx ) {
                var tick = L_all_ticks[idx];
                tick.rectUp = Math.floor( this.getYFromValue( tick.rising? tick.close : tick.open ) );
                tick.rectHeight = Math.floor( Math.abs(tick.close-tick.open) * this._pixels_per_value );
                tick.yHigh = Math.floor( this.getYFromValue( tick.high ) );
                tick.yLow = Math.floor( this.getYFromValue( tick.low ) );
            }
        };
        
        
    /**
     * 畫出此區
     */
    AreaXYTicks.prototype._doPaintForXY =

        function( IN_layer) {
            if (! this._mars_k.isVisibledForAreaTicks()) {
                return;
            }
            
            switch (IN_layer)
            {
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
                    break;
                    
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:
                    this._paintVerticalGrids(); // area.js
                    this._paintHorizontalGrids();
                    this._paintTicks(); // paint ticks
                    // 已完成的技術分析畫圖
                    this._ctx.save();
                    this._ctx.rect( 0, 0, this._width, this._height);
                    this._ctx.clip();
                    for( var i in this._drawns )
                        this._drawns[i].paint( this._ctx );
                    // 正在畫的技術分析畫圖
                    if( this._drawing )
                        this._drawing.paint( this._ctx );
                    this._ctx.restore();
                    this._paintSplitBar(); // area.js
                    break;
                    
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD:
                    this._paintYAxis(); // paint the y axis, and horizontals in ticks area
                    break;
                    
                case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS:
                    this._ctx.translate( 0.5, 0.5 );
                    this._paintFocus( this._mars_k.getPriceDecimalFormat());
                    this._ctx.translate( -0.5, -0.5 );
                    break;
            }
        };


    /**
     * 價格上漲的 tick 顏色
     */
    AreaXYTicks.prototype.getColorRisingTick =

        function() {
            switch( this._type ) {
                case 'OHLC_CANDLE': return this.getParams()['colorRisingBorder'];
                case 'OHLC_BAR': return this.getParams()['colorRising'];
                case 'OHLC_LINE': return this.getParams()['color'];
            }
        };

    /**
     * 價格下跌的 tick 顏色
     */
    AreaXYTicks.prototype.getColorSheddingTick =

        function() {
            switch( this._type ) {
                case 'OHLC_CANDLE': return this.getParams()['colorSheddingBorder'];
                case 'OHLC_BAR': return this.getParams()['colorShedding'];
                case 'OHLC_LINE': return this.getParams()['color'];
            }
        };

    //================================================================================================================
    // 滑鼠 & 觸控
    //================================================================================================================

    /**
     * 按下滑鼠
     */
    AreaXYTicks.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( this._drawing )
                this._drawing.procMouseDown( IN_x, IN_y, IN_which );
            else {
                var L_button_name = this.checkPointerInToolbutton( IN_x, IN_y);
                // 控制列點選 (優先)
                if( L_button_name != null )
                    switch (L_button_name) {
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
                // 畫圖物件點選
                else {
                    var anyDrawnClicked = false;
                    for( var i in this._drawns )
                        if( this._drawns[i].isMouseover() ) {
                            this._drawns[i].switchSelected();
                            anyDrawnClicked = true;
                        }
                    if( anyDrawnClicked )
                        this._mars_k.paint();
                }
            }
        };

    /**
     * 滑鼠移動
     */
    AreaXYTicks.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._drawing )
                this._drawing.procMouseMove( IN_x, IN_y, IN_evt_which );
            else {
                if( this.checkPointerInToolbutton(IN_x, IN_y) != null )
                    return AreaXY.prototype.CURSOR_IN_BUTTON;
                var anyDrawnSelected = false;
                for( var i in this._drawns )
                    if( this._drawns[i].isIntersect(IN_x, IN_y) )
                        anyDrawnSelected = true;
                if( anyDrawnSelected )
                    return AreaXY.prototype.CURSOR_DRAWN_MOUSEOVER;
            }
        };

    /**
     * 鼠鍵被放開
     */
    AreaXYTicks.prototype.procMouseUp =

        function() {

        };

    /**
     * 滑鼠移出
     */
    AreaXYTicks.prototype.procMouseOut =

        function() {
            this._mars_k.paint();
        };

    /**
     * 轉動滑鼠滾輪
     */
    AreaXYTicks.prototype.procMouseWheel =

        function( IN_wheel_delta ) {

        };


    /**
     * 開始觸控
     */
    AreaXYTicks.prototype.procTouchStart =

        function( IN_x, IN_y ) {
            this._mars_k.setFocusTick( IN_x);
            this._mars_k.paint();
            
            var L_which = 1; // 觸控視為滑鼠左鍵
            this.procMouseDown( IN_x, IN_y, L_which);
        };

    /**
     * 觸控滑動
     */
    AreaXYTicks.prototype.procTouchMove =

        function( IN_x, IN_y, IN_touches ) {
            if( this._dragging_from == null )
                return;
            this._draggingToAndPaint( IN_x );
        };

    /**
     * 結束觸控
     */
    AreaXYTicks.prototype.procTouchEnd =

        function( IN_x, IN_y) {            
            this._endDragging();
        };

    /**
     * 鍵盤
     */
    AreaXYTicks.prototype.procKeyDown =

        function( IN_evt ) {
            switch( IN_evt.keyCode ) {
                case 8: // <backspace>
                case 46: // <Delete>
                    // 檢查刪除畫圖物件
                    var anyDrawnDeleted = false;
                    for( var i=0; i<this._drawns.length; ++i )
                        if( this._drawns[i].isSelected() ) {
                            this._drawns.splice(i--, 1);
                            anyDrawnDeleted = true;
                        }
                    if( anyDrawnDeleted )
                        this._mars_k.paint();
            }
        };



    //================================================================================================================
    // various kinds of _paintXXX()
    //================================================================================================================

    /*
     * 畫出 ticks
     */
    AreaXYTicks.prototype._paintTicks =

        function() {
            var L_translate_x = 0.5 + (-this._mars_k.getVisibleAreaLeft());
            var L_translate_y = 0.5;
            this._ctx.translate( L_translate_x, L_translate_y );
            switch( this._type ) {
                case 'OHLC_CANDLE': this._paintTicksTypeCandle(); break;
                case 'OHLC_BAR' : this._paintTicksTypeBar(); break;
                case 'OHLC_LINE' : this._paintTicksTypeLine();
            }
            this._ctx.translate( -L_translate_x, -L_translate_y );
        };


    /**
     * paint ticks, type = Candle (蠟燭)
     */
    AreaXYTicks.prototype._paintTicksTypeCandle =

        function() {
            this._ctx.lineWidth = 1;
            var candleWidth = this._mars_k.getCandleWidth();

            var L_params = this.getParams();
            var L_color_rising_candle = L_params['colorRisingCandle'];
            var L_color_shedding_candle = L_params['colorSheddingCandle'];
            var L_color_rising_border = L_params['colorRisingBorder'];
            var L_color_shedding_border = L_params['colorSheddingBorder'];

            // stroke all rising ticks
            this._ctx.beginPath();
            this._ctx.strokeStyle = '#990000';
            var L_visible_tick_index_range = this._mars_k.getVisibleTickIndexRange();
            var L_all_ticks = this._mars_k.getAllTicks();
            for( var idx = L_visible_tick_index_range.begin; idx < L_visible_tick_index_range.end; ++idx ) {
                var L_tick = L_all_ticks[idx];
                if( L_tick.rising ) {
                    this._paintBorderedCandle( L_tick, candleWidth, L_color_rising_border, L_color_rising_candle );
                }
            }
            this._ctx.stroke();

            // stroke all shedding ticks
            this._ctx.beginPath();
            this._ctx.strokeStyle = '#007700';
            for( var idx = L_visible_tick_index_range.begin; idx < L_visible_tick_index_range.end; ++idx ) {
                var L_tick = L_all_ticks[idx];
                if( ! L_tick.rising ) {
                    this._paintBorderedCandle( L_tick, candleWidth, L_color_shedding_border, L_color_shedding_candle );
                }
            }
            this._ctx.stroke();
        };

    /**
     * paint ticks, type = Bar
     */
    AreaXYTicks.prototype._paintTicksTypeBar =

        function() {
            var barWidth = this._mars_k.getTickWidth() * 0.9;
            var visibleTicksIndexRange = this._mars_k.getVisibleTickIndexRange();
            this._ctx.lineWidth = Math.sqrt( barWidth );
            this._ctx.lineWidth = this._ctx.lineWidth<0.8? 0.8 : this._ctx.lineWidth; // 影響顏色深淺

            // stroke all rising ticks
            this._ctx.beginPath();
            this._ctx.strokeStyle = this.getParams()['colorRising'];
            for( var idx=visibleTicksIndexRange.begin; idx<visibleTicksIndexRange.end; ++idx ) {
                var tick = this._mars_k.getAllTicks()[idx];
                if( tick.rising )
                    this._paintBar( tick, barWidth );
            }
            this._ctx.stroke();

            // stroke all shedding ticks
            this._ctx.beginPath();
            this._ctx.strokeStyle = this.getParams()['colorShedding'];
            for( var idx=visibleTicksIndexRange.begin; idx<visibleTicksIndexRange.end; ++idx ) {
                var tick = this._mars_k.getAllTicks()[idx];
                if( ! tick.rising )
                    this._paintBar( tick, barWidth );
            }
            this._ctx.stroke();
        };

    /**
     * paint ticks, type = Line
     */
    AreaXYTicks.prototype._paintTicksTypeLine =

        function() {
            var visibleTicksIndexRange = this._mars_k.getVisibleTickIndexRange();
            var priceSource = this.getParams()['priceSource'];
            var price = priceSource=='Close'? function( tick ){ return tick.close; }
                : priceSource=='Open'? function( tick ){ return tick.open; }
                : priceSource=='High'? function( tick ){ return tick.high; }
                : priceSource=='Low'? function( tick ){ return tick.low; }
                : priceSource=='(H+L)/2'? function( tick ){ return tick.avgHL(); }
                : priceSource=='(H+L+C)/3'? function( tick ){ return tick.avgHLC(); }
                : function( tick ){ return tick.avgOHLC(); };
            this._ctx.fillStyle = this._ctx.strokeStyle = this.getParams()['color'];;
            this._ctx.lineWidth = Math.sqrt(this._mars_k.getTickWidth());
            this._ctx.lineWidth = this._ctx.lineWidth<0.8? 0.8 : this._ctx.lineWidth; // 影響顏色深淺
            this._ctx.lineJoin= 'round';
            // stroke all ticks
            var ticks = this._mars_k.getAllTicks();
            var i1 = visibleTicksIndexRange.begin>0? visibleTicksIndexRange.begin-1 : 0;
            var i2 = visibleTicksIndexRange.end<ticks.length? visibleTicksIndexRange.end+1 : ticks.length;
            for( var idx=i1; idx<i2; ++idx )
                ticks[idx].lineY = this.getYFromValue( price(ticks[idx]) );
            switch( this.getParams()['lineType'] ) {
                case 'With Marker':
                    for( var idx=i1; idx<i2; ++idx ) {
                        this._ctx.beginPath();
                        this._ctx.arc( ticks[idx].cx, ticks[idx].lineY, this._ctx.lineWidth, 0, 2*Math.PI );
                        this._ctx.fill();
                    }
                case 'Simple':
                    this._ctx.beginPath();
                    this._ctx.moveTo( ticks[i1].cx, ticks[i1].lineY );
                    for( var idx=i1+1; idx<i2; ++idx )
                        this._ctx.lineTo( ticks[idx].cx, ticks[idx].lineY );
                    this._ctx.stroke();
                    break;
                case 'Ladder':
                    this._ctx.beginPath();
                    for( var idx=i1; idx<i2-1; ++idx ) {
                        this._ctx.moveTo( ticks[idx].cx, ticks[idx].lineY );
                        this._ctx.lineTo( ticks[idx].cx, ticks[idx+1].lineY );
                        this._ctx.lineTo( ticks[idx+1].cx+this._ctx.lineWidth/2, ticks[idx+1].lineY );
                    }
                    this._ctx.stroke();
            }
        };




    /*
     * 畫 1 個 candle (bordered)
     */
    AreaXYTicks.prototype._paintBorderedCandle =

        function( IN_tick, IN_candle_width, IN_color_border, IN_color_fill ) {
            this._ctx.strokeStyle = IN_color_border;
            var tickRectHeight = Math.max( 1, IN_tick.rectHeight);
            if (IN_candle_width >= 1) {
                this._ctx.rect( IN_tick.candleLeft, IN_tick.rectUp, IN_candle_width, tickRectHeight );
            }
            this._ctx.moveTo( IN_tick.cx, IN_tick.yHigh );
            this._ctx.lineTo( IN_tick.cx, IN_tick.rectUp );
            this._ctx.moveTo( IN_tick.cx, IN_tick.rectUp + tickRectHeight );
            this._ctx.lineTo( IN_tick.cx, IN_tick.yLow );
            this._ctx.fillStyle = IN_color_fill;
            this._ctx.fillRect( IN_tick.candleLeft, IN_tick.rectUp, IN_candle_width, tickRectHeight );
        };

    /*
     * 畫 1 個 candle (simply filled)
     */
    AreaXYTicks.prototype._paintSimpleCandle =

        function( IN_tick, IN_candle_width ) {
            var tickRectHeight = Math.max( 1, IN_tick.rectHeight);
            this._ctx.fillStyle = this._ctx.strokeStyle;
            this._ctx.fillRect( IN_tick.candleLeft, IN_tick.rectUp, IN_candle_width, tickRectHeight );
            this._ctx.moveTo( IN_tick.cx, IN_tick.yHigh );
            this._ctx.lineTo( IN_tick.cx, IN_tick.yLow );
        };

    /*
     * 畫 1 個 tick, type = Bar
     */
    AreaXYTicks.prototype._paintBar =

        function( IN_tick, IN_bar_width ) {
            this._ctx.moveTo( IN_tick.cx, IN_tick.yHigh );
            this._ctx.lineTo( IN_tick.cx, IN_tick.yLow );
            var yOpen = IN_tick.rectUp + (IN_tick.rising? IN_tick.rectHeight : 0);
            var yClose = IN_tick.rectUp + (IN_tick.rising? 0 : IN_tick.rectHeight);
            this._ctx.moveTo( IN_tick.cx - IN_bar_width/2, yOpen );
            this._ctx.lineTo( IN_tick.cx + this._ctx.lineWidth/2, yOpen );
            this._ctx.moveTo( IN_tick.cx - this._ctx.lineWidth/2, yClose );
            this._ctx.lineTo( IN_tick.cx + IN_bar_width/2, yClose );
        };





    /**
     * 水平格線
     */
    AreaXYTicks.prototype._paintHorizontalGrids =

        function() {
            if (this._pixels_per_value <= 0) {
                return;
            }
            
            this._ctx.strokeStyle = this.getGridColor();
            this._ctx.lineWidth = 1;

            var tmpPow = Math.pow( 10, this._mars_k.getDecimalDigits() );
            var priceGap = Math.ceil( AreaXYTicks.prototype.Y_AXIS_MIN_SCALE_GAP_PIXELS / this._pixels_per_value * tmpPow) / tmpPow; // 刻度間距對應的價格 (須大於1個最小單位)
            if (priceGap <= 0) {
                return;
            }
            
            var price = Math.floor(this._value_high * tmpPow) / tmpPow;
            var y = Math.floor( this.getYFromValue(price) );
            this._y_scales = [];
            this._ctx.translate( 0.5, 0.5 );
            this._ctx.beginPath();
            while( y < this.getHeight() ) {
                this._ctx.moveTo( 0, y );
                this._ctx.lineTo( this._mars_k.getTicksAreaWidthExcludeYAxis(), y );
                this._y_scales.push( {'price':price, 'y':y} );
                price -= priceGap;
                y = Math.floor( this.getYFromValue(price) );
            }
            this._ctx.stroke();
            this._ctx.translate( -0.5, -0.5 );
        };

    /*
     * Y 軸刻度
     */
    AreaXYTicks.prototype._paintYAxis =

        function() {
            this._ctx.clearRect( this._mars_k.getTicksAreaWidthExcludeYAxis(), 0, MarsK.prototype.WIDTH_Y_AXIS, this._height );
            this._ctx.translate( 0.5, 0.5 );

            this._ctx.textAlign = AreaXYTicks.prototype.Y_AXIS_TEXT_ALIGN;
            this._ctx.textBaseline = "middle";
            this._ctx.shadowColor = this._y_axis_label_shadow_color;
            this._ctx.fillStyle = this._y_axis_fill_style_text_scale;
            this._ctx.font = AreaXYTicks.prototype.Y_AXIS_FONT_SCALE;
            var x = this._mars_k.getTicksAreaWidthExcludeYAxis() + AreaXYTicks.prototype.Y_AXIS_TEXT_POSITION;
            for( var i in this._y_scales )
                this._ctx.fillText( this._mars_k.getFormattedPrice(this._y_scales[i].price), x, this._y_scales[i].y );

            this._ctx.translate( -0.5, -0.5 );
        };
        
    AreaXYTicks.prototype._getPaintValues =
            
        function( IN_tick_index)
        {
            var L_all_ticks = this._mars_k.getAllTicks();
            var L_tick = L_all_ticks[IN_tick_index];
            if (! L_tick) {
                return null;
            }
            
            return {
                'O': { 'value': this._mars_k.getFormattedPrice( L_tick.open), 'color': 'rgb( 66, 166, 166)'},
                'H': { 'value': this._mars_k.getFormattedPrice( L_tick.high), 'color': 'rgb( 200, 100, 100)'},
                'L': { 'value': this._mars_k.getFormattedPrice( L_tick.low), 'color': 'rgb( 100, 200, 100)'},
                'C': { 'value': this._mars_k.getFormattedPrice( L_tick.close), 'color': 'rgb( 166, 166, 66)'},
            };
        };
        
        
    AreaXYTicks.prototype._setType = 
        function( IN_type)
        {
            // TODO - Check type.
            this._type = IN_type;
            return true;
        };

    AreaXYTicks.prototype._getDefinition = 
        function()
        {
            return AreaXYTicks.prototype.DEFINITION[this._type];
        };


AreaXYTicks.prototype.DEFINITION = {
    'OHLC_CANDLE': {
            'name_i18n': 'AREA_XY_TICK_OHLC_CANDLE_NAME',
            'independent': null,
            'getConstructor': function() { return AreaXYTicks;},
            'params': {
                'colorRisingCandle': [ 'rgba(255,0,0,0.3)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TICK_OHLC_CANDLE_PARAM_RISING_CANDLE_COLOR'}],
                'colorSheddingCandle': [ 'rgba(0,255,0,0.3)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TICK_OHLC_CANDLE_PARAM_SHEDDING_CANDLE_COLOR'}],
                'colorRisingBorder': [ 'rgb(187,0,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TICK_OHLC_CANDLE_PARAM_RISING_CANDLE_BORDER'}],
                'colorSheddingBorder': [ 'rgb(0,170,0)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TICK_OHLC_CANDLE_PARAM_SHEDDING_CANDLE_BORDER'}],
            },
        },
    'OHLC_BAR': {
            'name_i18n': 'AREA_XY_TICK_OHLC_BAR_NAME',
            'independent': null,
            'getConstructor': function() { return AreaXYTicks;},
            'params': {
                'colorRising': [ 'rgba(255,0,0,0.8)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'AREA_XY_TICK_OHLC_BAR_PARAM_RISING_CANDLE_COLOR'}],
                'colorShedding': [ 'rgba(0,255,0,0.8)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'AREA_XY_TICK_OHLC_BAR_PARAM_SHEDDING_CANDLE_COLOR'}],
            },
        },
    'OHLC_LINE': {
            'name_i18n': 'AREA_XY_TICK_OHLC_LINE_NAME',
            'independent': null,
            'getConstructor': function() { return AreaXYTicks;},
            'params': {
                'color': [ 'rgba(66,66,255,1)', {'type': AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea': false, 'alias_i18n': 'AREA_XY_TICK_OHLC_LINE_PARAM_COLOR'}],
                'priceSource': [ 'Close', {'type': AreaXY.prototype.PARAM_TYPES['ENUM'], 'enum':['Open','Close','High','Low','(H+L)/2','(H+L+C)/3','(H+L+O+C)/4'], 'showInArea':true, 'alias_i18n': 'AREA_XY_TICK_OHLC_LINE_PARAM_PRICE_SOURCE'}],
                'lineType': [ 'Ladder', {'type': AreaXY.prototype.PARAM_TYPES['ENUM'], 'enum':['Simple','With Marker','Ladder'], 'showInArea':true, 'alias_i18n': 'AREA_XY_TICK_OHLC_LINE_PARAM_LINE_TYPE'}],
            },
        },
};