/**
 * 右下角落空白區
 *
 */
var AreaCorner = function( IN_mars_k )
{
    this._initArea( IN_mars_k, true, true);
}
AreaCorner.prototype = new Area();
AreaCorner.prototype.constructor = AreaCorner;


    /**
     * 畫出此區
     */
    AreaCorner.prototype.doPaint = function( IN_layer) {
        //this._ctx.clearRect( 0, 0, this.getWidth(), this.getHeight() );
    };


