/**
 * 點
 */
var Point =

    function( x, y ) {
        this.x = x;
        this.y = y;
    };


    /**
     * 與 p2 距離
     */
    Point.prototype.distance =

        function( p2 ) {
            return Math.sqrt(Math.pow(p2.x-this.x, 2) + Math.pow(p2.y-this.y, 2));
        };
