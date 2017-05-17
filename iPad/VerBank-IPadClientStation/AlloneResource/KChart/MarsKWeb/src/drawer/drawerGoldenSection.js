/**
 * 畫圖 - 黃金分割
 *
 * @constructor
 */
var DrawerGoldenSection = function( IN_mars_k )
{
    this.init( IN_mars_k, Drawer.prototype.MODE_GOLDEN_SECTION );
    this._drawing_phase = DrawerGoldenSection.prototype.PHASE_1; // 正在畫圖中的哪個階段? null=完成
}
DrawerGoldenSection.prototype = new Drawer();
DrawerGoldenSection.prototype.PHASE_1 = { 'tip_i18n': 'DRAWER_GOLDEN_SECTION_PHASE_1_TIP' };
DrawerGoldenSection.prototype.PHASE_2 = { 'tip_i18n': 'DRAWER_GOLDEN_SECTION_PHASE_2_TIP' };
DrawerGoldenSection.prototype.PHASE_3 = { 'tip_i18n': 'DRAWER_GOLDEN_SECTION_PHASE_3_TIP' };


    /**
     * 滑鼠
     */
    DrawerGoldenSection.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._mars_k._focus_tick_index > -1 )
                switch( this._drawing_phase ) {
                    case DrawerGoldenSection.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        break;
                    case DrawerGoldenSection.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                        break;
                    case DrawerGoldenSection.prototype.PHASE_3:
                        this._drawn_points[2] = this.createDynaPoint(IN_y);
                }
        };

    /**
     * 滑鼠
     */
    DrawerGoldenSection.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( IN_which == 1 ) // 左鍵
                switch( this._drawing_phase ) {
                    case DrawerGoldenSection.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerGoldenSection.prototype.PHASE_2;
                        break;
                    case DrawerGoldenSection.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerGoldenSection.prototype.PHASE_3;
                        break;
                    case DrawerGoldenSection.prototype.PHASE_3:
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
    DrawerGoldenSection.prototype.paint  =

        function( IN_ctx ) {
            if( this.isDrawing() ) { // 正在畫..
                if( this._drawn_points.length > 0 ) {
                    this.printTip( IN_ctx );
                    this._drawGoldenSection( IN_ctx, Drawer.prototype.STYLE_DRAWING );
                }
            }
            else // 已畫完
                if( this._drawn_points.length == 3 ) {
                    var style = this._selected? Drawer.prototype.STYLE_SELECTED : this._mouseover? Drawer.prototype.STYLE_MOUSEOVER : this.getParam('color');
                    var lines = this._drawGoldenSection( IN_ctx, style );
                    if( this._selected ) // 端點白色方塊
                        for( var i in lines )
                            this.drawEndPoints( IN_ctx, lines[i] );
                    // 用來判斷 isIntersect() 的 hidden path
                    this.drawHiddenHelpLine( lines, IN_ctx.lineWidth );
                }
        };



    /**
     * 畫出黃金分割
     * 回傳畫出的所有線條(供後續畫端點和點選判斷)
     */
    DrawerGoldenSection.prototype._drawGoldenSection =

        function( IN_ctx, IN_style ) {
            var rv = [];
            var lineWidth = this.getParam( 'lineWidth' );
            var dotted = this.getParam( 'lineDotted' );
            if( this._drawn_points.length >= 2 ) {
                var x1 = this._drawn_points[0].x();
                var y1 = this._drawn_points[0].y();
                var x2 = this._drawn_points[1].x();
                var y2 = this._drawn_points[1].y();
                var line1 = this.createExtLine( x1, y1, x2, y2 );
                if( line1[0] ) {
                    this.drawLine( IN_ctx, line1[0], lineWidth, IN_style, dotted );
                    rv.push( line1[0] );
                }
                if( this._drawn_points.length == 3 ) {
                    var x3 = this._drawn_points[2].x();
                    var y3 = this._drawn_points[2].y();
                    var line2 = this.createParallelLine( line1[1], x3, y3 );
                    if( line2[0] ) {
                        this.drawLine( IN_ctx, line2[0], lineWidth, IN_style, dotted );
                        rv.push( line2[0] );
                    }

                    var p1 = new Point( (x1+x2)/2, (y1+y2)/2 ); // 軸線 與 line1 交點
                    var axis = this.createPerpendicularLine( line1[1], p1.x, p1.y );
                    var p2 = axis[1].getLineIntersection( line2[1] ); // 軸線 與 line2 交點
                    // 找 areaTicks 範圍內的 axis
                    var axisSegment = new Rect( 0, 0, this._mars_k.getTicksAreaWidthExcludeYAxis(), this._area_ticks._height).getIntersection( new Line(p1.x, p1.y, p2.x, p2.y) );
                    if( axisSegment ) {
                        this.drawLine( IN_ctx, axisSegment, lineWidth, IN_style, dotted );
                        rv.push( axisSegment );
                    }
                    var divisionX = p1.x+(p2.x-p1.x)*0.618; // 軸線上的黃金分割點
                    var divisionY = p1.y+(p2.y-p1.y)*0.618;
                    var divisionLine = this.createParallelLine( line1[1], divisionX, divisionY );
                    if( divisionLine[0] ) {
                        this.drawLine( IN_ctx, divisionLine[0], lineWidth, IN_style, dotted );
                        rv.push( divisionLine[0] );
                    }
                }
            }
            return rv;
        };
