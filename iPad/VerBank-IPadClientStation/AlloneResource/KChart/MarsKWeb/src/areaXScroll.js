/**
 * 水平捲動軸 X scroll bar
 *
 *
 */
var AreaXScroll = function( IN_mars_k, IN_visible, IN_overview_mode )
{
    this._initArea( IN_mars_k, false, true);
    
    this._dom_bg_canvas = document.createElement( 'canvas');
    //document.body.appendChild( this._dom_bg_canvas);
    this._dom_bg_canvas.width = IN_mars_k.getDomCanvas().width;
    this._dom_bg_canvas.height = MarsK.prototype.HEIGHT_X_SCROLL_OVERVIEW;
    
    this._ctx_bg = null;
    this._visible = IN_visible;
    this._overview_mode = IN_overview_mode;

    this._bar_x = 0;
    this._bar_width = 0;
}
AreaXScroll.prototype = new Area();
AreaXScroll.prototype.constructor = AreaXScroll;
AreaXScroll.prototype.MIN_X_SCROLL_BAR_WIDTH = 20;
AreaXScroll.prototype.BAR_SHADOW_BLUR = 8; // 捲動 bar 陰影厚度
AreaXScroll.prototype.CURSOR_IN_FOCUS = 'pointer';
AreaXScroll.prototype.CURSOR_OUT_OF_FOCUS = 'crosshair';
AreaXScroll.prototype.BG_COLOR_BAR_OVERVIEW = 'rgba(0,55,0, 0.3)';

