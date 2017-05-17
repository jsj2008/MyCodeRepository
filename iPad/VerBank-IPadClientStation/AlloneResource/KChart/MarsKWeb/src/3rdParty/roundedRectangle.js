/**
 * by Georgios Migdos
 * http://gmigdos.wordpress.com/2010/05/20/javascript-draw-a-rounded-rectangle-on-an-html-5-canvas/
 */

CanvasRenderingContext2D.prototype.fillRoundedRect = fillRoundedRect;

    /**
     * x: Upper left corner's X coordinate
     * y: Upper left corner's Y coordinate
     * w: Rectangle's width
     * h: Rectangle's height
     * r: Corner radius
     */
    function fillRoundedRect(x, y, w, h, r) {
        this.beginPath();
        this.moveTo(x+r, y);
        this.lineTo(x+w-r, y);
        this.quadraticCurveTo(x+w, y, x+w, y+r);
        this.lineTo(x+w, y+h-r);
        this.quadraticCurveTo(x+w, y+h, x+w-r, y+h);
        this.lineTo(x+r, y+h);
        this.quadraticCurveTo(x, y+h, x, y+h-r);
        this.lineTo(x, y+r);
        this.quadraticCurveTo(x, y, x+r, y);
        this.closePath();
        this.fill();
    }