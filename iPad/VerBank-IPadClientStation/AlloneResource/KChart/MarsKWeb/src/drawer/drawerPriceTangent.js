/**
 * 畫圖 - 價位切線
 *
 * @constructor
 */
var DrawerPriceTangent = function( IN_mars_k )
{
    this.init( IN_mars_k, Drawer.prototype.MODE_PRICE_TANGENT );
    this._drawing_phase = DrawerPriceTangent.prototype.PHASE_1; // 正在畫圖中的哪個階段? null=完成
}
DrawerPriceTangent.prototype = new Drawer();
DrawerPriceTangent.prototype.PHASE_1 = { 'tip_i18n': 'DRAWER_PRICE_TANGENT_1_TIP' };
DrawerPriceTangent.prototype.PHASE_2 = { 'tip_i18n': 'DRAWER_PRICE_TANGENT_2_TIP' };


    /**
     * 滑鼠
     */
    DrawerPriceTangent.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._mars_k._focus_tick_index > -1 )
                switch( this._drawing_phase ) {
                    case DrawerPriceTangent.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint();
                        break;
                    case DrawerPriceTangent.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint();
                }
        };

    /**
     * 滑鼠
     */
    DrawerPriceTangent.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( IN_which == 1 ) // 左鍵
                switch( this._drawing_phase ) {
                    case DrawerPriceTangent.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint();
                        this._drawing_phase = DrawerPriceTangent.prototype.PHASE_2;
                        break;
                    case DrawerPriceTangent.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint();
                        this._drawing_phase = null;
                        this._area_ticks.saveAndStopDrawing();
                }
            else if( IN_which == 3 ) // 右鍵 = 取消
                this._area_ticks.stopDrawing();
        };


    /**
     *
     */
    DrawerPriceTangent.prototype.paint  =

        function( IN_ctx ) {
            var lineWidth = this.getParam('lineWidth');
            if( this.isDrawing() ) { // 正在畫..
                if( this._drawn_points.length > 0 ) {
                    this.printTip( IN_ctx );
                    for( var i in this._drawn_points )
                        this._paintCoverageOfSelectedTick( IN_ctx, this._drawn_points[i] );
                    if( this._drawn_points.length == 2 ) {
                        var line = new Line( this._drawn_points[0].x(), this._drawn_points[0].y(), this._drawn_points[1].x(), this._drawn_points[1].y() );
                        this.drawLine( IN_ctx, line, lineWidth, Drawer.prototype.STYLE_DRAWING );
                    }
                }
            }
            else // 已畫完
                if( this._drawn_points.length == 2 ) {
                    for( var i in this._drawn_points )
                        this._paintCoverageOfSelectedTick( IN_ctx, this._drawn_points[i] );
                    var line = this.createExtLine( this._drawn_points[0].x(), this._drawn_points[0].y(), this._drawn_points[1].x(), this._drawn_points[1].y() );
                    if( line[0] ) {
                        // 線
                        var style = this._selected? Drawer.prototype.STYLE_SELECTED : this._mouseover? Drawer.prototype.STYLE_MOUSEOVER : this.getParam('color');
                        this.drawLine( IN_ctx, line[0], lineWidth, style, this.getParam('lineDotted') );
                        //  端點白色方塊
                        if( this._selected )
                            this.drawEndPoints( IN_ctx, line[0] );
                        // 用來判斷 isIntersect() 的 hidden path
                        this.drawHiddenHelpLine( [line[0]], IN_ctx.lineWidth );
                    }
                }
        };

    /**
     * 畫出被選擇的 tick 的半透明覆蓋
     */
    DrawerPriceTangent.prototype._paintCoverageOfSelectedTick =

        function( IN_ctx, IN_drawn_point ) {
            var p = IN_drawn_point;
            var cw = this._mars_k.getCandleWidth();
            var y1 = this._area_ticks.getYFromValue( p.focusTick.high )-5;
            var y2 = this._area_ticks.getYFromValue( p.focusTick.low )+5;
            IN_ctx.fillStyle = MarsKUtility.prototype.getContrastiveColor( this.getBackgroundColor(), 1, 0.2 );
            IN_ctx.fillRoundedRect( p.x()-cw, y1, cw*2, (y2-y1), 5 );
        };


