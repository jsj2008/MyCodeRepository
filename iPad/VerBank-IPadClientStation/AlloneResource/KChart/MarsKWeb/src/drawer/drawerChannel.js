/**
 * 畫圖 - 軌道線 (隨意通道)
 *
 * @constructor
 */
var DrawerChannel = function( IN_mars_k )
{
    this.init( IN_mars_k, Drawer.prototype.MODE_CHANNEL );
    this._drawing_phase = DrawerChannel.prototype.PHASE_1; // 正在畫圖中的哪個階段? null=完成
}
DrawerChannel.prototype = new Drawer();
DrawerChannel.prototype.PHASE_1 = { 'tip_i18n': 'DRAWER_CHANNEL_PHASE_1_TIP' };
DrawerChannel.prototype.PHASE_2 = { 'tip_i18n': 'DRAWER_CHANNEL_PHASE_2_TIP' };
DrawerChannel.prototype.PHASE_3 = { 'tip_i18n': 'DRAWER_CHANNEL_PHASE_3_TIP' };


    /**
     * 滑鼠
     */
    DrawerChannel.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._mars_k._focus_tick_index > -1 )
                switch( this._drawing_phase ) {
                    case DrawerChannel.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        break;
                    case DrawerChannel.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                        break;
                    case DrawerChannel.prototype.PHASE_3:
                        this._drawn_points[2] = this.createDynaPoint(IN_y);
                }
        };

    /**
     * 滑鼠
     */
    DrawerChannel.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( IN_which == 1 ) // 左鍵
                switch( this._drawing_phase ) {
                    case DrawerChannel.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerChannel.prototype.PHASE_2;
                        break;
                    case DrawerChannel.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerChannel.prototype.PHASE_3;
                        break;
                    case DrawerChannel.prototype.PHASE_3:
                        this._drawn_points[2] = this.createDynaPoint(IN_y);
                        this._drawing_phase = null;
                        this._area_ticks.saveAndStopDrawing();
                }
            else if( IN_which == 3 ) // 右鍵 = 取消
                this._area_ticks.stopDrawing();
        };


    /**
     *
     */
    DrawerChannel.prototype.paint  =

        function( IN_ctx ) {
            var lineWidth = this.getParam('lineWidth');
            if( this.isDrawing() ) { // 正在畫..
                if( this._drawn_points.length > 0 ) {
                    this.printTip( IN_ctx );
                    if( this._drawn_points.length >= 2 ) {
                        var x1 = this._drawn_points[0].x();
                        var y1 = this._drawn_points[0].y();
                        var x2 = this._drawn_points[1].x();
                        var y2 = this._drawn_points[1].y();
                        var line = this.createExtLine( x1, y1, x2, y2 );
                        if( line[0] )
                            this.drawLine( IN_ctx, line[0], lineWidth, Drawer.prototype.STYLE_DRAWING );
                        if( this._drawn_points.length == 3 ) {
                            line = this.createExtLineWithSlope( this._drawn_points[2].x(), this._drawn_points[2].y(), (y2-y1) / (x2-x1) );
                            if( line[0] )
                                this.drawLine( IN_ctx, line[0], lineWidth, Drawer.prototype.STYLE_DRAWING );
                        }
                    }
                }
            }
            else // 已畫完
                if( this._drawn_points.length == 3 ) {
                    var x1 = this._drawn_points[0].x();
                    var y1 = this._drawn_points[0].y();
                    var x2 = this._drawn_points[1].x();
                    var y2 = this._drawn_points[1].y();
                    var tracks = [];
                    tracks.push( this.createExtLine(x1, y1, x2, y2)[0] );
                    tracks.push( this.createExtLineWithSlope(this._drawn_points[2].x(), this._drawn_points[2].y(), (y2-y1)/(x2-x1))[0] );
                    for( var i in tracks )
                        if( tracks[i] ) {
                            var style = this._selected? Drawer.prototype.STYLE_SELECTED : this._mouseover? Drawer.prototype.STYLE_MOUSEOVER : this.getParam('color');
                            this.drawLine( IN_ctx, tracks[i], lineWidth, style, this.getParam('lineDotted') );
                            if( this._selected ) // 端點白色方塊
                                this.drawEndPoints( IN_ctx, tracks[i] );
                        }
                    // 用來判斷 isIntersect() 的 hidden path
                    this.drawHiddenHelpLine( tracks, IN_ctx.lineWidth );
                }
        };
