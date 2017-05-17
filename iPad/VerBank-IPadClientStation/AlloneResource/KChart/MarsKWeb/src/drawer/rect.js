/**
 * 2維平面區域
 */
var Rect =

    function( x1, y1, x2, y2 ) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    };


    /**
     * 回傳 line 與在這個 rect 的交集線段
     * 不在此 rect 範圍內, 或 line 長度=0, 回傳 null
     */
    Rect.prototype.getIntersection =

        function( line ) {
            var p1 = new Point( line.x1, line.y1 );
            var p2 = new Point( line.x2, line.y2 );
            var containsP1 = this._contains(p1);
            var containsP2 = this._contains(p2);
            if( containsP1 && containsP2 )
                return line;
            else if( containsP1 || containsP2 ) {
                var borders = this._getBorders();
                for( var i in borders ) {
                    var pi = line.getSegmentIntersection( borders[i] );
                    if( pi )
                        return containsP1? new Line(p1.x, p1.y, pi.x, pi.y) : new Line(p2.x, p2.y, pi.x, pi.y);
                }
            }
            else {
                var borders = this._getBorders();
                var p = [];
                for( var i in borders ) {
                    var pi = line.getSegmentIntersection( borders[i] );
                    if( pi )
                        p.push( pi );
                }
                if( p.length == 2 )
                    return Line.prototype.createLine( p[0], p[1] );
                else if( p.length > 2 ) { // 至少一端切於角
                    var d1 = p[0].distance( p[1] );
                    var d2 = p[0].distance( p[2] );
                    return p[0].distance(p[1]) > p[0].distance(p[2])?
                        Line.prototype.createLine(p[0], p[1])
                        : Line.prototype.createLine(p[0], p[2]);
                }
            }
            return null;
        };


    /**
     * 回傳在這個 rect 範圍內, 通過 p 與 line 垂直的線段
     * 不在此 rect 範圍內, 或 line 長度=0, 回傳 null
     */
    Rect.prototype.getPerpendicularLine =

        function( line, p ) {
            var slope = line.y2!=line.y1? -1 / ((line.y2-line.y1) / (line.x2-line.x1)) : Infinity;
            return this.getSegment( p, slope );
        };

    /**
     * 回傳在這個 rect 範圍內, 通過 p 與 line 平行的線段
     * 不在此 rect 範圍內, 或 line 長度=0, 回傳 null
     */
    Rect.prototype.getParallelLine =

        function( line, p ) {
            var slope = line.y2!=line.y1? (line.y2-line.y1) / (line.x2-line.x1) : 0;
            return this.getSegment( p, slope );
        };


    /**
     * 回傳在這個 rect 範圍內, 通過 p 斜率為 slope 的線段
     * 不在此 rect 範圍內則回傳 null
     */
    Rect.prototype.getSegment =

        function( p, slope ) {
            if( slope == 0 ) // horizontal
                return p.y>=this.y1 && p.y<=this.y2? new Line(this.x1, p.y, this.x2, p.y) : null;
            else if( slope == Infinity ) // vertical
                return p.x>=this.x1 && p.x<=this.x2? new Line(p.x, this.y1, p.x, this.y2) : null;
            else {
                var y1 = p.y - slope * (p.x-this.x1);
                var y2 = slope * (this.x2-p.x) + p.y;
                var line = new Line( this.x1, y1, this.x2, y2 );
                var borders = this._getBorders();
                var rect = new Rect( this.x1-1, this.y1-1, this.x2+1, this.y2+1 ); // 涵蓋浮點誤差
                var intersectPoints = [];
                for( var i in borders ) {
                    var pi = line.getLineIntersection( borders[i] ); // 兩 "直線" 交點
                    if( rect._contains(pi) )
                        intersectPoints.push( pi );
                }
                if( intersectPoints.length == 2 ) // 可視範圍內大多 2 交點
                    return Line.prototype.createLine( intersectPoints[0], intersectPoints[1] );
                else if( intersectPoints.length > 2 ) { // 至少一端切於角
                    var maxD = -1;
                    var p1 = intersectPoints[0];
                    var p2 = null;
                    for( var i=1; i<intersectPoints.length; ++i ) {
                        var d = p1.distance( intersectPoints[i] );
                        if( d > maxD ) {
                            maxD = d;
                            p2 = intersectPoints[i];
                        }
                    }
                    return Line.prototype.createLine( p1, p2 );
                }
                else // 逸出可視範圍
                    return null;
            }
        };


    /**
     * 回傳邊界(4 lines) 
     */
    Rect.prototype._getBorders =
        
        function() {
            var rv = [];
            rv.push( new Line(this.x1, this.y1, this.x2, this.y1) );
            rv.push( new Line(this.x1, this.y2, this.x2, this.y2) );
            rv.push( new Line(this.x1, this.y1, this.x1, this.y2) );
            rv.push( new Line(this.x2, this.y1, this.x2, this.y2) );
            return rv;
        };


    /**
     * 包含某點?
     */
    Rect.prototype._contains =
        
        function( point ) {
            return point.x>=this.x1 && point.x<=this.x2 && point.y>=this.y1 && point.y<=this.y2;
        };