/**
 * 畫圖 - 水平線
 *
 * @constructor
 */
var DrawerHorizontal = function( IN_mars_k )
{
    this.init( IN_mars_k, Drawer.prototype.MODE_HORIZONTAL );
    this._drawing_phase = DrawerHorizontal.prototype.PHASE_1; // 正在畫圖中的哪個階段? null=完成
}
DrawerHorizontal.prototype = new Drawer();
DrawerHorizontal.prototype.PHASE_1 = { 'tip_i18n': 'DRAWER_HORIZONTAL_PHASE_1_TIP' };


    /**
     * 滑鼠
     */
    DrawerHorizontal.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._drawing_phase == DrawerHorizontal.prototype.PHASE_1 )
                this._drawn_points[0] = this.createDynaPoint(IN_y);
        };

    /**
     * 滑鼠
     */
    DrawerHorizontal.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( IN_which == 1 ) // 左鍵
                switch( this._drawing_phase ) {
                    case DrawerHorizontal.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        this._drawing_phase = null;
                        this._area_ticks.saveAndStopDrawing();
                }
            else if( IN_which == 3 ) // 右鍵 = 取消
                this._area_ticks.stopDrawing();
        };


    /**
     *
     */
    DrawerHorizontal.prototype.paint  =

        function( IN_ctx ) {
            if( this.isDrawing() ) { // 正在畫..
                if( this._drawn_points.length == 1 )
                    this.printTip( IN_ctx );
            }
            else // 已畫完
                if( this._drawn_points.length == 1 ) {
                    var line = this.createExtLineWithSlope( 0, this._drawn_points[0].y(), 0 );
                    if( line[0] ) {
                        // 水平線
                        var style = this._selected? Drawer.prototype.STYLE_SELECTED : this._mouseover? Drawer.prototype.STYLE_MOUSEOVER : this.getParam('color');
                        this.drawLine( IN_ctx, line[0], this.getParam('lineWidth'), style, this.getParam('lineDotted') );
                        // 印出價格
                        IN_ctx.font = Drawer.prototype.FONT_TIP;
                        IN_ctx.textAlign = 'left';
                        IN_ctx.textBaseline = 'bottom';
                        IN_ctx.fillStyle = this.getParam('color');
                        IN_ctx.fillText( this._mars_k.getFormattedPrice(this._drawn_points[0].price), 5, line[0].y1 );
                        // selected 端點白色方塊
                        if( this._selected )
                            this.drawEndPoints( IN_ctx, line[0] );
                    }
                    // 用來判斷 isIntersect() 的 hidden path
                    this.drawHiddenHelpLine( [line[0]], IN_ctx.lineWidth );
                }
        };
