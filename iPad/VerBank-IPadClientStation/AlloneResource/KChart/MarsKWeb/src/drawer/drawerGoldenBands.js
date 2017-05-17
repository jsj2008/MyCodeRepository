/**
 * 畫圖 - 黃金波段
 *
 * @constructor
 */
var DrawerGoldenBands = function( IN_mars_k )
{
    this.init( IN_mars_k, Drawer.prototype.MODE_GOLDEN_BANDS );
    this._drawing_phase = DrawerGoldenBands.prototype.PHASE_1; // 正在畫圖中的哪個階段? null=完成

    var canvas = document.createElement( 'canvas' );
    canvas.width = 1;
    canvas.height = 1;
    this._ctx_test = canvas.getContext( '2d' );
}
DrawerGoldenBands.prototype = new Drawer();
DrawerGoldenBands.prototype.PHASE_1 = { 'tip_i18n': 'DRAWER_GOLDEN_BANDS_PHASE_1_TIP' };
DrawerGoldenBands.prototype.PHASE_2 = { 'tip_i18n': 'DRAWER_GOLDEN_BANDS_PHASE_2_TIP' };
DrawerGoldenBands.prototype.PHASE_3 = { 'tip_i18n': 'DRAWER_GOLDEN_BANDS_PHASE_3_TIP' };
DrawerGoldenBands.prototype.BANDS = ['0.236', '0.382', '0.500', '0.618', '0.809'];
DrawerGoldenBands.prototype.BAND_FONT = '15px Arial bold';

    /**
     * 滑鼠
     */
    DrawerGoldenBands.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._mars_k._focus_tick_index > -1 )
                switch( this._drawing_phase ) {
                    case DrawerGoldenBands.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        break;
                    case DrawerGoldenBands.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                        break;
                    case DrawerGoldenBands.prototype.PHASE_3:
                        this._drawn_points[2] = this.createDynaPoint(IN_y);
                }
        };

    /**
     * 滑鼠
     */
    DrawerGoldenBands.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( IN_which == 1 ) // 左鍵
                switch( this._drawing_phase ) {
                    case DrawerGoldenBands.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerGoldenBands.prototype.PHASE_2;
                        break;
                    case DrawerGoldenBands.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerGoldenBands.prototype.PHASE_3;
                        break;
                    case DrawerGoldenBands.prototype.PHASE_3:
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
    DrawerGoldenBands.prototype.paint  =

        function( IN_ctx ) {
            if( this.isDrawing() ) { // 正在畫..
                if( this._drawn_points.length > 0 ) {
                    this.printTip( IN_ctx );
                    this._drawGoldenBands( IN_ctx, Drawer.prototype.STYLE_DRAWING );
                }
            }
            else // 已畫完
                if( this._drawn_points.length == 3 ) {
                    var style = this._selected? Drawer.prototype.STYLE_SELECTED : this._mouseover? Drawer.prototype.STYLE_MOUSEOVER : this.getParam('color');
                    var lines = this._drawGoldenBands( IN_ctx, style );
                    if( this._selected ) // 端點白色方塊
                        for( var i in lines )
                            this.drawEndPoints( IN_ctx, lines[i] );
                    // 用來判斷 isIntersect() 的 hidden path
                    this.drawHiddenHelpLine( lines, IN_ctx.lineWidth );
                }
        };



    /**
     * 畫出黃金波段
     * 回傳畫出的所有線條(供後續畫端點和點選判斷)
     */
    DrawerGoldenBands.prototype._drawGoldenBands =

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
                if( ! line1[1] ) // 前兩點重合
                    return;
                if( line1[0] ) {
                    this.drawLine( IN_ctx, line1[0], lineWidth, IN_style, dotted );
                    rv.push( line1[0] );
                }
                if( this._drawn_points.length == 3 ) {
                    var x3 = this._drawn_points[2].x();
                    var y3 = this._drawn_points[2].y();
                    var line2 = this.createParallelLine( line1[1], x3, y3 ); // 第2條平行線 = line2
                    if( line2[0] ) {
                        this.drawLine( IN_ctx, line2[0], lineWidth, IN_style, dotted );
                        rv.push( line2[0] );
                    }

                    var p1 = new Point( (x1+x2)/2, (y1+y2)/2 ); // 軸線 與 line1 交點 (line1中點)
                    var axis = this.createPerpendicularLine( line1[1], p1.x, p1.y );
                    var p2 = axis[1].getLineIntersection( line2[1] ); // 軸線 與 line2 交點
                    // 找 areaTicks 範圍內的 axis
                    var axisSegment = new Rect( 0, 0, this._mars_k.getTicksAreaWidthExcludeYAxis(), this._area_ticks._height).getIntersection( new Line(p1.x, p1.y, p2.x, p2.y) );
                    if( axisSegment ) {
                        this.drawLine( IN_ctx, axisSegment, lineWidth, IN_style, dotted );
                        rv.push( axisSegment );
                    }

                    // 畫出各波段
                    this._ctx_test.beginPath(); // to test text collision
                    for( var i in DrawerGoldenBands.prototype.BANDS ) {
                        var band = DrawerGoldenBands.prototype.BANDS[i];
                        var bandX = p1.x+(p2.x-p1.x)*band; // 軸線上的波段分割點
                        var bandY = p1.y+(p2.y-p1.y)*band;
                        var bandLine = this.createParallelLine( line1[1], bandX, bandY );
                        if( bandLine[0] ) {
                            // draw line
                            this.drawLine( IN_ctx, bandLine[0], lineWidth, IN_style, dotted );
                            rv.push( bandLine[0] );
                            // draw text
                            var p = bandLine[0].x1<=bandLine[0].x2? new Point(bandLine[0].x1, bandLine[0].y1) : new Point(bandLine[0].x2, bandLine[0].y2);
                            var rotate = Math.atan((bandLine[0].y2-bandLine[0].y1)/(bandLine[0].x2-bandLine[0].x1));
                            var tw = this._ctx_test.measureText( DrawerGoldenBands.prototype.BANDS[i]).width;
                            var cos = Math.cos( rotate );
                            var sin = Math.sin( rotate );
                            if( !this._ctx_test.isPointInPath(p.x+50*cos, p.y+50*sin) && !this._ctx_test.isPointInPath(p.x+(50+tw)*cos, p.y+(50+tw)*sin)) {
                                this._ctx_test.translate( p.x, p.y );
                                this._ctx_test.rotate( rotate );
                                this._ctx_test.rect( 50, 0, tw, 15 );
                                IN_ctx.translate( p.x, p.y );
                                IN_ctx.rotate( rotate );
                                IN_ctx.textBaseline = 'top';
                                IN_ctx.textAlign = 'left';
                                IN_ctx.font = DrawerGoldenBands.prototype.BAND_FONT;
                                IN_ctx.fillStyle = IN_ctx.strokeStyle; // this.getParam('color');
                                IN_ctx.fillText( DrawerGoldenBands.prototype.BANDS[i], 50, -2 );
                                IN_ctx.rotate( -rotate );
                                IN_ctx.translate( -p.x, -p.y );
                                this._ctx_test.rotate( -rotate );
                                this._ctx_test.translate( -p.x, -p.y );
                            }
                        }
                    }
                }
            }
            return rv;
        };
