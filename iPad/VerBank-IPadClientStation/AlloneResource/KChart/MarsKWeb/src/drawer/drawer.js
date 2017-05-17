/**
 * 技術分析畫圖器
 *
 * @constructor
 */
var Drawer = function() {
    this._mode = null;
    this._mars_k = null;
    this._area_ticks = null;
    this._canvas = null; // 用來判斷是否被點選的 1x1 canvas
    this._ctx = null;
    this._mouseover = false;
    this._selected = false;
}
Drawer.prototype.MODE_LINE = 1;             // 隨意切線
Drawer.prototype.MODE_PRICE_TANGENT = 2;    // 價位切線
Drawer.prototype.MODE_HORIZONTAL = 3;       // 水平線
Drawer.prototype.MODE_CHANNEL = 4;          // 軌道線(隨意通道)
Drawer.prototype.MODE_GOLDEN_SECTION = 5;   // 黃金分割
Drawer.prototype.MODE_GOLDEN_BANDS = 6;     // 黃金波段
Drawer.prototype.MODE_GOLDEN_CIRCLES = 7;     // 黃金波段

Drawer.prototype.STYLE_DRAWING = null;
Drawer.prototype.STYLE_MOUSEOVER = null;
Drawer.prototype.STYLE_SELECTED = null;
Drawer.prototype.TA = 2; // 圖形點選額外粗細增益(degree of thickness augment for user-friendly)
Drawer.prototype.END_POINT_WIDTH = 5;
Drawer.prototype.FONT_TIP = '12px Arial';
Drawer.prototype.BIG_NUMBER = Math.pow( 10, 15 );
Drawer.prototype.RECT_BOUNDLESS = new Rect(-Drawer.prototype.BIG_NUMBER, -Drawer.prototype.BIG_NUMBER, Drawer.prototype.BIG_NUMBER, Drawer.prototype.BIG_NUMBER)
Drawer.prototype.isMouseover = function(){ return this._mouseover; };
Drawer.prototype.isSelected = function(){ return this._selected; };



/**
 * 預設參數
 */
