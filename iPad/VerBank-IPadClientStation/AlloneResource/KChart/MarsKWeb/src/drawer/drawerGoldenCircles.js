/**
 * 畫圖 - 黃金分割圓(弧)
 *
 * @constructor
 */
var DrawerGoldenCircles = function( IN_mars_k )
{
    this.init( IN_mars_k, Drawer.prototype.MODE_GOLDEN_CIRCLES );
    this._drawing_phase = DrawerGoldenCircles.prototype.PHASE_1; // 正在畫圖中的哪個階段? null=完成
    var canvas = document.createElement( 'canvas' );
    canvas.width = 1;
    canvas.height = 1;
    this._ctx_test = canvas.getContext( '2d' );
}
DrawerGoldenCircles.prototype = new Drawer();
DrawerGoldenCircles.prototype.PHASE_1 = { 'tip_i18n': 'DRAWER_GOLDEN_CIRCLES_PHASE_1_TIP' };
DrawerGoldenCircles.prototype.PHASE_2 = { 'tip_i18n': 'DRAWER_GOLDEN_CIRCLES_PHASE_2_TIP' };
DrawerGoldenCircles.prototype.ARC_WIDTH = Math.PI*2 * 60 / 360;
DrawerGoldenCircles.prototype.BANDS = ['0.236', '0.382', '0.500', '0.618', '0.809', '1'];

    /**
     * 滑鼠
     */
    DrawerGoldenCircles.prototype.procMouseMove =

        function( IN_x, IN_y, IN_evt_which ) {
            if( this._mars_k._focus_tick_index > -1 )
                switch( this._drawing_phase ) {
                    case DrawerGoldenCircles.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        break;
                    case DrawerGoldenCircles.prototype.PHASE_2:
                        this._drawn_points[1] = this.createDynaPoint(IN_y);
                }
        };

    /**
     * 滑鼠
     */
    DrawerGoldenCircles.prototype.procMouseDown =

        function( IN_x, IN_y, IN_which ) {
            if( IN_which == 1 ) // 左鍵
                switch( this._drawing_phase ) {
                    case DrawerGoldenCircles.prototype.PHASE_1:
                        this._drawn_points[0] = this.createDynaPoint(IN_y);
                        this._drawing_phase = DrawerGoldenCircles.prototype.PHASE_2;
                        break;
                    case DrawerGoldenCircles.prototype.PHASE_2:
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
    DrawerGoldenCircles.prototype.paint  =

        function( IN_ctx ) {
            if( this.isDrawing() ) { // 正在畫..
                if( this._drawn_points.length > 0 ) {
                    this.printTip( IN_ctx );
                    this._drawGoldenCircles( IN_ctx, Drawer.prototype.STYLE_DRAWING );
                }
            }
            else // 已畫完
                if( this._drawn_points.length == 2 ) {
                    var style = this._selected? Drawer.prototype.STYLE_SELECTED : this._mouseover? Drawer.prototype.STYLE_MOUSEOVER : this.getParam('color');
                    var arcs = this._drawGoldenCircles( IN_ctx, style );
                    if( this._selected ) // 端點白色方塊
                        for( var i in arcs )
                            this.drawEndPointsOfArc( IN_ctx, arcs[i] );
                    // 用來判斷 isIntersect() 的 hidden path
                    this.drawHiddenHelpArc( arcs, IN_ctx.lineWidth );
                }
        };



    /**
     * 畫出黃金分割圓弧
     * 回傳畫出的所有線條(供後續畫端點和點選判斷)
     */
    DrawerGoldenCircles.prototype._drawGoldenCircles =

        function( IN_ctx, IN_style ) {
            var rv = [];
            var lineWidth = this.getParam( 'lineWidth' );
            var dotted = this.getParam( 'lineDotted' );
            if( this._drawn_points.length == 2 ) {
                var x1 = this._drawn_points[0].x();
                var y1 = this._drawn_points[0].y();
                var x2 = this._drawn_points[1].x();
                var y2 = this._drawn_points[1].y();
                var radius = Math.sqrt(Math.pow(Math.abs(x2-x1), 2) + Math.pow(Math.abs(y2-y1), 2));
                if( radius > 0 ) {
                    var degree = Math.atan2( y2-y1, x2-x1 );
                    degree = degree>=0? degree : Math.PI*2+degree;
                    this._ctx_test.beginPath(); // to test text collision
                    for( var i in DrawerGoldenCircles.prototype.BANDS ) {
                        var band = DrawerGoldenCircles.prototype.BANDS[i];
                        var arc = new Arc( x1, y1, radius*band, degree-DrawerGoldenCircles.prototype.ARC_WIDTH/2, degree+DrawerGoldenCircles.prototype.ARC_WIDTH/2 );
                        // draw arc
                        this.drawArc( IN_ctx, arc, lineWidth, IN_style, dotted );
                        rv.push( arc );
                        // draw text
                        var textDegree = (arc.sAngle + arc.eAngle) / 2;
                        var slope = Math.tan( textDegree );
                        var dx = Math.sqrt( Math.pow(arc.r,2) / (1+Math.pow(slope,2)) );
                        if( textDegree>Math.PI*0.5 && textDegree<=Math.PI*1.5 )
                            dx *= -1;
                        var p = new Point( arc.x+dx, arc.y+dx*slope );
                        var rotate = degree - Math.PI*0.5;
                        var tw = this._ctx_test.measureText( DrawerGoldenCircles.prototype.BANDS[i]).width;
                        var cos = Math.cos( rotate );
                        var sin = Math.sin( rotate );
                        if( !this._ctx_test.isPointInPath(p.x-tw/2*cos, p.y-tw/2*sin) && !this._ctx_test.isPointInPath(p.x+tw/2*cos, p.y+tw/2*sin)) {
                            this._ctx_test.translate( p.x, p.y );
                            this._ctx_test.rotate( rotate );
                            this._ctx_test.rect( -tw/2, 0, tw/2, 15 );
                            IN_ctx.translate( p.x, p.y );
                            IN_ctx.rotate( rotate );
                            IN_ctx.textBaseline = 'top';
                            IN_ctx.textAlign = 'center';
                            IN_ctx.font = DrawerGoldenBands.prototype.BAND_FONT;
                            IN_ctx.fillStyle = IN_ctx.strokeStyle; // this.getParam('color');
                            IN_ctx.fillText( DrawerGoldenCircles.prototype.BANDS[i], 0, 0 );
                            IN_ctx.rotate( -rotate );
                            IN_ctx.translate( -p.x, -p.y );
                            this._ctx_test.rotate( -rotate );
                            this._ctx_test.translate( -p.x, -p.y );
                        }
                    }
                }
            }
            return rv;
        };