AreaXScroll.prototype._refreshColorsForArea = function()
{
    this._bar_shadow_color_overview = MarsKUtility.prototype.getContrastiveColor( AreaXScroll.prototype.BG_COLOR_BAR_OVERVIEW, 1 );
    this._bg_color_bar_no_overview = MarsKUtility.prototype.getContrastiveColor( window.getComputedStyle(this._dom_canvas)['backgroundColor'], 0.7 );
};

    /**
     * 畫出此區
     */
    AreaXScroll.prototype.doPaint = function( IN_layer) {
        if (! this._mars_k.isVisibledForAreaXScroll()) {
            return;
        }
        
        switch (IN_layer)
        {
            case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_1_AREA_GRID:
                break;
                    
            case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_2_AREA_CONTENT:
                break;

            case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_3_AREA_DASHBOARD:
                if( this._overview_mode ) {
                    if( this._ctx_bg == null )
                        this._repaintBackgroundOverviewCanvas();
                    this._ctx.clearRect( 0, 0, this._width, this._height );
                    this._ctx.drawImage( this._dom_bg_canvas, 0, 0 ); // overall-ticks background canvas
                    this._ctx.shadowColor = this._bar_shadow_color_overview;
                    this._ctx.fillStyle = AreaXScroll.prototype.BG_COLOR_BAR_OVERVIEW;
                }
                else {
                    this._ctx.clearRect( 0, 0, this._width, this._height );
                    this._ctx.fillStyle = this._bg_color_bar_no_overview;
                }

                var areaTicksTotalWidth = this._mars_k.getTotalWidth();
                this._bar_width = this._width * this._width / areaTicksTotalWidth;
                if( this._bar_width < AreaXScroll.prototype.MIN_X_SCROLL_BAR_WIDTH )
                    this._bar_width = AreaXScroll.prototype.MIN_X_SCROLL_BAR_WIDTH;
                this._bar_x = this._width * this._mars_k.getVisibleAreaLeft() / areaTicksTotalWidth;
                if( this._bar_x + this._bar_width > this._width )
                    this._bar_x = this._width - this._bar_width;

                this._ctx.translate( 0.5, 0.5 );
                this._ctx.shadowBlur = AreaXScroll.prototype.BAR_SHADOW_BLUR;
                this._ctx.fillRect( this._bar_x+1, 1, this._bar_width-2, this._height-2 );
                this._ctx.shadowBlur = 0;
                this._ctx.translate( -0.5, -0.5 );
                break;

            case MarsK.prototype.AREA_PAINT_LAYERS.LAYER_4_FOCUS:

                break;
        }
    };


    //================================================================================================================
    // 滑鼠 & 觸控
    //================================================================================================================

    /**
     * 按下滑鼠
     */
    AreaXScroll.prototype.procMouseDown =

        function( IN_x, IN_y ) {
            if( IN_x>=this._bar_x && IN_x<=this._bar_x+this._bar_width )
                ;
            else {
                var jumpTo = IN_x * this._mars_k.getTotalWidth() / this._width;
                this._mars_k.setVisibleAreaLeft( jumpTo );
                this._mars_k.paint();
                this._bar_x = IN_x;
            }
            this._beginDragging( IN_x, IN_y );
        };

    /**
     * 滑鼠移動
     */
    AreaXScroll.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            // 決定游標類型
            var L_custom;
            if( IN_x>=this._bar_x && IN_x<=this._bar_x+this._bar_width )
                L_custom = AreaXScroll.prototype.CURSOR_IN_FOCUS;
            else
                L_custom = AreaXScroll.prototype.CURSOR_OUT_OF_FOCUS;
            // mouse dragging?
            if( this._dragging_from!=null && IN_evt_which!=0 ) // dragging..
                this._draggingToAndPaint( IN_x );
            else
                this.procMouseUp();
            
            return L_custom;
        };


    /**
     * 鼠鍵被放開
     */
    AreaXScroll.prototype.procMouseUp =

        function() {
            this._endDragging();
        };

    /**
     * 開始觸控
     */
    AreaXScroll.prototype.procTouchStart =

        function( IN_x, IN_y ) {
            this.procMouseDown( IN_x, IN_y);
            //this._beginDragging( IN_x, IN_y );
        };


    /**
     * 觸控滑動
     */
    AreaXScroll.prototype.procTouchMove =

        function( IN_x, IN_y, IN_touches ) {
            if( this._dragging_from == null )
                return;
            this._draggingToAndPaint( IN_x );
        };

    /**
     * 結束觸控
     */
    AreaXScroll.prototype.procTouchEnd =

        function() {
            this._endDragging();
        };
        
    AreaXScroll.prototype.procResize =
               
        function() {
            this._dom_bg_canvas.width = this._mars_k.getDomCanvas().width;
            this._ctx_bg = null; // Set context to null to run _repaintBackgroundOverviewCanvas in doPaint.
        };

    AreaXScroll.prototype.cleanPaintCache =

        function() {
            this._ctx_bg = null; // Set context to null to run _repaintBackgroundOverviewCanvas in doPaint.  
        };


    //================================================================================================================
    // 以下函式 "不應該" 由別處叫用
    //================================================================================================================

    // 進入拖曳狀態
    AreaXScroll.prototype._beginDragging =

        function( IN_x, IN_y ) {
            this._dragging_from = { 'x':IN_x, 'y':IN_y };
            this._dragging_from_target_state = this._bar_x;
        };

    // 離開拖曳狀態
    AreaXScroll.prototype._endDragging =

        function() {
            this._dragging_from = null;
            this._dragging_from_target_state = null;
        };

    /**
     * 滑鼠拖曳到某個 x 座標, 並重繪
     */
    AreaXScroll.prototype._draggingToAndPaint =

        function( IN_x ) {
            var movement = IN_x - this._dragging_from.x;
            var assumingBarX = this._dragging_from_target_state + movement;
            var visibleAreaLeft = assumingBarX * this._mars_k.getTotalWidth() / this._width;
            this._mars_k.setVisibleAreaLeft( visibleAreaLeft );
            this._mars_k.paint();
        };



    /**
     * 可視 ?
     */
    AreaXScroll.prototype.setVisible = function( IN_visible ) {
        this._visible = IN_visible;
    };
    AreaXScroll.prototype.isVisible = function() {
        return this._visible;
    };


    /**
     * 顯示全域圖 ?
     */
    AreaXScroll.prototype.setOverviewMode = function( IN_boolean ) {
        this._overview_mode = IN_boolean;
    };
    AreaXScroll.prototype.isOverviewMode = function() {
        return this._overview_mode;
    };




    // 重繪鳥瞰圖背景 canvas
    AreaXScroll.prototype._repaintBackgroundOverviewCanvas = function() {
        var allTicks = this._mars_k.getAllTicks();
        var horizontalMargin = MarsK.prototype.MARGIN_HORIZONTAL * this._width / this._mars_k.getTotalWidth();
        var tickWidth = (this._width - 2*horizontalMargin) / allTicks.length;
        var highest = 0;
        var lowest = Number.POSITIVE_INFINITY;
        for( var i in allTicks ) {
            var tick = allTicks[i];
            if( tick.high > highest )
                highest = tick.high;
            if( tick.low < lowest )
                lowest = tick.low;
        }
        var colorRising = this._mars_k.getAreaTicks().getColorRisingTick();
        var colorShedding = this._mars_k.getAreaTicks().getColorSheddingTick();
        var pixelsPerPrice = this._height / (highest - lowest);
        var candleWidth = tickWidth * MarsK.prototype.CANDLE_WIDTH_RATIO;
        candleWidth = candleWidth<1? 1 : candleWidth; // 影響顏色深淺
        this._ctx_bg = this._dom_bg_canvas.getContext( '2d' );
        this._ctx_bg.clearRect( 0, 0, this._width, this._height );
        // this._ctx_bg.clearRect( 0, 0, this._dom_bg_canvas.width, this._dom_bg_canvas.height ); // is this better than the above line ?
        for( var i in allTicks ) {
            var tick = allTicks[i];
            this._ctx_bg.fillStyle = tick.rising? colorRising : colorShedding;
            var x = horizontalMargin + tickWidth*i + (tickWidth-candleWidth);
            var y = (highest-tick.high)*pixelsPerPrice;
            var h = (highest-tick.low)*pixelsPerPrice - y;
            this._ctx_bg.fillRect( x, y, candleWidth, h );
        }
    };
    
    
/**
 * 刪除所有Tick
 */
AreaXScroll.prototype.removeAllTicks = function()
{
    this._ctx_bg = null; // Set context of overview to repaint it when next doPaint calling.
};

/**
 * 從左邊加入 ticks
 */
AreaXScroll.prototype.insertTicks = function( IN_arr_ticks) 
{
    this._ctx_bg = null; // Set context of overview to repaint it when next doPaint calling.
};
   
/**
 * 從右邊加入 ticks
 */
AreaXScroll.prototype.appendTicks = function( IN_arr_ticks)
{
    this._ctx_bg = null; // Set context of overview to repaint it when next doPaint calling.
};