Drawer.prototype.DEFINITIONS = {};
Drawer.prototype.DEFINITIONS[ Drawer.prototype.MODE_LINE ] = {
    'name_i18n': 'DRAWER_LINE_NAME',
    'params': {
        'color': [ 'rgba(168, 168, 0, 1)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'DRAWER_LINE_PARAM_COLOR'}],
        'lineWidth': [ 2, { 'type':AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min':1, 'max':20, 'showInArea':false, 'alias_i18n': 'DRAWER_LINE_PARAM_LINE_WIDTH'}],
        'lineDotted': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_LINE_PARAM_LINE_DOTTED'}],
        'showTip': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_LINE_PARAM_SHOW_TIP'}],
    }
};
Drawer.prototype.DEFINITIONS[ Drawer.prototype.MODE_PRICE_TANGENT ] = {
    'name_i18n': 'DRAWER_PRICE_TANGENT_NAME',
    'params': {
        'color': [ 'rgba(168, 168, 0, 0.7)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'DRAWER_PRICE_TANGENT_PARAM_COLOR'}],
        'lineWidth': [ 2, { 'type':AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min':1, 'max':10, 'showInArea':false, 'alias_i18n': 'DRAWER_PRICE_TANGENT_PARAM_LINE_WIDTH'}],
        'lineDotted': [ false, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_PRICE_TANGENT_PARAM_LINE_DOTTED'}],
        'showTip': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_PRICE_TANGENT_PARAM_SHOW_TIP'}],
    }
};
Drawer.prototype.DEFINITIONS[ Drawer.prototype.MODE_HORIZONTAL ] = {
    'name_i18n': 'DRAWER_HORIZONTAL_NAME',
    'params': {
        'color': [ 'rgba(168, 168, 0, 1)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'DRAWER_HORIZONTAL_PARAM_COLOR'}],
        'lineWidth': [ 2, { 'type':AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min':1, 'max':20, 'showInArea':false, 'alias_i18n': 'DRAWER_HORIZONTAL_PARAM_LINE_WIDTH'}],
        'lineDotted': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_HORIZONTAL_PARAM_LINE_DOTTED'}],
        'showTip': [ true, { 'type': AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_HORIZONTAL_PARAM_SHOW_TIP'}],
    }
};
Drawer.prototype.DEFINITIONS[ Drawer.prototype.MODE_CHANNEL ] = {
    'name_i18n': 'DRAWER_CHANNEL_NAME',
    'params': {
        'color': [ 'rgba(168, 168, 0, 1)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'DRAWER_CHANNEL_PARAM_COLOR'}],
        'lineWidth': [ 2, { 'type':AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min':1, 'max':20, 'showInArea':false, 'alias_i18n': 'DRAWER_CHANNEL_PARAM_LINE_WIDTH'}],
        'lineDotted': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_CHANNEL_PARAM_LINE_DOTTED'}],
        'showTip': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_CHANNEL_PARAM_SHOW_TIP'}],
    }
};
Drawer.prototype.DEFINITIONS[ Drawer.prototype.MODE_GOLDEN_SECTION ] = {
    'name_i18n': 'DRAWER_GOLDEN_SECTION_NAME',
    'params': {
        'color': [ 'rgba(168, 168, 0, 1)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'DRAWER_GOLDEN_SECTION_PARAM_COLOR'}],
        'lineWidth': [ 2, { 'type':AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min':1, 'max':20, 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_SECTION_PARAM_LINE_WIDTH'}],
        'lineDotted': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_SECTION_PARAM_LINE_DOTTED'}],
        'showTip': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_SECTION_PARAM_SHOW_TIP'}],
    }
};
Drawer.prototype.DEFINITIONS[ Drawer.prototype.MODE_GOLDEN_BANDS ] = {
    'name_i18n': 'DRAWER_GOLDEN_BANDS_NAME',
    'params': {
        'color': [ 'rgba(168, 168, 0, 1)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'DRAWER_GOLDEN_BANDS_PARAM_COLOR'}],
        'lineWidth': [ 2, { 'type':AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min':1, 'max':20, 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_BANDS_PARAM_LINE_WIDTH'}],
        'lineDotted': [ false, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_BANDS_PARAM_LINE_DOTTED'}],
        'showTip': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_BANDS_PARAM_SHOW_TIP'}],
    }
};
Drawer.prototype.DEFINITIONS[ Drawer.prototype.MODE_GOLDEN_CIRCLES ] = {
    'name_i18n': 'DRAWER_GOLDEN_CIRCLES_NAME',
    'params': {
        'color': [ 'rgba(168, 168, 0, 1)', {'type':AreaXY.prototype.PARAM_TYPES['COLOR'], 'showInArea':true, 'alias_i18n': 'DRAWER_GOLDEN_CIRCLES_PARAM_COLOR'}],
        'lineWidth': [ 2, { 'type':AreaXY.prototype.PARAM_TYPES['NUMBER'], 'min':1, 'max':20, 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_CIRCLES_PARAM_LINE_WIDTH'}],
        'lineDotted': [ false, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_CIRCLES_PARAM_LINE_DOTTED'}],
        'showTip': [ true, { 'type':AreaXY.prototype.PARAM_TYPES['BOOLEAN'], 'showInArea':false, 'alias_i18n': 'DRAWER_GOLDEN_CIRCLES_PARAM_SHOW_TIP'}],
    }
};



/**
 *
 */
Drawer.prototype.initStatic =

    function( IN_mars_k ) {
        // 建立各種靜態填充patterns
        var patternCanvas = document.createElement('canvas');
        patternCanvas.width=30;
        patternCanvas.height=30;
        var patternCtx = patternCanvas.getContext('2d');
        var changeDrawingPattern = function() {
            var c = 96 + Date.now() % 64;
            var grd = patternCtx.createRadialGradient(15,15,3,15,15,28);
            grd.addColorStop(0,'rgb('+c+','+c+','+c+')');
            grd.addColorStop(1,"white");
            patternCtx.fillStyle = grd;
            patternCtx.fillRect( 0, 0, 30, 30 );
            Drawer.prototype.STYLE_DRAWING = patternCtx.createPattern( patternCanvas, 'repeat' );
            // setTimeout( changeDrawingPattern, 100 ); // only chrome could afford to run smoothly
        }();
        var changeMouseoverPattern = function() {
            var c = 33; // Date.now() % 128;
            var grd = patternCtx.createRadialGradient(15,15,3,15,15,28);
            grd.addColorStop(0,'rgb('+c+','+c+','+c+')');
            grd.addColorStop(0.6,"white");
            patternCtx.fillStyle = grd;
            patternCtx.fillRect( 0, 0, 30, 30 );
            Drawer.prototype.STYLE_MOUSEOVER = patternCtx.createPattern( patternCanvas, 'repeat' );
            // setTimeout( changeMouseoverPattern, 100 ); // only chrome could afford this
        }();
        var changeSelectedPattern = function() {
            var rg = 255; // Date.now() % 256;
            var grd = patternCtx.createRadialGradient(15,15,3,15,15,28);
            grd.addColorStop(0,'rgb('+rg+','+rg+',11)');
            grd.addColorStop(0.8,"black");
            patternCtx.fillStyle = grd;
            patternCtx.fillRect( 0, 0, 30, 30 );
            Drawer.prototype.STYLE_SELECTED = patternCtx.createPattern( patternCanvas, 'repeat' );
            // IN_mars_k.paint();
            // setTimeout( changeSelectedPattern, 100 );
        }();
    };


/**
 * 創造 Drawer 實例
 */
Drawer.prototype.createTechDrawer =

    function( IN_mars_k, IN_mode ) {
        switch( IN_mode ) {
            case Drawer.prototype.MODE_LINE:
                return new DrawerLine( IN_mars_k );
            case Drawer.prototype.MODE_PRICE_TANGENT:
                return new DrawerPriceTangent( IN_mars_k );
            case Drawer.prototype.MODE_HORIZONTAL:
                return new DrawerHorizontal( IN_mars_k );
            case Drawer.prototype.MODE_CHANNEL:
                return new DrawerChannel( IN_mars_k );
            case Drawer.prototype.MODE_GOLDEN_SECTION:
                return new DrawerGoldenSection( IN_mars_k );
            case Drawer.prototype.MODE_GOLDEN_BANDS:
                return new DrawerGoldenBands( IN_mars_k );
            case Drawer.prototype.MODE_GOLDEN_CIRCLES:
                return new DrawerGoldenCircles( IN_mars_k );
            default:
                alert( '施工中' );
                return null;
        }
    }



    /**
     * 初始化
     */
    Drawer.prototype.init =

        function( IN_mars_k, IN_mode ) {
            this._mars_k = IN_mars_k;
            this._area_ticks = this._mars_k.getAreaTicks();
            this._mode = IN_mode;
            this._drawn_points = []; // 已完成的畫圖, array of Point

            // prepare ctx to draw the hidden path on it for detecting mouse-over
            var canvas = document.createElement('canvas');
            canvas.width = 1;
            canvas.height = 1;
            this._ctx = canvas.getContext('2d');
        };

    /**
     * 取得參數設定
     */
    Drawer.prototype.getParam =

        function( param ) {
            return Drawer.prototype.DEFINITIONS[ this._mode ][ 'params' ][ param ][0];
        };

    /**
     * 正在畫?
     */
    Drawer.prototype.isDrawing =

        function() {
            return this._drawing_phase != null;
        };

    Drawer.prototype.getBackgroundColor = 
        function() {
            var bgColor = window.getComputedStyle( this._mars_k._dom_canvas)['backgroundColor'];
            return bgColor;
        };

    /**
     * 回傳目前游標焦點的動態座標
     * 1. 傳入 y, 回傳 ( tick, price(IN_y) )
     * 2. 未傳入 y, 回傳 ( tick, tick.closePrice )
     */
    Drawer.prototype.createDynaPoint =

        function( y ) {
            var rv = {};
            var marsK = this._mars_k;
            var areaTicks = this._area_ticks;
            rv.focusTick = marsK._focus_tick;
            rv.price = y!=undefined? areaTicks.getValueFromY(y) : rv.focusTick.close;
            // 以下座標相對於 area ticks (0,0)
            rv.x = function(){ return rv.focusTick? rv.focusTick.cx-marsK.getVisibleAreaLeft() : 0; };
            rv.y = function(){ return areaTicks.getYFromValue(rv.price); }
            return rv;
        };

    /**
     * 判斷傳入(x,y)是否落在這個畫圖物件範圍內
     */
    Drawer.prototype.isIntersect =

        function( x, y ) {
            this._mouseover = this._ctx.isPointInPath(x, y);
            return this._mouseover;
        };

    /**
     * 切換 selected / non-selected
     */
    Drawer.prototype.switchSelected =

        function() {
            this._selected = !this._selected;
        };


    /**
     * 印出操作提示
     */
    Drawer.prototype.printTip =

        function( ctx ) {
            if( this.getParam('showTip') ) {
                ctx.font = Drawer.prototype.FONT_TIP;
                ctx.fillStyle = MarsKUtility.prototype.getContrastiveColor( this.getBackgroundColor(), 1 );
                ctx.textAlign = 'left';
                ctx.textBaseline = 'top';
                var lastPoint = this._drawn_points[this._drawn_points.length-1];
                
                var L_tip = this._mars_k.i18n( this._drawing_phase['tip_i18n']);
                ctx.fillText( L_tip, lastPoint.x()+15, lastPoint.y()+5 );
            }
        };

    /**
     * 畫線
     */
    Drawer.prototype.drawLine =

        function( ctx, line, lineWidth, style, dotted ) {
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = style;
            dotted = dotted && ctx.setLineDash!=undefined;
            if( dotted )
                ctx.setLineDash( [5*lineWidth, 3*lineWidth] );
            ctx.beginPath();
            ctx.moveTo( line.x1, line.y1 );
            ctx.lineTo( line.x2, line.y2 );
            ctx.stroke();
            if( dotted )
                ctx.setLineDash( [] );
        };

    /**
     * 畫弧
     */
    Drawer.prototype.drawArc =

        function( ctx, arc, lineWidth, style, dotted ) {
            ctx.lineWidth = 0.3;
            ctx.strokeStyle = MarsKUtility.prototype.getContrastiveColor( this.getBackgroundColor(), 0.5 );
            if( ctx.setLineDash != undefined )
                ctx.setLineDash( [5*lineWidth, 3*lineWidth] );
            ctx.beginPath();
            ctx.arc( arc.x, arc.y, arc.r, 0, Math.PI*2 );
            ctx.stroke();
            if( ctx.setLineDash != undefined )
                ctx.setLineDash( [] );

            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = style;
            dotted = dotted && ctx.setLineDash!=undefined;
            if( dotted )
                ctx.setLineDash( [5*lineWidth, 3*lineWidth] );
            ctx.beginPath();
            ctx.arc( arc.x, arc.y, arc.r, arc.sAngle, arc.eAngle );
            ctx.stroke();
            if( dotted )
                ctx.setLineDash( [] );
        };

    /**
     * 畫線段兩端端點
     */
    Drawer.prototype.drawEndPoints =

        function( ctx, segment ) {
            ctx.fillStyle = MarsKUtility.prototype.getContrastiveColor( this.getBackgroundColor(), 1 );
            ctx.fillRect( segment.x1-Drawer.prototype.END_POINT_WIDTH, segment.y1-Drawer.prototype.END_POINT_WIDTH, Drawer.prototype.END_POINT_WIDTH*2, Drawer.prototype.END_POINT_WIDTH*2 );
            ctx.fillRect( segment.x2-Drawer.prototype.END_POINT_WIDTH, segment.y2-Drawer.prototype.END_POINT_WIDTH, Drawer.prototype.END_POINT_WIDTH*2, Drawer.prototype.END_POINT_WIDTH*2 );
        };

    /**
     * 標示出一段圓弧
     */
    Drawer.prototype.drawEndPointsOfArc =

        function( ctx, arc ) {
            ctx.fillStyle = MarsKUtility.prototype.getContrastiveColor( this.getBackgroundColor(), 1 );
            var angles = [arc.sAngle, arc.eAngle];
            for( var i in angles ) {
                var slope = Math.tan( angles[i] );
                var dx = Math.sqrt( Math.pow(arc.r,2) / (1+Math.pow(slope,2)) );
                if( angles[i]>Math.PI*0.5 && angles[i]<=Math.PI*1.5 )
                    dx *= -1;
                var x = arc.x + dx;
                var y = arc.y + dx*slope;
                ctx.fillRect( x-Drawer.prototype.END_POINT_WIDTH, y-Drawer.prototype.END_POINT_WIDTH, Drawer.prototype.END_POINT_WIDTH*2, Drawer.prototype.END_POINT_WIDTH*2 );
            }
        }


    /**
     * 畫出用來判斷 isIntersect() 的 hidden path of line
     */
    Drawer.prototype.drawHiddenHelpLine =

        function( lines, lineWidth ) {
            this._ctx.beginPath();
            for( var i in lines )
                if( lines[i] != null ) {
                    var arc = Math.atan( (lines[i].y2-lines[i].y1) / (lines[i].x2-lines[i].x1) ); // y軸與一般座標系相反, 左下右上算出斜率及atan皆為負值
                    var px = Math.abs(arc) * (Drawer.prototype.TA + lineWidth);
                    var py = 1.58 * (Drawer.prototype.TA + lineWidth) - px;
                    if( arc > 0 ) {
                        this._ctx.moveTo( lines[i].x1-px, lines[i].y1+py );
                        this._ctx.lineTo( lines[i].x2-px, lines[i].y2+py );
                        this._ctx.lineTo( lines[i].x2+px, lines[i].y2-py );
                        this._ctx.lineTo( lines[i].x1+px, lines[i].y1-py );
                    }
                    else {
                        this._ctx.moveTo( lines[i].x1-px, lines[i].y1-py );
                        this._ctx.lineTo( lines[i].x2-px, lines[i].y2-py );
                        this._ctx.lineTo( lines[i].x2+px, lines[i].y2+py );
                        this._ctx.lineTo( lines[i].x1+px, lines[i].y1+py );
                    }
                }
        };

    /**
     * 畫出用來判斷 isIntersect() 的 hidden path of arc
     */
    Drawer.prototype.drawHiddenHelpArc =

        function( arcs, lineWidth ) {
            this._ctx.beginPath();
            for( var i in arcs )
                if( arcs[i]!=null && arcs[i].r>0 )
                    this._ctx.arc( arcs[i].x, arcs[i].y, arcs[i].r, arcs[i].sAngle, arcs[i].eAngle );
        };



    /**
     * 回傳
     * 1. 兩端延伸至 tick 區邊緣的線段 (產生的線段若不在 tick 區域內 = null)
     * 2. 兩端無限延伸的直線
     */
    Drawer.prototype.createExtLine =

        function( x1, y1, x2, y2 ) {
            var rv = [];
            var p = new Point(x1,y1);
            var slope = (y2-y1)/(x2-x1);
            var rectAreaTicks = new Rect( 0, 0, this._mars_k.getTicksAreaWidthExcludeYAxis(), this._area_ticks._height );
            rv.push( rectAreaTicks.getSegment(p, slope) );
            rv.push( Drawer.prototype.RECT_BOUNDLESS.getSegment(p, slope) );
            return rv;
        };

    /**
     * 回傳
     * 1. 兩端延伸至 tick 區邊緣的線段 (產生的線段若不在 tick 區域內 = null)
     * 2. 兩端無限延伸的直線
     */
    Drawer.prototype.createExtLineWithSlope =

        function( x, y, slope ) {
            var rv = [];
            var p = new Point(x,y);
            var rectAreaTicks = new Rect( 0, 0, this._mars_k.getTicksAreaWidthExcludeYAxis(), this._area_ticks._height );
            rv.push( rectAreaTicks.getSegment(p, slope) );
            rv.push( Drawer.prototype.RECT_BOUNDLESS.getSegment(p, slope) );
            return rv;
        };

    /**
     * 回傳
     * 1. 兩端延伸至 tick 區邊緣且與 line 垂直又通過 (x,y) 的線段 (產生的線段若不在 tick 區域內 = null)
     * 2. 兩端無限延伸且與 line 垂直又通過 (x,y) 的直線
     */
    Drawer.prototype.createPerpendicularLine =

        function( line, x, y ) {
            var rv = [];
            var p = new Point(x,y);
            var rectAreaTicks = new Rect( 0, 0, this._mars_k.getTicksAreaWidthExcludeYAxis(), this._area_ticks._height );
            rv.push( rectAreaTicks.getPerpendicularLine(line, p) );
            rv.push( Drawer.prototype.RECT_BOUNDLESS.getPerpendicularLine(line, p) );
            return rv;
        };

    /**
     * 回傳
     * 1. 兩端延伸至 tick 區邊緣且與 line 平行又通過 (x,y) 的線段 (產生的線段若不在 tick 區域內 = null)
     * 2. 兩端無限延伸且與 line 平行又通過 (x,y) 的線段
     */
    Drawer.prototype.createParallelLine =

        function( line, x, y ) {
            var rv = [];
            var p = new Point(x,y);
            var rectAreaTicks = new Rect( 0, 0, this._mars_k.getTicksAreaWidthExcludeYAxis(), this._area_ticks._height );
            rv.push( rectAreaTicks.getParallelLine(line, p) );
            rv.push( Drawer.prototype.RECT_BOUNDLESS.getParallelLine(line, p) );
            return rv;
        };