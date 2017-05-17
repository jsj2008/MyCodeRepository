/**
 * 畫圖 - 隨意切線
 *
 * @constructor
 */
var DrawerLine = function( IN_mars_k )
{
    this.init( IN_mars_k, Drawer.prototype.MODE_LINE );
    this._drawing_phase = DrawerLine.prototype.PHASE_1; // 正在畫圖中的哪個階段? null=完成
}
DrawerLine.prototype = new Drawer();
DrawerLine.prototype.PHASE_1 = { 'tip_i18n': 'DRAWER_LINE_PHASE_1_TIP' };
DrawerLine.prototype.PHASE_2 = { 'tip_i18n': 'DRAWER_LINE_PHASE_2_TIP' };


    /**
     * 滑鼠
     */
    DrawerLine.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._mars_k._focus_tick_index > -1 )
                switch( this._drawing_phase ) {
                    case DrawerLine.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint( IN_y );
                        break;
                    case DrawerLine.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint( IN_y );
                }
        };

    /**
     * 滑鼠
     */
    DrawerLine.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( IN_which == 1 ) // 左鍵
                switch( this._drawing_phase ) {
                    case DrawerLine.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerLine.prototype.PHASE_2;
                        break;
                    case DrawerLine.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                        this._drawing_phase = null;
                        this._area_ticks.saveAndStopDrawing();
                }
            else if( IN_which == 3 ) // 右鍵 = 取消
                this._area_ticks.stopDrawing();
        };


    /**
     *
     */
    DrawerLine.prototype.paint  =

        function( IN_ctx ) {
            var lineWidth = this.getParam( 'lineWidth' );
            if( this.isDrawing() ) { // 正在畫..
                if( this._drawn_points.length > 0 ) {
                    this.printTip( IN_ctx );
                    if( this._drawn_points.length == 2 ) {
                        var line = new Line( this._drawn_points[0].x(), this._drawn_points[0].y(), this._drawn_points[1].x(), this._drawn_points[1].y() );
                        this.drawLine( IN_ctx, line, lineWidth, Drawer.prototype.STYLE_DRAWING );
                    }
                }
            }
            else // 已畫完
                if( this._drawn_points.length == 2 ) {
                    var line = this.createExtLine( this._drawn_points[0].x(), this._drawn_points[0].y(), this._drawn_points[1].x(), this._drawn_points[1].y() );
                    if( line[0] ) {
                        var style = this._selected? Drawer.prototype.STYLE_SELECTED : this._mouseover? Drawer.prototype.STYLE_MOUSEOVER : this.getParam('color');
                        this.drawLine( IN_ctx, line[0], lineWidth, style, this.getParam('lineDotted') );
                        // selected 端點白色方塊
                        if( this._selected )
                            this.drawEndPoints( IN_ctx, line[0] );
                        // 用來判斷 isIntersect() 的 hidden path
                        this.drawHiddenHelpLine( [line[0]], IN_ctx.lineWidth );
                    }
                }
        };
