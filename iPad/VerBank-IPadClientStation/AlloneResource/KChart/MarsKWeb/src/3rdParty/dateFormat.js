
    /**
     * 这个很不错，好像是 csdn 的 Meizz 写的：
     * 对Date的扩展，将 Date 转化为指定格式的String
     * 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
     * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
     * 例子：
     * (new Date()).format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
     * (new Date()).format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
     * @author: meizz
     */
    Date.prototype.format = function( fmt ) {
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "h+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if( /(y+)/.test(fmt) )
            fmt = fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        for( var k in o )
            if( new RegExp("("+ k +")").test(fmt) )
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        return fmt;
    };
    
    // 此為依上面函式拓展之UTC時間格式
    Date.prototype.formatUTC = function( fmt ) {
        var o = {
            "M+" : this.getUTCMonth()+1,                 //月份
            "d+" : this.getUTCDate(),                    //日
            "h+" : this.getUTCHours(),                   //小时
            "m+" : this.getUTCMinutes(),                 //分
            "s+" : this.getUTCSeconds(),                 //秒
            "q+" : Math.floor((this.getUTCMonth()+3)/3), //季度
            "S"  : this.getUTCMilliseconds()             //毫秒
        };
        if( /(y+)/.test(fmt) )
            fmt = fmt.replace(RegExp.$1, (this.getUTCFullYear()+"").substr(4 - RegExp.$1.length));
        for( var k in o )
            if( new RegExp("("+ k +")").test(fmt) )
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        return fmt;
    };
    
    Date.prototype.offsetDateByTimezoneOffsetInMinutes = function( timezoneOffsetInMinutes)
    {
        var offsetDate = new Date( this.getTime() + timezoneOffsetInMinutes * 60 * 1000);
        return offsetDate;
    }
    
    // 此為依上面函式拓展之帶入時區時間格式
    Date.prototype.formatWithTimezoneOffsetInMinutes = function( fmt, timezoneOffsetInMinutes)
    {
        var offsetDate = this.offsetDateByTimezoneOffsetInMinutes( timezoneOffsetInMinutes);
        return offsetDate.formatUTC( fmt);
    };
    
    