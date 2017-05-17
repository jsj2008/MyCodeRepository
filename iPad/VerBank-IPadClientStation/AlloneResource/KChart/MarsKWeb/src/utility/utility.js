// Fix performance.now() for safari.
if (window.performance == undefined) {
    window.performance = {};
}
performance.now =
    performance.now ||
    performance.webkitNow ||
    performance.mozNow ||
    performance.msNow ||
    performance.oNow ||
    Date.now;
    
var MarsKUtility = function() {};

MarsKUtility.prototype.__anchor_time;
MarsKUtility.prototype.anchorProfile = function()
{
    var L_last_anchor_time = MarsKUtility.prototype.__anchor_time;
    MarsKUtility.prototype.__anchor_time = performance.now();
    
    if (L_last_anchor_time != undefined) {
        return MarsKUtility.prototype.__anchor_time - L_last_anchor_time;;
    }
};

MarsKUtility.prototype.registerEvent = function( IN_dom, IN_event_name, IN_caller, IN_func)
{
    var L_handler = function()
    {
        IN_func.apply( IN_caller, arguments);
    };
    
    if (window.addEventListener) {
        // W3C.
        var L_use_capture = false; // Event fire from root to leaf.
        IN_event_name = IN_event_name.replace( /^on/, ''); // Remove prefix - 'on'xxx.
        IN_dom.addEventListener( IN_event_name, L_handler, L_use_capture);
        return function() {
            IN_dom.removeEventListener( IN_event_name, L_handler, L_use_capture);
        }
    }
    else {
        // Old IE.
        if (IN_dom.attachEvent( IN_event_name, L_handler)) {
            return function() {
                IN_dom.detachEvent( IN_event_name, L_handler);
            };
        }
    }
    
    return null;
};

MarsKUtility.prototype.getTimezone = function()
{
    return -(new Date().getTimezoneOffset() / 60);
};

MarsKUtility.prototype.getTimezoneMinutes = function()
{
    return -(new Date().getTimezoneOffset());
};

MarsKUtility.prototype.leadingZero = function( IN_number, IN_digits)
{
    return (new Array( IN_digits).join(0) + IN_number).slice( -IN_digits);
};

MarsKUtility.prototype.colorStringToArray = function( IN_color_str)
{
    if (IN_color_str.indexOf( 'rgba') != -1) {
        return MarsKUtility.prototype.rgbaStringToArray( IN_color_str);
    }
    
    return MarsKUtility.prototype.rgbStringToArray( IN_color_str);
}

MarsKUtility.prototype.rgbStringToArray = function( IN_rgb_str)
{
    var L_arr = [];
    IN_rgb_str.replace(
        /rgb\((.*),(.*),(.*)\)/,
        function( $str, $1, $2, $3, $4)
        {
            var L_r = parseInt( $1);
            var L_g = parseInt( $2);
            var L_b = parseInt( $3);
            L_arr = L_arr.concat( [L_r, L_g, L_b]);
        }
    );
    
    return L_arr;
};

MarsKUtility.prototype.rgbaStringToArray = function( IN_rgba_str)
{
    var L_arr = [];
    IN_rgba_str.replace(
        /rgba\((.*),(.*),(.*),(.*)\)/,
        function( $str, $1, $2, $3, $4)
        {
            var L_r = parseInt( $1);
            var L_g = parseInt( $2);
            var L_b = parseInt( $3);
            var L_a = parseFloat( $4);
            L_arr = L_arr.concat( [L_r, L_g, L_b, L_a]);
        }
    );
    
    return L_arr;
};

MarsKUtility.prototype.rgbArrayToHexStr = function( IN_rgb_arr)
{
    return '#' +
        MarsKUtility.prototype.leadingZero( IN_rgb_arr[0].toString( 16), 2) +
        MarsKUtility.prototype.leadingZero( IN_rgb_arr[1].toString( 16), 2) +
        MarsKUtility.prototype.leadingZero( IN_rgb_arr[2].toString( 16), 2);
};

/**
 * 指定alpha並依傳入的原始顏色(IN_color)和對比度(IN_contrast)回傳對比顏色
 */
MarsKUtility.prototype.getContrastiveColor =

    function( IN_color, IN_contrast, IN_alpha ) {
        if (IN_color == null) {
            console.log( 'getContrastiveColor: arg of color is invalid.');
            return;
        }
        var rgb = IN_color.replace(/[^\d,]/g, '').split(',');
        var r = rgb[0] * 1;
        var g = rgb[1] * 1;
        var b = rgb[2] * 1;
        if( IN_alpha && IN_alpha>=0 && IN_alpha<=1 )
            return 'rgba('
                + Math.floor((r<128? r+(255-r)*IN_contrast : r-r*IN_contrast)) + ','
                + Math.floor((g<128? g+(255-g)*IN_contrast : g-g*IN_contrast)) + ','
                + Math.floor((b<128? b+(255-b)*IN_contrast : b-b*IN_contrast)) + ','
                + IN_alpha
                + ')';
        else
            return 'rgb('
                + Math.floor((r<128? r+(255-r)*IN_contrast : r-r*IN_contrast)) + ','
                + Math.floor((g<128? g+(255-g)*IN_contrast : g-g*IN_contrast)) + ','
                + Math.floor((b<128? b+(255-b)*IN_contrast : b-b*IN_contrast))
                + ')';
    };



/**
 * 四捨五入到指定小數位數
 */
MarsKUtility.prototype.round =

    function( IN_price, IN_decimal_digits ) {
        var tmpPow = Math.pow( 10, IN_decimal_digits );
        return Math.round( IN_price * tmpPow ) / tmpPow;
    };
