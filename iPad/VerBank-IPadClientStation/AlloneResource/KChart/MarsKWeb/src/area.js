/**
 * Mars K 線圖中的某個區域
 *
 */
var Area = function() {
    this._x = 0;
    this._y = 0;
    this._width = 0;
    this._height = 0;

    // 拖曳狀態中, 記住起點
    this._dragging_from = null;

    // 切換至拖曳狀態時,記住拖曳狀態一開始的狀態( area ticks = visible_area_left; area x scroll = bar_x)
    this._dragging_from_target_state = null;

    // 在此點畫出交叉線
    this._mouse_moving_position = null;

    // 觸控縮放狀態中,隨時記住前2點間距離
    this._is_zooming = false;
    this._zooming_touches_gap = 0;
};

Area.prototype.getGridColor =

    function() {
        return this._color_grid;
    };

Area.prototype._initArea = function( IN_mars_k, IN_is_draggable, IN_is_zoomable)
{
    this._mars_k = IN_mars_k;
    this._dom_canvas = this._mars_k.getDomCanvas();
    this._ctx = this._mars_k.getContext();
    this._is_draggable = IN_is_draggable;
    this._is_zoomable = IN_is_zoomable;
    this.refreshColors();
};

Area.prototype._convertCoordFromDomToAreaPixelSpace = function( IN_pointer_x, IN_pointer_y)
{
    var L_dom_canvas = this._dom_canvas;
    
    var L_offset_x = 0;
    var L_offset_y = 0;
    for (var L_dom_parent_node = L_dom_canvas; L_dom_parent_node; L_dom_parent_node = L_dom_parent_node.offsetParent) {
        L_offset_x += L_dom_parent_node.offsetLeft;
        L_offset_y += L_dom_parent_node.offsetTop;
    }
    
    var L_x = IN_pointer_x - L_offset_x;// this._dom_canvas_bounding_client_rect.left;
    var L_y = IN_pointer_y - L_offset_y;// this._dom_canvas_bounding_client_rect.top;

    var L_sx = L_dom_canvas.width / L_dom_canvas.clientWidth;
    var L_sy = L_dom_canvas.height / L_dom_canvas.clientHeight;
    var L_px = L_sx * L_x;
    var L_py = L_sy * L_y;
    var L_relative_px = Math.floor( L_px - this._x);
    var L_relative_py = Math.floor( L_py - this._y);
 
    return {
        'relative_px': L_relative_px,
        'relative_py': L_relative_py,
    };
};

    /**
     * 畫出此區域
     */
    Area.prototype.paint =

        function( IN_layer) {
            this._ctx.translate( this._x, this._y );
            try {
                this.doPaint( IN_layer);
            }
            finally {
                this._ctx.translate( -this._x, -this._y );
            }
        };
        
    Area.prototype.refreshColors =
        function()
        {
            var bgColor = window.getComputedStyle( this._dom_canvas)['backgroundColor'];
            this._color_grid = MarsKUtility.prototype.getContrastiveColor( bgColor, MarsK.prototype.GRID_CONTRAST );
            this._y_axis_label_shadow_color = MarsKUtility.prototype.getContrastiveColor( bgColor, 0.7 );
            this._y_axis_fill_style_text_scale = MarsKUtility.prototype.getContrastiveColor( bgColor, 0.5 );
            this._y_axis_fill_style_text_floating_label = MarsKUtility.prototype.getContrastiveColor( bgColor, 1 );
            
            if (this._refreshColorsForArea) {
                this._refreshColorsForArea();
            }
        };

    /**
     * 垂直格線
     */
    Area.prototype._paintVerticalGrids =

        function() {
            var visibleAreaLeft = this._mars_k.getVisibleAreaLeft();
            var visibleRange = this._mars_k.getVisibleTickIndexRange();
            this._ctx.strokeStyle = this.getGridColor();
            this._ctx.translate( -visibleAreaLeft, 0 );
            this._ctx.translate( 0.5, 0 );
            this._ctx.beginPath();
            var L_all_ticks = this._mars_k.getAllTicks();
            for( var i=visibleRange.begin; i<visibleRange.end; ++i ) {
                var tick = L_all_ticks[i];
                if( tick.xScale ) {
                    this._ctx.moveTo( tick.cx, 0 );
                    this._ctx.lineTo( tick.cx, this._height );
                }
            }
            this._ctx.lineWidth = 1;
            this._ctx.stroke();
            this._ctx.translate( -0.5, 0 );
            this._ctx.translate( visibleAreaLeft, 0 );
        };
        
    /**
     * 區域上方水平分割線
     */
    Area.prototype._paintSplitBar =

        function() {
            // Draw horizontal line of tech area.
            var L_ctx = this._ctx;
            L_ctx.strokeStyle = 'rgb( 140, 140, 140)';
            L_ctx.lineWidth = 2;
            L_ctx.beginPath();
            L_ctx.moveTo( 0, 1);
            L_ctx.lineTo( this._width, 1);
            L_ctx.stroke();
        };





    //================================================================================================================
    // 滑鼠 & 觸控
    //================================================================================================================

    /**
     * 按下滑鼠
     */
    Area.prototype.mouseDown =

        function( IN_evt ) {
            var L_area_pixel_space_coords = this._convertCoordFromDomToAreaPixelSpace( IN_evt.clientX, IN_evt.clientY);
            var L_relative_px = L_area_pixel_space_coords['relative_px'];
            var L_relative_py = L_area_pixel_space_coords['relative_py'];
            
            if (this._is_draggable) {
                this._beginDragging( L_relative_px, L_relative_py );
            }
            
            if( this.procMouseDown != undefined ) {
                return this.procMouseDown( L_relative_px, L_relative_py, IN_evt.which );
            }
        };

    /**
     * 滑鼠移動
     */
    Area.prototype.mouseMove =

        function( IN_evt ) {
            var L_area_pixel_space_coords = this._convertCoordFromDomToAreaPixelSpace( IN_evt.clientX, IN_evt.clientY);
            var L_relative_px = L_area_pixel_space_coords['relative_px'];
            var L_relative_py = L_area_pixel_space_coords['relative_py'];
             
            this._mouse_moving_position = { 'x':L_relative_px, 'y':L_relative_py };
            
            if (this._is_draggable) {
                if( L_relative_px < this._mars_k.getTicksAreaWidthExcludeYAxis() ) {
                    if( this._dragging_from != null && IN_evt.which != 0 ) {// dragging..
                        this._draggingToAndPaint( L_relative_px );
                    }
                    else {
                        if (this.procMouseUp) {
                            this.procMouseUp();
                        }
                    }
                }
                else {
                    if (this.procMouseOut) {
                        this.procMouseOut();
                    }
                }
            }
            
            if( this.procMouseMove != undefined ) {
                return this.procMouseMove( L_relative_px, L_relative_py, IN_evt.which );
            }
        };

    /**
     * 放開鼠鍵
     */
    Area.prototype.mouseUp =

        function( IN_evt ) {
            if (this._is_draggable) {
                this._endDragging();
            }
    
            if( this.procMouseUp != undefined ) {
                return this.procMouseUp();
            }
        };

    /**
     * 滑鼠移出
     */
    Area.prototype.mouseOut =

        function( IN_evt ) {
            if (this._is_draggable) {
                this._endDragging();
            }
            
            if( this.isMouseIn() ) {
                this._mouse_moving_position = null;                
                if( this.procMouseOut != undefined ) {
                    return this.procMouseOut();
                }
            }
        };

    /**
     * 滾輪
     */
    Area.prototype.mouseWheel =

        function( IN_evt ) {
            var delta = IN_evt.wheelDelta==undefined? IN_evt.detail : IN_evt.wheelDelta;
            
            if (this._is_zoomable) {
                this._mars_k.zoomAndPaint( delta > 0 ); // 向上縮小, 向下放大
            }
    
            if( this.procMouseWheel != undefined ) {
                return this.procMouseWheel( delta );
            }
        };


    /**
     * 開始觸控
     */
    Area.prototype.touchStart =

        function( IN_evt ) {
            var L_touches = IN_evt.touches;
            if (L_touches == undefined || L_touches.length == 0) {
                return;
            }
            
            var L_area_pixel_space_coords = this._convertCoordFromDomToAreaPixelSpace( L_touches[0].clientX, L_touches[0].clientY);
            var L_relative_px = L_area_pixel_space_coords['relative_px'];
            var L_relative_py = L_area_pixel_space_coords['relative_py'];
            if (this._is_draggable) {
                this._beginDragging( L_relative_px, L_relative_py );
            }
    
            if( this.procTouchStart != undefined ) {
                return this.procTouchStart( L_relative_px, L_relative_py );
            }
        };

    /**
     * 觸控移動中
     */
    Area.prototype.touchMove =

        function( IN_evt ) {
            var L_touches = IN_evt.touches;
            if (L_touches == undefined || L_touches.length == 0) {
                return;
            }
            
            var L_area_pixel_space_coords = this._convertCoordFromDomToAreaPixelSpace( L_touches[0].clientX, L_touches[0].clientY);
            var L_relative_px = L_area_pixel_space_coords['relative_px'];
            var L_relative_py = L_area_pixel_space_coords['relative_py'];
            
            if (this._is_draggable) {
                if( this._dragging_from != null ) {
                    if( L_touches.length > 1 ) { // 雙指縮放(只看前2個觸控點)
                        if( this._zooming_touches_gap == null ) 
                            this._zooming_touches_gap = Math.abs( L_touches[1].clientX - L_touches[0].clientX );
                        
                        var newZoomingTouchesGap = Math.abs( L_touches[1].clientX - L_touches[0].clientX );
                        var L_gap_changing_distance = Math.abs(newZoomingTouchesGap - this._zooming_touches_gap);
                        if (this._is_zooming && L_gap_changing_distance > MarsK.prototype.TOUCH_ZOOM_GAP_THRESHOLD) {
                            // Zoom.
                            this._mars_k.zoomAndPaint( newZoomingTouchesGap > this._zooming_touches_gap );
                            this._zooming_touches_gap = newZoomingTouchesGap;
                        }
                        else if( L_gap_changing_distance > MarsK.prototype.TOUCH_ZOOM_START_THRESHOLD ) {
                            // Start to zoom.
                            this._is_zooming = true;
                        }
                    }
                    else {
                        // dragging
                        this._is_zooming = false;
                        this._draggingToAndPaint( L_relative_px );
                    }
                }
            }
            
            if( this.procTouchMove != undefined ) {
                return this.procTouchMove( L_relative_px, L_relative_py );
            }
        };

    /**
     * 結束觸控
     */
    Area.prototype.touchEnd =

        function( IN_evt ) { 
            var L_changed_touches = IN_evt.changedTouches;
            if (L_changed_touches == undefined || L_changed_touches.length == 0) {
                return;
            }
            
            var L_area_pixel_space_coords = this._convertCoordFromDomToAreaPixelSpace( L_changed_touches[0].clientX, L_changed_touches[0].clientY);
            var L_relative_px = L_area_pixel_space_coords['relative_px'];
            var L_relative_py = L_area_pixel_space_coords['relative_py'];
            
            if (this._is_draggable) {
                this._endDragging();
            }
            
            this._is_zooming = false;
    
            if( this.procTouchEnd != undefined )
                return this.procTouchEnd( L_relative_px, L_relative_py);
        };

    /**
     * Canvas重設像素大小
     */
    Area.prototype.resize =
        
        function() {
            if( this.procResize != undefined ) {
                return this.procResize();
            }
        };


    /** 取得位置,大小 */
    Area.prototype.getX = function() { return this._x; };
    Area.prototype.getY = function() { return this._y; };
    Area.prototype.getWidth = function() { return this._width; };
    Area.prototype.getHeight = function() { return this._height; };

    /**
     * 重新定義位置大小
     */
    Area.prototype.reshape =

        function( IN_x, IN_y, IN_width, IN_height ) {
            this._x = IN_x;
            this._y = IN_y;
            this._width = IN_width;
            this._height = IN_height;
            this._dom_canvas_bounding_client_rect = this._dom_canvas.getBoundingClientRect();
        };

    /**
     * 某滑鼠事件是否發生在此區域內 ?
     */
    Area.prototype.isHit =

        function( IN_evt ) {
            var L_touches = IN_evt.touches;
            var L_changed_touches = IN_evt.changedTouches;
            if (L_touches && L_touches.length > 0) {
                // Touch event.
                var L_client_x = L_touches[0].clientX;
                var L_client_y = L_touches[0].clientY;
            }
            else if (L_changed_touches && L_changed_touches.length > 0) {
                var L_client_x = L_changed_touches[0].clientX;
                var L_client_y = L_changed_touches[0].clientY;
            }
            else {
                // Mouse event.
                var L_client_x = IN_evt.clientX;
                var L_client_y = IN_evt.clientY;
            }
            
            var L_area_pixel_space_coords = this._convertCoordFromDomToAreaPixelSpace( L_client_x, L_client_y);
            var L_relative_px = L_area_pixel_space_coords['relative_px'];
            var L_relative_py = L_area_pixel_space_coords['relative_py'];

            return L_relative_px >= 0 && L_relative_px <= this._width && 
                   L_relative_py >= 0 && L_relative_py <= this._height;
        };

    /**
     * 滑鼠在此區活動
     */
    Area.prototype.isMouseIn =

        function() {
            return this._dragging_from != null || this._mouse_moving_position != null;
        };

    /**
     * Returns the current position of the mouse cursor if it's in this area and not in dragging mode,
     * otherwise, null
     */
    Area.prototype.getMouseMovingPosition =

        function() {
            return this._mouse_moving_position;
        };


    /**
     * 進入滑鼠拖曳狀態
     */
    Area.prototype._beginDragging =

        function( IN_x, IN_y ) {
            this._dragging_from = { 'x':IN_x, 'y':IN_y };
            this._dragging_from_target_state = this._mars_k.getVisibleAreaLeft();
        };

    /**
     * 滑鼠拖曳到某個 x 座標, 並重繪
     */
    Area.prototype._draggingToAndPaint =

        function( IN_x ) {
            this._mouse_moving_position = null;
            this._mars_k.setVisibleAreaLeft( this._dragging_from_target_state + this._dragging_from.x - IN_x );
            this._mars_k.paint();
        };

    /**
     * 離開滑鼠拖曳狀態
     */
    Area.prototype._endDragging =

        function() {
            this._dragging_from = null;
            this._dragging_from_target_state = null;
            this._zooming_touches_gap = null;
        };
