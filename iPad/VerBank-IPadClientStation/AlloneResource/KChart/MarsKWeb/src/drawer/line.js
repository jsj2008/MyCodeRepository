/**
 * 線
 */
var Line =

    function( x1, y1, x2, y2 ) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    };

    /**
     * 2點建立1線
     */
    Line.prototype.createLine =

        function( point1, point2 ) {
            return new Line( point1.x, point1.y, point2.x, point2.y );
        };

    /**
     * 2直線(非線段)交點, 平行重合回傳null
     */
    Line.prototype.getLineIntersection =

        function( line2 ) {
            var a1 = this.y2 - this.y1;
            var b1 = this.x1 - this.x2;
            var c1 = (this.x2-this.x1)*this.y1 - (this.y2-this.y1)*this.x1;
            var a2 = line2.y2 - line2.y1;
            var b2 = line2.x1 - line2.x2;
            var c2 = (line2.x2-line2.x1)*line2.y1 - (line2.y2-line2.y1)*line2.x1;
            var m = a1*b2 - a2*b1;
            return m!=0? new Point((c2*b1-c1*b2)/m, (c1*a2-c2*a1)/m) : null;
        };


    /**
     * 2線段交點, 平行重合回傳null
     */
    Line.prototype.getSegmentIntersection =

        function( line2 ) {
            var pi = this.getLineIntersection( line2 );
            if( pi && this._possiblyContains(pi) && line2._possiblyContains(pi) )
                return pi;
            return null;
        };


    /**
     * 傳入的 point 是否可能落在此線上?
     */
    Line.prototype._possiblyContains =

        function( point ) {
            return point.x+0.01 >= Math.min(this.x1, this.x2) // 考慮浮點誤差
                && point.x-0.01 <= Math.max(this.x1, this.x2)
                && point.y+0.01 >= Math.min(this.y1, this.y2)
                && point.y-0.01 <= Math.max(this.y1, this.y2);
        };