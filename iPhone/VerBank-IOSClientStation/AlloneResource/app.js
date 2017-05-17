var CscApi;
(function (CscApi) {
    var Point = (function () {
        function Point(x, y) {
            this.x = x;
            this.y = y;
        }
        Point.prototype.getX = function () {
            return this.x;
        };
        Point.prototype.getY = function () {
            return this.y;
        };
        Point.prototype.getDistance = function (p2) {
            var dx = p2.x - this.x;
            var dy = p2.y - this.y;
            return Math.sqrt(dx * dx + dy * dy);
        };
        ;
        return Point;
    })();
    CscApi.Point = Point;
})(CscApi || (CscApi = {}));
var CscApi;
(function (CscApi) {
    (function (SpanTypeEnum) {
        SpanTypeEnum[SpanTypeEnum["MINUTE"] = 0] = "MINUTE";
        SpanTypeEnum[SpanTypeEnum["HOUR"] = 1] = "HOUR";
        SpanTypeEnum[SpanTypeEnum["DAY"] = 2] = "DAY";
        SpanTypeEnum[SpanTypeEnum["MONTH"] = 3] = "MONTH";
        SpanTypeEnum[SpanTypeEnum["YEAR"] = 4] = "YEAR";
    })(CscApi.SpanTypeEnum || (CscApi.SpanTypeEnum = {}));
    var SpanTypeEnum = CscApi.SpanTypeEnum;
    (function (ScaleTypeEnum) {
        ScaleTypeEnum[ScaleTypeEnum["MINUTES"] = 0] = "MINUTES";
        ScaleTypeEnum[ScaleTypeEnum["HOURS"] = 1] = "HOURS";
        ScaleTypeEnum[ScaleTypeEnum["DAYS"] = 2] = "DAYS";
        ScaleTypeEnum[ScaleTypeEnum["WEEKS"] = 3] = "WEEKS";
        ScaleTypeEnum[ScaleTypeEnum["MONTHS"] = 4] = "MONTHS";
        ScaleTypeEnum[ScaleTypeEnum["YEARS"] = 5] = "YEARS";
    })(CscApi.ScaleTypeEnum || (CscApi.ScaleTypeEnum = {}));
    var ScaleTypeEnum = CscApi.ScaleTypeEnum;
    (function (ChartType) {
        ChartType[ChartType["TIME_SCALE"] = 0] = "TIME_SCALE";
        ChartType[ChartType["OHLC"] = 1] = "OHLC";
        ChartType[ChartType["AO"] = 2] = "AO";
        ChartType[ChartType["ARBR"] = 3] = "ARBR";
        ChartType[ChartType["ATR"] = 4] = "ATR";
        ChartType[ChartType["BOLLINGER_BAND"] = 5] = "BOLLINGER_BAND";
        ChartType[ChartType["BIAS"] = 6] = "BIAS";
        ChartType[ChartType["BIAS_AB"] = 7] = "BIAS_AB";
        ChartType[ChartType["CCI"] = 8] = "CCI";
        ChartType[ChartType["DMI"] = 9] = "DMI";
        ChartType[ChartType["KDJ"] = 10] = "KDJ";
        ChartType[ChartType["MA"] = 11] = "MA";
        ChartType[ChartType["MACD"] = 12] = "MACD";
        ChartType[ChartType["MTM"] = 13] = "MTM";
        ChartType[ChartType["OBV"] = 14] = "OBV";
        ChartType[ChartType["PSY"] = 15] = "PSY";
        ChartType[ChartType["ROC"] = 16] = "ROC";
        ChartType[ChartType["RSI"] = 17] = "RSI";
        ChartType[ChartType["RSI_SMOOTH"] = 18] = "RSI_SMOOTH";
        ChartType[ChartType["VOLUME"] = 19] = "VOLUME";
        ChartType[ChartType["VR"] = 20] = "VR";
        ChartType[ChartType["WR"] = 21] = "WR";
        ChartType[ChartType["OSMA"] = 22] = "OSMA";
        ChartType[ChartType["SAR"] = 23] = "SAR";
    })(CscApi.ChartType || (CscApi.ChartType = {}));
    var ChartType = CscApi.ChartType;
    (function (ConfigParameterValueType) {
        ConfigParameterValueType[ConfigParameterValueType["NUMBER"] = 0] = "NUMBER";
        ConfigParameterValueType[ConfigParameterValueType["COLOR_RGBA"] = 1] = "COLOR_RGBA";
        ConfigParameterValueType[ConfigParameterValueType["COLOR_RGB"] = 2] = "COLOR_RGB";
        ConfigParameterValueType[ConfigParameterValueType["ENUM"] = 3] = "ENUM";
    })(CscApi.ConfigParameterValueType || (CscApi.ConfigParameterValueType = {}));
    var ConfigParameterValueType = CscApi.ConfigParameterValueType;
    (function (OhlcType) {
        OhlcType[OhlcType["REALITY"] = 0] = "REALITY";
        OhlcType[OhlcType["HEIKIN_ASHI"] = 1] = "HEIKIN_ASHI";
    })(CscApi.OhlcType || (CscApi.OhlcType = {}));
    var OhlcType = CscApi.OhlcType;
    (function (OhlcBarType) {
        OhlcBarType[OhlcBarType["BAR"] = 0] = "BAR";
        OhlcBarType[OhlcBarType["CANDLESTICK"] = 1] = "CANDLESTICK";
    })(CscApi.OhlcBarType || (CscApi.OhlcBarType = {}));
    var OhlcBarType = CscApi.OhlcBarType;
    (function (DrawerType) {
        DrawerType[DrawerType["LINE"] = 0] = "LINE";
        DrawerType[DrawerType["HORIZONTAL_LINE"] = 1] = "HORIZONTAL_LINE";
        DrawerType[DrawerType["PRICE_TANGENT"] = 2] = "PRICE_TANGENT";
        DrawerType[DrawerType["CHANNEL"] = 3] = "CHANNEL";
        DrawerType[DrawerType["GOLDEN_SECTION"] = 4] = "GOLDEN_SECTION";
        DrawerType[DrawerType["GOLDEN_BANDS"] = 5] = "GOLDEN_BANDS";
        DrawerType[DrawerType["GOLDEN_CIRCLE"] = 6] = "GOLDEN_CIRCLE";
        DrawerType[DrawerType["GANN_FAN"] = 7] = "GANN_FAN";
        DrawerType[DrawerType["LINEAR_REGRESSION"] = 8] = "LINEAR_REGRESSION";
    })(CscApi.DrawerType || (CscApi.DrawerType = {}));
    var DrawerType = CscApi.DrawerType;
    (function (ViewAlignMode) {
        ViewAlignMode[ViewAlignMode["LEFT"] = 0] = "LEFT";
        ViewAlignMode[ViewAlignMode["RIGHT"] = 1] = "RIGHT";
    })(CscApi.ViewAlignMode || (CscApi.ViewAlignMode = {}));
    var ViewAlignMode = CscApi.ViewAlignMode;
    var TickData = (function () {
        function TickData() {
            this.primitives = new Float32Array(5);
            this.datetime = null;
        }
        TickData.prototype.getOpen = function () { return this.primitives[0]; };
        TickData.prototype.getHigh = function () { return this.primitives[1]; };
        TickData.prototype.getLow = function () { return this.primitives[2]; };
        TickData.prototype.getClose = function () { return this.primitives[3]; };
        TickData.prototype.getVolume = function () { return this.primitives[4]; };
        TickData.prototype.getDatetime = function () { return this.datetime; };
        TickData.prototype.setOpen = function (value) { this.primitives[0] = value; };
        TickData.prototype.setHigh = function (value) { this.primitives[1] = value; };
        TickData.prototype.setLow = function (value) { this.primitives[2] = value; };
        TickData.prototype.setClose = function (value) { this.primitives[3] = value; };
        TickData.prototype.setVolume = function (value) { this.primitives[4] = value; };
        TickData.prototype.setDatetime = function (value) { this.datetime = value; };
        TickData.prototype.replace = function (tickData) {
            this.setOpen(tickData.getOpen());
            this.setHigh(tickData.getHigh());
            this.setLow(tickData.getLow());
            this.setClose(tickData.getClose());
            this.setVolume(tickData.getVolume());
            this.setDatetime(tickData.getDatetime());
        };
        return TickData;
    })();
    CscApi.TickData = TickData;
    (function (Key) {
        Key[Key["BACKSPACE"] = 0] = "BACKSPACE";
        Key[Key["TAB"] = 1] = "TAB";
        Key[Key["RETURN"] = 2] = "RETURN";
        Key[Key["SHIFT"] = 3] = "SHIFT";
        Key[Key["CTRL"] = 4] = "CTRL";
        Key[Key["ALT"] = 5] = "ALT";
        Key[Key["PAUSE_BREAK"] = 6] = "PAUSE_BREAK";
        Key[Key["CAPSLOCK"] = 7] = "CAPSLOCK";
        Key[Key["ESC"] = 8] = "ESC";
        Key[Key["SPACE"] = 9] = "SPACE";
        Key[Key["PAGEUP"] = 10] = "PAGEUP";
        Key[Key["PAGEDOWN"] = 11] = "PAGEDOWN";
        Key[Key["END"] = 12] = "END";
        Key[Key["HOME"] = 13] = "HOME";
        Key[Key["LEFT"] = 14] = "LEFT";
        Key[Key["UP"] = 15] = "UP";
        Key[Key["RIGHT"] = 16] = "RIGHT";
        Key[Key["DOWN"] = 17] = "DOWN";
        Key[Key["PRINTSCR"] = 18] = "PRINTSCR";
        Key[Key["INSERT"] = 19] = "INSERT";
        Key[Key["DELETE"] = 20] = "DELETE";
        Key[Key["NUM_0"] = 21] = "NUM_0";
        Key[Key["NUM_1"] = 22] = "NUM_1";
        Key[Key["NUM_2"] = 23] = "NUM_2";
        Key[Key["NUM_3"] = 24] = "NUM_3";
        Key[Key["NUM_4"] = 25] = "NUM_4";
        Key[Key["NUM_5"] = 26] = "NUM_5";
        Key[Key["NUM_6"] = 27] = "NUM_6";
        Key[Key["NUM_7"] = 28] = "NUM_7";
        Key[Key["NUM_8"] = 29] = "NUM_8";
        Key[Key["NUM_9"] = 30] = "NUM_9";
        Key[Key["A"] = 31] = "A";
        Key[Key["B"] = 32] = "B";
        Key[Key["C"] = 33] = "C";
        Key[Key["D"] = 34] = "D";
        Key[Key["E"] = 35] = "E";
        Key[Key["F"] = 36] = "F";
        Key[Key["G"] = 37] = "G";
        Key[Key["H"] = 38] = "H";
        Key[Key["I"] = 39] = "I";
        Key[Key["J"] = 40] = "J";
        Key[Key["K"] = 41] = "K";
        Key[Key["L"] = 42] = "L";
        Key[Key["M"] = 43] = "M";
        Key[Key["N"] = 44] = "N";
        Key[Key["O"] = 45] = "O";
        Key[Key["P"] = 46] = "P";
        Key[Key["Q"] = 47] = "Q";
        Key[Key["R"] = 48] = "R";
        Key[Key["S"] = 49] = "S";
        Key[Key["T"] = 50] = "T";
        Key[Key["U"] = 51] = "U";
        Key[Key["V"] = 52] = "V";
        Key[Key["W"] = 53] = "W";
        Key[Key["X"] = 54] = "X";
        Key[Key["Y"] = 55] = "Y";
        Key[Key["Z"] = 56] = "Z";
        Key[Key["TURNOFF"] = 57] = "TURNOFF";
        Key[Key["SLEEP"] = 58] = "SLEEP";
        Key[Key["NUMPAD_0"] = 59] = "NUMPAD_0";
        Key[Key["NUMPAD_1"] = 60] = "NUMPAD_1";
        Key[Key["NUMPAD_2"] = 61] = "NUMPAD_2";
        Key[Key["NUMPAD_3"] = 62] = "NUMPAD_3";
        Key[Key["NUMPAD_4"] = 63] = "NUMPAD_4";
        Key[Key["NUMPAD_5"] = 64] = "NUMPAD_5";
        Key[Key["NUMPAD_6"] = 65] = "NUMPAD_6";
        Key[Key["NUMPAD_7"] = 66] = "NUMPAD_7";
        Key[Key["NUMPAD_8"] = 67] = "NUMPAD_8";
        Key[Key["NUMPAD_9"] = 68] = "NUMPAD_9";
        Key[Key["NUMPAD_MULTIPLY"] = 69] = "NUMPAD_MULTIPLY";
        Key[Key["NUMPAD_ADD"] = 70] = "NUMPAD_ADD";
        Key[Key["NUMPAD_SUBTRACT"] = 71] = "NUMPAD_SUBTRACT";
        Key[Key["NUMPAD_COMMA"] = 72] = "NUMPAD_COMMA";
        Key[Key["NUMPAD_DIVIDE"] = 73] = "NUMPAD_DIVIDE";
        Key[Key["F1"] = 74] = "F1";
        Key[Key["F2"] = 75] = "F2";
        Key[Key["F3"] = 76] = "F3";
        Key[Key["F4"] = 77] = "F4";
        Key[Key["F5"] = 78] = "F5";
        Key[Key["F6"] = 79] = "F6";
        Key[Key["F7"] = 80] = "F7";
        Key[Key["F8"] = 81] = "F8";
        Key[Key["F9"] = 82] = "F9";
        Key[Key["F10"] = 83] = "F10";
        Key[Key["F11"] = 84] = "F11";
        Key[Key["F12"] = 85] = "F12";
        Key[Key["NUMLOCK"] = 86] = "NUMLOCK";
        Key[Key["SCROLLLOCK"] = 87] = "SCROLLLOCK";
        Key[Key["ADD"] = 88] = "ADD";
        Key[Key["COMMA"] = 89] = "COMMA";
        Key[Key["SUBTRACT"] = 90] = "SUBTRACT";
        Key[Key["DECIMAL"] = 91] = "DECIMAL";
        Key[Key["LEFT_QUOTE"] = 92] = "LEFT_QUOTE";
        Key[Key["WAKEUP"] = 93] = "WAKEUP";
    })(CscApi.Key || (CscApi.Key = {}));
    var Key = CscApi.Key;
    (function (MouseButton) {
        MouseButton[MouseButton["LEFT"] = 0] = "LEFT";
        MouseButton[MouseButton["RIGHT"] = 1] = "RIGHT";
        MouseButton[MouseButton["META"] = 2] = "META";
    })(CscApi.MouseButton || (CscApi.MouseButton = {}));
    var MouseButton = CscApi.MouseButton;
    CscApi.LANG_UNKNOWN_STRING = '???';
})(CscApi || (CscApi = {}));
var CscApi;
(function (CscApi) {
    var bigNumber = Math.pow(10, 15);
    var Rect = (function () {
        function Rect(x, y, width, height) {
            this.x1 = x;
            this.y1 = y;
            this.x2 = x + width;
            this.y2 = y + height;
        }
        Rect.prototype.getIntersection = function (line) {
            var p1 = new CscApi.Point(line.getX1(), line.getY1());
            var p2 = new CscApi.Point(line.getX2(), line.getY2());
            var containsP1 = this._contains(p1);
            var containsP2 = this._contains(p2);
            if (containsP1 && containsP2) {
                return line;
            }
            else if (containsP1 || containsP2) {
                var borders = this._getBorders();
                for (var i in borders) {
                    var pi = line.getSegmentIntersection(borders[i]);
                    if (pi) {
                        return containsP1 ? new CscApi.Line(p1.getX(), p1.getY(), p2.getX(), p2.getY()) : new CscApi.Line(p2.getX(), p2.getY(), pi.getX(), pi.getY());
                    }
                }
            }
            else {
                var borders = this._getBorders();
                var p = [];
                for (var i in borders) {
                    var pi = line.getSegmentIntersection(borders[i]);
                    if (pi) {
                        p.push(pi);
                    }
                }
                if (p.length == 2) {
                    var p0 = p[0];
                    var p1 = p[1];
                    return new CscApi.Line(p0.getX(), p0.getY(), p1.getX(), p1.getY());
                }
                else if (p.length > 2) {
                    var p0 = p[0];
                    var p1 = p[1];
                    var p2 = p[2];
                    var d1 = p0.getDistance(p1);
                    var d2 = p0.getDistance(p2);
                    return p0.getDistance(p1) > p0.getDistance(p2) ?
                        new CscApi.Line(p0.getX(), p0.getY(), p1.getX(), p1.getY())
                        : new CscApi.Line(p0.getX(), p0.getY(), p2.getX(), p2.getY());
                }
            }
            return null;
        };
        ;
        Rect.prototype.getPerpendicularLine = function (line, p) {
            var slope = line.getY2() != line.getY1() ? -1 / ((line.getY2() - line.getY1()) / (line.getX2() - line.getX1())) : Infinity;
            return this.getSegment(p, slope);
        };
        ;
        Rect.prototype.getParallelLine = function (line, p) {
            var slope = line.getY2() != line.getY1() ? (line.getY2() - line.getY1()) / (line.getX2() - line.getX1()) : 0;
            return this.getSegment(p, slope);
        };
        ;
        Rect.prototype.getSegment = function (p, slope) {
            if (slope == 0) {
                return p.getY() >= this.y1 && p.getY() <= this.y2 ? new CscApi.Line(this.x1, p.getY(), this.x2, p.getY()) : null;
            }
            else if (isNaN(slope) || slope == Infinity || slope == -Infinity) {
                return p.getX() >= this.x1 && p.getX() <= this.x2 ? new CscApi.Line(p.getX(), this.y1, p.getX(), this.y2) : null;
            }
            else {
                var y1 = p.getY() - slope * (p.getX() - this.x1);
                var y2 = slope * (this.x2 - p.getX()) + p.getY();
                var line = new CscApi.Line(this.x1, y1, this.x2, y2);
                var borders = this._getBorders();
                var pa = new CscApi.Point(this.x1 - 1, this.y1 - 1);
                var pb = new CscApi.Point(this.x2 + 1, this.y2 + 1);
                var rect = new Rect(pa.getX(), pa.getY(), pb.getX() - pa.getX(), pb.getY() - pa.getY());
                var intersectPoints = [];
                for (var i in borders) {
                    var pi = line.getLineIntersection(borders[i]);
                    if (rect._contains(pi)) {
                        intersectPoints.push(pi);
                    }
                }
                if (intersectPoints.length == 2) {
                    return new CscApi.Line(intersectPoints[0].getX(), intersectPoints[0].getY(), intersectPoints[1].getX(), intersectPoints[1].getY());
                }
                else if (intersectPoints.length > 2) {
                    var maxD = -1;
                    var p1 = intersectPoints[0];
                    var p2 = null;
                    for (var n = 1; n < intersectPoints.length; ++n) {
                        var d = p1.getDistance(intersectPoints[n]);
                        if (d > maxD) {
                            maxD = d;
                            p2 = intersectPoints[n];
                        }
                    }
                    return new CscApi.Line(p1.getX(), p1.getY(), p2.getX(), p2.getY());
                }
                else {
                    return null;
                }
            }
        };
        ;
        Rect.prototype._getBorders = function () {
            var rv = [];
            var plt = new CscApi.Point(this.x1, this.y1);
            var prt = new CscApi.Point(this.x2, this.y1);
            var plb = new CscApi.Point(this.x1, this.y2);
            var prb = new CscApi.Point(this.x2, this.y2);
            rv.push(new CscApi.Line(plt.getX(), plt.getY(), prt.getX(), prt.getY()));
            rv.push(new CscApi.Line(plb.getX(), plb.getY(), prb.getX(), prb.getY()));
            rv.push(new CscApi.Line(plt.getX(), plt.getY(), plb.getX(), plb.getY()));
            rv.push(new CscApi.Line(prt.getX(), prt.getY(), prb.getX(), prb.getY()));
            return rv;
        };
        ;
        Rect.prototype._contains = function (point) {
            return point.getX() >= this.x1 && point.getX() <= this.x2 && point.getY() >= this.y1 && point.getY() <= this.y2;
        };
        ;
        return Rect;
    })();
    CscApi.Rect = Rect;
})(CscApi || (CscApi = {}));
/// <reference path="../../../cscApi/candlestickChartApi.ts" />
/// <reference path="../../../cscApi/util/rect.ts" />
var CscImpl;
(function (CscImpl) {
    ;
    var BIG_NUMBER = 10000.0;
    var RECT_BOUNDLESS = new CscApi.Rect(-BIG_NUMBER, -BIG_NUMBER, BIG_NUMBER + BIG_NUMBER, BIG_NUMBER + BIG_NUMBER);
    var Drawer = (function () {
        function Drawer(chart, handleId, drawerType, maxStep) {
            this.chart = chart;
            this.handleId = handleId;
            this.drawerType = drawerType;
            this.maxStep = maxStep;
            this.drawnStepList = [];
            this.current = {
                time: null,
                index: null,
                value: null,
            };
            this.currentXInArea = -Infinity;
            this.currentYInArea = -Infinity;
            this.styleHintFontSize = 16;
            this.styleHintFontName = 'Arial';
            this.styleHintTextColorRgba = [255, 225, 140, 255];
            var defaultConfig = CscApi.defaultDrawerConfigs[drawerType];
            this.setConfig(defaultConfig);
        }
        Drawer.prototype.refCandlestickChart = function () {
            return this.chart.getArea().getCandlestickChart();
        };
        Drawer.prototype.refRenderer = function () {
            return this.chart.getArea().getCandlestickChart().getRenderer();
        };
        Drawer.prototype.refArea = function () {
            return this.chart.getArea();
        };
        Drawer.prototype.getHandleId = function () {
            return this.handleId;
        };
        Drawer.prototype.getType = function () {
            return this.drawerType;
        };
        Drawer.prototype.getChart = function () {
            return this.chart;
        };
        Drawer.prototype.getConfig = function () {
            return this.config;
        };
        Drawer.prototype.setConfig = function (config) {
            console.error('unexpected non-override invocation.');
            return false;
        };
        Drawer.prototype.cloneConfig = function (config) {
            try {
                config = JSON.parse(JSON.stringify(config));
            }
            catch (err) {
                config = null;
                console.error('invalid config.');
            }
            return config;
        };
        Drawer.prototype.getStep = function () {
            return this.drawnStepList.length;
        };
        Drawer.prototype.getDrawnStepList = function () {
            var result = [];
            var drawnStepList = this.drawnStepList;
            var numberOfDrawnSteps = drawnStepList.length;
            for (var i = 0; i < numberOfDrawnSteps; ++i) {
                var step = drawnStepList[i];
                result.push({
                    time: step.time,
                    index: step.index,
                    value: step.value,
                });
            }
            return result;
        };
        Drawer.prototype.isCompleted = function () {
            return this.drawnStepList.length == this.maxStep;
        };
        Drawer.prototype.getHintTextColorRgba = function () {
            return this.styleHintTextColorRgba;
        };
        Drawer.prototype.setHintTextColorRgba = function (colorRgba) {
            this.styleHintTextColorRgba = colorRgba;
        };
        Drawer.prototype.getCurrentState = function () {
            var current = this.current;
            return {
                time: current.time,
                index: current.index,
                value: current.value,
            };
        };
        Drawer.prototype.setCurrentState = function (state, resetIndexByTime) {
            var current = this.current = {
                time: state.time,
                index: state.index,
                value: state.value,
            };
            if (resetIndexByTime) {
                var context = this.refCandlestickChart().getContext();
                var newTickIndex = context.getLowerBoundTickIndexByTime(current.time);
                if (newTickIndex == null) {
                    return false;
                }
                current.index = newTickIndex;
            }
            return true;
        };
        Drawer.prototype.move = function (xInArea, yInArea) {
            var area = this.chart.getArea();
            var currentStep = this.current;
            var tickIndex = this.refCandlestickChart().getTickIndexFromXInArea(area.getHandleId(), xInArea);
            var context = this.refCandlestickChart().getContext();
            var orderedTickList = context.getOrderedTickList();
            var tickData = orderedTickList[tickIndex];
            if (tickData == null) {
                return false;
            }
            this.currentXInArea = xInArea;
            this.currentYInArea = yInArea;
            currentStep.index = tickIndex;
            currentStep.value = area.getChartValueFromYInArea(this.chart.getHandleId(), yInArea);
            currentStep.time = tickData.getDatetime().getTime();
            return true;
        };
        Drawer.prototype.revert = function () {
            this.drawnStepList.pop();
        };
        Drawer.prototype.commit = function () {
            if (this.drawnStepList.length >= this.maxStep) {
                return;
            }
            var current = this.current;
            var context = this.refCandlestickChart().getContext();
            var orderedTickList = context.getOrderedTickList();
            var tickIndex = current.index;
            if (tickIndex != null) {
                if (tickIndex >= orderedTickList.length) {
                    tickIndex = orderedTickList.length - 1;
                }
                if (tickIndex < 0) {
                    tickIndex = 0;
                }
                var tickData = orderedTickList[tickIndex];
                current.time = tickData.getDatetime().getTime();
            }
            this.drawnStepList.push(current);
            var newState = {
                time: current.time,
                index: current.index,
                value: current.value,
            };
            this.current = newState;
        };
        Drawer.prototype.render = function () {
            this.drawHint();
        };
        Drawer.prototype.onTickUpdate = function (modifiedLowerestIndex) {
            var area = this.chart.getArea();
            var drawnStepList = this.drawnStepList;
            var numberOfSteps = drawnStepList.length;
            var context = this.refCandlestickChart().getContext();
            for (var i = 0; i < numberOfSteps; ++i) {
                var drawnStep = drawnStepList[i];
                if (drawnStep.index < modifiedLowerestIndex) {
                    continue;
                }
                var newTickIndex = context.getLowerBoundTickIndexByTime(drawnStep.time);
                if (newTickIndex != null) {
                    drawnStep.index = newTickIndex;
                }
            }
        };
        Drawer.prototype.drawHint = function () {
            if (this.isCompleted()) {
                return;
            }
            var candlestickChart = this.refCandlestickChart();
            var lang = candlestickChart.getLang();
            var currentStep = this.drawnStepList.length;
            var hint = lang.getDrawerStepHint(this.drawerType, currentStep);
            if (hint != null) {
                var renderer = this.refRenderer();
                var fontSize = this.styleHintFontSize;
                renderer.setTextFontSize(fontSize);
                renderer.setTextFontName(this.styleHintFontName);
                renderer.setTextFontBold(false);
                renderer.setTextAlignToLeft();
                renderer.setTextBaseLineToTop();
                renderer.setFillColorRgba(this.styleHintTextColorRgba);
                var textX = this.currentXInArea + fontSize;
                var textY = this.currentYInArea + fontSize;
                var textHeight = fontSize;
                var textWidth = renderer.getTextWidth(hint);
                renderer.fillText(hint, textX, textY);
            }
        };
        Drawer.prototype.drawLine = function (line, dashLength) {
            if (dashLength === void 0) { dashLength = 0; }
            var renderer = this.refRenderer();
            if (dashLength > 0) {
                renderer.strokeDashedLine(dashLength, line.getX1(), line.getY1(), line.getX2(), line.getY2());
            }
            else {
                renderer.strokeLine(line.getX1(), line.getY1(), line.getX2(), line.getY2());
            }
        };
        Drawer.prototype.drawLineFromEndPoints = function (x1, y1, x2, y2, dashLength) {
            if (dashLength === void 0) { dashLength = 0; }
            var renderer = this.refRenderer();
            if (dashLength > 0) {
                renderer.strokeDashedLine(dashLength, x1, y1, x2, y2);
            }
            else {
                renderer.strokeLine(x1, y1, x2, y2);
            }
        };
        Drawer.prototype.createExtLine = function (line) {
            var x1 = line.getX1();
            var y1 = line.getY1();
            var x2 = line.getX2();
            var y2 = line.getY2();
            return this.createExtLineFromEndPoints(x1, y1, x2, y2);
        };
        Drawer.prototype.createExtLineFromEndPoints = function (x1, y1, x2, y2) {
            var slope = (y2 - y1) / (x2 - x1);
            return this.createExtLineWithSlope(x2, y2, slope);
        };
        Drawer.prototype.createExtLineWithSlope = function (x, y, slope) {
            var rv = [];
            var p = new CscApi.Point(x, y);
            var chart = this.chart;
            var rectAreaTicks = new CscApi.Rect(0, 0, chart.getWidth(), chart.getHeight());
            return {
                lineForBoundRect: rectAreaTicks.getSegment(p, slope),
                lineForBoundlessRect: RECT_BOUNDLESS.getSegment(p, slope),
            };
        };
        Drawer.prototype.createPerpendicularLine = function (line, x, y) {
            var p = new CscApi.Point(x, y);
            var chart = this.chart;
            var rectAreaTicks = new CscApi.Rect(0, 0, chart.getWidth(), chart.getHeight());
            return {
                lineForBoundRect: rectAreaTicks.getPerpendicularLine(line, p),
                lineForBoundlessRect: RECT_BOUNDLESS.getPerpendicularLine(line, p),
            };
        };
        Drawer.prototype.createParallelLine = function (line, x, y) {
            var p = new CscApi.Point(x, y);
            var chart = this.chart;
            var rectAreaTicks = new CscApi.Rect(0, 0, chart.getWidth(), chart.getHeight());
            return {
                lineForBoundRect: rectAreaTicks.getParallelLine(line, p),
                lineForBoundlessRect: RECT_BOUNDLESS.getParallelLine(line, p),
            };
        };
        return Drawer;
    })();
    CscImpl.Drawer = Drawer;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
var CscImpl;
(function (CscImpl) {
    var DrawerOfLine = (function (_super) {
        __extends(DrawerOfLine, _super);
        function DrawerOfLine(chart, handleId) {
            var maxStep = 2;
            _super.call(this, chart, handleId, CscApi.DrawerType.LINE, maxStep);
        }
        DrawerOfLine.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configLineWidth = config.params['lineWidth'];
            var configLineDashedlength = config.params['lineDashedLength'];
            var configLineColorRgba = config.params['lineColorRgba'];
            this.styleLine1Width = configLineWidth.value;
            this.styleLine1DashedLength = configLineDashedlength.value;
            this.styleLine1ColorRgba = configLineColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfLine.prototype.getStyleLine1Width = function () {
            return this.styleLine1Width;
        };
        DrawerOfLine.prototype.setStyleLine1Width = function (dashedLength) {
            this.styleLine1Width = dashedLength;
        };
        DrawerOfLine.prototype.getStyleLine1DashedLength = function () {
            return this.styleLine1DashedLength;
        };
        DrawerOfLine.prototype.setStyleLine1DashedLength = function (dashedLength) {
            this.styleLine1DashedLength = dashedLength;
        };
        DrawerOfLine.prototype.getStyleLine1ColorRgba = function () {
            return this.styleLine1ColorRgba;
        };
        DrawerOfLine.prototype.setStyleLine1ColorRgba = function (colorRgba) {
            this.styleLine1ColorRgba = colorRgba;
        };
        DrawerOfLine.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var line1;
            var slope;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                var x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                var y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                var x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                var y2 = area.getChartYCoordFromValue(chartHandleId, current.value);
                line1 = this.createExtLineFromEndPoints(x1, y1, x2, y2).lineForBoundRect;
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                var x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                var y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                var x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep1.index);
                var y2 = area.getChartYCoordFromValue(chartHandleId, drawnStep1.value);
                slope = (y2 - y1) / (x2 - x1);
                line1 = this.createExtLineWithSlope(x2, y2, slope).lineForBoundRect;
            }
            if (line1 != null) {
                renderer.setLineWidth(this.styleLine1Width);
                renderer.setStrokeColorRgba(this.styleLine1ColorRgba);
                this.drawLine(line1, this.styleLine1DashedLength);
            }
        };
        return DrawerOfLine;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfLine = DrawerOfLine;
})(CscImpl || (CscImpl = {}));
/// <reference path="../../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var Chart = (function () {
        function Chart(chartType, area, handleId, width, height, decimalDigits, caption) {
            this.area = area;
            this.handleId = handleId;
            this.chartType = chartType;
            this.width = width;
            this.height = height;
            this.decimalDigits = decimalDigits;
            this.caption = caption;
            this.drawers = {};
            this.snGeneratorOfDrawerHandleId = new CscApi.SnGenerator();
            this.styleValueScaleFontSize = 12;
            this.styleValueScaleFontName = 'Arial';
            this.styleValueScaleFontBold = false;
            this.styleValueScaleFontColorRgba = [128, 128, 128];
            this.styleValueScaleSpanMargin = 36;
            this.argIsDirty = true;
            var defaultConfig = CscApi.defaultChartConfigs[chartType];
            if (defaultConfig != null) {
                this.setConfig(defaultConfig);
            }
            else {
                console.error('嚴重錯誤，圖表(' + chartType + ')無預設設置。');
            }
        }
        Chart.prototype.getArea = function () {
            return this.area;
        };
        Chart.prototype.getHandleId = function () {
            return this.handleId;
        };
        Chart.prototype.getType = function () {
            return this.chartType;
        };
        Chart.prototype.getConfig = function () {
            return this.config;
        };
        Chart.prototype.setConfig = function (config) {
            console.error('unexpected non-override invocation.');
            return false;
        };
        Chart.prototype.cloneConfig = function (config) {
            try {
                config = JSON.parse(JSON.stringify(config));
            }
            catch (err) {
                config = null;
                console.error('invalid config.');
            }
            return config;
        };
        Chart.prototype.getArgValueByName = function (paramName) {
            var config = this.getConfig();
            var paramConfig = config.params[paramName];
            if (paramConfig == null) {
                return null;
            }
            return paramConfig.value;
        };
        Chart.prototype.setArgValueByName = function (paramName, value) {
            var config = this.getConfig();
            var paramConfig = config.params[paramName];
            if (paramConfig == null) {
                return false;
            }
            paramConfig.value = value;
            this.setConfig(config);
            return true;
        };
        Chart.prototype.isArgDirty = function () {
            return this.argIsDirty;
        };
        Chart.prototype.setArgDirty = function (dirty) {
            this.argIsDirty = dirty;
        };
        Chart.prototype.getCaption = function () {
            return this.caption;
        };
        Chart.prototype.setCaption = function (caption) {
            this.caption = caption;
        };
        Chart.prototype.reconcileStyleFromChart = function (chart) {
            this.setStyleValueScaleFontSize(chart.getStyleValueScaleFontSize());
            this.setStyleValueScaleFontName(chart.getStyleValueScaleFontName());
            this.setStyleValueScaleFontBold(chart.getStyleValueScaleFontBold());
            this.setStyleValueScaleFontColorRgba(chart.getStyleValueScaleFontColorRgba());
            this.setStyleYScalesSpanMargin(chart.getStyleValueScaleSpanMargin());
        };
        Chart.prototype.refCandlestickChart = function () {
            return this.getArea().getCandlestickChart();
        };
        Chart.prototype.refContext = function () {
            return this.refCandlestickChart().getContext();
        };
        Chart.prototype.refRenderer = function () {
            return this.refCandlestickChart().getRenderer();
        };
        Chart.prototype.refTimeScale = function () {
            return this.refCandlestickChart().getTimeScale();
        };
        Chart.prototype.isDrawing = function () {
            var drawers = this.drawers;
            for (var handleId in drawers) {
                var drawer = drawers[handleId];
                if (false == drawer.isCompleted()) {
                    return true;
                }
            }
            return false;
        };
        Chart.prototype.setWidth = function (width) {
            this.width = width;
            return true;
        };
        Chart.prototype.getWidth = function () {
            return this.width;
        };
        Chart.prototype.setHeight = function (height) {
            this.height = height;
            return true;
        };
        Chart.prototype.getHeight = function () {
            return this.height;
        };
        Chart.prototype.getDecimalDigits = function () {
            if (this.decimalDigits != null) {
                return this.decimalDigits;
            }
            var candlestickChart = this.refCandlestickChart();
            return candlestickChart.getDecimalDigits();
        };
        Chart.prototype.getValueOfElement = function (index) {
            return null;
        };
        Chart.prototype.addDrawer = function (drawerType) {
            var drawer;
            var handleId = this.snGeneratorOfDrawerHandleId.allocate();
            switch (drawerType) {
                case CscApi.DrawerType.LINE:
                    drawer = new CscImpl.DrawerOfLine(this, handleId);
                    break;
                case CscApi.DrawerType.HORIZONTAL_LINE:
                    drawer = new CscImpl.DrawerOfHorizontalLine(this, handleId);
                    break;
                case CscApi.DrawerType.PRICE_TANGENT:
                    drawer = new CscImpl.DrawerOfPriceTangent(this, handleId);
                    break;
                case CscApi.DrawerType.CHANNEL:
                    drawer = new CscImpl.DrawerOfChannel(this, handleId);
                    break;
                case CscApi.DrawerType.GOLDEN_SECTION:
                    drawer = new CscImpl.DrawerOfGoldenSection(this, handleId);
                    break;
                case CscApi.DrawerType.GOLDEN_BANDS:
                    drawer = new CscImpl.DrawerOfGoldenBands(this, handleId);
                    break;
                case CscApi.DrawerType.GOLDEN_CIRCLE:
                    drawer = new CscImpl.DrawerOfGoldenCircle(this, handleId);
                    break;
                case CscApi.DrawerType.GANN_FAN:
                    drawer = new CscImpl.DrawerOfGannFan(this, handleId);
                    break;
                case CscApi.DrawerType.LINEAR_REGRESSION:
                    drawer = new CscImpl.DrawerOfLinearRegression(this, handleId);
                    break;
                default:
                    this.snGeneratorOfDrawerHandleId.recycle(handleId);
                    console.error('unknown drawer type.');
                    return null;
            }
            this.drawers[handleId] = drawer;
            return handleId;
        };
        Chart.prototype.getDrawer = function (handleId) {
            var drawer = this.drawers[handleId];
            return drawer ? drawer : null;
        };
        Chart.prototype.removeDrawer = function (handleId) {
            if (this.drawers[handleId]) {
                delete this.drawers[handleId];
                this.snGeneratorOfDrawerHandleId.recycle(handleId);
                return true;
            }
            return false;
        };
        Chart.prototype.removeAllDrawers = function () {
            var drawers = this.drawers;
            for (var handleId in drawers) {
                delete this.drawers[handleId];
                this.snGeneratorOfDrawerHandleId.recycle(handleId);
            }
        };
        Chart.prototype.moveDrawers = function (xInArea, yInArea) {
            var drawers = this.drawers;
            for (var handleId in drawers) {
                var drawer = drawers[handleId];
                if (false == drawer.isCompleted()) {
                    drawer.move(xInArea, yInArea);
                }
            }
        };
        Chart.prototype.revertDrawers = function (includeCompletedDrawer) {
            var drawers = this.drawers;
            var overRevertedDrawerList = [];
            for (var handleId in drawers) {
                var drawer = drawers[handleId];
                if (false == includeCompletedDrawer && drawer.isCompleted()) {
                    continue;
                }
                if (drawer.getStep() == 0) {
                    overRevertedDrawerList.push(drawer);
                }
                else {
                    drawer.revert();
                }
            }
            return overRevertedDrawerList;
        };
        Chart.prototype.commitDrawers = function (xInArea, yInArea) {
            var drawers = this.drawers;
            for (var handleId in drawers) {
                var drawer = drawers[handleId];
                drawer.move(xInArea, yInArea);
                drawer.commit();
            }
        };
        Chart.prototype.processMouseUp = function (button, xInArea, yInArea) {
        };
        Chart.prototype.processMouseMove = function (xInArea, yInArea) {
            var drawers = this.drawers;
            for (var handleId in drawers) {
                var drawer = drawers[handleId];
                drawer.move(xInArea, yInArea);
            }
        };
        Chart.prototype.updateElements = function (updateTickFromIndex) {
            this.argIsDirty = false;
            var drawers = this.drawers;
            for (var handleId in drawers) {
                var drawer = drawers[handleId];
                drawer.onTickUpdate(updateTickFromIndex);
            }
        };
        Chart.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            return {
                lowestValue: Number.POSITIVE_INFINITY,
                highestValue: Number.NEGATIVE_INFINITY,
            };
        };
        Chart.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            return null;
        };
        Chart.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            return true;
        };
        Chart.prototype.renderValueInfo = function (focusElementIndex) {
        };
        Chart.prototype.renderDrawers = function () {
            var drawers = this.drawers;
            for (var handleId in drawers) {
                var drawer = drawers[handleId];
                drawer.render();
            }
        };
        Chart.prototype.getHighestValue = function () {
            return Number.MAX_VALUE;
        };
        Chart.prototype.getLowestValue = function () {
            return Number.MIN_VALUE;
        };
        Chart.prototype.generateValueScale = function (pixelsOfGap, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) {
            var candlestickChart = this.refCandlestickChart();
            var height = this.height;
            var tmpPow = Math.pow(10, this.getDecimalDigits());
            var priceGap = Math.ceil(pixelsOfGap / pixelsPerValue * tmpPow) / tmpPow;
            var viewYScale = [];
            if (priceGap > 0) {
                var value = Math.floor(areaHighestValue * tmpPow) / tmpPow;
                var y = Math.floor(valueToYCoordConvertor(value));
                while (y <= height) {
                    if (y > 0) {
                        viewYScale.push({ value: value, yCoord: y });
                    }
                    value -= priceGap;
                    y = Math.floor(valueToYCoordConvertor(value));
                }
            }
            return viewYScale;
        };
        Chart.prototype.generateValueScaleIncludeZero = function (pixelsOfGap, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) {
            var candlestickChart = this.refCandlestickChart();
            var height = this.height;
            var tmpPow = Math.pow(10, this.getDecimalDigits());
            var priceGap = Math.ceil(pixelsOfGap / pixelsPerValue * tmpPow) / tmpPow;
            var viewYScale = [];
            var yZero = Math.floor(valueToYCoordConvertor(0));
            if (yZero >= 0 && yZero < this.height) {
                viewYScale.push({ value: 0, yCoord: yZero });
            }
            if (priceGap > 0) {
                var yLowestValue = Math.floor(valueToYCoordConvertor(areaLowestValue));
                var value = areaLowestValue;
                var y = yLowestValue;
                while (y > yZero) {
                    if (Math.abs(y - yZero) < pixelsOfGap) {
                        break;
                    }
                    if (y > 0 && y < height) {
                        viewYScale.push({ value: value, yCoord: y });
                    }
                    value += priceGap;
                    y = Math.floor(valueToYCoordConvertor(value));
                }
                var yHighestValue = Math.floor(valueToYCoordConvertor(areaHighestValue));
                var value = areaHighestValue;
                var y = yHighestValue;
                while (y < yZero) {
                    if (Math.abs(y - yZero) < pixelsOfGap) {
                        break;
                    }
                    if (y > 0 && y < height) {
                        viewYScale.push({ value: value, yCoord: y });
                    }
                    value -= priceGap;
                    y = Math.floor(valueToYCoordConvertor(value));
                }
            }
            return viewYScale;
        };
        Chart.prototype.getStyleValueScaleFontSize = function () {
            return this.styleValueScaleFontSize;
        };
        Chart.prototype.setStyleValueScaleFontSize = function (fontSize) {
            this.styleValueScaleFontSize = fontSize;
        };
        Chart.prototype.getStyleValueScaleFontName = function () {
            return this.styleValueScaleFontName;
        };
        Chart.prototype.setStyleValueScaleFontName = function (fontName) {
            this.styleValueScaleFontName = fontName;
        };
        Chart.prototype.getStyleValueScaleFontBold = function () {
            return this.styleValueScaleFontBold;
        };
        Chart.prototype.setStyleValueScaleFontBold = function (bold) {
            this.styleValueScaleFontBold = bold;
        };
        Chart.prototype.getStyleValueScaleFontColorRgba = function () {
            return this.styleValueScaleFontColorRgba.slice(0);
        };
        Chart.prototype.setStyleValueScaleFontColorRgba = function (fontColor) {
            this.styleValueScaleFontColorRgba = fontColor.slice(0);
        };
        Chart.prototype.getStyleValueScaleSpanMargin = function () {
            return this.styleValueScaleSpanMargin;
        };
        Chart.prototype.setStyleYScalesSpanMargin = function (spanMargin) {
            this.styleValueScaleSpanMargin = spanMargin;
        };
        Chart.prototype.drawDragon = function (vector2dComponentList, startPointIndex, numberOfPoints) {
            var candlestickChart = this.refCandlestickChart();
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var renderer = this.refRenderer();
            if (viewTickWidth < 1) {
                var stridePoints = Math.floor(1 / viewTickWidth);
                var fixedStartIndex = Math.ceil(startPointIndex / stridePoints) * stridePoints;
                var fixedNumberOfPoints = (startPointIndex - fixedStartIndex) + numberOfPoints;
                if (fixedNumberOfPoints > 1) {
                    renderer.strokeLineStrips(vector2dComponentList, fixedStartIndex, fixedNumberOfPoints);
                }
            }
            else {
                renderer.strokeLineStrips(vector2dComponentList, startPointIndex, numberOfPoints);
            }
        };
        Chart.prototype.drawPoints = function (vector2dComponentList, startPointIndex, numberOfPoints) {
            var renderer = this.refRenderer();
            renderer.strokePoints(vector2dComponentList, startPointIndex, numberOfPoints);
        };
        Chart.prototype.drawValueInfo = function (valueInfoList) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            var style = candlestickChart.getStyle();
            var styleFontSize = style.getChartCaptionInfoFontSize();
            var shortMargin = Math.floor(styleFontSize * 0.618);
            var longMargin = Math.floor(styleFontSize * 1.618);
            var caption = this.caption;
            var captionFontSize = style.getChartCaptionInfoFontSize();
            var captionFontName = style.getChartCaptionInfoFontName();
            var captionTextColorRgba = style.getChartCaptionTextColorRgba();
            var captionValueTextColorRgba = style.getChartCaptionValueTextColorRgba();
            var xOffset = 0;
            renderer.setFillColorRgba(captionTextColorRgba);
            renderer.setTextAlignToLeft();
            renderer.setTextBaseLineToTop();
            renderer.setTextFontSize(captionFontSize);
            renderer.setTextFontName(captionFontName);
            renderer.setTextFontBold(true);
            if (caption != null) {
                renderer.fillText(caption, xOffset, 0);
                xOffset += renderer.getTextWidth(caption);
                xOffset += longMargin;
            }
            if (valueInfoList != null) {
                var numberOfValueInfo = valueInfoList.length;
                for (var i = 0; i < numberOfValueInfo; ++i) {
                    var valueInfo = valueInfoList[i];
                    var itemName = valueInfo.name;
                    var itemValue = valueInfo.value;
                    var itemValueColor = valueInfo.valueColor;
                    renderer.setFillColorRgba(captionTextColorRgba);
                    renderer.fillText(itemName, xOffset, 0);
                    xOffset += renderer.getTextWidth(itemName) + shortMargin;
                    renderer.setFillColorRgba(itemValueColor != null ? itemValueColor : captionValueTextColorRgba);
                    renderer.fillText(itemValue, xOffset, 0);
                    xOffset += renderer.getTextWidth(itemValue) + longMargin;
                }
            }
        };
        return Chart;
    })();
    CscImpl.Chart = Chart;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfMtm = (function (_super) {
        __extends(ChartOfMtm, _super);
        function ChartOfMtm(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.MTM, area, handleId, width, height, DECIMAL_DIGITS, 'MTM');
            this.elementMtmList = null;
            this.elementMtmMaList = null;
            this.elementViewMtmDragon = null;
            this.elementViewMtmMaDragon = null;
        }
        ChartOfMtm.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configMtmPeriod = config.params['mtmPeriod'];
            var configMtmMaPeriod = config.params['mtmMaPeriod'];
            var configMtmLineWidth = config.params['mtmLineWidth'];
            var configMtmLineColorRgba = config.params['mtmLineColorRgba'];
            var configMtmMaLineWidth = config.params['mtmMaLineWidth'];
            var configMtmMaLineColorRgba = config.params['mtmMaLineColorRgba'];
            this.argMtmPeriod = configMtmPeriod.value;
            this.argMtmMaPeriod = configMtmMaPeriod.value;
            this.styleMtmLineWidth = configMtmLineWidth.value;
            this.styleMtmLineColorRgba = configMtmLineColorRgba.value;
            this.styleMtmMaLineWidth = configMtmMaLineWidth.value;
            this.styleMtmMaLineColorRgba = configMtmMaLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMtm.prototype.getArgMtmPeriod = function () {
            return this.argMtmPeriod;
        };
        ChartOfMtm.prototype.setArgMtmPeriod = function (period) {
            this.argMtmPeriod = period;
            this.config.params['mtmPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMtm.prototype.getArgMtmMaPeriod = function () {
            return this.argMtmMaPeriod;
        };
        ChartOfMtm.prototype.setArgMtmMaPeriod = function (period) {
            this.argMtmMaPeriod = period;
            this.config.params['mtmMaPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMtm.prototype.getStyleMtmLineWidth = function () {
            return this.styleMtmLineWidth;
        };
        ChartOfMtm.prototype.setStyleMtmLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleMtmLineWidth = lineWidth;
            this.config.params['mtmLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfMtm.prototype.getStyleMtmLineColorRgba = function () {
            return this.styleMtmLineColorRgba;
        };
        ChartOfMtm.prototype.setStyleMtmLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleMtmLineColorRgba = colorRgba;
            this.config.params['mtmLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfMtm.prototype.getStyleMtmMaLineWidth = function () {
            return this.styleMtmMaLineWidth;
        };
        ChartOfMtm.prototype.setStyleMtmMaLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleMtmMaLineWidth = lineWidth;
            this.config.params['mtmMaLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfMtm.prototype.getStyleMtmMaLineColorRgba = function () {
            return this.styleMtmMaLineColorRgba;
        };
        ChartOfMtm.prototype.setStyleMtmMaLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleMtmMaLineColorRgba = colorRgba;
            this.config.params['mtmMaLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfMtm.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementMtmList.length) {
                return this.elementMtmList[index];
            }
            return null;
        };
        ChartOfMtm.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewMtmDragon == null || this.elementViewMtmDragon.length !== numberOfDragonComponents) {
                this.elementViewMtmDragon = CscApi.Utility.resizeFloat32Array(this.elementViewMtmDragon, numberOfDragonComponents);
            }
            if (this.elementViewMtmMaDragon == null || this.elementViewMtmMaDragon.length !== numberOfDragonComponents) {
                this.elementViewMtmMaDragon = CscApi.Utility.resizeFloat32Array(this.elementViewMtmMaDragon, numberOfDragonComponents);
            }
            if (this.elementMtmList == null || this.elementMtmList.length !== numberOfOrderedTickList) {
                this.elementMtmList = CscApi.Utility.resizeFloat32Array(this.elementMtmList, numberOfOrderedTickList);
            }
            if (this.elementMtmMaList == null || this.elementMtmMaList.length !== numberOfOrderedTickList) {
                this.elementMtmMaList = CscApi.Utility.resizeFloat32Array(this.elementMtmMaList, numberOfOrderedTickList);
            }
            var elementMtmList = this.elementMtmList;
            var elementMtmMaList = this.elementMtmMaList;
            var mtmPeriod = this.argMtmPeriod;
            var mtmMaPeriod = this.argMtmMaPeriod;
            var sumMtmMa = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                if (i >= mtmPeriod) {
                    var bi = i - mtmPeriod;
                    var mtm = tickData.getClose() - orderedTickList[bi].getClose();
                    elementMtmList[i] = mtm;
                    if (i < mtmPeriod + mtmMaPeriod) {
                        elementMtmMaList[i] = NaN;
                    }
                    else {
                        var mtmMa = sumMtmMa / mtmMaPeriod;
                        elementMtmMaList[i] = mtmMa;
                        sumMtmMa += mtm - elementMtmList[bi];
                    }
                }
                else {
                    elementMtmList[i] = elementMtmMaList[i] = NaN;
                }
            }
        };
        ChartOfMtm.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementMtmList = this.elementMtmList;
            var elementMtmMaList = this.elementMtmMaList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var mtm = elementMtmList[vi];
                var mtmMa = elementMtmMaList[vi];
                if (false == isNaN(mtm)) {
                    if (mtm > highestValue)
                        highestValue = mtm;
                    if (mtm < lowestValue)
                        lowestValue = mtm;
                }
                if (false == isNaN(mtmMa)) {
                    if (mtmMa > highestValue)
                        highestValue = mtmMa;
                    if (mtmMa < lowestValue)
                        lowestValue = mtmMa;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfMtm.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementMtmList = this.elementMtmList;
            var elementMtmMaList = this.elementMtmMaList;
            var elementViewMtmDragon = this.elementViewMtmDragon;
            var elementViewMtmMaDragon = this.elementViewMtmMaDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argMtmPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementMtmList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var mtm = elementMtmList[i];
                var mtmMa = elementMtmMaList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewMtmDragon[vi] = viewXCoord;
                elementViewMtmDragon[vyi] = isNaN(mtm) ? NaN : Math.floor(valueToYCoordConvertor(mtm));
                elementViewMtmMaDragon[vi] = viewXCoord;
                elementViewMtmMaDragon[vyi] = isNaN(mtmMa) ? NaN : Math.floor(valueToYCoordConvertor(mtmMa));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfMtm.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argMtmPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementMtmList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argMtmPeriod ? viewStartTickIndex : this.argMtmPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                renderer.setLineWidth(Math.floor(Math.min(this.styleMtmLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleMtmLineColorRgba);
                this.drawDragon(this.elementViewMtmDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleMtmMaLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleMtmMaLineColorRgba);
                this.drawDragon(this.elementViewMtmMaDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfMtm.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var mtm = this.elementMtmList[focusElementIndex];
                var mtmMa = this.elementMtmMaList[focusElementIndex];
                valueInfoList = [
                    { name: 'MTM Period', value: this.argMtmPeriod.toString(), valueColor: null },
                    { name: 'MTM MA Period', value: this.argMtmMaPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(mtm))
                    valueInfoList.push({ name: 'MTM', value: mtm.toFixed(DECIMAL_DIGITS), valueColor: this.styleMtmLineColorRgba });
                if (false === isNaN(mtmMa))
                    valueInfoList.push({ name: 'MTM MA', value: mtmMa.toFixed(DECIMAL_DIGITS), valueColor: this.styleMtmMaLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfMtm;
    })(CscImpl.Chart);
    CscImpl.ChartOfMtm = ChartOfMtm;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfRsiSmooth = (function (_super) {
        __extends(ChartOfRsiSmooth, _super);
        function ChartOfRsiSmooth(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.RSI_SMOOTH, area, handleId, width, height, DECIMAL_DIGITS, 'RSI Smooth');
            this.elementRsiAvgRisingList = null;
            this.elementRsiAvgFallingList = null;
            this.elementRsiSmoothList = null;
            this.elementViewRsiSmoothDragon = null;
        }
        ChartOfRsiSmooth.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configRsiSmoothLineWidth = config.params['rsiSmoothLineWidth'];
            var configRsiSmoothLineColorRgba = config.params['rsiSmoothLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleRsiSmoothLineWidth = configRsiSmoothLineWidth.value;
            this.styleRsiSmoothLineColorRgba = configRsiSmoothLineColorRgba.value;
            this.config = config;
            return true;
        };
        ChartOfRsiSmooth.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfRsiSmooth.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfRsiSmooth.prototype.getStyleRsiSmoothLineWidth = function () {
            return this.styleRsiSmoothLineWidth;
        };
        ChartOfRsiSmooth.prototype.setStyleRsiSmoothLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleRsiSmoothLineWidth = lineWidth;
            this.config.params['rsiSmoothLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfRsiSmooth.prototype.getStyleRsiSmoothLineColorRgba = function () {
            return this.styleRsiSmoothLineColorRgba;
        };
        ChartOfRsiSmooth.prototype.setStyleRsiSmoothLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleRsiSmoothLineColorRgba = colorRgba;
            this.config.params['rsiSmoothLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfRsiSmooth.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementRsiSmoothList.length) {
                return this.elementRsiSmoothList[index];
            }
            return null;
        };
        ChartOfRsiSmooth.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewRsiSmoothDragon == null || this.elementViewRsiSmoothDragon.length !== numberOfDragonComponents) {
                this.elementViewRsiSmoothDragon = CscApi.Utility.resizeFloat32Array(this.elementViewRsiSmoothDragon, numberOfDragonComponents);
            }
            if (this.elementRsiAvgRisingList == null || this.elementRsiAvgRisingList.length !== numberOfOrderedTickList) {
                this.elementRsiAvgRisingList = CscApi.Utility.resizeFloat32Array(this.elementRsiAvgRisingList, numberOfOrderedTickList);
            }
            if (this.elementRsiAvgFallingList == null || this.elementRsiAvgFallingList.length !== numberOfOrderedTickList) {
                this.elementRsiAvgFallingList = CscApi.Utility.resizeFloat32Array(this.elementRsiAvgFallingList, numberOfOrderedTickList);
            }
            if (this.elementRsiSmoothList == null || this.elementRsiSmoothList.length !== numberOfOrderedTickList) {
                this.elementRsiSmoothList = CscApi.Utility.resizeFloat32Array(this.elementRsiSmoothList, numberOfOrderedTickList);
            }
            var elementRsiAvgRisingList = this.elementRsiAvgRisingList;
            var elementRsiAvgFallingList = this.elementRsiAvgFallingList;
            var elementRsiSmoothList = this.elementRsiSmoothList;
            var period = this.argPeriod;
            elementRsiSmoothList[i] = NaN;
            elementRsiAvgRisingList[0] = elementRsiAvgFallingList[0] = 0;
            for (var i = 1; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var diff = tickData.getClose() - tickData.getOpen();
                var todayRising = diff > 0 ? diff : 0;
                var todayFalling = diff < 0 ? -diff : 0;
                var p = i < period ? i + 1 : period;
                var pi = i - 1;
                var avgRising = elementRsiAvgRisingList[i] = elementRsiAvgRisingList[pi] + (todayRising - elementRsiAvgRisingList[pi]) / p;
                var avgFalling = elementRsiAvgFallingList[i] = elementRsiAvgFallingList[pi] + (todayFalling - elementRsiAvgFallingList[pi]) / p;
                elementRsiSmoothList[i] = 100 * avgRising / (avgRising + avgFalling);
            }
        };
        ChartOfRsiSmooth.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementRsiSmoothList = this.elementRsiSmoothList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var rsiSmooth = elementRsiSmoothList[vi];
                if (false == isNaN(rsiSmooth)) {
                    if (rsiSmooth > highestValue)
                        highestValue = rsiSmooth;
                    if (rsiSmooth < lowestValue)
                        lowestValue = rsiSmooth;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfRsiSmooth.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementRsiSmoothList = this.elementRsiSmoothList;
            var elementViewRsiSmoothDragon = this.elementViewRsiSmoothDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementRsiSmoothList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var rsiSmooth = elementRsiSmoothList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewRsiSmoothDragon[vi] = viewXCoord;
                elementViewRsiSmoothDragon[vyi] = isNaN(rsiSmooth) ? NaN : Math.floor(valueToYCoordConvertor(rsiSmooth));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfRsiSmooth.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementRsiSmoothList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleRsiSmoothLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleRsiSmoothLineColorRgba);
                this.drawDragon(this.elementViewRsiSmoothDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfRsiSmooth.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var rsiSmooth = this.elementRsiSmoothList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(rsiSmooth))
                    valueInfoList.push({ name: 'RSI Smooth', value: rsiSmooth.toFixed(DECIMAL_DIGITS), valueColor: this.styleRsiSmoothLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfRsiSmooth;
    })(CscImpl.Chart);
    CscImpl.ChartOfRsiSmooth = ChartOfRsiSmooth;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var BANDS = [0.236, 0.382, 0.500, 0.618, 0.809];
    var NUMBER_OF_BANDS = BANDS.length;
    var DrawerOfGoldenBands = (function (_super) {
        __extends(DrawerOfGoldenBands, _super);
        function DrawerOfGoldenBands(chart, handleId) {
            var maxStep = 3;
            _super.call(this, chart, handleId, CscApi.DrawerType.GOLDEN_BANDS, maxStep);
        }
        DrawerOfGoldenBands.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configLine1Width = config.params['line1Width'];
            var configLine1Dashedlength = config.params['line1DashedLength'];
            var configLine1ColorRgba = config.params['line1ColorRgba'];
            var configLine2Width = config.params['line2Width'];
            var configLine2Dashedlength = config.params['line2DashedLength'];
            var configLine2ColorRgba = config.params['line2ColorRgba'];
            this.styleLine1Width = configLine1Width.value;
            this.styleLine1DashedLength = configLine1Dashedlength.value;
            this.styleLine1ColorRgba = configLine1ColorRgba.value;
            this.styleLine2Width = configLine2Width.value;
            this.styleLine2DashedLength = configLine2Dashedlength.value;
            this.styleLine2ColorRgba = configLine2ColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfGoldenBands.prototype.getStyleLine1Width = function () {
            return this.styleLine1Width;
        };
        DrawerOfGoldenBands.prototype.setStyleLine1Width = function (lineWidth) {
            this.styleLine1Width = lineWidth;
        };
        DrawerOfGoldenBands.prototype.getStyleLine1DashedLength = function () {
            return this.styleLine1DashedLength;
        };
        DrawerOfGoldenBands.prototype.setStyleLine1DashedLength = function (dashedLength) {
            this.styleLine1DashedLength = dashedLength;
        };
        DrawerOfGoldenBands.prototype.getStyleLine1ColorRgba = function () {
            return this.styleLine1ColorRgba;
        };
        DrawerOfGoldenBands.prototype.setStyleLine1ColorRgba = function (colorRgba) {
            this.styleLine1ColorRgba = colorRgba;
        };
        DrawerOfGoldenBands.prototype.getStyleLine2Width = function () {
            return this.styleLine2Width;
        };
        DrawerOfGoldenBands.prototype.setStyleLine2Width = function (lineWidth) {
            this.styleLine2Width = lineWidth;
        };
        DrawerOfGoldenBands.prototype.getStyleLine2DashedLength = function () {
            return this.styleLine2DashedLength;
        };
        DrawerOfGoldenBands.prototype.setStyleLine2DashedLength = function (dashedLength) {
            this.styleLine2DashedLength = dashedLength;
        };
        DrawerOfGoldenBands.prototype.getStyleLine2ColorRgba = function () {
            return this.styleLine2ColorRgba;
        };
        DrawerOfGoldenBands.prototype.setStyleLine2ColorRgba = function (colorRgba) {
            this.styleLine2ColorRgba = colorRgba;
        };
        DrawerOfGoldenBands.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var x1;
            var x2;
            var y1;
            var y2;
            var x3;
            var y3;
            var slope;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, current.value);
                slope = (y2 - y1) / (x2 - x1);
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep1.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, drawnStep1.value);
                slope = (y2 - y1) / (x2 - x1);
            }
            if (x1 == x2 && y1 == y2) {
                y2 += 0.1;
            }
            var line1 = new CscApi.Line(x1, y1, x2, y2);
            var viewLine1;
            var viewLine1ext;
            var viewLine2;
            var viewLine2ext;
            var resultOfLine1 = this.createExtLineFromEndPoints(x1, y1, x2, y2);
            viewLine1 = resultOfLine1.lineForBoundRect;
            viewLine1ext = resultOfLine1.lineForBoundlessRect;
            if (currentStep == 2) {
                var drawnStep1 = drawnStepList[1];
                x3 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                y3 = area.getChartYCoordFromValue(chartHandleId, current.value);
            }
            else if (currentStep > 2) {
                var drawnStep2 = drawnStepList[2];
                x3 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep2.index);
                y3 = area.getChartYCoordFromValue(chartHandleId, drawnStep2.value);
            }
            var line2 = line1.getParallelLine(x3, y3);
            var resultOfLine2 = this.createExtLineWithSlope(x3, y3, slope);
            viewLine2 = resultOfLine2.lineForBoundRect;
            viewLine2ext = resultOfLine2.lineForBoundlessRect;
            if (viewLine1ext != null) {
                renderer.setLineWidth(this.styleLine1Width);
                renderer.setStrokeColorRgba(this.styleLine1ColorRgba);
                this.drawLine(viewLine1ext, this.styleLine1DashedLength);
            }
            if (viewLine2ext != null) {
                renderer.setLineWidth(this.styleLine2Width);
                renderer.setStrokeColorRgba(this.styleLine2ColorRgba);
                this.drawLine(viewLine2ext, this.styleLine2DashedLength);
                var virtualAxisLine = line1.getPerpendicular(x3, y3);
                var p1 = line1.getLineIntersection(virtualAxisLine);
                var p2 = line2.getLineIntersection(virtualAxisLine);
                if (p1 && p2) {
                    for (var i = 0; i < NUMBER_OF_BANDS; ++i) {
                        var rate = BANDS[i];
                        var divisionPointX = p1.getX() + (p2.getX() - p1.getX()) * rate;
                        var divisionPointY = p1.getY() + (p2.getY() - p1.getY()) * rate;
                        var resultOfDivisionLine = this.createPerpendicularLine(virtualAxisLine, divisionPointX, divisionPointY);
                        var viewDivisionLine = resultOfDivisionLine.lineForBoundRect;
                        if (viewDivisionLine) {
                            this.drawLine(viewDivisionLine, this.styleLine2DashedLength);
                        }
                        this.drawLineFromEndPoints(p1.getX(), p1.getY(), p2.getX(), p2.getY(), this.styleLine2DashedLength);
                    }
                }
            }
        };
        return DrawerOfGoldenBands;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfGoldenBands = DrawerOfGoldenBands;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfAo = (function (_super) {
        __extends(ChartOfAo, _super);
        function ChartOfAo(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.AO, area, handleId, width, height, DECIMAL_DIGITS, 'AO');
            this.elementViewAoPole = null;
        }
        ChartOfAo.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configShortPeriod = config.params['shortPeriod'];
            var configLongPeriod = config.params['longPeriod'];
            var configPositiveColorRgba = config.params['positiveColorRgba'];
            var configNegativeColorRgba = config.params['negativeColorRgba'];
            this.argShortPeriod = configShortPeriod.value;
            this.argLongPeriod = configLongPeriod.value;
            this.stylePositiveColorRgba = configPositiveColorRgba.value;
            this.styleNegativeColorRgba = configNegativeColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfAo.prototype.getArgShortPeriod = function () {
            return this.argShortPeriod;
        };
        ChartOfAo.prototype.setArgShortPeriod = function (period) {
            this.argShortPeriod = period;
            this.config.params['shortPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfAo.prototype.getArgLongPeriod = function () {
            return this.argLongPeriod;
        };
        ChartOfAo.prototype.setArgLongPeriod = function (period) {
            this.argLongPeriod = period;
            this.config.params['longPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfAo.prototype.getStyleAoPositiveColorRgba = function () {
            return this.stylePositiveColorRgba;
        };
        ChartOfAo.prototype.setStyleAoPositiveColorRgba = function (colorRgba) {
            this.stylePositiveColorRgba = colorRgba;
            this.config.params['positiveColorRgba'].value = colorRgba;
        };
        ChartOfAo.prototype.getStyleAoNegativeColorRgba = function () {
            return this.styleNegativeColorRgba;
        };
        ChartOfAo.prototype.setStyleAoNegativeColorRgba = function (colorRgba) {
            this.styleNegativeColorRgba = colorRgba;
            this.config.params['negativeColorRgba'].value = colorRgba;
        };
        ChartOfAo.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementAoList.length) {
                return this.elementAoList[index];
            }
            return null;
        };
        ChartOfAo.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewAoPole == null || this.elementViewAoPole.length !== numberOfOrderedTickList) {
                this.elementViewAoPole = CscApi.Utility.resizeFloat32Array(this.elementViewAoPole, numberOfOrderedTickList);
            }
            if (this.elementMidList == null || this.elementMidList.length !== numberOfOrderedTickList) {
                this.elementMidList = CscApi.Utility.resizeFloat32Array(this.elementMidList, numberOfOrderedTickList);
            }
            if (this.elementAoList == null || this.elementAoList.length !== numberOfOrderedTickList) {
                this.elementAoList = CscApi.Utility.resizeFloat32Array(this.elementAoList, numberOfOrderedTickList);
            }
            var elementMidList = this.elementMidList;
            var elementAoList = this.elementAoList;
            var shortPeriod = this.argShortPeriod;
            var longPeriod = this.argLongPeriod;
            var sumShort = 0;
            var sumLong = 0;
            var sumDiff = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var mid = elementMidList[i] = (tickData.getHigh() + tickData.getLow()) * 0.5;
                elementAoList[i] = NaN;
                sumShort += mid;
                sumLong += mid;
                if (i >= shortPeriod) {
                    sumShort -= elementMidList[i - shortPeriod];
                    if (i >= longPeriod) {
                        sumLong -= elementMidList[i - longPeriod];
                        elementAoList[i] = sumShort / shortPeriod - sumLong / longPeriod;
                    }
                }
            }
        };
        ChartOfAo.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementAoList = this.elementAoList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var ao = elementAoList[vi];
                if (false == isNaN(ao)) {
                    if (ao > highestValue)
                        highestValue = ao;
                    if (ao < lowestValue)
                        lowestValue = ao;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfAo.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementAoList = this.elementAoList;
            var elementViewAo = this.elementViewAoPole;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var viewZeroValueYCoord = this.viewZeroValueYCoord = Math.floor(valueToYCoordConvertor(0));
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var ao = elementAoList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewAo[i] = Math.floor(valueToYCoordConvertor(ao)) - viewZeroValueYCoord;
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfAo.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            renderer.translate(-viewStartXCoord, 0);
            var elementViewAoPole = this.elementViewAoPole;
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var poleWidth = Math.floor(viewTickWidth * 0.8);
            if (poleWidth < 1) {
                poleWidth = 1;
            }
            var poleHalfWidth = Math.floor(poleWidth * 0.5);
            if (poleHalfWidth < 0) {
                poleHalfWidth = 0;
            }
            var timeScale = candlestickChart.getTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var elementAoList = this.elementAoList;
            var styleAoPositiveColorRgba = this.stylePositiveColorRgba;
            var styleAoNegativeColorRgba = this.styleNegativeColorRgba;
            var viewZeroValueYCoord = this.viewZeroValueYCoord;
            renderer.translate(-poleHalfWidth, 0);
            renderer.setFillColorRgba(styleAoPositiveColorRgba);
            var prevIsIncrease = true;
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var ao = elementAoList[i];
                var poleHeight = elementViewAoPole[i];
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var isIncrease;
                if (i > 0) {
                    var prevAo = elementAoList[i - 1];
                    isIncrease = ao >= prevAo;
                }
                else {
                    isIncrease = true;
                }
                if (isIncrease != prevIsIncrease) {
                    prevIsIncrease = isIncrease;
                    renderer.setFillColorRgba(isIncrease ? styleAoPositiveColorRgba : styleAoNegativeColorRgba);
                }
                renderer.fillRect(viewXCoord, viewZeroValueYCoord, poleWidth, poleHeight);
            }
            renderer.translate(poleHalfWidth, 0);
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfAo.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var ao = this.elementAoList[focusElementIndex];
                valueInfoList = [
                    { name: 'Short', value: this.argShortPeriod.toString(), valueColor: null },
                    { name: 'Long', value: this.argLongPeriod.toString(), valueColor: null }
                ];
                if (false === isNaN(ao))
                    valueInfoList.push({ name: 'AO', value: ao.toFixed(DECIMAL_DIGITS), valueColor: ao >= 0 ? this.stylePositiveColorRgba : this.styleNegativeColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfAo;
    })(CscImpl.Chart);
    CscImpl.ChartOfAo = ChartOfAo;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var Style = (function () {
        function Style() {
            var defaultFontName = 'Arial';
            var defaultGridLuminance = 32;
            this.backgroundColorRgba = [20, 20, 20, 255];
            this.timeScaleLabelFontSize = 16;
            this.timeScaleFontSize = {};
            this.timeScaleFontName = {};
            this.timeScaleFontBold = {};
            this.timeScaleTextColorRgba = {};
            this.timeScaleGridLineWidth = {};
            this.timeScaleGridLineColorRgba = {};
            this.vauleScaleWidth = 80;
            this.valueScaleGridLineColorRgba = [defaultGridLuminance, defaultGridLuminance, defaultGridLuminance, 255];
            this.valueScaleLabelBackgroundColorRgba = [40, 36, 48, 255];
            this.valueScaleLabelFontSize = 16;
            this.valueScaleLabelFontName = defaultFontName;
            this.valueScaleLabelFontBold = false;
            this.valueScaleLabelTextColorRgba = [255, 255, 255, 255];
            this.focusLineWidth = 1;
            this.focusLineColorRgba = [192, 220, 255, 140];
            this.focusLineVisibleWhenDrawing = true;
            this.areaBorderColorRgba = [64, 64, 64, 255];
            this.areaBorderLineWidth = 1;
            this.chartCaptionInfoFontSize = 14;
            this.chartCaptionInfoFontName = defaultFontName;
            this.chartCaptionTextColorRgba = [255, 255, 255, 255];
            this.chartCaptionValueTextColorRgba = [128, 192, 255, 255];
            var defaultTimeScaleFontName = defaultFontName;
            var spanTypeList = [
                CscApi.SpanTypeEnum.MINUTE,
                CscApi.SpanTypeEnum.HOUR,
                CscApi.SpanTypeEnum.DAY,
                CscApi.SpanTypeEnum.MONTH,
                CscApi.SpanTypeEnum.YEAR
            ];
            for (var i = 0; i < spanTypeList.length; ++i) {
                var spanType = spanTypeList[i];
                var textLuminance = Math.min(255, 140 + i * 20);
                var gridLuminance = defaultGridLuminance + i * 16;
                this.timeScaleFontSize[spanType] = 10 + i;
                this.timeScaleFontName[spanType] = defaultTimeScaleFontName;
                this.timeScaleFontBold[spanType] = false;
                this.timeScaleTextColorRgba[spanType] = [textLuminance, textLuminance, textLuminance, 255];
                this.timeScaleGridLineWidth[spanType] = 1;
                this.timeScaleGridLineColorRgba[spanType] = [gridLuminance, gridLuminance, gridLuminance, 255];
            }
        }
        Style.prototype.getBackgroundColorRgba = function () {
            return this.backgroundColorRgba;
        };
        Style.prototype.setBackgroundColorRgba = function (rgba) {
            this.backgroundColorRgba.length = 0;
            Array.prototype.push.apply(this.backgroundColorRgba, rgba);
        };
        Style.prototype.getTimeScaleLabelFontSize = function () {
            return this.timeScaleLabelFontSize;
        };
        Style.prototype.setTimeScaleLabelFontSize = function (fontSize) {
            this.timeScaleLabelFontSize = Math.floor(fontSize);
        };
        Style.prototype.getTimeScaleFontSize = function (spanType) {
            return this.timeScaleFontSize[spanType];
        };
        Style.prototype.setTimeScaleFontSize = function (spanType, fontSize) {
            this.timeScaleFontSize[spanType] = Math.floor(fontSize);
        };
        Style.prototype.getTimeScaleFontName = function (spanType) {
            return this.timeScaleFontName[spanType];
        };
        Style.prototype.setTimeScaleFontName = function (spanType, fontName) {
            this.timeScaleFontName[spanType] = fontName;
        };
        Style.prototype.getTimeScaleFontBold = function (spanType) {
            return this.timeScaleFontBold[spanType];
        };
        Style.prototype.setTimeScaleFontBold = function (spanType, bold) {
            this.timeScaleFontBold[spanType] = bold;
        };
        Style.prototype.getTimeScaleTextColorRgba = function (spanType) {
            return this.timeScaleTextColorRgba[spanType];
        };
        Style.prototype.setTimeScaleTextColorRgba = function (spanType, colorRgba) {
            this.timeScaleTextColorRgba[spanType] = colorRgba;
        };
        Style.prototype.getTimeScaleGridLineWidth = function (spanType) {
            return this.timeScaleGridLineWidth[spanType];
        };
        Style.prototype.setTimeScaleGridLineWidth = function (spanType, lineWidth) {
            this.timeScaleGridLineWidth[spanType] = lineWidth;
        };
        Style.prototype.getTimeScaleGridLineColorRgba = function (spanType) {
            return this.timeScaleGridLineColorRgba[spanType];
        };
        Style.prototype.setTimeScaleGridLineColorRgba = function (spanType, colorRgba) {
            this.timeScaleGridLineColorRgba[spanType] = colorRgba;
        };
        Style.prototype.getValueScaleWidth = function () {
            return this.vauleScaleWidth;
        };
        Style.prototype.setValueScaleWidth = function (value) {
            this.vauleScaleWidth = value;
        };
        Style.prototype.getValueScaleGridLineColorRgba = function () {
            return this.valueScaleGridLineColorRgba;
        };
        Style.prototype.setValueScaleGridLineColorRgba = function (colorRgba) {
            this.valueScaleGridLineColorRgba = colorRgba;
        };
        Style.prototype.getValueScaleLabelBackgroundColorRgba = function () {
            return this.valueScaleLabelBackgroundColorRgba;
        };
        Style.prototype.setValueScaleLabelBackgroundColorRgba = function (colorRgba) {
            this.valueScaleLabelBackgroundColorRgba = colorRgba;
        };
        Style.prototype.getValueScaleLabelFontSize = function () {
            return this.valueScaleLabelFontSize;
        };
        Style.prototype.setValueScaleLabelFontSize = function (fontSize) {
            this.valueScaleLabelFontSize = fontSize;
        };
        Style.prototype.getValueScaleLabelFontName = function () {
            return this.valueScaleLabelFontName;
        };
        Style.prototype.setValueScaleLabelFontName = function (fontName) {
            this.valueScaleLabelFontName = fontName;
        };
        Style.prototype.getValueScaleLabelFontBold = function () {
            return this.valueScaleLabelFontBold;
        };
        Style.prototype.setValueScaleLabelFontBold = function (bold) {
            this.valueScaleLabelFontBold = bold;
        };
        Style.prototype.getValueScaleLabelTextColorRgba = function () {
            return this.valueScaleLabelTextColorRgba;
        };
        Style.prototype.setValueScaleLabelTextColorRgba = function (colorRgba) {
            this.valueScaleLabelTextColorRgba = colorRgba;
        };
        Style.prototype.getFocusLineWidth = function () {
            return this.focusLineWidth;
        };
        Style.prototype.setFocusLineWidth = function (lineWidth) {
            this.focusLineWidth = lineWidth;
        };
        Style.prototype.getFocusLineColorRgba = function () {
            return this.focusLineColorRgba;
        };
        Style.prototype.setFocusLineColorRgba = function (colorRgba) {
            this.focusLineColorRgba = colorRgba;
        };
        Style.prototype.getFocusLineVisibleWhenDrawing = function () {
            return this.focusLineVisibleWhenDrawing;
        };
        Style.prototype.setFocusLineVisibleWhenDrawing = function (visibleWhenDrawing) {
            this.focusLineVisibleWhenDrawing = visibleWhenDrawing;
        };
        Style.prototype.getAreaBorderColorRgba = function () {
            return this.areaBorderColorRgba;
        };
        Style.prototype.setAreaBorderColorRgba = function (colorRgba) {
            this.areaBorderColorRgba = colorRgba;
        };
        Style.prototype.getAreaBorderLineWidth = function () {
            return this.areaBorderLineWidth;
        };
        Style.prototype.setAreaBorderLineWidth = function (lineWidth) {
            this.areaBorderLineWidth = lineWidth;
        };
        Style.prototype.getChartCaptionInfoFontSize = function () {
            return this.chartCaptionInfoFontSize;
        };
        Style.prototype.setChartCaptionInfoFontSize = function (fontSize) {
            this.chartCaptionInfoFontSize = Math.floor(fontSize);
        };
        Style.prototype.getChartCaptionInfoFontName = function () {
            return this.chartCaptionInfoFontName;
        };
        Style.prototype.setChartCaptionInfoFontName = function (fontSize) {
            this.chartCaptionInfoFontName = fontSize;
        };
        Style.prototype.getChartCaptionTextColorRgba = function () {
            return this.chartCaptionTextColorRgba;
        };
        Style.prototype.setChartCaptionTextColorRgba = function (colorRgba) {
            this.chartCaptionTextColorRgba = colorRgba;
        };
        Style.prototype.getChartCaptionValueTextColorRgba = function () {
            return this.chartCaptionValueTextColorRgba;
        };
        Style.prototype.setChartCaptionValueTextColorRgba = function (colorRgba) {
            this.chartCaptionValueTextColorRgba = colorRgba;
        };
        return Style;
    })();
    CscImpl.Style = Style;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
/// <reference path="../cscImpl/style.ts" />
var CscFacade;
(function (CscFacade) {
    var CandlestickChartStyleFacade = (function (_super) {
        __extends(CandlestickChartStyleFacade, _super);
        function CandlestickChartStyleFacade(candlestickChartFacade) {
            _super.call(this);
            this.initialized = false;
            this.getCandlestickChartFacade = function () { return candlestickChartFacade; };
            this.reset();
        }
        CandlestickChartStyleFacade.prototype.reset = function () {
            var defaultFontName = 'Arial';
            this.marginLeft = 10;
            this.marginRight = 0;
            this.marginTop = 10;
            this.marginBottom = 10;
            this.vauleScaleWidth = 100;
            this.heightOfTimeScale = 30;
            this.minHeightRatioOfTiAreas = 0.3;
            this.maxHeightRatioOfTiAreas = 0.65;
            this.paddingHeightOfAreas = 5;
            this.valueScaleFontSize = 12;
            this.valueScaleFontName = defaultFontName;
            this.valueScaleFontBold = false;
            this.valueScaleColorRgba = [255, 255, 255, 255];
            this.processStyleChanged();
            this.initialized = true;
        };
        CandlestickChartStyleFacade.prototype.processStyleChanged = function () {
            if (false == this.initialized) {
                return;
            }
            this.getCandlestickChartFacade().processStyleChanged();
        };
        CandlestickChartStyleFacade.prototype.getMarginLeft = function () { return this.marginLeft; };
        CandlestickChartStyleFacade.prototype.setMarginLeft = function (value) { this.marginLeft = value; this.processStyleChanged(); };
        ;
        CandlestickChartStyleFacade.prototype.getMarginRight = function () { return this.marginRight; };
        CandlestickChartStyleFacade.prototype.setMarginRight = function (value) { this.marginRight = value; this.processStyleChanged(); };
        ;
        CandlestickChartStyleFacade.prototype.getMarginTop = function () { return this.marginTop; };
        CandlestickChartStyleFacade.prototype.setMarginTop = function (value) { this.marginTop = value; this.processStyleChanged(); };
        ;
        CandlestickChartStyleFacade.prototype.getMarginBottom = function () { return this.marginBottom; };
        CandlestickChartStyleFacade.prototype.setMarginBottom = function (value) { this.marginBottom = value; this.processStyleChanged(); };
        ;
        CandlestickChartStyleFacade.prototype.getHeightOfTimeScale = function () { return this.heightOfTimeScale; };
        CandlestickChartStyleFacade.prototype.setHeightOfTimeScale = function (value) { this.heightOfTimeScale = value; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.getMinHeightRatioOfTiAreas = function () { return this.minHeightRatioOfTiAreas; };
        CandlestickChartStyleFacade.prototype.setMinHeightRatioOfTiAreas = function (value) { this.minHeightRatioOfTiAreas = value; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.getMaxHeightRatioOfTiAreas = function () { return this.maxHeightRatioOfTiAreas; };
        CandlestickChartStyleFacade.prototype.setMaxHeightRatioOfTiAreas = function (value) { this.maxHeightRatioOfTiAreas = value; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.getPaddingHeightOfAreas = function () { return this.paddingHeightOfAreas; };
        CandlestickChartStyleFacade.prototype.setPaddingHeightOfAreas = function (value) { this.paddingHeightOfAreas = value; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.getValueScaleFontSize = function () { return this.valueScaleFontSize; };
        CandlestickChartStyleFacade.prototype.setVauleScaleFontSize = function (fontSize) { this.valueScaleFontSize = fontSize; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.getValueScaleFontName = function () { return this.valueScaleFontName; };
        CandlestickChartStyleFacade.prototype.setVauleScaleFontName = function (fontName) { this.valueScaleFontName = fontName; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.getValueScaleFontBold = function () { return this.valueScaleFontBold; };
        CandlestickChartStyleFacade.prototype.setVauleScaleFontBold = function (bold) { this.valueScaleFontBold = bold; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.getValueScaleColorRgba = function () { return this.valueScaleColorRgba; };
        CandlestickChartStyleFacade.prototype.setValueScaleColorRgba = function (colorRgba) { this.valueScaleColorRgba = colorRgba; this.processStyleChanged(); };
        CandlestickChartStyleFacade.prototype.adjustGlobalFontSize = function (minFontSize, maxFontSize, autoAdjustStyles) {
            if (minFontSize == null) {
                throw 'minFontSize is null.';
            }
            else if (maxFontSize == null) {
                throw 'maxFontSize is null.';
            }
            minFontSize = Math.floor(minFontSize);
            maxFontSize = Math.floor(maxFontSize);
            var dynamicRange = maxFontSize - minFontSize;
            this.setTimeScaleLabelFontSize(maxFontSize);
            this.setTimeScaleFontSize(CscApi.SpanTypeEnum.MINUTE, minFontSize + dynamicRange * 1 / 5);
            this.setTimeScaleFontSize(CscApi.SpanTypeEnum.HOUR, minFontSize + dynamicRange * 2 / 5);
            this.setTimeScaleFontSize(CscApi.SpanTypeEnum.DAY, minFontSize + dynamicRange * 3 / 5);
            this.setTimeScaleFontSize(CscApi.SpanTypeEnum.MONTH, minFontSize + dynamicRange * 4 / 5);
            this.setTimeScaleFontSize(CscApi.SpanTypeEnum.YEAR, maxFontSize);
            this.setVauleScaleFontSize(minFontSize);
            this.setChartCaptionInfoFontSize(minFontSize + dynamicRange * 0.5);
            if (autoAdjustStyles) {
                this.setValueScaleWidth(this.getValueScaleFontSize() * 10);
                this.setHeightOfTimeScale(Math.ceil(maxFontSize * 1.4));
            }
            this.processStyleChanged();
        };
        CandlestickChartStyleFacade.prototype.saveToJson = function () {
            return JSON.stringify(this);
        };
        CandlestickChartStyleFacade.prototype.restoreFromObj = function (jsObj) {
            for (var key in jsObj) {
                this[key] = jsObj[key];
            }
            this.processStyleChanged();
        };
        return CandlestickChartStyleFacade;
    })(CscImpl.Style);
    CscFacade.CandlestickChartStyleFacade = CandlestickChartStyleFacade;
})(CscFacade || (CscFacade = {}));
/// <reference path="candlestickChartApi.ts" />
var CscApi;
(function (CscApi) {
    var DrawerType = CscApi.DrawerType;
    var DrawerParameterValueType = CscApi.ConfigParameterValueType;
    CscApi.defaultDrawerConfigs = {};
    CscApi.defaultDrawerConfigs[DrawerType.LINE] = {
        name: 'LINE',
        params: {
            'lineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'lineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'lineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.HORIZONTAL_LINE] = {
        name: 'HORIZONTAL_LINE',
        params: {
            'lineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'lineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'lineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.PRICE_TANGENT] = {
        name: 'PRICE_TANGENT',
        params: {
            'lineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'lineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'lineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.CHANNEL] = {
        name: 'CHANNEL',
        params: {
            'line1Width': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'line1DashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'line1ColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
            'line2Width': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'line2DashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'line2ColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.GOLDEN_SECTION] = {
        name: 'GOLDEN_SECTION',
        params: {
            'line1Width': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'line1DashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'line1ColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
            'line2Width': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'line2DashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'line2ColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.GOLDEN_BANDS] = {
        name: 'GOLDEN_BANDS',
        params: {
            'line1Width': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'line1DashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'line1ColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
            'line2Width': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'line2DashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'line2ColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.GOLDEN_CIRCLE] = {
        name: 'GOLDEN_CIRCLE',
        params: {
            'circleLineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'circleLineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'circleLineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
            'fanLineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'fanLineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'fanLineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
            'goldenArcLineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'goldenArcLineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'goldenArcLineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.GANN_FAN] = {
        name: 'GANN_FAN',
        params: {
            'fanLineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'fanLineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'fanLineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
    CscApi.defaultDrawerConfigs[DrawerType.LINEAR_REGRESSION] = {
        name: 'LINE_REGRESSION',
        params: {
            'lineWidth': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'lineDashedLength': {
                valueType: DrawerParameterValueType.NUMBER,
                value: 5,
                visible: true,
            },
            'lineColorRgba': {
                valueType: DrawerParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        },
    };
})(CscApi || (CscApi = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var DrawerOfPriceTangent = (function (_super) {
        __extends(DrawerOfPriceTangent, _super);
        function DrawerOfPriceTangent(chart, handleId) {
            var maxStep = 2;
            _super.call(this, chart, handleId, CscApi.DrawerType.PRICE_TANGENT, maxStep);
        }
        DrawerOfPriceTangent.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configLineWidth = config.params['lineWidth'];
            var configLineDashedlength = config.params['lineDashedLength'];
            var configLineColorRgba = config.params['lineColorRgba'];
            this.styleLine1Width = configLineWidth.value;
            this.styleLine1DashedLength = configLineDashedlength.value;
            this.styleLine1ColorRgba = configLineColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfPriceTangent.prototype.getStyleLine1Width = function () {
            return this.styleLine1Width;
        };
        DrawerOfPriceTangent.prototype.setStyleLine1Width = function (lineWidth) {
            this.styleLine1Width = lineWidth;
        };
        DrawerOfPriceTangent.prototype.getStyleLine1DashedLength = function () {
            return this.styleLine1DashedLength;
        };
        DrawerOfPriceTangent.prototype.setStyleLine1DashedLength = function (dashedLength) {
            this.styleLine1DashedLength = dashedLength;
        };
        DrawerOfPriceTangent.prototype.getStyleLine1ColorRgba = function () {
            return this.styleLine1ColorRgba;
        };
        DrawerOfPriceTangent.prototype.setStyleLine1ColorRgba = function (colorRgba) {
            this.styleLine1ColorRgba = colorRgba;
        };
        DrawerOfPriceTangent.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var chart = this.chart;
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var line1;
            var slope;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                var x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                var y1 = area.getChartYCoordFromValue(chartHandleId, chart.getValueOfElement(drawnStep0.index));
                var x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                var y2 = area.getChartYCoordFromValue(chartHandleId, chart.getValueOfElement(current.index));
                line1 = this.createExtLineFromEndPoints(x1, y1, x2, y2).lineForBoundRect;
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                var x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                var y1 = area.getChartYCoordFromValue(chartHandleId, chart.getValueOfElement(drawnStep0.index));
                var x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep1.index);
                var y2 = area.getChartYCoordFromValue(chartHandleId, chart.getValueOfElement(drawnStep1.index));
                slope = (y2 - y1) / (x2 - x1);
                line1 = this.createExtLineWithSlope(x2, y2, slope).lineForBoundRect;
            }
            if (line1 != null) {
                renderer.setLineWidth(this.styleLine1Width);
                renderer.setStrokeColorRgba(this.styleLine1ColorRgba);
                this.drawLine(line1, this.styleLine1DashedLength);
            }
        };
        return DrawerOfPriceTangent;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfPriceTangent = DrawerOfPriceTangent;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfKdj = (function (_super) {
        __extends(ChartOfKdj, _super);
        function ChartOfKdj(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.KDJ, area, handleId, width, height, DECIMAL_DIGITS, 'KDJ');
            this.elementKList = null;
            this.elementDList = null;
            this.elementJList = null;
            this.elementViewKDragon = null;
            this.elementViewDDragon = null;
            this.elementViewJDragon = null;
        }
        ChartOfKdj.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configKLineWidth = config.params['kLineWidth'];
            var configKLineColorRgba = config.params['kLineColorRgba'];
            var configDLineWidth = config.params['dLineWidth'];
            var configDLineColorRgba = config.params['dLineColorRgba'];
            var configJLineWidth = config.params['jLineWidth'];
            var configJLineColorRgba = config.params['jLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleKLineWidth = configKLineWidth.value;
            this.styleKLineColorRgba = configKLineColorRgba.value;
            this.styleDLineWidth = configDLineWidth.value;
            this.styleDLineColorRgba = configDLineColorRgba.value;
            this.styleJLineWidth = configJLineWidth.value;
            this.styleJLineColorRgba = configJLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfKdj.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfKdj.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfKdj.prototype.getStyleKLineWidth = function () {
            return this.styleKLineWidth;
        };
        ChartOfKdj.prototype.setStyleKLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleKLineWidth = lineWidth;
            this.config.params['kLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfKdj.prototype.getStyleKLineColorRgba = function () {
            return this.styleKLineColorRgba;
        };
        ChartOfKdj.prototype.setStyleKLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleKLineColorRgba = colorRgba;
            this.config.params['kLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfKdj.prototype.getStyleDLineWidth = function () {
            return this.styleDLineWidth;
        };
        ChartOfKdj.prototype.setStyleDLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleDLineWidth = lineWidth;
            this.config.params['dLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfKdj.prototype.getStyleDLineColorRgba = function () {
            return this.styleDLineColorRgba;
        };
        ChartOfKdj.prototype.setStyleDLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleDLineColorRgba = colorRgba;
            this.config.params['dLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfKdj.prototype.getStyleJLineWidth = function () {
            return this.styleJLineWidth;
        };
        ChartOfKdj.prototype.setStyleJLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleJLineWidth = lineWidth;
            this.config.params['jLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfKdj.prototype.getStyleJLineColorRgba = function () {
            return this.styleJLineColorRgba;
        };
        ChartOfKdj.prototype.setStyleJLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleJLineColorRgba = colorRgba;
            this.config.params['jLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfKdj.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementKList.length) {
                return this.elementKList[index];
            }
            return null;
        };
        ChartOfKdj.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewKDragon == null || this.elementViewKDragon.length !== numberOfDragonComponents) {
                this.elementViewKDragon = CscApi.Utility.resizeFloat32Array(this.elementViewKDragon, numberOfDragonComponents);
            }
            if (this.elementViewDDragon == null || this.elementViewDDragon.length !== numberOfDragonComponents) {
                this.elementViewDDragon = CscApi.Utility.resizeFloat32Array(this.elementViewDDragon, numberOfDragonComponents);
            }
            if (this.elementViewJDragon == null || this.elementViewJDragon.length !== numberOfDragonComponents) {
                this.elementViewJDragon = CscApi.Utility.resizeFloat32Array(this.elementViewJDragon, numberOfDragonComponents);
            }
            if (this.elementKList == null || this.elementKList.length !== numberOfOrderedTickList) {
                this.elementKList = CscApi.Utility.resizeFloat32Array(this.elementKList, numberOfOrderedTickList);
            }
            if (this.elementDList == null || this.elementDList.length !== numberOfOrderedTickList) {
                this.elementDList = CscApi.Utility.resizeFloat32Array(this.elementDList, numberOfOrderedTickList);
            }
            if (this.elementJList == null || this.elementJList.length !== numberOfOrderedTickList) {
                this.elementJList = CscApi.Utility.resizeFloat32Array(this.elementJList, numberOfOrderedTickList);
            }
            var elementKList = this.elementKList;
            var elementDList = this.elementDList;
            var elementJList = this.elementJList;
            var period = this.argPeriod;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                if (i >= period - 1) {
                    var periodLow = Number.POSITIVE_INFINITY;
                    var periodHigh = Number.NEGATIVE_INFINITY;
                    for (var n = i - period + 1; n < i; ++n) {
                        var low = orderedTickList[n].getLow();
                        var high = orderedTickList[n].getHigh();
                        if (low < periodLow) {
                            periodLow = low;
                        }
                        if (high > periodHigh) {
                            periodHigh = high;
                        }
                    }
                    var rsv = periodHigh === periodLow ? 100 :
                        tickData.getClose() === periodLow ? 1 :
                            100 * (tickData.getClose() - periodLow) / (periodHigh - periodLow);
                    var pi = i - 1;
                    var prevTickData = orderedTickList[pi];
                    var k = rsv * 1 / 3 + elementKList[pi] * 2 / 3;
                    var d = k * 1 / 3 + elementDList[pi] * 2 / 3;
                    var j = 3 * d - 2 * k;
                    elementKList[i] = k;
                    elementDList[i] = d;
                    elementJList[i] = j;
                }
                else {
                    elementKList[i] = elementDList[i] = elementJList[i] = 50;
                }
            }
        };
        ChartOfKdj.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementKList = this.elementKList;
            var elementDList = this.elementDList;
            var elementJList = this.elementJList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var k = elementKList[vi];
                var d = elementDList[vi];
                var j = elementJList[vi];
                if (false == isNaN(k)) {
                    if (k > highestValue)
                        highestValue = k;
                    if (k < lowestValue)
                        lowestValue = k;
                }
                if (false == isNaN(d)) {
                    if (d > highestValue)
                        highestValue = d;
                    if (d < lowestValue)
                        lowestValue = d;
                }
                if (false == isNaN(j)) {
                    if (j > highestValue)
                        highestValue = j;
                    if (j < lowestValue)
                        lowestValue = j;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfKdj.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementKList = this.elementKList;
            var elementDList = this.elementDList;
            var elementJList = this.elementJList;
            var elementViewKDragon = this.elementViewKDragon;
            var elementViewDDragon = this.elementViewDDragon;
            var elementViewJDragon = this.elementViewJDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementKList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var k = elementKList[i];
                var d = elementDList[i];
                var j = elementJList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewKDragon[vi] = viewXCoord;
                elementViewKDragon[vyi] = isNaN(k) ? NaN : Math.floor(valueToYCoordConvertor(k));
                elementViewDDragon[vi] = viewXCoord;
                elementViewDDragon[vyi] = isNaN(d) ? NaN : Math.floor(valueToYCoordConvertor(d));
                elementViewJDragon[vi] = viewXCoord;
                elementViewJDragon[vyi] = isNaN(j) ? NaN : Math.floor(valueToYCoordConvertor(j));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfKdj.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementKList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                renderer.setLineWidth(Math.floor(Math.min(this.styleKLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleKLineColorRgba);
                this.drawDragon(this.elementViewKDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleDLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleDLineColorRgba);
                this.drawDragon(this.elementViewDDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleJLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleJLineColorRgba);
                this.drawDragon(this.elementViewJDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfKdj.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var k = this.elementKList[focusElementIndex];
                var d = this.elementDList[focusElementIndex];
                var j = this.elementJList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(k))
                    valueInfoList.push({ name: 'K', value: k.toFixed(DECIMAL_DIGITS), valueColor: this.styleKLineColorRgba });
                if (false === isNaN(d))
                    valueInfoList.push({ name: 'D', value: d.toFixed(DECIMAL_DIGITS), valueColor: this.styleDLineColorRgba });
                if (false === isNaN(j))
                    valueInfoList.push({ name: 'J', value: j.toFixed(DECIMAL_DIGITS), valueColor: this.styleJLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfKdj;
    })(CscImpl.Chart);
    CscImpl.ChartOfKdj = ChartOfKdj;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var Context = (function () {
        function Context() {
            this.ticks = new CscApi.OrderedHashMap();
            this.orderedTickList = [];
            this.snGeneratorOfEvents = new CscApi.SnGenerator();
            this.eventsOfTickUpdate = {};
        }
        Context.prototype.getOrderedTickList = function () {
            if (this.orderedTickListIsDirty == true) {
                this.orderedTickListIsDirty = false;
                this.orderedTickList = this.ticks.GetOrderedValueList();
            }
            return this.orderedTickList;
        };
        Context.prototype.clearTicks = function () {
            this.ticks.Clear();
            this.orderedTickList = [];
            this.orderedTickListIsDirty = false;
            this.fireEventForOnTickUpdate(0);
        };
        Context.prototype._convertTickToTickData = function (tick) {
            var datetimeOfTick = new Date(tick.timestamp);
            if (false == CscApi.Utility.isDateValid(datetimeOfTick)) {
                console.error('invalid datetime of tick.');
                return null;
            }
            var tickData = new CscApi.TickData();
            var o = tick.open;
            var h = tick.high;
            var l = tick.low;
            var c = tick.close;
            var v = tick.volume;
            tickData.setOpen(o != null ? o : c);
            tickData.setHigh(h != null ? h : c);
            tickData.setLow(l != null ? l : c);
            tickData.setClose(c);
            tickData.setVolume(v != null ? v : 0);
            tickData.setDatetime(datetimeOfTick);
            return tickData;
        };
        Context.prototype.addTicks = function (tickList) {
            var modifiedLowerestIndex = Infinity;
            var ticks = this.ticks;
            var numberOfTick = tickList.length;
            for (var i = 0; i < numberOfTick; ++i) {
                var tick = tickList[i];
                if (tick != null) {
                    var tickData = this._convertTickToTickData(tick);
                    var modifiedIndex = ticks.PutAndCheckIndex(tickData.getDatetime().getTime(), tickData);
                    if (modifiedIndex < modifiedLowerestIndex) {
                        modifiedLowerestIndex = modifiedIndex;
                    }
                }
            }
            this.orderedTickListIsDirty = true;
            if (isFinite(modifiedLowerestIndex)) {
                this.fireEventForOnTickUpdate(modifiedLowerestIndex);
            }
            return true;
        };
        Context.prototype.mergeTicks = function (tickList, mergeTimeSpanInMsec) {
            return this.updateTicks(tickList, mergeTimeSpanInMsec, true);
        };
        Context.prototype.emplaceTicks = function (tickList, mergeTimeSpanInMsec) {
            return this.updateTicks(tickList, mergeTimeSpanInMsec, false);
        };
        Context.prototype.updateTicks = function (tickList, mergeTimeSpanInMsec, isMerged) {
            var modifiedLowerestIndex = Infinity;
            var ticks = this.ticks;
            var numberOfTick = tickList.length;
            for (var i = 0; i < numberOfTick; ++i) {
                var tick = tickList[i];
                if (tick != null) {
                    var tickData = this._convertTickToTickData(tick);
                    var tickTime = tickData.getDatetime().getTime();
                    var modifiedIndex;
                    var locationTickTime = Math.floor(tickTime / mergeTimeSpanInMsec) * mergeTimeSpanInMsec;
                    tickData.setDatetime(new Date(locationTickTime));
                    var locationTickData = ticks.Get(locationTickTime);
                    if (locationTickData == null) {
                        var boundariesPoints = ticks.FindKeyBoundaryPointers(tickTime);
                        var numberOfBoundariesKeys = boundariesPoints.length;
                        if (numberOfBoundariesKeys > 0) {
                            var lowerBoundPointer = boundariesPoints[0];
                            var lowerBoundKey = lowerBoundPointer.key;
                            var lowerBoundTickData = ticks.Get(lowerBoundKey);
                            if (lowerBoundTickData) {
                                var lowerBoundLocationTickTime = Math.floor(lowerBoundTickData.getDatetime().getTime() / mergeTimeSpanInMsec) * mergeTimeSpanInMsec;
                                if (lowerBoundLocationTickTime == locationTickTime) {
                                    locationTickData = lowerBoundTickData;
                                    modifiedIndex = lowerBoundPointer.index;
                                }
                            }
                        }
                        if (locationTickData == null && numberOfBoundariesKeys > 1) {
                            var upperBoundPointer = boundariesPoints[0];
                            var upperBoundKey = upperBoundPointer.key;
                            var upperBoundTickData = ticks.Get(upperBoundKey);
                            if (upperBoundTickData) {
                                var upperBoundLocationTickTime = Math.floor(upperBoundTickData.getDatetime().getTime() / mergeTimeSpanInMsec) * mergeTimeSpanInMsec;
                                if (upperBoundLocationTickTime == locationTickTime) {
                                    locationTickData = upperBoundTickData;
                                    modifiedIndex = upperBoundPointer.index;
                                }
                            }
                        }
                    }
                    else {
                        modifiedIndex = ticks.GetIndex(locationTickTime);
                    }
                    if (locationTickData) {
                        if (isMerged) {
                            var tickHigh = tickData.getHigh();
                            if (tickHigh > locationTickData.getHigh()) {
                                locationTickData.setHigh(tickHigh);
                            }
                            var tickLow = tickData.getLow();
                            if (tickLow < locationTickData.getLow()) {
                                locationTickData.setLow(tickLow);
                            }
                            locationTickData.setClose(tickData.getClose());
                            locationTickData.setVolume(locationTickData.getVolume() + tickData.getVolume());
                        }
                        else {
                            locationTickData.replace(tickData);
                        }
                    }
                    else {
                        modifiedIndex = ticks.PutAndCheckIndex(locationTickTime, tickData);
                    }
                    if (modifiedIndex < modifiedLowerestIndex) {
                        modifiedLowerestIndex = modifiedIndex;
                    }
                }
            }
            this.orderedTickListIsDirty = true;
            if (isFinite(modifiedLowerestIndex)) {
                this.fireEventForOnTickUpdate(modifiedLowerestIndex);
            }
            return true;
        };
        Context.prototype.getLowerBoundTickIndexByTime = function (tickTimeInMsec) {
            var boundaries = this.ticks.FindKeyBoundaryPointers(tickTimeInMsec);
            var lowerBound = boundaries[0];
            if (lowerBound == null) {
                return null;
            }
            return lowerBound.index;
        };
        Context.prototype.fireEventForOnTickUpdate = function (modifiedLowerestIndex) {
            var eventCallbacks = this.eventsOfTickUpdate;
            for (var handleId in eventCallbacks) {
                var callback = eventCallbacks[handleId];
                if (callback) {
                    callback(modifiedLowerestIndex);
                }
            }
        };
        Context.prototype.addEventListenerOnTickUpdate = function (callback) {
            if (callback == null) {
                return null;
            }
            var handleId = this.snGeneratorOfEvents.allocate();
            this.eventsOfTickUpdate[handleId] = callback;
            return handleId;
        };
        Context.prototype.removeEventListener = function (handleId) {
            if (handleId == null) {
                return;
            }
            delete this.eventsOfTickUpdate[handleId];
            this.snGeneratorOfEvents.recycle(handleId);
        };
        return Context;
    })();
    CscImpl.Context = Context;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = null;
    var ChartOfOhlc = (function (_super) {
        __extends(ChartOfOhlc, _super);
        function ChartOfOhlc(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.OHLC, area, handleId, width, height, DECIMAL_DIGITS, 'OHLC');
            this.elements = null;
            this.argOhlcType = CscApi.OhlcType.REALITY;
            this.styleCandleWidth = null;
        }
        ChartOfOhlc.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configOhlcType = config.params['ohlcType'];
            var configOhlcBarType = config.params['ohlcBarType'];
            var configCandlestickRisingColorRgba = config.params['candlestickRisingColorRgba'];
            var configCandlestickFallingColorRgba = config.params['candlestickFallingColorRgba'];
            var configBarRisingPositiveColorRgba = config.params['barRisingColorRgba'];
            var configBarNegativeColorRgba = config.params['barFallingColorRgba'];
            this.argOhlcType = configOhlcType.value;
            this.styleOhlcBarType = configOhlcBarType.value;
            this.styleCandleRisingColorRgba = configCandlestickRisingColorRgba.value;
            this.styleCandleFallingColorRgba = configCandlestickFallingColorRgba.value;
            this.styleBarRisingColorRgba = configBarRisingPositiveColorRgba.value;
            this.styleBarFallingColorRgba = configBarNegativeColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfOhlc.prototype.getArgOhlcType = function () {
            return this.argOhlcType;
        };
        ChartOfOhlc.prototype.setArgOhlcType = function (ohlcType) {
            this.argOhlcType = ohlcType;
            this.config.params['ohlcType'].value = ohlcType;
            this.setArgDirty(true);
            return true;
        };
        ChartOfOhlc.prototype.getStyleOhlcBarType = function () {
            return this.styleOhlcBarType;
        };
        ChartOfOhlc.prototype.setStyleOhlcBarType = function (ohlcBarType) {
            this.styleOhlcBarType = ohlcBarType;
            this.config.params['ohlcBarType'].value = ohlcBarType;
            return true;
        };
        ChartOfOhlc.prototype.getStyleRisingCandleColorRgba = function () {
            return this.styleCandleRisingColorRgba;
        };
        ChartOfOhlc.prototype.setStyleRisingCandleColorRgba = function (colorRgba) {
            this.styleCandleRisingColorRgba = colorRgba;
            this.config.params['candlestickRisingColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfOhlc.prototype.getStyleSheddingCandleColorRgba = function () {
            return this.styleCandleFallingColorRgba;
        };
        ChartOfOhlc.prototype.setStyleSheddingCandleColorRgba = function (colorRgba) {
            this.styleCandleFallingColorRgba = colorRgba;
            this.config.params['candlestickRisingColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfOhlc.prototype.getStyleRisingBorderColorRgba = function () {
            return this.styleBarRisingColorRgba;
        };
        ChartOfOhlc.prototype.setStyleRisingBorderColorRgba = function (colorRgba) {
            this.styleBarRisingColorRgba = colorRgba;
            this.config.params['barRisingColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfOhlc.prototype.getSheddingBorderColorRgba = function () {
            return this.styleBarFallingColorRgba;
        };
        ChartOfOhlc.prototype.setSheddingBorderColorRgba = function (colorRgba) {
            this.styleBarFallingColorRgba = colorRgba;
            this.config.params['barFaillingColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfOhlc.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elements.length) {
                return this.elements[index].tickData.getClose();
            }
            return null;
        };
        ChartOfOhlc.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            if (this.elements == null || this.elements.length != numberOfOrderedTickList) {
                this.elements = CscApi.Utility.resizeArray(this.elements, numberOfOrderedTickList);
            }
            var elements = this.elements;
            if (this.argOhlcType === CscApi.OhlcType.REALITY) {
                for (var i = updateTickFromIndex; i < numberOfOrderedTickList; ++i) {
                    var tickData = orderedTickList[i];
                    elements[i] = {
                        tickData: tickData,
                        rising: tickData.getClose() > tickData.getOpen(),
                        viewCandleStickLeftCoord: null,
                        viewCandleStickTopCoord: null,
                        viewCandleStickHeight: null,
                        viewUpperShadowTopCoord: null,
                        viewLowerShadowBottomCoord: null,
                    };
                }
            }
            else if (this.argOhlcType === CscApi.OhlcType.HEIKIN_ASHI) {
                for (var i = updateTickFromIndex; i < numberOfOrderedTickList; ++i) {
                    var tickData = orderedTickList[i];
                    var o = tickData.getOpen();
                    var h = tickData.getHigh();
                    var l = tickData.getLow();
                    var c = tickData.getClose();
                    var heikenAshiTick = new CscApi.TickData();
                    var hc;
                    var ho;
                    var hh;
                    var hl;
                    if (i === 0) {
                        hc = (o + h + l + c) / 4;
                        ho = tickData.getOpen();
                        hh = Math.max(h, ho, hc);
                        hl = Math.min(l, ho, hc);
                    }
                    else {
                        var prevTickData = orderedTickList[i - 1];
                        var prevHeikenAshiTick = elements[i - 1].tickData;
                        hc = (o + h + l + c) / 4;
                        ho = (prevHeikenAshiTick.getOpen() + prevTickData.getClose()) * 0.5;
                        hh = Math.max(h, ho, hc);
                        hl = Math.min(l, ho, hc);
                    }
                    heikenAshiTick.setOpen(ho);
                    heikenAshiTick.setClose(hc);
                    heikenAshiTick.setHigh(hh);
                    heikenAshiTick.setLow(hl);
                    elements[i] = {
                        tickData: heikenAshiTick,
                        rising: heikenAshiTick.getClose() > heikenAshiTick.getOpen(),
                        viewCandleStickLeftCoord: null,
                        viewCandleStickTopCoord: null,
                        viewCandleStickHeight: null,
                        viewUpperShadowTopCoord: null,
                        viewLowerShadowBottomCoord: null,
                    };
                }
            }
            else {
                throw 'unknown OHLC type.';
            }
        };
        ChartOfOhlc.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var tickData = orderedTickList[i];
                if (tickData.getHigh() > highestValue) {
                    highestValue = tickData.getHigh();
                }
                if (tickData.getLow() < lowestValue) {
                    lowestValue = tickData.getLow();
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfOhlc.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elements = this.elements;
            var candleWidth = this.styleCandleWidth = this.refCandlestickChart().getViewTickWidth() * 0.8;
            var candleHalfWidth = candleWidth * 0.5;
            this.styleCandleWidth = Math.floor(candleWidth);
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var element = elements[i];
                var tickData = element.tickData;
                var timeScaleElement = timeScaleElements[i];
                var o = tickData.getOpen();
                var h = tickData.getHigh();
                var l = tickData.getLow();
                var c = tickData.getClose();
                element.viewCandleStickLeftCoord = Math.floor(timeScaleElement.viewXCoord - candleHalfWidth);
                if (element.rising) {
                    element.viewCandleStickTopCoord = Math.floor(valueToYCoordConvertor(c));
                    element.viewCandleStickHeight = Math.floor(valueToYCoordConvertor(o) - element.viewCandleStickTopCoord);
                }
                else {
                    element.viewCandleStickTopCoord = Math.floor(valueToYCoordConvertor(o));
                    element.viewCandleStickHeight = Math.floor(valueToYCoordConvertor(c) - element.viewCandleStickTopCoord);
                }
                element.viewUpperShadowTopCoord = Math.floor(valueToYCoordConvertor(h));
                element.viewLowerShadowBottomCoord = Math.floor(valueToYCoordConvertor(l));
            }
            return yAxisEnabled ? this.generateValueScale(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfOhlc.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            if (this.styleOhlcBarType === CscApi.OhlcBarType.BAR) {
                this.renderTickAsBars(viewStartTickIndex, viewEndTickIndex);
            }
            else {
                this.renderTickAsCandlestick(viewStartTickIndex, viewEndTickIndex);
            }
            return true;
        };
        ChartOfOhlc.prototype.renderTickAsCandlestick = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            renderer.setLineWidth(1);
            var styleRisingCandleColorRgba = this.styleCandleRisingColorRgba;
            var styleSheddingCandleColorRgba = this.styleCandleFallingColorRgba;
            var styleRisingBorderColorRgba = this.styleBarRisingColorRgba;
            var styleSheddingBorderColorRgba = this.styleBarFallingColorRgba;
            var area = this.getArea();
            var elements = this.elements;
            var candleWidth = this.styleCandleWidth;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var viewStartXCoord = area.getViewStartXCoord();
            renderer.translate(-viewStartXCoord, 0);
            if (candleWidth > 1) {
                renderer.setFillColorRgba(styleRisingCandleColorRgba);
                renderer.setStrokeColorRgba(styleRisingBorderColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var element = elements[i];
                    var timeScaleElement = timeScaleElements[i];
                    if (element.rising) {
                        renderer.strokeLine(timeScaleElement.viewXCoord, element.viewUpperShadowTopCoord, timeScaleElement.viewXCoord, element.viewCandleStickTopCoord);
                        renderer.strokeLine(timeScaleElement.viewXCoord, element.viewCandleStickTopCoord + element.viewCandleStickHeight, timeScaleElement.viewXCoord, element.viewLowerShadowBottomCoord);
                        renderer.fillRect(element.viewCandleStickLeftCoord, element.viewCandleStickTopCoord, candleWidth, element.viewCandleStickHeight);
                        renderer.strokeRect(element.viewCandleStickLeftCoord, element.viewCandleStickTopCoord, candleWidth, element.viewCandleStickHeight);
                    }
                }
                renderer.setFillColorRgba(styleSheddingCandleColorRgba);
                renderer.setStrokeColorRgba(styleSheddingBorderColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var element = elements[i];
                    var timeScaleElement = timeScaleElements[i];
                    if (false === element.rising) {
                        renderer.strokeLine(timeScaleElement.viewXCoord, element.viewUpperShadowTopCoord, timeScaleElement.viewXCoord, element.viewCandleStickTopCoord);
                        renderer.strokeLine(timeScaleElement.viewXCoord, element.viewCandleStickTopCoord + element.viewCandleStickHeight, timeScaleElement.viewXCoord, element.viewLowerShadowBottomCoord);
                        renderer.fillRect(element.viewCandleStickLeftCoord, element.viewCandleStickTopCoord, candleWidth, element.viewCandleStickHeight);
                        renderer.strokeRect(element.viewCandleStickLeftCoord, element.viewCandleStickTopCoord, candleWidth, element.viewCandleStickHeight);
                    }
                }
            }
            else {
                var prevViewXCoord = null;
                renderer.setStrokeColorRgba(styleRisingBorderColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var element = elements[i];
                    var timeScaleElement = timeScaleElements[i];
                    if (element.rising) {
                        if (prevViewXCoord !== timeScaleElement.viewXCoord) {
                            prevViewXCoord = timeScaleElement.viewXCoord;
                            renderer.strokeLine(timeScaleElement.viewXCoord, element.viewUpperShadowTopCoord, timeScaleElement.viewXCoord, element.viewLowerShadowBottomCoord);
                        }
                    }
                }
                renderer.setStrokeColorRgba(styleSheddingBorderColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var element = elements[i];
                    var timeScaleElement = timeScaleElements[i];
                    if (false === element.rising) {
                        if (prevViewXCoord !== timeScaleElement.viewXCoord) {
                            prevViewXCoord = timeScaleElement.viewXCoord;
                            renderer.strokeLine(timeScaleElement.viewXCoord, element.viewUpperShadowTopCoord, timeScaleElement.viewXCoord, element.viewLowerShadowBottomCoord);
                        }
                    }
                }
            }
            renderer.translate(viewStartXCoord, 0);
        };
        ChartOfOhlc.prototype.renderTickAsBars = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            renderer.setLineWidth(1);
            var styleRisingBorderColorRgba = this.styleBarRisingColorRgba;
            var styleSheddingBorderColorRgba = this.styleBarFallingColorRgba;
            var area = this.getArea();
            var elements = this.elements;
            var barWidth = this.refCandlestickChart().getViewTickWidth() * 0.9;
            var halfBarWidth = Math.floor(barWidth * 0.5);
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var viewStartXCoord = area.getViewStartXCoord();
            var barWidth = Math.max(1, Math.ceil(Math.sqrt(barWidth)));
            renderer.setLineWidth(barWidth);
            renderer.translate(-viewStartXCoord, 0);
            renderer.setStrokeColorRgba(styleRisingBorderColorRgba);
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var element = elements[i];
                var timeScaleElement = timeScaleElements[i];
                if (element.rising) {
                    renderer.strokeLine(timeScaleElement.viewXCoord, element.viewUpperShadowTopCoord, timeScaleElement.viewXCoord, element.viewLowerShadowBottomCoord);
                    renderer.strokeLine(Math.floor(timeScaleElement.viewXCoord - halfBarWidth), element.viewCandleStickTopCoord + element.viewCandleStickHeight, Math.floor(timeScaleElement.viewXCoord + barWidth * 0.5), element.viewCandleStickTopCoord + element.viewCandleStickHeight);
                    renderer.strokeLine(Math.floor(timeScaleElement.viewXCoord - barWidth * 0.5), element.viewCandleStickTopCoord, Math.floor(timeScaleElement.viewXCoord + halfBarWidth), element.viewCandleStickTopCoord);
                }
            }
            renderer.setStrokeColorRgba(styleSheddingBorderColorRgba);
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var element = elements[i];
                var timeScaleElement = timeScaleElements[i];
                if (false == element.rising) {
                    renderer.strokeLine(timeScaleElement.viewXCoord, element.viewUpperShadowTopCoord, timeScaleElement.viewXCoord, element.viewLowerShadowBottomCoord);
                    renderer.strokeLine(Math.floor(timeScaleElement.viewXCoord - barWidth * 0.5), element.viewCandleStickTopCoord + element.viewCandleStickHeight, Math.floor(timeScaleElement.viewXCoord + halfBarWidth), element.viewCandleStickTopCoord + element.viewCandleStickHeight);
                    renderer.strokeLine(Math.floor(timeScaleElement.viewXCoord - halfBarWidth), element.viewCandleStickTopCoord, Math.floor(timeScaleElement.viewXCoord + barWidth * 0.5), element.viewCandleStickTopCoord);
                }
            }
            renderer.translate(viewStartXCoord, 0);
        };
        ChartOfOhlc.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var candlestickChart = this.refCandlestickChart();
                var decimalDigits = candlestickChart.getDecimalDigits();
                var focusElement = this.elements[focusElementIndex];
                if (focusElement) {
                    var tickData = focusElement.tickData;
                    valueInfoList = [
                        { name: 'O', value: tickData.getOpen().toFixed(decimalDigits), valueColor: null },
                        { name: 'H', value: tickData.getHigh().toFixed(decimalDigits), valueColor: null },
                        { name: 'L', value: tickData.getLow().toFixed(decimalDigits), valueColor: null },
                        { name: 'C', value: tickData.getClose().toFixed(decimalDigits), valueColor: null },
                        { name: 'IDX', value: focusElementIndex.toString(), valueColor: null },
                    ];
                }
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfOhlc;
    })(CscImpl.Chart);
    CscImpl.ChartOfOhlc = ChartOfOhlc;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var clipViewportInArea = true;
    var Y_AXIS_TEXT_POSITION = 3;
    var Area = (function () {
        function Area(candlestickChart, areaHandleId, width, height) {
            this.candlestickChart = candlestickChart;
            this.areaHandleId = areaHandleId;
            this.width = width;
            this.height = height;
            this.chartContexts = {};
            this.snGeneratorOfChartHandleId = new CscApi.SnGenerator();
            this.highestValue = null;
            this.lowestValue = null;
            this.viewStartXCoord = null;
            this.viewStartTickIndex = null;
            this.viewNumberOfTicks = null;
            this.viewMaxStartXCoord = null;
            this.viewTickWidth = null;
            this.viewIsDirty = true;
            this.focusElementIndex = null;
            this.autoFocusLastTickWhenUnfocussed = true;
            this.viewZoomingToFocusElement = true;
            this.viewZoomingAlignMode = CscApi.ViewAlignMode.RIGHT;
        }
        Area.prototype.getCandlestickChart = function () {
            return this.candlestickChart;
        };
        Area.prototype.getContext = function () {
            return this.candlestickChart.getContext();
        };
        Area.prototype.getHandleId = function () {
            return this.areaHandleId;
        };
        Area.prototype.setWidth = function (width) {
            var chartContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                chart.setWidth(width);
            }
            this.width = width;
            var defaultPadding = width * 0.15;
            this.viewPaddingLeft = defaultPadding;
            this.viewPaddingRight = defaultPadding;
            this.viewIsDirty = true;
            return true;
        };
        Area.prototype.getWidth = function () {
            return this.width;
        };
        Area.prototype.setHeight = function (height) {
            var chartContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                chart.setHeight(height);
            }
            this.height = height;
            this.viewIsDirty = true;
            return true;
        };
        Area.prototype.getHeight = function () {
            return this.height;
        };
        Area.prototype.getViewStartTickIndex = function () {
            return this.viewStartTickIndex;
        };
        Area.prototype.setViewStartTickIndex = function (index) {
            this.viewStartTickIndex = index;
            var timeScale = this.candlestickChart.getTimeScale();
            this.setViewStartXCoord(timeScale.getXFromTickIndex(index));
        };
        Area.prototype.getViewNumberOfTicks = function () {
            return this.viewNumberOfTicks;
        };
        Area.prototype.getViewEndTickIndex = function () {
            return this.viewStartTickIndex + this.viewNumberOfTicks - 1;
        };
        Area.prototype.setViewEndTickIndex = function (index) {
            var viewStartTickIndex = index - this.viewNumberOfTicks + 1;
            this.setViewStartTickIndex(viewStartTickIndex);
        };
        Area.prototype.getViewStartXCoord = function () {
            return this.viewStartXCoord;
        };
        Area.prototype.setViewStartXCoord = function (viewStartXCoord) {
            if (this.viewStartXCoord == viewStartXCoord) {
                return;
            }
            this.viewStartXCoord = viewStartXCoord;
            this.viewIsDirty = true;
        };
        Area.prototype.getViewMaxStartXCoord = function () {
            return this.viewMaxStartXCoord;
        };
        Area.prototype.setViewIsDirty = function (isDirty) {
            this.viewIsDirty = isDirty;
        };
        Area.prototype.getFocusElementIndex = function () {
            return this.focusElementIndex;
        };
        Area.prototype.setFocusElementIndex = function (focusElementIndex) {
            var timeScale = this.candlestickChart.getTimeScale();
            if (timeScale == null) {
                return;
            }
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (timeScaleElements == null) {
                return;
            }
            if (focusElementIndex < 0 || focusElementIndex >= timeScaleElements.length) {
                return;
            }
            this.focusElementIndex = focusElementIndex;
        };
        Area.prototype.getChartValueFromYInArea = function (chartHandleId, yInArea) {
            var chartViewContext = this.chartContexts[chartHandleId];
            if (chartViewContext && chartViewContext.yCoordToValueConvertor) {
                return chartViewContext.yCoordToValueConvertor(yInArea);
            }
            return null;
        };
        Area.prototype.getChartYCoordFromValue = function (chartHandleId, value) {
            var chartViewContext = this.chartContexts[chartHandleId];
            if (chartViewContext && chartViewContext.valueToYCoordConvertor) {
                return chartViewContext.valueToYCoordConvertor(value);
            }
            return null;
        };
        Area.prototype.isDrawing = function () {
            var chartContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                if (chart.isDrawing()) {
                    return true;
                }
            }
            return false;
        };
        Area.prototype.update = function (updateTickFromIndex) {
            var chartContexts = this.chartContexts;
            var tickDataIsDirty = updateTickFromIndex != null;
            if (tickDataIsDirty) {
                for (var handleId in chartContexts) {
                    var chart = chartContexts[handleId].chart;
                    chart.updateElements(updateTickFromIndex);
                }
            }
            else {
                for (var handleId in chartContexts) {
                    var chart = chartContexts[handleId].chart;
                    if (chart.isArgDirty()) {
                        chart.updateElements(0);
                        this.viewIsDirty = true;
                    }
                }
            }
            this.confineViewArea();
            if (tickDataIsDirty || this.viewIsDirty) {
                this.viewIsDirty = false;
                this._updateYScales();
            }
            return true;
        };
        Area.prototype._updateYScales = function () {
            var chartContexts = this.chartContexts;
            var viewStartTickIndex = this.viewStartTickIndex;
            var viewNumberOfTicks = this.viewNumberOfTicks;
            var viewEndTickIndex = this.getViewEndTickIndex();
            this.highestValue = Number.NEGATIVE_INFINITY;
            this.lowestValue = Number.POSITIVE_INFINITY;
            for (var handleId in chartContexts) {
                var chartContext = chartContexts[handleId];
                var chart = chartContext.chart;
                var updatingResult = chart.updateViewYRange(viewStartTickIndex, viewEndTickIndex);
                var l = updatingResult.lowestValue;
                var h = updatingResult.highestValue;
                if (h != null && h > this.highestValue) {
                    this.highestValue = h;
                }
                if (l != null && l < this.lowestValue) {
                    this.lowestValue = l;
                }
            }
            this.viewYScales = {};
            var viewYScales = this.viewYScales;
            var highestValue = this.highestValue;
            var lowestValue = this.lowestValue;
            var priceRange = highestValue - lowestValue;
            for (var handleId in chartContexts) {
                var chartContext = chartContexts[handleId];
                var chart = chartContext.chart;
                var pixelsPerValue = chart.getHeight() / priceRange;
                var valueToYCoordConvertor = (function (innerHighestValue, innerPixelsPerValue) {
                    return function (value) {
                        return (innerHighestValue - value) * innerPixelsPerValue;
                    };
                })(highestValue, pixelsPerValue);
                var yCoordToValueConvertor = (function (innerHighestValue, innerPixelsPerValue) {
                    return function (yCoord) {
                        return innerHighestValue - yCoord / innerPixelsPerValue;
                    };
                })(highestValue, pixelsPerValue);
                chartContext.pixelsPerValue = pixelsPerValue;
                chartContext.valueToYCoordConvertor = valueToYCoordConvertor;
                chartContext.yCoordToValueConvertor = yCoordToValueConvertor;
                var yScale = chart.updateForRendering(viewStartTickIndex, viewEndTickIndex, lowestValue, highestValue, pixelsPerValue, valueToYCoordConvertor, chartContext.yAxisEnabled);
                if (yScale != null) {
                    viewYScales[handleId] = yScale;
                }
            }
        };
        Area.prototype.render = function () {
            var candlestickChart = this.candlestickChart;
            var focusElementIndex = this.focusElementIndex;
            var isDrawing = candlestickChart.isDrawing();
            var viewStartXCoord = this.viewStartXCoord;
            var renderer = candlestickChart.getRenderer();
            var style = candlestickChart.getStyle();
            var styleChartInfoFontSize = style.getChartCaptionInfoFontSize();
            var styleFocusLineWidth = style.getFocusLineWidth();
            var styleFocusLineColorRgba = style.getFocusLineColorRgba();
            var focusLineVisible = isDrawing == false || isDrawing == style.getFocusLineVisibleWhenDrawing();
            this.drawVerticalGrids(candlestickChart.getTimeScale());
            var viewStartTickIndex = this.viewStartTickIndex;
            var viewNumberOfTicks = this.viewNumberOfTicks;
            var viewEndTickIndex = this.getViewEndTickIndex();
            var chartContexts = this.chartContexts;
            var viewYScales = this.viewYScales;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                var viewYScale = viewYScales[handleId];
                if (viewYScale != null) {
                    this.drawHorizontalGrids(renderer, chart, viewYScale);
                }
                chart.render(viewStartTickIndex, viewEndTickIndex);
            }
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                chart.renderDrawers();
            }
            if (focusLineVisible) {
                if (focusElementIndex != null) {
                    var timeScale = candlestickChart.getTimeScale();
                    var timeScaleElements = timeScale.getTimeScaleElements();
                    var timeScaleElement = timeScaleElements[focusElementIndex];
                    if (timeScaleElement != null) {
                        var x = timeScaleElement.viewXCoord - viewStartXCoord;
                        renderer.setLineWidth(styleFocusLineWidth);
                        renderer.setStrokeColorRgba(styleFocusLineColorRgba);
                        renderer.strokeLine(x, 0, x, this.height);
                    }
                }
            }
            var chartViewContexts = this.chartContexts;
            var numberOfValueInfo = 0;
            var width = this.width;
            renderer.translate(Y_AXIS_TEXT_POSITION, 0);
            var chartContexts = this.chartContexts;
            var valueScaleFontSize = style.getValueScaleLabelFontSize();
            var valueScaleFontName = style.getValueScaleLabelFontName();
            var valueScaleFontBold = style.getValueScaleLabelFontBold();
            var valueScaleLabelBackgroundColorRgba = style.getValueScaleLabelBackgroundColorRgba();
            var valueScaleLabelTextColorRgba = style.getValueScaleLabelTextColorRgba();
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                var chartViewContext = chartViewContexts[handleId];
                if (chartViewContext.focusValue != null) {
                    var yCoord = chartViewContext.valueToYCoordConvertor(chartViewContext.focusValue);
                    if (focusLineVisible) {
                        renderer.setLineWidth(styleFocusLineWidth);
                        renderer.setStrokeColorRgba(styleFocusLineColorRgba);
                        renderer.strokeLine(0, yCoord, width, yCoord);
                    }
                    if (chartViewContext.yAxisEnabled) {
                        var value = chartViewContext.focusValue.toFixed(chart.getDecimalDigits());
                        renderer.setTextAlignToCenter();
                        renderer.setTextBaseLineToTop();
                        renderer.setTextFontSize(valueScaleFontSize);
                        renderer.setTextFontName(valueScaleFontName);
                        renderer.setTextFontBold(valueScaleFontBold);
                        var valueStrWidth = renderer.getTextWidth(value) + valueScaleFontSize;
                        var xCoord = width;
                        var backRectHeight = valueScaleFontSize;
                        renderer.setFillColorRgba(valueScaleLabelBackgroundColorRgba);
                        renderer.fillRect(xCoord - valueStrWidth, yCoord, valueStrWidth, backRectHeight);
                        renderer.setFillColorRgba(valueScaleLabelTextColorRgba);
                        renderer.fillText(value, Math.floor(xCoord - valueStrWidth * 0.5), yCoord);
                    }
                }
                if (focusElementIndex != null) {
                    var yOffset = (styleChartInfoFontSize + 4) * numberOfValueInfo;
                    renderer.translate(0, yOffset);
                    chart.renderValueInfo(focusElementIndex);
                    ++numberOfValueInfo;
                    renderer.translate(0, -yOffset);
                }
            }
            renderer.translate(-Y_AXIS_TEXT_POSITION, 0);
            return true;
        };
        Area.prototype.addChart = function (chartType) {
            var handleId = this.snGeneratorOfChartHandleId.allocate();
            var chart;
            var chartWidth = this.width;
            var chartHeight = this.height;
            chart = CscImpl.ChartFactory.generate(chartType, this, handleId, chartWidth, chartHeight);
            if (chart == null) {
                this.snGeneratorOfChartHandleId.recycle(handleId);
                console.error('unknown chart type.');
                return null;
            }
            this.chartContexts[handleId] = {
                chart: chart,
                pixelsPerValue: null,
                valueToYCoordConvertor: null,
                yCoordToValueConvertor: null,
                focusValue: null,
                yAxisEnabled: true,
            };
            return handleId;
        };
        Area.prototype.getChart = function (handleId) {
            var chartContext = this.chartContexts[handleId];
            return chartContext ? chartContext.chart : null;
        };
        Area.prototype.getChartList = function () {
            var chartList = [];
            var chartContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                chartList.push(chart);
            }
            return chartList;
        };
        Area.prototype.removeChart = function (handleId) {
            if (this.chartContexts[handleId]) {
                delete this.chartContexts[handleId];
                this.snGeneratorOfChartHandleId.recycle(handleId);
                return true;
            }
            return false;
        };
        Area.prototype.getChartYAxisEnabled = function (handleId) {
            var chartContext = this.chartContexts[handleId];
            if (chartContext != null) {
                return chartContext.yAxisEnabled;
            }
            return null;
        };
        Area.prototype.setChartYAxisEnabled = function (handleId, enabled) {
            var chartContext = this.chartContexts[handleId];
            if (chartContext != null) {
                chartContext.yAxisEnabled = enabled;
            }
        };
        Area.prototype.getViewZoomingToFocusElement = function () {
            return this.viewZoomingToFocusElement;
        };
        Area.prototype.setViewZoomingToFocusElement = function (enabled) {
            this.viewZoomingToFocusElement = enabled;
        };
        Area.prototype.getViewZoomingAlignMode = function () {
            return this.viewZoomingAlignMode;
        };
        Area.prototype.setViewZoomingAlignMode = function (mode) {
            this.viewZoomingAlignMode = mode;
        };
        Area.prototype.reconcileViewFromArea = function (area) {
            this.setViewStartXCoord(area.getViewStartXCoord());
            this.setViewZoomingToFocusElement(area.getViewZoomingToFocusElement());
            this.setViewZoomingAlignMode(area.getViewZoomingAlignMode());
            this.viewIsDirty = area.viewIsDirty;
            this.viewPaddingLeft = area.viewPaddingLeft;
            this.viewPaddingRight = area.viewPaddingRight;
            this.viewTickWidth = area.viewTickWidth;
            this.viewMaxStartXCoord = area.viewMaxStartXCoord;
        };
        Area.prototype.processMouseDown = function (button, xInArea, yInArea) {
        };
        Area.prototype.processMouseUp = function (button, xInArea, yInArea) {
            var chartContexts = this.chartContexts;
            if (button === CscApi.MouseButton.LEFT) {
                for (var handleId in chartContexts) {
                    var chart = chartContexts[handleId].chart;
                    chart.commitDrawers(xInArea, yInArea);
                }
            }
            else if (button === CscApi.MouseButton.RIGHT) {
                for (var handleId in chartContexts) {
                    var chart = chartContexts[handleId].chart;
                    var removeDrawerList = chart.revertDrawers(false);
                    if (removeDrawerList != null) {
                        for (var i = 0; i < removeDrawerList.length; ++i) {
                            var drawer = removeDrawerList[i];
                            this.candlestickChart.processDrawerTerminated(drawer);
                            drawer.getChart().removeDrawer(drawer.getHandleId());
                        }
                    }
                }
            }
        };
        Area.prototype.processMouseMove = function (xInArea, yInArea) {
            var chartContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                chart.moveDrawers(xInArea, yInArea);
            }
        };
        Area.prototype.processMouseWheel = function (zoomOut, xInArea, yInArea) {
        };
        Area.prototype.processTouchStart = function (xInArea, yInArea) {
        };
        Area.prototype.processTouchMove = function (xInArea, yInArea) {
            var chartContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                chart.moveDrawers(xInArea[0], yInArea[0]);
            }
        };
        Area.prototype.processTouchEnd = function (xInArea, yInArea) {
            var chartContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                chart.commitDrawers(xInArea[0], yInArea[0]);
            }
        };
        Area.prototype.focusX = function (xInArea) {
            var timeScale = this.candlestickChart.getTimeScale();
            var elementIndex = timeScale.getTickIndexFromX(xInArea + this.getViewStartXCoord());
            this.setFocusElementIndex(elementIndex);
            return elementIndex;
        };
        Area.prototype.focusY = function (yInArea) {
            var chartContexts = this.chartContexts;
            var chartViewContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chartContext = chartContexts[handleId];
                var chart = chartContext.chart;
                var chartViewContext = chartViewContexts[handleId];
                if (chartViewContext.yCoordToValueConvertor) {
                    var value = chartViewContext.yCoordToValueConvertor(yInArea);
                    chartViewContext.focusValue = value;
                }
            }
        };
        Area.prototype.focusYByFocusedElement = function () {
            var chartContexts = this.chartContexts;
            var chartViewContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                var chartViewContext = chartViewContexts[handleId];
                if (chartViewContext.yCoordToValueConvertor && this.focusElementIndex != null) {
                    var value = chartViewContext.chart.getValueOfElement(this.focusElementIndex);
                    chartViewContext.focusValue = value;
                }
                else {
                    chartViewContext.focusValue = null;
                }
            }
        };
        Area.prototype.focusXY = function (xInArea, yInArea) {
            this.focusX(xInArea);
            this.focusY(yInArea);
        };
        Area.prototype.unfocus = function () {
            this.setFocusElementIndex(null);
            this.unfocusValue();
        };
        Area.prototype.unfocusValue = function () {
            var chartContexts = this.chartContexts;
            var chartViewContexts = this.chartContexts;
            for (var handleId in chartContexts) {
                var chart = chartContexts[handleId].chart;
                var chartViewContext = chartViewContexts[handleId];
                chartViewContext.focusValue = null;
            }
        };
        Area.prototype.confineViewArea = function () {
            var width = this.width;
            var timeScale = this.candlestickChart.getTimeScale();
            var viewMaxStartXCoord = Math.floor(timeScale.getTotalWidth() - width + this.viewPaddingRight);
            if (viewMaxStartXCoord < 0) {
                viewMaxStartXCoord = 0;
            }
            this.viewMaxStartXCoord = viewMaxStartXCoord;
            var prevViewStartXCoord = this.viewStartXCoord;
            var prevViewStartTickIndex = this.viewStartTickIndex;
            var prevViewNumberOfTicks = this.viewNumberOfTicks;
            var prevViewTickWidth = this.viewTickWidth;
            var viewTickWidth = this.candlestickChart.getViewTickWidth();
            if (prevViewTickWidth != viewTickWidth) {
                this.viewIsDirty = true;
                this.viewTickWidth = viewTickWidth;
                var newViewStartXCoord = null;
                if (this.viewZoomingToFocusElement) {
                    var focusElementIndex = this.focusElementIndex;
                    var prevViewEndTickIndex = prevViewStartTickIndex != null && prevViewNumberOfTicks != null ? prevViewStartTickIndex + prevViewNumberOfTicks - 1 : null;
                    if (focusElementIndex != null) {
                        var prevFocusElementViewXCoord = Math.floor(focusElementIndex * prevViewTickWidth + prevViewTickWidth * 0.5);
                        var prevFocusElementViewXCoordInScreen = prevFocusElementViewXCoord - prevViewStartXCoord;
                        var timeScaleElements = timeScale.getTimeScaleElements();
                        if (focusElementIndex != null && timeScaleElements != null) {
                            var timeScaleElement = timeScaleElements[focusElementIndex];
                            var viewXCoord = timeScaleElement.viewXCoord;
                            newViewStartXCoord = viewXCoord - prevFocusElementViewXCoordInScreen;
                        }
                    }
                }
                if (newViewStartXCoord == null) {
                    if (this.viewZoomingAlignMode === CscApi.ViewAlignMode.LEFT) {
                        this.viewStartXCoord = 0;
                        var timeScaleElements = timeScale.getTimeScaleElements();
                        if (prevViewStartTickIndex != null) {
                            var timeScaleElement = timeScaleElements[prevViewStartTickIndex];
                            if (timeScaleElement) {
                                newViewStartXCoord = timeScaleElement.viewXLeftCoord;
                            }
                        }
                    }
                    else {
                        this.viewStartXCoord = this.viewMaxStartXCoord;
                        var prevViewEndTickIndex = prevViewStartTickIndex != null && prevViewNumberOfTicks != null ? prevViewStartTickIndex + prevViewNumberOfTicks - 1 : null;
                        if (prevViewEndTickIndex != null) {
                            var timeScaleElements = timeScale.getTimeScaleElements();
                            var timeScaleElement = timeScaleElements[prevViewEndTickIndex];
                            if (timeScaleElement) {
                                var viewXCoord = timeScaleElement.viewXLeftCoord;
                                newViewStartXCoord = viewXCoord - this.width;
                            }
                        }
                    }
                }
                if (newViewStartXCoord != null) {
                    this.viewStartXCoord = newViewStartXCoord;
                }
            }
            if (this.viewStartXCoord == null) {
                this.viewStartXCoord = this.viewMaxStartXCoord;
            }
            else if (this.viewStartXCoord < -this.viewPaddingLeft) {
                this.viewStartXCoord = -this.viewPaddingLeft;
            }
            else if (this.viewStartXCoord > this.viewMaxStartXCoord) {
                this.viewStartXCoord = this.viewMaxStartXCoord;
            }
            var viewStartTickIndex = timeScale.getTickIndexFromX(this.viewStartXCoord);
            var viewEndTickIndex = timeScale.getTickIndexFromX(this.viewStartXCoord + width);
            if (viewStartTickIndex < 0) {
                viewStartTickIndex = 0;
            }
            var orderedTickList = this.getContext().getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            if (viewEndTickIndex > numberOfOrderedTickList) {
                viewEndTickIndex = numberOfOrderedTickList - 1;
            }
            this.viewStartTickIndex = viewStartTickIndex;
            this.viewNumberOfTicks = viewEndTickIndex - viewStartTickIndex + 1;
            if (false == this.viewIsDirty) {
                if (viewStartTickIndex !== prevViewStartTickIndex || this.viewNumberOfTicks !== prevViewNumberOfTicks) {
                    this.viewIsDirty = true;
                }
            }
        };
        Area.prototype.drawVerticalGrids = function (timeScale) {
            var candlestickChart = this.candlestickChart;
            var timeScaleElementList = timeScale.getTimeScaleElements();
            var renderer = candlestickChart.getRenderer();
            var style = candlestickChart.getStyle();
            var viewStartTickIndex = this.getViewStartTickIndex();
            var viewEndTickIndex = this.getViewEndTickIndex();
            var viewStartXCoord = this.getViewStartXCoord();
            renderer.translate(-viewStartXCoord, 0);
            var prevSpanType = null;
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var tickScaleElement = timeScaleElementList[i];
                var spanType = tickScaleElement.spanType;
                if (null != spanType) {
                    var xCoord = tickScaleElement.viewXCoord;
                    if (prevSpanType != spanType) {
                        renderer.setStrokeColorRgb(style.getTimeScaleGridLineColorRgba(spanType));
                        renderer.setLineWidth(style.getTimeScaleGridLineWidth(spanType));
                        prevSpanType = spanType;
                    }
                    renderer.strokeLine(xCoord, 0, xCoord, this.height);
                }
            }
            renderer.translate(viewStartXCoord, 0);
        };
        ;
        Area.prototype.drawHorizontalGrids = function (renderer, chart, viewYScale) {
            var style = this.candlestickChart.getStyle();
            renderer.setStrokeColorRgba(style.getValueScaleGridLineColorRgba());
            var width = chart.getWidth();
            var numberOfYScales = viewYScale.length;
            for (var i = 0; i < numberOfYScales; ++i) {
                var yScale = viewYScale[i];
                var yCoord = yScale.yCoord;
                renderer.strokeLine(0, yCoord, width, yCoord);
            }
        };
        Area.prototype._setupFontStyleForChartYScaleRendering = function (renderer, chart) {
            renderer.setTextAlignToLeft();
            renderer.setTextBaseLineToMiddle();
            renderer.setTextFontSize(chart.getStyleValueScaleFontSize());
            renderer.setTextFontName(chart.getStyleValueScaleFontName());
            renderer.setTextFontBold(chart.getStyleValueScaleFontBold());
            renderer.setFillColorRgba(chart.getStyleValueScaleFontColorRgba());
        };
        Area.prototype.drawYScale = function (renderer, chart, viewYScale, xOffset) {
            var style = this.candlestickChart.getStyle();
            var x = xOffset + Y_AXIS_TEXT_POSITION;
            renderer.translate(x, 0);
            this._setupFontStyleForChartYScaleRendering(renderer, chart);
            var decimalDigits = chart.getDecimalDigits();
            for (var i in viewYScale) {
                var yScale = viewYScale[i];
                renderer.fillText(yScale.value.toFixed(decimalDigits), 0, yScale.yCoord);
            }
            renderer.translate(-x, 0);
        };
        ;
        Area.prototype.getYScaleValuesWidth = function () {
            var candlestickChart = this.candlestickChart;
            var renderer = candlestickChart.getRenderer();
            var chartContexts = this.chartContexts;
            var viewYScales = this.viewYScales;
            var finalYScaleWidth = 0;
            for (var handleId in viewYScales) {
                var viewYScale = viewYScales[handleId];
                var chartContext = chartContexts[handleId];
                if (chartContext == null) {
                    continue;
                }
                var chart = chartContext.chart;
                var decimalDigits = chart.getDecimalDigits();
                this._setupFontStyleForChartYScaleRendering(renderer, chart);
                for (var i in viewYScale) {
                    var yScale = viewYScale[i];
                    var valueStr = yScale.value.toFixed(decimalDigits);
                    var width = renderer.getTextWidth(valueStr);
                    if (width > finalYScaleWidth) {
                        finalYScaleWidth = width;
                    }
                }
            }
            return finalYScaleWidth;
        };
        Area.prototype.renderYScaleValues = function (xOffset) {
            var candlestickChart = this.candlestickChart;
            var style = candlestickChart.getStyle();
            var renderer = candlestickChart.getRenderer();
            var chartContexts = this.chartContexts;
            var viewYScales = this.viewYScales;
            for (var handleId in viewYScales) {
                var viewYScale = viewYScales[handleId];
                var chartContext = chartContexts[handleId];
                if (chartContext != null) {
                    var chart = chartContext.chart;
                    this.drawYScale(renderer, chart, viewYScale, xOffset);
                }
            }
        };
        return Area;
    })();
    CscImpl.Area = Area;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfDmi = (function (_super) {
        __extends(ChartOfDmi, _super);
        function ChartOfDmi(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.DMI, area, handleId, width, height, DECIMAL_DIGITS, 'DMI');
            this.elementTrList = null;
            this.elementDxList = null;
            this.elementDmpList = null;
            this.elementDmnList = null;
            this.elementDipList = null;
            this.elementDinList = null;
            this.elementAdxList = null;
            this.elementAdxrList = null;
            this.elementViewDmipDragon = null;
            this.elementViewDminDragon = null;
            this.elementViewAdxDragon = null;
            this.elementViewAdxrDragon = null;
            this.setArgDirty(true);
        }
        ChartOfDmi.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configDmipLineWidth = config.params['dmipLineWidth'];
            var configDmipLineColorRgba = config.params['dmipLineColorRgba'];
            var configDminLineWidth = config.params['dminLineWidth'];
            var configDminLineColorRgba = config.params['dminLineColorRgba'];
            var configAdxLineWidth = config.params['adxLineWidth'];
            var configAdxLineColorRgba = config.params['adxLineColorRgba'];
            var configAdxrLineWidth = config.params['adxrLineWidth'];
            var configAdxrLineColorRgba = config.params['adxrLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleDmipLineWidth = configDmipLineWidth.value;
            this.styleDmipLineColorRgba = configDmipLineColorRgba.value;
            this.styleDminLineWidth = configDminLineWidth.value;
            this.styleDminLineColorRgba = configDminLineColorRgba.value;
            this.styleAdxLineWidth = configAdxLineWidth.value;
            this.styleAdxLineColorRgba = configAdxLineColorRgba.value;
            this.styleAdxrLineWidth = configAdxrLineWidth.value;
            this.styleAdxrLineColorRgba = configAdxrLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfDmi.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfDmi.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfDmi.prototype.getStyleDmipLineWidth = function () {
            return this.styleDmipLineWidth;
        };
        ChartOfDmi.prototype.setStyleDmipLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleDmipLineWidth = lineWidth;
            this.config.params['dmipLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfDmi.prototype.getStyleDmipLineColorRgba = function () {
            return this.styleDmipLineColorRgba;
        };
        ChartOfDmi.prototype.setStyleDmipLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleDmipLineColorRgba = colorRgba;
            this.config.params['dmipLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfDmi.prototype.getStyleDminLineWidth = function () {
            return this.styleDminLineWidth;
        };
        ChartOfDmi.prototype.setStyleDminLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleDminLineWidth = lineWidth;
            this.config.params['dminLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfDmi.prototype.getStyleDminLineColorRgba = function () {
            return this.styleDminLineColorRgba;
        };
        ChartOfDmi.prototype.setStyleDminLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleDminLineColorRgba = colorRgba;
            this.config.params['dminLineColor'].value = colorRgba;
            return true;
        };
        ChartOfDmi.prototype.getStyleAdxLineWidth = function () {
            return this.styleAdxLineWidth;
        };
        ChartOfDmi.prototype.setStyleAdxLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleAdxLineWidth = lineWidth;
            this.config.params['adxLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfDmi.prototype.getStyleAdxLineColorRgba = function () {
            return this.styleAdxLineColorRgba;
        };
        ChartOfDmi.prototype.setStyleAdxLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleAdxLineColorRgba = colorRgba;
            this.config.params['adxLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfDmi.prototype.getStyleAdxrLineWidth = function () {
            return this.styleAdxrLineWidth;
        };
        ChartOfDmi.prototype.setStyleAdxrLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleAdxrLineWidth = lineWidth;
            this.config.params['adxrLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfDmi.prototype.getStyleAdxrLineColorRgba = function () {
            return this.styleAdxrLineColorRgba;
        };
        ChartOfDmi.prototype.setStyleAdxrLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleAdxrLineColorRgba = colorRgba;
            this.config.params['adxrLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfDmi.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementDipList.length) {
                return this.elementDipList[index];
            }
            return null;
        };
        ChartOfDmi.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewDmipDragon == null || this.elementViewDmipDragon.length !== numberOfDragonComponents) {
                this.elementViewDmipDragon = CscApi.Utility.resizeFloat32Array(this.elementViewDmipDragon, numberOfDragonComponents);
            }
            if (this.elementViewDminDragon == null || this.elementViewDminDragon.length !== numberOfDragonComponents) {
                this.elementViewDminDragon = CscApi.Utility.resizeFloat32Array(this.elementViewDminDragon, numberOfDragonComponents);
            }
            if (this.elementViewAdxDragon == null || this.elementViewAdxDragon.length !== numberOfDragonComponents) {
                this.elementViewAdxDragon = CscApi.Utility.resizeFloat32Array(this.elementViewAdxDragon, numberOfDragonComponents);
            }
            if (this.elementViewAdxrDragon == null || this.elementViewAdxrDragon.length !== numberOfDragonComponents) {
                this.elementViewAdxrDragon = CscApi.Utility.resizeFloat32Array(this.elementViewAdxrDragon, numberOfDragonComponents);
            }
            if (this.elementTrList == null || this.elementTrList.length !== numberOfOrderedTickList) {
                this.elementTrList = CscApi.Utility.resizeFloat32Array(this.elementTrList, numberOfOrderedTickList);
            }
            if (this.elementDxList == null || this.elementDxList.length !== numberOfOrderedTickList) {
                this.elementDxList = CscApi.Utility.resizeFloat32Array(this.elementDxList, numberOfOrderedTickList);
            }
            if (this.elementDmpList == null || this.elementDmpList.length !== numberOfOrderedTickList) {
                this.elementDmpList = CscApi.Utility.resizeFloat32Array(this.elementDmpList, numberOfOrderedTickList);
            }
            if (this.elementDmnList == null || this.elementDmnList.length !== numberOfOrderedTickList) {
                this.elementDmnList = CscApi.Utility.resizeFloat32Array(this.elementDmnList, numberOfOrderedTickList);
            }
            if (this.elementDipList == null || this.elementDipList.length !== numberOfOrderedTickList) {
                this.elementDipList = CscApi.Utility.resizeFloat32Array(this.elementDipList, numberOfOrderedTickList);
            }
            if (this.elementDinList == null || this.elementDinList.length !== numberOfOrderedTickList) {
                this.elementDinList = CscApi.Utility.resizeFloat32Array(this.elementDinList, numberOfOrderedTickList);
            }
            if (this.elementAdxList == null || this.elementAdxList.length !== numberOfOrderedTickList) {
                this.elementAdxList = CscApi.Utility.resizeFloat32Array(this.elementAdxList, numberOfOrderedTickList);
            }
            if (this.elementAdxrList == null || this.elementAdxrList.length !== numberOfOrderedTickList) {
                this.elementAdxrList = CscApi.Utility.resizeFloat32Array(this.elementAdxrList, numberOfOrderedTickList);
            }
            var elementTrList = this.elementTrList;
            var elementDxList = this.elementDxList;
            var elementDmpList = this.elementDmpList;
            var elementDmnList = this.elementDmnList;
            var elementDipList = this.elementDipList;
            var elementDinList = this.elementDinList;
            var elementAdxList = this.elementAdxList;
            var elementAdxrList = this.elementAdxrList;
            var period = this.argPeriod;
            var sumTr = 0;
            var sumDx = 0;
            var sumDmp = 0;
            var sumDmn = 0;
            var sumAdx = 0;
            if (numberOfOrderedTickList > 0) {
                var tickData = orderedTickList[0];
                elementTrList[0] = tickData.getHigh() - tickData.getLow();
                elementDxList[0] = elementDmpList[0] = elementDmnList[0] = 0;
                elementDipList[0] = elementDinList[0] = elementAdxList[0] = elementAdxrList[0] = NaN;
            }
            for (var i = 1; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var prevTickData = orderedTickList[i - 1];
                var prevClose = prevTickData.getClose();
                elementDxList[i] = 0;
                elementAdxList[i] = 0;
                var tr = elementTrList[i] = Math.max(tickData.getHigh(), prevClose) - Math.min(tickData.getLow(), prevClose);
                var dmp = Math.max(0, tickData.getHigh() - prevTickData.getHigh());
                var dmn = Math.max(0, prevTickData.getLow() - tickData.getLow());
                dmp = (dmp > dmn) ? dmp : 0;
                dmn = (dmn > dmp) ? dmn : 0;
                elementDmpList[i] = dmp;
                elementDmnList[i] = dmn;
                sumTr += tr;
                sumDmp += dmp;
                sumDmn += dmn;
                if (i < period) {
                    elementDipList[i] = elementDinList[i] = elementAdxList[i] = elementAdxrList[i] = NaN;
                    continue;
                }
                var bi = i - period;
                sumTr -= elementTrList[bi];
                sumDmp -= elementDmpList[bi];
                sumDmn -= elementDmnList[bi];
                var dip = Math.max(0, 100 * sumDmp / sumTr);
                var din = Math.max(0, 100 * sumDmn / sumTr);
                elementDipList[i] = dip;
                elementDinList[i] = din;
                var dx = elementDxList[i] = 100 * Math.abs(dip - din) / (dip + din);
                sumDx += dx;
                if (i < period * 2) {
                    elementAdxList[i] = elementAdxrList[i] = NaN;
                    continue;
                }
                sumDx -= elementDxList[bi];
                var adx = elementAdxList[i] = sumDx / period;
                sumAdx += adx;
                if (i < period * 3) {
                    elementAdxrList[i] = NaN;
                    continue;
                }
                sumAdx -= elementAdxList[bi];
                elementAdxrList[i] = sumAdx / period;
            }
        };
        ChartOfDmi.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementDmipList = this.elementDipList;
            var elementDminList = this.elementDinList;
            var elementAdxList = this.elementAdxList;
            var elementAdxrList = this.elementAdxrList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var dmip = elementDmipList[vi];
                var dmin = elementDminList[vi];
                var adx = elementAdxList[vi];
                var adxr = elementAdxrList[vi];
                if (false == isNaN(dmip)) {
                    if (dmip > highestValue)
                        highestValue = dmip;
                    if (dmip < lowestValue)
                        lowestValue = dmip;
                }
                if (false == isNaN(dmin)) {
                    if (dmin > highestValue)
                        highestValue = dmin;
                    if (dmin < lowestValue)
                        lowestValue = dmin;
                }
                if (false == isNaN(adx)) {
                    if (adx > highestValue)
                        highestValue = adx;
                    if (adx < lowestValue)
                        lowestValue = adx;
                }
                if (false == isNaN(adxr)) {
                    if (adxr > highestValue)
                        highestValue = adxr;
                    if (adxr < lowestValue)
                        lowestValue = adxr;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfDmi.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementDmipList = this.elementDipList;
            var elementDminList = this.elementDinList;
            var elementAdxList = this.elementAdxList;
            var elementAdxrList = this.elementAdxrList;
            var elementViewDmipDragon = this.elementViewDmipDragon;
            var elementViewDminDragon = this.elementViewDminDragon;
            var elementViewAdxDragon = this.elementViewAdxDragon;
            var elementViewAdxrDragon = this.elementViewAdxrDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementDmipList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var dmip = elementDmipList[i];
                var dmin = elementDminList[i];
                var adx = elementAdxList[i];
                var adxr = elementAdxrList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewDmipDragon[vi] = viewXCoord;
                elementViewDmipDragon[vyi] = isNaN(dmip) ? NaN : Math.floor(valueToYCoordConvertor(dmip));
                elementViewDminDragon[vi] = viewXCoord;
                elementViewDminDragon[vyi] = isNaN(dmin) ? NaN : Math.floor(valueToYCoordConvertor(dmin));
                elementViewAdxDragon[vi] = viewXCoord;
                elementViewAdxDragon[vyi] = isNaN(adx) ? NaN : Math.floor(valueToYCoordConvertor(adx));
                elementViewAdxrDragon[vi] = viewXCoord;
                elementViewAdxrDragon[vyi] = isNaN(adxr) ? NaN : Math.floor(valueToYCoordConvertor(adxr));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfDmi.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementDipList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                renderer.setLineWidth(Math.floor(Math.min(this.styleDmipLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleDmipLineColorRgba);
                this.drawDragon(this.elementViewDmipDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleDminLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleDminLineColorRgba);
                this.drawDragon(this.elementViewDminDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleAdxLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleAdxLineColorRgba);
                this.drawDragon(this.elementViewAdxDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleAdxrLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleAdxrLineColorRgba);
                this.drawDragon(this.elementViewAdxrDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfDmi.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var dmip = this.elementDipList[focusElementIndex];
                var dmin = this.elementDinList[focusElementIndex];
                var adx = this.elementAdxList[focusElementIndex];
                var adxr = this.elementAdxrList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(dmip))
                    valueInfoList.push({ name: 'DMI+', value: dmip.toFixed(DECIMAL_DIGITS), valueColor: this.styleDmipLineColorRgba });
                if (false === isNaN(dmin))
                    valueInfoList.push({ name: 'DMI-', value: dmin.toFixed(DECIMAL_DIGITS), valueColor: this.styleDminLineColorRgba });
                if (false === isNaN(adx))
                    valueInfoList.push({ name: 'ADX', value: adx.toFixed(DECIMAL_DIGITS), valueColor: this.styleDmipLineColorRgba });
                if (false === isNaN(adxr))
                    valueInfoList.push({ name: 'ADXR', value: adxr.toFixed(DECIMAL_DIGITS), valueColor: this.styleDminLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfDmi;
    })(CscImpl.Chart);
    CscImpl.ChartOfDmi = ChartOfDmi;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfBollingerBand = (function (_super) {
        __extends(ChartOfBollingerBand, _super);
        function ChartOfBollingerBand(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.BOLLINGER_BAND, area, handleId, width, height, DECIMAL_DIGITS, 'Bollinger Band');
            this.elementMaList = null;
            this.elementDiffSquareList = null;
            this.elementUpperList = null;
            this.elementLowerList = null;
            this.elementViewRangeFilledPolygon = null;
            this.elementViewUpperDragon = null;
            this.elementViewLowerDragon = null;
        }
        ChartOfBollingerBand.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configK = config.params['k'];
            var configLineWidth = config.params['lineWidth'];
            var configLineColorRgba = config.params['lineColorRgba'];
            var configFillColorRgba = config.params['fillColorRgba'];
            this.argPeriod = configPeriod.value;
            this.argK = configK.value;
            this.styleLineWidth = configLineWidth.value;
            this.styleLineColorRgba = configLineColorRgba.value;
            this.styleFillColorRgba = configFillColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBollingerBand.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfBollingerBand.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBollingerBand.prototype.getArgK = function () {
            return this.argK;
        };
        ChartOfBollingerBand.prototype.setArgK = function (period) {
            this.argK = period;
            this.config.params['k'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBollingerBand.prototype.getStyleLineWidth = function () {
            return this.styleLineWidth;
        };
        ChartOfBollingerBand.prototype.setStyleLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleLineWidth = lineWidth;
            this.config.params['lineWidth'].value = lineWidth;
            return true;
        };
        ChartOfBollingerBand.prototype.getStyleLineColorRgba = function () {
            return this.styleLineColorRgba;
        };
        ChartOfBollingerBand.prototype.setStyleLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleLineColorRgba = colorRgba;
            this.config.params['lineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfBollingerBand.prototype.getStyleFillColorRgba = function () {
            return this.styleFillColorRgba;
        };
        ChartOfBollingerBand.prototype.setStyleFillColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleFillColorRgba = colorRgba;
            this.config.params['fillColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfBollingerBand.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementUpperList.length) {
                return this.elementUpperList[index];
            }
            return null;
        };
        ChartOfBollingerBand.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewLowerDragon == null || this.elementViewLowerDragon.length !== numberOfDragonComponents) {
                this.elementViewLowerDragon = CscApi.Utility.resizeFloat32Array(this.elementViewLowerDragon, numberOfDragonComponents);
            }
            if (this.elementViewUpperDragon == null || this.elementViewUpperDragon.length !== numberOfDragonComponents) {
                this.elementViewUpperDragon = CscApi.Utility.resizeFloat32Array(this.elementViewUpperDragon, numberOfDragonComponents);
            }
            if (this.elementMaList == null || this.elementMaList.length !== numberOfOrderedTickList) {
                this.elementMaList = CscApi.Utility.resizeFloat32Array(this.elementMaList, numberOfOrderedTickList);
            }
            if (this.elementDiffSquareList == null || this.elementDiffSquareList.length !== numberOfOrderedTickList) {
                this.elementDiffSquareList = CscApi.Utility.resizeFloat32Array(this.elementDiffSquareList, numberOfOrderedTickList);
            }
            if (this.elementLowerList == null || this.elementLowerList.length !== numberOfOrderedTickList) {
                this.elementLowerList = CscApi.Utility.resizeFloat32Array(this.elementLowerList, numberOfOrderedTickList);
            }
            if (this.elementUpperList == null || this.elementUpperList.length !== numberOfOrderedTickList) {
                this.elementUpperList = CscApi.Utility.resizeFloat32Array(this.elementUpperList, numberOfOrderedTickList);
            }
            var elementMaList = this.elementMaList;
            var elementDiffSquareList = this.elementDiffSquareList;
            var elementLowerList = this.elementLowerList;
            var elementUpperList = this.elementUpperList;
            var period = this.argPeriod;
            var k = this.argK;
            var periodSumMa = 0;
            var periodSumDiffSquare = 0;
            this.elementDiffSquareList[0] = 0;
            this.elementMaList[0] = this.elementLowerList[0] = this.elementUpperList[0] = NaN;
            for (var i = 1; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var pi = i - 1;
                var prevTickData = orderedTickList[pi];
                periodSumMa += prevTickData.getClose();
                periodSumDiffSquare += elementDiffSquareList[pi];
                var p = i < period ? i : period;
                var sd = Math.sqrt(periodSumDiffSquare / p);
                var ma = periodSumMa / p;
                var ksd = k * sd;
                elementMaList[i] = ma;
                elementLowerList[i] = ma - ksd;
                elementUpperList[i] = ma + ksd;
                var diff = tickData.getClose() - ma;
                elementDiffSquareList[i] = diff * diff;
                if (i >= period) {
                    var bi = i - period;
                    periodSumMa -= orderedTickList[bi].getClose();
                    periodSumDiffSquare -= elementDiffSquareList[bi];
                }
            }
        };
        ChartOfBollingerBand.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementLowerList = this.elementLowerList;
            var elementUpperList = this.elementUpperList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var lower = elementLowerList[vi];
                var upper = elementUpperList[vi];
                if (false == isNaN(lower)) {
                    if (lower > highestValue)
                        highestValue = lower;
                    if (lower < lowestValue)
                        lowestValue = lower;
                }
                if (false == isNaN(upper)) {
                    if (upper > highestValue)
                        highestValue = upper;
                    if (upper < lowestValue)
                        lowestValue = upper;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfBollingerBand.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementLowerList = this.elementLowerList;
            var elementUpperList = this.elementUpperList;
            var elementViewLowerDragon = this.elementViewLowerDragon;
            var elementViewUpperDragon = this.elementViewUpperDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementUpperList.length - 1) {
                viewEndTickIndex++;
            }
            var viewRangeFilledPolygonIndex = 0;
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var lower = elementLowerList[i];
                var upper = elementUpperList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewLowerDragon[vi] = viewXCoord;
                elementViewLowerDragon[vyi] = isNaN(lower) ? NaN : Math.floor(valueToYCoordConvertor(lower));
                elementViewUpperDragon[vi] = viewXCoord;
                elementViewUpperDragon[vyi] = isNaN(upper) ? NaN : Math.floor(valueToYCoordConvertor(upper));
            }
            var firstPointIndex = viewStartTickIndex >= 1 ? viewStartTickIndex : 1;
            var numberOfTicksInViewRange = viewEndTickIndex - firstPointIndex + 1;
            var numberOfComponents = numberOfTicksInViewRange * 4;
            if (this.elementViewRangeFilledPolygon == null || this.elementViewRangeFilledPolygon.length !== numberOfComponents) {
                this.elementViewRangeFilledPolygon = CscApi.Utility.resizeFloat32Array(this.elementViewRangeFilledPolygon, numberOfComponents);
            }
            var elementViewRangeFilledPolygon = this.elementViewRangeFilledPolygon;
            var viewRangeFilledPolygonIndex = 0;
            for (var i = firstPointIndex; i <= viewEndTickIndex; ++i) {
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewRangeFilledPolygon[viewRangeFilledPolygonIndex++] = elementViewLowerDragon[vi];
                elementViewRangeFilledPolygon[viewRangeFilledPolygonIndex++] = elementViewLowerDragon[vyi];
            }
            for (var i = viewEndTickIndex; i >= firstPointIndex; --i) {
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewRangeFilledPolygon[viewRangeFilledPolygonIndex++] = elementViewUpperDragon[vi];
                elementViewRangeFilledPolygon[viewRangeFilledPolygonIndex++] = elementViewUpperDragon[vyi];
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfBollingerBand.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementUpperList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= 1 ? viewStartTickIndex : 1;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setFillColorRgba(this.styleFillColorRgba);
                renderer.fillPolygon(this.elementViewRangeFilledPolygon);
                renderer.setLineWidth(Math.floor(Math.min(this.styleLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleLineColorRgba);
                this.drawDragon(this.elementViewLowerDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleLineColorRgba);
                this.drawDragon(this.elementViewUpperDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfBollingerBand.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var ma = this.elementMaList[focusElementIndex];
                var lower = this.elementLowerList[focusElementIndex];
                var upper = this.elementUpperList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                    { name: 'K', value: this.argK.toString(), valueColor: null },
                ];
                if (false === isNaN(ma))
                    valueInfoList.push({ name: 'MA', value: ma.toFixed(DECIMAL_DIGITS), valueColor: null });
                if (false === isNaN(lower))
                    valueInfoList.push({ name: 'L', value: lower.toFixed(DECIMAL_DIGITS), valueColor: null });
                if (false === isNaN(upper))
                    valueInfoList.push({ name: 'U', value: upper.toFixed(DECIMAL_DIGITS), valueColor: null });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfBollingerBand;
    })(CscImpl.Chart);
    CscImpl.ChartOfBollingerBand = ChartOfBollingerBand;
})(CscImpl || (CscImpl = {}));
/// <reference path="../../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var LANG_UNKNOWN_STRING = CscApi.LANG_UNKNOWN_STRING;
    var LangOfZhTw = (function () {
        function LangOfZhTw() {
        }
        LangOfZhTw.prototype.getChartOhlcBarType = function (barType) {
            switch (barType) {
                case CscApi.OhlcBarType.BAR: return 'BAR';
                case CscApi.OhlcBarType.CANDLESTICK: return '蠟燭圖';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype.getChartName = function (chartType) {
            switch (chartType) {
                case CscApi.ChartType.AO: return 'AO';
                case CscApi.ChartType.ARBR: return 'ARBR';
                case CscApi.ChartType.ATR: return 'ATR';
                case CscApi.ChartType.BIAS: return 'BIAS';
                case CscApi.ChartType.BIAS_AB: return 'A-B BIAS';
                case CscApi.ChartType.BOLLINGER_BAND: return 'Bollinger Band';
                case CscApi.ChartType.CCI: return 'CCI';
                case CscApi.ChartType.DMI: return 'DMI';
                case CscApi.ChartType.KDJ: return 'KDJ';
                case CscApi.ChartType.MA: return 'MA';
                case CscApi.ChartType.MACD: return 'MACD';
                case CscApi.ChartType.MTM: return 'MTM';
                case CscApi.ChartType.OBV: return 'OBV';
                case CscApi.ChartType.OHLC: return 'OHLC';
                case CscApi.ChartType.PSY: return 'PSY';
                case CscApi.ChartType.ROC: return 'ROC';
                case CscApi.ChartType.RSI: return 'RSI';
                case CscApi.ChartType.RSI_SMOOTH: return 'RSI Smooth';
                case CscApi.ChartType.TIME_SCALE: return 'Time Scale';
                case CscApi.ChartType.VOLUME: return 'Volume';
                case CscApi.ChartType.VR: return 'VR';
                case CscApi.ChartType.WR: return 'WR';
                case CscApi.ChartType.OSMA: return 'OSMA';
                case CscApi.ChartType.SAR: return 'SAR';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype.getChartCaption = function (chartType) {
            switch (chartType) {
                case CscApi.ChartType.AO: return '動量震動指標';
                case CscApi.ChartType.ARBR: return '人氣意願指標';
                case CscApi.ChartType.ATR: return '真實波動幅值均值';
                case CscApi.ChartType.BIAS: return '乖離率';
                case CscApi.ChartType.BIAS_AB: return 'A-B乖離率';
                case CscApi.ChartType.BOLLINGER_BAND: return '布林通道';
                case CscApi.ChartType.CCI: return '順勢指標';
                case CscApi.ChartType.DMI: return '動向指標';
                case CscApi.ChartType.KDJ: return '隨機震盪指標';
                case CscApi.ChartType.MA: return '移動平均';
                case CscApi.ChartType.MACD: return '平滑異動移動平均線';
                case CscApi.ChartType.MTM: return '動量指標';
                case CscApi.ChartType.OBV: return '能量潮';
                case CscApi.ChartType.OHLC: return '市場開高收低價格';
                case CscApi.ChartType.PSY: return '心理線指標';
                case CscApi.ChartType.ROC: return '變動數率指標';
                case CscApi.ChartType.RSI: return '相對強弱指標';
                case CscApi.ChartType.RSI_SMOOTH: return '平滑相對強弱指標';
                case CscApi.ChartType.TIME_SCALE: return '時間軸';
                case CscApi.ChartType.VOLUME: return '交易量';
                case CscApi.ChartType.VR: return '容量指標';
                case CscApi.ChartType.WR: return '威廉R指標';
                case CscApi.ChartType.OSMA: return '移動振動平均震盪器指標';
                case CscApi.ChartType.SAR: return '停損點轉向操作系統';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype.getChartParamName = function (chartType, paramName) {
            switch (chartType) {
                case CscApi.ChartType.AO: return this._getChartParamNameOfAo(paramName);
                case CscApi.ChartType.ARBR: return this._getChartParamNameOfArBr(paramName);
                case CscApi.ChartType.ATR: return this._getChartParamNameOfAtr(paramName);
                case CscApi.ChartType.BIAS: return this._getChartParamNameOfBias(paramName);
                case CscApi.ChartType.BIAS_AB: return this._getChartParamNameOfBiasAB(paramName);
                case CscApi.ChartType.BOLLINGER_BAND: return this._getChartParamNameOfBollingerBand(paramName);
                case CscApi.ChartType.CCI: return this._getChartParamNameOfCci(paramName);
                case CscApi.ChartType.DMI: return this._getChartParamNameOfDmi(paramName);
                case CscApi.ChartType.KDJ: return this._getChartParamNameOfKdj(paramName);
                case CscApi.ChartType.MA: return this._getChartParamNameOfMa(paramName);
                case CscApi.ChartType.MACD: return this._getChartParamNameOfMacd(paramName);
                case CscApi.ChartType.MTM: return this._getChartParamNameOfMtm(paramName);
                case CscApi.ChartType.OBV: return this._getChartParamNameOfObv(paramName);
                case CscApi.ChartType.OHLC: return this._getChartParamNameOfOhlc(paramName);
                case CscApi.ChartType.PSY: return this._getChartParamNameOfPsy(paramName);
                case CscApi.ChartType.ROC: return this._getChartParamNameOfRoc(paramName);
                case CscApi.ChartType.RSI: return this._getChartParamNameOfRsi(paramName);
                case CscApi.ChartType.RSI_SMOOTH: return this._getChartParamNameOfRsiSmooth(paramName);
                case CscApi.ChartType.TIME_SCALE: return this._getChartParamNameOfTimeScale(paramName);
                case CscApi.ChartType.VOLUME: return this._getChartParamNameOfVolume(paramName);
                case CscApi.ChartType.VR: return this._getChartParamNameOfVr(paramName);
                case CscApi.ChartType.WR: return this._getChartParamNameOfWr(paramName);
                case CscApi.ChartType.OSMA: return this._getChartParamNameOfOsMa(paramName);
                case CscApi.ChartType.SAR: return this._getChartParamNameOfSar(paramName);
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getChartParamNameOfAo = function (paramName) {
            switch (paramName) {
                case 'shortPeriod': return '短週期';
                case 'longPeriod': return '長週期';
                case 'positiveColorRgba': return '資量色彩';
                case 'negativeColorRgba': return '減量色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfArBr = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'arLineWidth': return 'AR線寬度';
                case 'arLineColorRgba': return 'AR線色彩';
                case 'brLineWidth': return 'BR線寬度';
                case 'brLineColorRgba': return 'BR線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfAtr = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'atrLineWidth': return 'ATR線寬度';
                case 'atrLineColorRgba': return 'ATR線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfBias = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'biasLineWidth': return 'BIAS線寬度';
                case 'biasLineColorRgba': return 'BIAS線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfBiasAB = function (paramName) {
            switch (paramName) {
                case 'shortPeriod': return '短週期(A)';
                case 'longPeriod': return '長週期(B)';
                case 'biasLineWidth': return 'BIAS線寬度';
                case 'biasLineColorRgba': return 'BIAS線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfBollingerBand = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'k': return '標準差倍數(K值)';
                case 'lineWidth': return '通道邊線寬度';
                case 'lineColorRgba': return '通道邊線色彩';
                case 'fillColorRgba': return '通道填充色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfCci = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'cciLineWidth': return 'CCI線寬度';
                case 'cciLineColorRgba': return 'CCI線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfDmi = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'dmipLineWidth': return 'DMI+線寬度';
                case 'dmipLineColorRgba': return 'DMI+線色彩';
                case 'dminLineWidth': return 'DMI-線寬度';
                case 'dminLineColorRgba': return 'DMI-線色彩';
                case 'adxLineWidth': return 'ADX線寬度';
                case 'adxLineColorRgba': return 'ADX線色彩';
                case 'adxrLineWidth': return 'ADXR線寬度';
                case 'adxrLineColorRgba': return 'ADXR線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfKdj = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'kLineWidth': return 'K線寬度';
                case 'kLineColorRgba': return 'K線色彩';
                case 'dLineWidth': return 'D線寬度';
                case 'dLineColorRgba': return 'D線色彩';
                case 'jLineWidth': return 'J線寬度';
                case 'jLineColorRgba': return 'J線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfMa = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'maLineWidth': return 'MA線寬度';
                case 'maLineColorRgba': return 'MA線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfMacd = function (paramName) {
            switch (paramName) {
                case 'shortPeriod': return '短週期';
                case 'longPeriod': return '長週期';
                case 'periodSignal': return '信號週期';
                case 'diffLineWidth': return 'DIFF線寬度';
                case 'diffLineColorRgba': return 'DIFF線色彩';
                case 'demLineWidth': return 'DEM線寬度';
                case 'demLineColorRgba': return 'DEM線色彩';
                case 'macdPositiveColorRgba': return 'MACD+色彩';
                case 'macdNegativeColorRgba': return 'MACD-色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfMtm = function (paramName) {
            switch (paramName) {
                case 'mtmPeriod': return 'MTM週期';
                case 'mtmMaPeriod': return 'MTM MA週期';
                case 'mtmLineWidth': return 'MTM線寬度';
                case 'mtmLineColorRgba': return 'MTM線色彩';
                case 'mtmMaLineWidth': return 'MTM MA線寬度';
                case 'mtmMaLineColorRgba': return 'MTM MA線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfObv = function (paramName) {
            switch (paramName) {
                case 'obvPeriod': return 'OBV週期';
                case 'obvMaPeriod': return 'OBV MA週期';
                case 'obvLineWidth': return 'OBV線寬度';
                case 'obvLineColorRgba': return 'OBV線色彩';
                case 'obvMaLineWidth': return 'OBV MA線寬度';
                case 'obvMaLineColorRgba': return 'OBV MA線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfOhlc = function (paramName) {
            switch (paramName) {
                case 'ohlcType': return '數據類型';
                case 'ohlcBarType': return '顯示類型';
                case 'candlestickRisingColorRgba': return '蠟燭圖上漲色彩';
                case 'candlestickFallingColorRgba': return '蠟燭圖下跌色彩';
                case 'barRisingColorRgba': return '線上漲色彩';
                case 'barFallingColorRgba': return '線下跌線寬度';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfPsy = function (paramName) {
            switch (paramName) {
                case 'psyPeriod': return 'PSY週期';
                case 'psyMaPeriod': return 'PSY MA週期';
                case 'psyLineWidth': return 'PSY線寬度';
                case 'psyLineColorRgba': return 'PSY線色彩';
                case 'psyMaLineWidth': return 'PSY MA線寬度';
                case 'psyMaLineColorRgba': return 'PSY MA線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfRoc = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'rocLineWidth': return 'ROC線寬度';
                case 'rocLineColorRgba': return 'ROC線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfRsi = function (paramName) {
            switch (paramName) {
                case 'shortPeriod': return '短週期';
                case 'longPeriod': return '長週期';
                case 'rsiShortLineWidth': return '短週期線寬度';
                case 'rsiShortLineColorRgba': return '短週期線色彩';
                case 'rsiLongLineWidth': return '長週期線寬度';
                case 'rsiLongLineColorRgba': return '長週期線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfRsiSmooth = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'rsiSmoothLineWidth': return '線寬度';
                case 'rsiSmoothLineColorRgba': return '線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfTimeScale = function (paramName) {
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfVolume = function (paramName) {
            switch (paramName) {
                case 'volumePoleColorRgba': return '色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfVr = function (paramName) {
            switch (paramName) {
                case 'vrPeriod': return 'VR週期';
                case 'vrMaPeriod': return 'VR MA週期';
                case 'vrLineWidth': return 'VR線寬度';
                case 'vrLineColorRgba': return 'VR線色彩';
                case 'vrMaLineWidth': return 'VR MA線寬度';
                case 'vrMaLineColorRgba': return 'VR MA線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfWr = function (paramName) {
            switch (paramName) {
                case 'period': return '週期';
                case 'wrLineWidth': return '線寬度';
                case 'wrLineColorRgba': return '線色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfOsMa = function (paramName) {
            switch (paramName) {
                case 'shortPeriod': return '短週期';
                case 'longPeriod': return '長週期';
                case 'periodSignal': return '信號週期';
                case 'macdPositiveColorRgba': return 'MACD+色彩';
                case 'macdNegativeColorRgba': return 'MACD-色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype._getChartParamNameOfSar = function (paramName) {
            switch (paramName) {
                case 'sarAfInit': return '初始加速因子';
                case 'sarAfStep': return '加速因子遞增值';
                case 'sarAfLimit': return '加速因子最大限制值';
                case 'sarDotSize': return '點大小';
                case 'sarDotColorRgba': return '點色彩';
            }
            return paramName;
        };
        LangOfZhTw.prototype.getChartParamEnum = function (chartType, paramName, value) {
            switch (chartType) {
                case CscApi.ChartType.OHLC: return this._getChartParamEnumOfOhlc(paramName, value);
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getChartParamEnumOfOhlc = function (paramName, value) {
            switch (paramName) {
                case 'ohlcType':
                    switch (value) {
                        case CscApi.OhlcBarType.BAR: return '原始數據';
                        case CscApi.OhlcBarType.CANDLESTICK: return 'Heikin-Ashi(平均足)';
                    }
                    break;
                case 'ohlcBarType':
                    switch (value) {
                        case CscApi.OhlcBarType.BAR: return 'OHLC線';
                        case CscApi.OhlcBarType.CANDLESTICK: return '蠟燭圖';
                    }
                    break;
            }
            return paramName;
        };
        LangOfZhTw.prototype.getDrawerCaption = function (drawerType) {
            switch (drawerType) {
                case CscApi.DrawerType.LINE: return '直線';
                case CscApi.DrawerType.HORIZONTAL_LINE: return '水平線';
                case CscApi.DrawerType.PRICE_TANGENT: return '價位切線';
                case CscApi.DrawerType.CHANNEL: return '通道線';
                case CscApi.DrawerType.GOLDEN_SECTION: return '黃金分割';
                case CscApi.DrawerType.GOLDEN_BANDS: return '黃金波段';
                case CscApi.DrawerType.GOLDEN_CIRCLE: return '黃金分割圓';
                case CscApi.DrawerType.GANN_FAN: return '甘式扇形';
                case CscApi.DrawerType.LINEAR_REGRESSION: return '線性回歸線';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype.getDrawerStepHint = function (drawerType, step) {
            switch (drawerType) {
                case CscApi.DrawerType.LINE: return this._getDrawerStepHintOfLine(step);
                case CscApi.DrawerType.HORIZONTAL_LINE: return this._getDrawerStepHintOfHorizontalLine(step);
                case CscApi.DrawerType.PRICE_TANGENT: return this._getDrawerStepHintOfPriceTangent(step);
                case CscApi.DrawerType.CHANNEL: return this._getDrawerStepHintOfChannel(step);
                case CscApi.DrawerType.GOLDEN_SECTION: return this._getDrawerStepHintOfGoldenSection(step);
                case CscApi.DrawerType.GOLDEN_BANDS: return this._getDrawerStepHintOfGoldenBands(step);
                case CscApi.DrawerType.GOLDEN_CIRCLE: return this._getDrawerStepHintOfGoldenCircle(step);
                case CscApi.DrawerType.GANN_FAN: return this._getDrawerStepHintOfGannFan(step);
                case CscApi.DrawerType.LINEAR_REGRESSION: return this._getDrawerStepHintOfLinearRegression(step);
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfLine = function (step) {
            switch (step) {
                case 0: return '請決定線段起點。';
                case 1: return '請決定線段終點。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfHorizontalLine = function (step) {
            switch (step) {
                case 0: return '請決定水平線的高度。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfPriceTangent = function (step) {
            switch (step) {
                case 0: return '請決定線段起點。';
                case 1: return '請決定線段終點。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfChannel = function (step) {
            switch (step) {
                case 0: return '請決第一條通道線線段起點。';
                case 1: return '請決第一條通道線線段終點。';
                case 2: return '請決第二條通道線線段的位置。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfGoldenSection = function (step) {
            switch (step) {
                case 0: return '請決第一條線段起點。';
                case 1: return '請決第一條線段終點。';
                case 2: return '請決第二條線段的位置。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfGoldenBands = function (step) {
            switch (step) {
                case 0: return '請決第一條線段起點。';
                case 1: return '請決第一條線段終點。';
                case 2: return '請決第二條線段的位置。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfGoldenCircle = function (step) {
            switch (step) {
                case 0: return '請決定黃金分割弧起點。';
                case 1: return '點擊決定黃金分割弧終點。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfGannFan = function (step) {
            switch (step) {
                case 0: return '請決定扇形線原點。';
                case 1: return '請決定1x1線的端點。';
            }
            return LANG_UNKNOWN_STRING;
        };
        LangOfZhTw.prototype._getDrawerStepHintOfLinearRegression = function (step) {
            switch (step) {
                case 0: return '請決定第一個點。';
                case 1: return '請決定第二個點。';
            }
            return LANG_UNKNOWN_STRING;
        };
        return LangOfZhTw;
    })();
    CscImpl.LangOfZhTw = LangOfZhTw;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfObv = (function (_super) {
        __extends(ChartOfObv, _super);
        function ChartOfObv(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.OBV, area, handleId, width, height, DECIMAL_DIGITS, 'OBV');
            this.elementVolList = null;
            this.elementObvList = null;
            this.elementObvMaList = null;
            this.elementViewObvDragon = null;
            this.elementViewObvMaDragon = null;
        }
        ChartOfObv.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configObvPeriod = config.params['obvPeriod'];
            var configObvMaPeriod = config.params['obvMaPeriod'];
            var configObvLineWidth = config.params['obvLineWidth'];
            var configObvLineColorRgba = config.params['obvLineColorRgba'];
            var configObvMaLineWidth = config.params['obvMaLineWidth'];
            var configObvMaLineColorRgba = config.params['obvMaLineColorRgba'];
            this.argObvPeriod = configObvPeriod.value;
            this.argObvMaPeriod = configObvMaPeriod.value;
            this.styleObvLineWidth = configObvLineWidth.value;
            this.styleObvLineColorRgba = configObvLineColorRgba.value;
            this.styleObvMaLineWidth = configObvMaLineWidth.value;
            this.styleObvMaLineColorRgba = configObvMaLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfObv.prototype.getArgObvPeriod = function () {
            return this.argObvPeriod;
        };
        ChartOfObv.prototype.setArgObvPeriod = function (period) {
            this.argObvPeriod = period;
            this.config.params['obvPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfObv.prototype.getArgObvMaPeriod = function () {
            return this.argObvMaPeriod;
        };
        ChartOfObv.prototype.setArgObvMaPeriod = function (period) {
            this.argObvMaPeriod = period;
            this.config.params['obvMaPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfObv.prototype.getStyleObvLineWidth = function () {
            return this.styleObvLineWidth;
        };
        ChartOfObv.prototype.setStyleObvLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleObvLineWidth = lineWidth;
            this.config.params['obvLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfObv.prototype.getStyleObvLineColorRgba = function () {
            return this.styleObvLineColorRgba;
        };
        ChartOfObv.prototype.setStyleObvLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleObvLineColorRgba = colorRgba;
            this.config.params['obvLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfObv.prototype.getStyleObvMaLineWidth = function () {
            return this.styleObvMaLineWidth;
        };
        ChartOfObv.prototype.setStyleObvMaLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleObvMaLineWidth = lineWidth;
            this.config.params['obvMaLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfObv.prototype.getStyleObvMaLineColorRgba = function () {
            return this.styleObvMaLineColorRgba;
        };
        ChartOfObv.prototype.setStyleObvMaLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleObvMaLineColorRgba = colorRgba;
            this.config.params['obvMaLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfObv.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementObvList.length) {
                return this.elementObvList[index];
            }
            return null;
        };
        ChartOfObv.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewObvDragon == null || this.elementViewObvDragon.length !== numberOfDragonComponents) {
                this.elementViewObvDragon = CscApi.Utility.resizeFloat32Array(this.elementViewObvDragon, numberOfDragonComponents);
            }
            if (this.elementViewObvMaDragon == null || this.elementViewObvMaDragon.length !== numberOfDragonComponents) {
                this.elementViewObvMaDragon = CscApi.Utility.resizeFloat32Array(this.elementViewObvMaDragon, numberOfDragonComponents);
            }
            if (this.elementVolList == null || this.elementVolList.length !== numberOfOrderedTickList) {
                this.elementVolList = CscApi.Utility.resizeFloat32Array(this.elementVolList, numberOfOrderedTickList);
            }
            if (this.elementObvList == null || this.elementObvList.length !== numberOfOrderedTickList) {
                this.elementObvList = CscApi.Utility.resizeFloat32Array(this.elementObvList, numberOfOrderedTickList);
            }
            if (this.elementObvMaList == null || this.elementObvMaList.length !== numberOfOrderedTickList) {
                this.elementObvMaList = CscApi.Utility.resizeFloat32Array(this.elementObvMaList, numberOfOrderedTickList);
            }
            var elementVolList = this.elementVolList;
            var elementObvList = this.elementObvList;
            var elementObvMaList = this.elementObvMaList;
            var obvPeriod = this.argObvPeriod;
            var obvMaPeriod = this.argObvMaPeriod;
            var sumVolume = 0;
            var sumObv = 0;
            var sumObvMa = 0;
            for (var i = 1; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var prevTickData = orderedTickList[i - 1];
                var vol = elementVolList[i] = tickData.getClose() > prevTickData.getClose() ? tickData.getVolume() : -tickData.getVolume();
                sumVolume += vol;
                if (i >= obvPeriod) {
                    sumVolume -= elementVolList[i - obvPeriod];
                }
                var obv = elementObvList[i] = sumVolume;
                sumObv += obv;
                if (i >= obvMaPeriod) {
                    sumObv -= elementObvList[i - obvMaPeriod];
                }
                var p = i < obvMaPeriod ? i + 1 : obvMaPeriod;
                elementObvMaList[i] = sumObv / p;
            }
        };
        ChartOfObv.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementObvList = this.elementObvList;
            var elementObvMaList = this.elementObvMaList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var obv = elementObvList[vi];
                var obvMa = elementObvMaList[vi];
                if (false == isNaN(obv)) {
                    if (obv > highestValue)
                        highestValue = obv;
                    if (obv < lowestValue)
                        lowestValue = obv;
                }
                if (false == isNaN(obvMa)) {
                    if (obvMa > highestValue)
                        highestValue = obvMa;
                    if (obvMa < lowestValue)
                        lowestValue = obvMa;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfObv.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementObvList = this.elementObvList;
            var elementObvMaList = this.elementObvMaList;
            var elementViewObvDragon = this.elementViewObvDragon;
            var elementViewObvMaDragon = this.elementViewObvMaDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argObvPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementObvList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var obv = elementObvList[i];
                var obvMa = elementObvMaList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewObvDragon[vi] = viewXCoord;
                elementViewObvDragon[vyi] = isNaN(obv) ? NaN : Math.floor(valueToYCoordConvertor(obv));
                elementViewObvMaDragon[vi] = viewXCoord;
                elementViewObvMaDragon[vyi] = isNaN(obvMa) ? NaN : Math.floor(valueToYCoordConvertor(obvMa));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfObv.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argObvPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementObvList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argObvPeriod ? viewStartTickIndex : this.argObvPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                renderer.setLineWidth(Math.floor(Math.min(this.styleObvLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleObvLineColorRgba);
                this.drawDragon(this.elementViewObvDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleObvMaLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleObvMaLineColorRgba);
                this.drawDragon(this.elementViewObvMaDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfObv.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var obv = this.elementObvList[focusElementIndex];
                var obvMa = this.elementObvMaList[focusElementIndex];
                valueInfoList = [
                    { name: 'OBV Period', value: this.argObvPeriod.toString(), valueColor: null },
                    { name: 'OBV MA Period', value: this.argObvMaPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(obv))
                    valueInfoList.push({ name: 'OBV', value: obv.toFixed(DECIMAL_DIGITS), valueColor: this.styleObvLineColorRgba });
                if (false === isNaN(obvMa))
                    valueInfoList.push({ name: 'OBV MA', value: obvMa.toFixed(DECIMAL_DIGITS), valueColor: this.styleObvMaLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfObv;
    })(CscImpl.Chart);
    CscImpl.ChartOfObv = ChartOfObv;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var DrawerOfChannel = (function (_super) {
        __extends(DrawerOfChannel, _super);
        function DrawerOfChannel(chart, handleId) {
            var maxStep = 3;
            _super.call(this, chart, handleId, CscApi.DrawerType.CHANNEL, maxStep);
        }
        DrawerOfChannel.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configLine1Width = config.params['line1Width'];
            var configLine1Dashedlength = config.params['line1DashedLength'];
            var configLine1ColorRgba = config.params['line1ColorRgba'];
            var configLine2Width = config.params['line2Width'];
            var configLine2Dashedlength = config.params['line2DashedLength'];
            var configLine2ColorRgba = config.params['line2ColorRgba'];
            this.styleLine1Width = configLine1Width.value;
            this.styleLine1DashedLength = configLine1Dashedlength.value;
            this.styleLine1ColorRgba = configLine1ColorRgba.value;
            this.styleLine2Width = configLine2Width.value;
            this.styleLine2DashedLength = configLine2Dashedlength.value;
            this.styleLine2ColorRgba = configLine2ColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfChannel.prototype.getStyleLine1Width = function () {
            return this.styleLine1Width;
        };
        DrawerOfChannel.prototype.setStyleLine1Width = function (lineWidth) {
            this.styleLine1Width = lineWidth;
        };
        DrawerOfChannel.prototype.getStyleLine1DashedLength = function () {
            return this.styleLine1DashedLength;
        };
        DrawerOfChannel.prototype.setStyleLine1DashedLength = function (dashedLength) {
            this.styleLine1DashedLength = dashedLength;
        };
        DrawerOfChannel.prototype.getStyleLine1ColorRgba = function () {
            return this.styleLine1ColorRgba;
        };
        DrawerOfChannel.prototype.setStyleLine1ColorRgba = function (colorRgba) {
            this.styleLine1ColorRgba = colorRgba;
        };
        DrawerOfChannel.prototype.getStyleLine2Width = function () {
            return this.styleLine2Width;
        };
        DrawerOfChannel.prototype.setStyleLine2Width = function (lineWidth) {
            this.styleLine2Width = lineWidth;
        };
        DrawerOfChannel.prototype.getStyleLine2DashedLength = function () {
            return this.styleLine2DashedLength;
        };
        DrawerOfChannel.prototype.setStyleLine2DashedLength = function (lineWidth) {
            this.styleLine2DashedLength = lineWidth;
        };
        DrawerOfChannel.prototype.getStyleLine2ColorRgba = function () {
            return this.styleLine2ColorRgba;
        };
        DrawerOfChannel.prototype.setStyleLine2ColorRgba = function (colorRgba) {
            this.styleLine2ColorRgba = colorRgba;
        };
        DrawerOfChannel.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var line1;
            var line2;
            var slope;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                var x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                var y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                var x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                var y2 = area.getChartYCoordFromValue(chartHandleId, current.value);
                line1 = this.createExtLineFromEndPoints(x1, y1, x2, y2).lineForBoundRect;
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                var x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                var y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                var x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep1.index);
                var y2 = area.getChartYCoordFromValue(chartHandleId, drawnStep1.value);
                slope = (y2 - y1) / (x2 - x1);
                line1 = this.createExtLineWithSlope(x2, y2, slope).lineForBoundRect;
            }
            if (currentStep == 2) {
                var drawnStep1 = drawnStepList[1];
                var x3 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                var y3 = area.getChartYCoordFromValue(chartHandleId, current.value);
                line2 = this.createExtLineWithSlope(x3, y3, slope).lineForBoundRect;
            }
            else if (currentStep > 2) {
                var drawnStep2 = drawnStepList[2];
                var x3 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep2.index);
                var y3 = area.getChartYCoordFromValue(chartHandleId, drawnStep2.value);
                line2 = this.createExtLineWithSlope(x3, y3, slope).lineForBoundRect;
            }
            if (line1 != null) {
                renderer.setLineWidth(this.styleLine1Width);
                renderer.setStrokeColorRgba(this.styleLine1ColorRgba);
                this.drawLine(line1, this.styleLine1DashedLength);
            }
            if (line2 != null) {
                renderer.setLineWidth(this.styleLine2Width);
                renderer.setStrokeColorRgba(this.styleLine2ColorRgba);
                this.drawLine(line2, this.styleLine2DashedLength);
            }
        };
        return DrawerOfChannel;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfChannel = DrawerOfChannel;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscFacade;
(function (CscFacade) {
    var CandlestickChartFacade = (function () {
        function CandlestickChartFacade() {
            this.candlestickChart = null;
            this.domCanvas = null;
            this.style = null;
            this.context = null;
            this.areaOfMain = null;
            this.areaOfIndependentTiList = null;
            this.areaOfTimeScale = null;
            this.drawer = null;
            this.drawerMap = null;
            this.onDrawerTerminated = null;
        }
        CandlestickChartFacade.prototype.getCandlestickChart = function () {
            return this.candlestickChart;
        };
        CandlestickChartFacade.prototype.getContext = function () {
            return this.candlestickChart.getContext();
        };
        CandlestickChartFacade.prototype.setContext = function (context) {
            this.candlestickChart.setContext(context);
        };
        CandlestickChartFacade.prototype.getStyle = function () {
            return this.style;
        };
        CandlestickChartFacade.prototype.getLang = function () {
            return this.candlestickChart.getLang();
        };
        CandlestickChartFacade.prototype.setLangLocale = function (locale) {
            if (locale == null) {
                return false;
            }
            var arr = locale.match(/(\w{2})[-_](\w{2})/);
            if (arr.length != 3) {
                console.error('wrong locale format.');
                return false;
            }
            var lang = arr[1].toLowerCase();
            var country = arr[2].toUpperCase();
            var realLocale = lang + '-' + country;
            if (realLocale === 'zh-TW') {
                this.candlestickChart.setLang(new CscImpl.LangOfZhTw());
            }
            else {
                return false;
            }
            return true;
        };
        CandlestickChartFacade.prototype.getDecimalDigits = function () {
            return this.candlestickChart.getDecimalDigits();
        };
        CandlestickChartFacade.prototype.setDecimalDigits = function (decimalDigits) {
            this.candlestickChart.setDecimalDigits(decimalDigits);
        };
        CandlestickChartFacade.prototype.getTimezone = function () {
            var timezoneOffsetInMinutes = this.candlestickChart.getTimezoneOffsetInMinutes();
            return Math.floor(timezoneOffsetInMinutes / 60);
        };
        CandlestickChartFacade.prototype.setTimezone = function (utcOffsetInHours) {
            this.candlestickChart.setTimezoneOffsetInMinutes(Math.floor(utcOffsetInHours * 60));
            this.present();
        };
        CandlestickChartFacade.prototype.init = function (domCanvas) {
            if (this.candlestickChart != null) {
                return false;
            }
            else if (domCanvas == null) {
                return false;
            }
            var candlestickChart = new CscImpl.CandlestickChart(domCanvas, null);
            if (false == candlestickChart.init()) {
                return false;
            }
            this.candlestickChart = candlestickChart;
            this.domCanvas = domCanvas;
            this.tiMap = {};
            this.drawerMap = {};
            this.resetStyleToDefault();
            candlestickChart.setLockFocusElementToLast(true);
            if (false == this.setLangLocale(CscApi.Utility.getLocale())) {
                if (false == this.setLangLocale('zh-TW')) {
                    alert('failed to set default locale.');
                }
            }
            var areaIdOfMain = candlestickChart.addArea(0, 0, 0, 0);
            var areaOfMain = candlestickChart.getArea(areaIdOfMain);
            var chartIdOfOhlc = areaOfMain.addChart(CscApi.ChartType.OHLC);
            var chartOfOhlc = areaOfMain.getChart(chartIdOfOhlc);
            this.tiMap['ohlc'] = {
                area: areaOfMain,
                chart: chartOfOhlc,
                tiIndex: null,
            };
            var areaIdOfTimeScale = candlestickChart.addArea(0, 0, 0, 0);
            var areaOfTimeScale = candlestickChart.getArea(areaIdOfTimeScale);
            var chartIdOfTimeScale = areaOfTimeScale.addChart(CscApi.ChartType.TIME_SCALE);
            var chartOfTimeScale = areaOfMain.getChart(chartIdOfTimeScale);
            this.tiMap['timeScale'] = {
                area: areaOfTimeScale,
                chart: chartOfTimeScale,
                tiIndex: null,
            };
            this.areaOfMain = areaOfMain;
            this.areaOfIndependentTiList = [];
            this.areaOfTimeScale = areaOfTimeScale;
            this.chartOfOhlc = chartOfOhlc;
            this.reshapeAreas();
            this.candlestickChart.addEventListenerOnDrawerTerminated(function (drawer) {
            });
            this.present();
            return true;
        };
        CandlestickChartFacade.prototype.release = function () {
            this.candlestickChart.release();
        };
        CandlestickChartFacade.prototype.resetStyleToDefault = function () {
            this.style = new CscFacade.CandlestickChartStyleFacade(this);
            this.candlestickChart.setStyle(this.style);
        };
        CandlestickChartFacade.prototype.resize = function () {
            this.reshapeAreas();
            this.present();
        };
        CandlestickChartFacade.prototype.present = function () {
            this.candlestickChart.present();
        };
        CandlestickChartFacade.prototype.reshapeAreas = function () {
            var candlestickChart = this.candlestickChart;
            var style = this.style;
            var styleMarginLeft = style.getMarginLeft();
            var styleMarginRight = style.getMarginRight();
            var styleMarginTop = style.getMarginTop();
            var styleMarginBottom = style.getMarginBottom();
            var styleMinHeightRatioOfTiAreas = style.getMinHeightRatioOfTiAreas();
            var styleMaxHeightRatioOfTiAreas = style.getMaxHeightRatioOfTiAreas();
            var styleValueScaleWidth = style.getValueScaleWidth();
            var styleHeightOfTimeScale = style.getHeightOfTimeScale();
            var stylePaddingHeightOfAreas = style.getPaddingHeightOfAreas();
            var maxNumberOfIndependentTiAreas = 5;
            var numberOfIndependentTiAreas = this.areaOfIndependentTiList.length;
            var heightRatioOfAllTiAreas;
            if (numberOfIndependentTiAreas >= 1) {
                heightRatioOfAllTiAreas = (numberOfIndependentTiAreas - 1) / (maxNumberOfIndependentTiAreas - 1) * (styleMaxHeightRatioOfTiAreas - styleMinHeightRatioOfTiAreas) + styleMinHeightRatioOfTiAreas;
                if (heightRatioOfAllTiAreas > styleMaxHeightRatioOfTiAreas) {
                    heightRatioOfAllTiAreas = styleMaxHeightRatioOfTiAreas;
                }
            }
            else {
                heightRatioOfAllTiAreas = 0;
            }
            var heightRatioOfMainArea = 1 - heightRatioOfAllTiAreas;
            var domCanvas = this.domCanvas;
            var canvasWidth = domCanvas.width;
            var canvasHeight = domCanvas.height;
            var areaOfIndependentTiList = this.areaOfIndependentTiList;
            var numberOfAreaOfIndependentTi = areaOfIndependentTiList.length;
            var totalPaddingHeight = Math.floor(stylePaddingHeightOfAreas * (numberOfAreaOfIndependentTi + 1));
            var availableHeightExclusiveTimeScale = Math.max(0, Math.floor(canvasHeight - styleHeightOfTimeScale - styleMarginTop - styleMarginBottom - totalPaddingHeight));
            var yScaleWidth = 0;
            for (var n = 0; n < 2; ++n) {
                var areaWidth = Math.max(0, Math.floor(canvasWidth - yScaleWidth - styleMarginLeft - styleMarginRight));
                var offsetX = styleMarginLeft;
                var offsetY = styleMarginTop;
                var mainAreaHeight = Math.floor(heightRatioOfMainArea * availableHeightExclusiveTimeScale);
                candlestickChart.reshapeArea(this.areaOfMain.getHandleId(), offsetX, offsetY, areaWidth, mainAreaHeight);
                offsetY += mainAreaHeight + stylePaddingHeightOfAreas;
                if (numberOfAreaOfIndependentTi > 0) {
                    var heightOfAllTiAreas = availableHeightExclusiveTimeScale - mainAreaHeight;
                    var heightOfTiArea = Math.floor(heightOfAllTiAreas / numberOfAreaOfIndependentTi);
                    for (var i = 0; i < numberOfAreaOfIndependentTi; ++i) {
                        var area = areaOfIndependentTiList[i];
                        candlestickChart.reshapeArea(area.getHandleId(), offsetX, offsetY, areaWidth, heightOfTiArea);
                        offsetY += heightOfTiArea + stylePaddingHeightOfAreas;
                    }
                }
                candlestickChart.reshapeArea(this.areaOfTimeScale.getHandleId(), offsetX, offsetY, areaWidth, styleHeightOfTimeScale);
                candlestickChart.update();
                if (n == 0) {
                    var paddingWidth = 10;
                    var yScaleWidth = this.getYScaleWidth() + paddingWidth;
                    yScaleWidth = Math.min(yScaleWidth, styleValueScaleWidth);
                }
            }
            this.present();
        };
        CandlestickChartFacade.prototype.getYScaleWidth = function () {
            var areaOfIndependentTiList = this.areaOfIndependentTiList;
            var numberOfAreaOfIndependentTi = areaOfIndependentTiList.length;
            var yScaleWidth = this.areaOfMain.getYScaleValuesWidth();
            if (numberOfAreaOfIndependentTi > 0) {
                for (var i = 0; i < numberOfAreaOfIndependentTi; ++i) {
                    var area = areaOfIndependentTiList[i];
                    var yScaleWidthInArea = area.getYScaleValuesWidth();
                    if (yScaleWidthInArea > yScaleWidth) {
                        yScaleWidth = yScaleWidthInArea;
                    }
                }
            }
            return yScaleWidth;
        };
        CandlestickChartFacade.prototype.getMaxViewStartXCoord = function () {
            return this.candlestickChart.getMaxViewStartXCoord();
        };
        CandlestickChartFacade.prototype.setViewStartXCoord = function (xCoord) {
            this.candlestickChart.setViewStartXCoord(xCoord);
        };
        CandlestickChartFacade.prototype.setViewStartXCoordToLeft = function () {
            this.candlestickChart.setViewStartXCoord(0);
        };
        CandlestickChartFacade.prototype.setViewStartXCoordToRight = function () {
            var candlestickChart = this.candlestickChart;
            candlestickChart.setViewStartXCoord(candlestickChart.getMaxViewStartXCoord());
        };
        CandlestickChartFacade.prototype.getLockFocusElementToLast = function () {
            return this.candlestickChart.getLockFocusElementToLast();
        };
        CandlestickChartFacade.prototype.setLockFocusElementToLast = function (lockFocusElementToLast) {
            this.candlestickChart.setLockFocusElementToLast(lockFocusElementToLast);
        };
        CandlestickChartFacade.prototype.addTi = function (tiId, chartType) {
            if (tiId === 'ohlc' || tiId === 'timeScale') {
                throw 'invalid ID, "' + tiId + '" is reserved for internal chart.';
            }
            var tiMap = this.tiMap;
            var tiContext = tiMap[tiId];
            if (tiContext != null) {
                this.removeTi(tiId);
            }
            var tiContext;
            var chart;
            switch (chartType) {
                case CscApi.ChartType.MA:
                case CscApi.ChartType.BOLLINGER_BAND:
                case CscApi.ChartType.SAR:
                    var chartId = this.areaOfMain.addChart(chartType);
                    chart = this.areaOfMain.getChart(chartId);
                    this.areaOfMain.setChartYAxisEnabled(chartId, false);
                    tiContext = {
                        area: this.areaOfMain,
                        chart: chart,
                        tiIndex: null,
                    };
                    this.areaOfMain.setChartYAxisEnabled(chart.getHandleId(), false);
                    break;
                default:
                    var candlestickChart = this.candlestickChart;
                    var areaId = candlestickChart.addArea(20, 420, 1100, 250);
                    var area = candlestickChart.getArea(areaId);
                    area.reconcileViewFromArea(this.areaOfMain);
                    var chartId = area.addChart(chartType);
                    chart = area.getChart(chartId);
                    chart.reconcileStyleFromChart(this.chartOfOhlc);
                    var tiIndex = this.areaOfIndependentTiList.length;
                    this.areaOfIndependentTiList.push(area);
                    tiContext = {
                        area: area,
                        chart: chart,
                        tiIndex: tiIndex,
                    };
                    area.setChartYAxisEnabled(chart.getHandleId(), true);
                    break;
            }
            if (tiContext != null) {
                var prev = this.tiMap[tiId];
                if (prev != null) {
                    this.removeTi(tiId);
                }
                this.tiMap[tiId] = tiContext;
            }
            this.reshapeAreas();
            this.present();
        };
        CandlestickChartFacade.prototype.addTiMa = function (id) {
            return this.addTi(id, CscApi.ChartType.MA);
        };
        CandlestickChartFacade.prototype.addTiMacd = function (id) {
            return this.addTi(id, CscApi.ChartType.MACD);
        };
        CandlestickChartFacade.prototype.addTiAo = function (id) {
            return this.addTi(id, CscApi.ChartType.AO);
        };
        CandlestickChartFacade.prototype.addTiArBr = function (id) {
            return this.addTi(id, CscApi.ChartType.ARBR);
        };
        CandlestickChartFacade.prototype.addTiAtr = function (id) {
            return this.addTi(id, CscApi.ChartType.ATR);
        };
        CandlestickChartFacade.prototype.addTiBias = function (id) {
            return this.addTi(id, CscApi.ChartType.BIAS);
        };
        CandlestickChartFacade.prototype.addTiBiasAB = function (id) {
            return this.addTi(id, CscApi.ChartType.BIAS_AB);
        };
        CandlestickChartFacade.prototype.addTiCci = function (id) {
            return this.addTi(id, CscApi.ChartType.CCI);
        };
        CandlestickChartFacade.prototype.addTiDmi = function (id) {
            return this.addTi(id, CscApi.ChartType.DMI);
        };
        CandlestickChartFacade.prototype.addTiKdj = function (id) {
            return this.addTi(id, CscApi.ChartType.KDJ);
        };
        CandlestickChartFacade.prototype.addTiMtm = function (id) {
            return this.addTi(id, CscApi.ChartType.MTM);
        };
        CandlestickChartFacade.prototype.addTiObv = function (id) {
            return this.addTi(id, CscApi.ChartType.OBV);
        };
        CandlestickChartFacade.prototype.addTiPsy = function (id) {
            return this.addTi(id, CscApi.ChartType.PSY);
        };
        CandlestickChartFacade.prototype.addTiRoc = function (id) {
            return this.addTi(id, CscApi.ChartType.ROC);
        };
        CandlestickChartFacade.prototype.addTiRsi = function (id) {
            return this.addTi(id, CscApi.ChartType.RSI);
        };
        CandlestickChartFacade.prototype.addTiRsiSmooth = function (id) {
            return this.addTi(id, CscApi.ChartType.RSI_SMOOTH);
        };
        CandlestickChartFacade.prototype.addTiBollingerBand = function (id) {
            return this.addTi(id, CscApi.ChartType.BOLLINGER_BAND);
        };
        CandlestickChartFacade.prototype.addTiVolume = function (id) {
            return this.addTi(id, CscApi.ChartType.VOLUME);
        };
        CandlestickChartFacade.prototype.addTiVr = function (id) {
            return this.addTi(id, CscApi.ChartType.VR);
        };
        CandlestickChartFacade.prototype.addTiWr = function (id) {
            return this.addTi(id, CscApi.ChartType.WR);
        };
        CandlestickChartFacade.prototype.addTiOsma = function (id) {
            return this.addTi(id, CscApi.ChartType.OSMA);
        };
        CandlestickChartFacade.prototype.addTiSar = function (id) {
            return this.addTi(id, CscApi.ChartType.SAR);
        };
        CandlestickChartFacade.prototype.removeTi = function (id) {
            var tiMap = this.tiMap;
            var tiContext = tiMap[id];
            if (tiContext == null) {
                console.warn('unknown technical indicator ID: ' + id);
                return;
            }
            var area = tiContext.area;
            area.removeChart(tiContext.chart.getHandleId());
            var chartList = area.getChartList();
            if (chartList.length == 0) {
                this.candlestickChart.removeArea(area.getHandleId());
                var tiIndex = tiContext.tiIndex;
                if (tiIndex != null) {
                    this.areaOfIndependentTiList.splice(tiIndex, 1);
                    for (var tempTiId in tiMap) {
                        var tempTiMap = tiMap[tempTiId];
                        if (tempTiMap.tiIndex > tiIndex) {
                            --tempTiMap.tiIndex;
                        }
                    }
                    this.reshapeAreas();
                }
            }
            delete tiMap[id];
            this.present();
        };
        CandlestickChartFacade.prototype.removeAllTi = function () {
            var tiIdList = Object.keys(this.tiMap);
            for (var i in tiIdList) {
                var tiId = tiIdList[i];
                if (this._isBuiltInTi(tiId)) {
                    continue;
                }
                this.removeTi(tiId);
            }
        };
        CandlestickChartFacade.prototype._isBuiltInTi = function (tiId) {
            return tiId == 'ohlc' || tiId == 'timeScale';
        };
        CandlestickChartFacade.prototype.isTiExisting = function (id) {
            return this.tiMap[id] != null;
        };
        CandlestickChartFacade.prototype.getTiType = function (id) {
            var tiContext = this.tiMap[id];
            if (tiContext == null) {
                console.warn('unknown technical indicator ID: ' + id);
                return null;
            }
            return tiContext.chart.getType();
        };
        CandlestickChartFacade.prototype.getTiConfig = function (id) {
            var tiContext = this.tiMap[id];
            if (tiContext == null) {
                console.warn('unknown technical indicator ID: ' + id);
                return null;
            }
            return tiContext.chart.getConfig();
        };
        CandlestickChartFacade.prototype.getTiArg = function (id, paramName) {
            var tiContext = this.tiMap[id];
            if (tiContext == null) {
                console.warn('unknown technical indicator ID: ' + id);
                return null;
            }
            return tiContext.chart.getArgValueByName(paramName);
        };
        CandlestickChartFacade.prototype.setTiArg = function (id, paramName, value) {
            var tiContext = this.tiMap[id];
            if (tiContext == null) {
                console.warn('unknown technical indicator ID: ' + id);
                return false;
            }
            return tiContext.chart.setArgValueByName(paramName, value);
        };
        CandlestickChartFacade.prototype.getTiList = function () {
            var tiIdList = Object.keys(this.tiMap);
            var result = [];
            for (var i in tiIdList) {
                var tiId = tiIdList[i];
                if (this._isBuiltInTi(tiId)) {
                    continue;
                }
                result.push(tiId);
            }
            return result;
        };
        CandlestickChartFacade.prototype.setTiCaption = function (id, caption) {
            var tiContext = this.tiMap[id];
            if (tiContext == null) {
                console.warn('unknown technical indicator ID: ' + id);
                return;
            }
            tiContext.chart.setCaption(caption);
            this.present();
        };
        CandlestickChartFacade.prototype.processStyleChanged = function () {
            var style = this.style;
            var fontSize = style.getValueScaleFontSize();
            var areas = [
                this.areaOfMain,
                this.areaOfTimeScale,
            ].concat(this.areaOfIndependentTiList);
            for (var n in areas) {
                var area = areas[n];
                var chartList = area.getChartList();
                for (var i in chartList) {
                    var chart = chartList[i];
                    chart.setStyleValueScaleFontSize(fontSize);
                    chart.setStyleValueScaleFontName(style.getValueScaleFontName());
                    chart.setStyleValueScaleFontBold(style.getValueScaleFontBold());
                    chart.setStyleValueScaleFontColorRgba(style.getValueScaleColorRgba());
                    chart.setStyleYScalesSpanMargin(fontSize * 2);
                }
            }
            this.areaOfTimeScale.setHeight(fontSize);
            this.reshapeAreas();
            this.present();
        };
        CandlestickChartFacade.prototype.isDrawerExisting = function (drawerId) {
            return this.drawerMap[drawerId] != null;
        };
        CandlestickChartFacade.prototype.startToDraw = function (drawerId, drawerType, commitSteps) {
            this.stopDrawing();
            var chartOfOhlc = this.chartOfOhlc;
            var drawerHandleId = chartOfOhlc.addDrawer(drawerType);
            var drawer = chartOfOhlc.getDrawer(drawerHandleId);
            if (drawer == null) {
                return;
            }
            this.drawer = drawer;
            this.drawerMap[drawerId] = {
                drawer: drawer,
            };
            if (commitSteps != null) {
                var numberOfSteps = commitSteps.length;
                for (var i = 0; i < numberOfSteps; ++i) {
                    drawer.setCurrentState(commitSteps[i], false);
                    drawer.commit();
                }
            }
            this.present();
        };
        CandlestickChartFacade.prototype.stopDrawing = function () {
            var drawer = this.drawer;
            if (drawer == null) {
                return;
            }
            else if (false == drawer.isCompleted()) {
                this.chartOfOhlc.removeDrawer(drawer.getHandleId());
            }
            this.drawer = null;
            this.present();
        };
        CandlestickChartFacade.prototype.removeDrawer = function (drawerId) {
            var drawerContext = this.drawerMap[drawerId];
            if (drawerContext != null) {
                var drawer = drawerContext.drawer;
                drawer.getChart().removeDrawer(drawer.getHandleId());
                delete this.drawerMap[drawerId];
                this.present();
            }
        };
        CandlestickChartFacade.prototype.removeAllDrawers = function () {
            this.chartOfOhlc.removeAllDrawers();
            this.candlestickChart.present();
            this.drawerMap = {};
            this.present();
        };
        CandlestickChartFacade.prototype.saveToJson = function (options) {
            var result = {
                style: null,
                tiMap: null,
                drawerMap: null,
            };
            var extractAll = options == null;
            if (extractAll || options.style) {
                result.style = this.getStyle();
            }
            if (extractAll || options.ti) {
                result.tiMap = {};
                var tiMap = result.tiMap;
                for (var tiId in this.tiMap) {
                    var tiContext = this.tiMap[tiId];
                    tiMap[tiId] = {
                        tiType: tiContext.chart.getType(),
                        index: tiContext.tiIndex,
                        tiConfig: tiContext.chart.getConfig(),
                    };
                }
            }
            if (extractAll || options.drawing) {
                result.drawerMap = {};
                var drawerMap = result.drawerMap;
                for (var drawerId in this.drawerMap) {
                    var drawerContext = this.drawerMap[drawerId];
                    drawerMap[drawerId] = {
                        drawerType: drawerContext.drawer.getType(),
                        drawnStepList: drawerContext.drawer.getDrawnStepList(),
                        drawerConfig: drawerContext.drawer.getConfig(),
                    };
                }
            }
            return JSON.stringify(result);
        };
        CandlestickChartFacade.prototype.restoreFromJson = function (options, json) {
            var jsObj = JSON.parse(json);
            var extractAll = options == null;
            if (extractAll || options.style) {
                this.getStyle().restoreFromObj(jsObj.style);
            }
            if (extractAll || options.ti) {
                var orderedTiMap = new CscApi.OrderedHashMap();
                var ohlcAreaTiMap = {};
                for (var tiId in jsObj.tiMap) {
                    var ti = jsObj.tiMap[tiId];
                    if (tiId === 'ohlc' || tiId === 'timeScale') {
                        var tiContext = this.tiMap[tiId];
                        if (tiContext != null) {
                            tiContext.chart.setConfig(ti.tiConfig);
                        }
                        continue;
                    }
                    if (ti.index != null) {
                        orderedTiMap.Put(ti.index, tiId);
                    }
                    else {
                        ohlcAreaTiMap[tiId] = ti;
                    }
                }
                this.removeAllTi();
                for (var tiId_1 in ohlcAreaTiMap) {
                    var ti = ohlcAreaTiMap[tiId_1];
                    this.addTi(tiId_1, ti.tiType);
                    var tiContext = this.tiMap[tiId_1];
                    if (tiContext != null) {
                        tiContext.chart.setConfig(ti.tiConfig);
                    }
                }
                var tiIdList = orderedTiMap.GetOrderedValueList();
                for (var i_1 in tiIdList) {
                    var tiId_2 = tiIdList[i_1];
                    var ti = jsObj.tiMap[tiId_2];
                    this.addTi(tiId_2, ti.tiType);
                    var tiContext = this.tiMap[tiId_2];
                    if (tiContext != null) {
                        tiContext.chart.setConfig(ti.tiConfig);
                    }
                }
            }
            if (extractAll || options.drawing) {
                this.removeAllDrawers();
                var drawerMap = this.drawerMap;
                var chartOfOhlc = this.chartOfOhlc;
                var resetIndexByTime = true;
                var lang = this.getLang();
                for (var drawerId in jsObj.drawerMap) {
                    var persistenceDrawer = jsObj.drawerMap[drawerId];
                    var drawerHandleId = chartOfOhlc.addDrawer(persistenceDrawer.drawerType);
                    var drawer = chartOfOhlc.getDrawer(drawerHandleId);
                    var drawnStepList = persistenceDrawer.drawnStepList;
                    var numberOfDrawnSteps = drawnStepList.length;
                    var ok = true;
                    for (var i = 0; i < numberOfDrawnSteps; ++i) {
                        var drawnStep = drawnStepList[i];
                        if (false == drawer.setCurrentState(drawnStep, resetIndexByTime)) {
                            ok = false;
                            break;
                        }
                        drawer.commit();
                    }
                    if (false == drawer.isCompleted()) {
                        var drawerCaption = lang.getDrawerCaption(persistenceDrawer.drawerType);
                        console.warn('繪圖 ' + drawerCaption + ' ( ' + drawerId + ' ) 還原後不滿足所有步驟，此繪圖將被放棄還原。');
                        ok = false;
                    }
                    if (ok) {
                        drawerMap[drawerId] = {
                            drawer: drawer,
                        };
                        drawer.setConfig(persistenceDrawer.drawerConfig);
                    }
                    else {
                        chartOfOhlc.removeDrawer(drawerHandleId);
                    }
                }
            }
            return true;
        };
        return CandlestickChartFacade;
    })();
    CscFacade.CandlestickChartFacade = CandlestickChartFacade;
})(CscFacade || (CscFacade = {}));
///<reference path="../cscApi/candlestickChartApi.ts"/>
var CscImpl;
(function (CscImpl) {
    var TouchState = (function () {
        function TouchState() {
            this._domPositionX = new Array();
            this._domPositionY = new Array();
            this._positionX = new Array();
            this._positionY = new Array();
        }
        TouchState.prototype.Reset = function () {
            this._domPositionX.length = 0;
            this._domPositionY.length = 0;
            this._positionX.length = 0;
            this._positionY.length = 0;
        };
        TouchState.prototype.GetDomPositionXList = function () {
            return this._domPositionX;
        };
        TouchState.prototype.GetDomPositionYList = function () {
            return this._domPositionY;
        };
        TouchState.prototype.GetPositionXList = function () {
            return this._positionX;
        };
        TouchState.prototype.GetPositionYList = function () {
            return this._positionY;
        };
        TouchState.prototype.SetDomPositionList = function (x, y) {
            this._domPositionX = x;
            this._domPositionY = y;
        };
        TouchState.prototype.SetPositionList = function (x, y) {
            this._positionX = x;
            this._positionY = y;
        };
        return TouchState;
    })();
    CscImpl.TouchState = TouchState;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var DrawerOfGoldenSection = (function (_super) {
        __extends(DrawerOfGoldenSection, _super);
        function DrawerOfGoldenSection(chart, handleId) {
            var maxStep = 3;
            _super.call(this, chart, handleId, CscApi.DrawerType.GOLDEN_SECTION, maxStep);
        }
        DrawerOfGoldenSection.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configLine1Width = config.params['line1Width'];
            var configLine1Dashedlength = config.params['line1DashedLength'];
            var configLine1ColorRgba = config.params['line1ColorRgba'];
            var configLine2Width = config.params['line2Width'];
            var configLine2Dashedlength = config.params['line2DashedLength'];
            var configLine2ColorRgba = config.params['line2ColorRgba'];
            this.styleLine1Width = configLine1Width.value;
            this.styleLine1DashedLength = configLine1Dashedlength.value;
            this.styleLine1ColorRgba = configLine1ColorRgba.value;
            this.styleLine2Width = configLine2Width.value;
            this.styleLine2DashedLength = configLine2Dashedlength.value;
            this.styleLine2ColorRgba = configLine2ColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfGoldenSection.prototype.getStyleLine1Width = function () {
            return this.styleLine1Width;
        };
        DrawerOfGoldenSection.prototype.setStyleLine1Width = function (lineWidth) {
            this.styleLine1Width = lineWidth;
        };
        DrawerOfGoldenSection.prototype.getStyleLine1DashedLength = function () {
            return this.styleLine1DashedLength;
        };
        DrawerOfGoldenSection.prototype.setStyleLine1DashedLength = function (dashedLength) {
            this.styleLine1DashedLength = dashedLength;
        };
        DrawerOfGoldenSection.prototype.getStyleLine1ColorRgba = function () {
            return this.styleLine1ColorRgba;
        };
        DrawerOfGoldenSection.prototype.setStyleLine1ColorRgba = function (colorRgba) {
            this.styleLine1ColorRgba = colorRgba;
        };
        DrawerOfGoldenSection.prototype.getStyleLine2Width = function () {
            return this.styleLine2Width;
        };
        DrawerOfGoldenSection.prototype.setStyleLine2Width = function (lineWidth) {
            this.styleLine2Width = lineWidth;
        };
        DrawerOfGoldenSection.prototype.getStyleLine2DashedLength = function () {
            return this.styleLine2DashedLength;
        };
        DrawerOfGoldenSection.prototype.setStyleLine2DashedLength = function (dashedLength) {
            this.styleLine2DashedLength = dashedLength;
        };
        DrawerOfGoldenSection.prototype.getStyleLine2ColorRgba = function () {
            return this.styleLine2ColorRgba;
        };
        DrawerOfGoldenSection.prototype.setStyleLine2ColorRgba = function (colorRgba) {
            this.styleLine2ColorRgba = colorRgba;
        };
        DrawerOfGoldenSection.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var x1;
            var x2;
            var y1;
            var y2;
            var x3;
            var y3;
            var slope;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, current.value);
                slope = (y2 - y1) / (x2 - x1);
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep1.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, drawnStep1.value);
                slope = (y2 - y1) / (x2 - x1);
            }
            if (x1 == x2 && y1 == y2) {
                y2 += 0.1;
            }
            var line1 = new CscApi.Line(x1, y1, x2, y2);
            var viewLine1;
            var viewLine1ext;
            var viewLine2;
            var viewLine2ext;
            var resultOfLine1 = this.createExtLineFromEndPoints(x1, y1, x2, y2);
            viewLine1 = resultOfLine1.lineForBoundRect;
            viewLine1ext = resultOfLine1.lineForBoundlessRect;
            if (currentStep == 2) {
                var drawnStep1 = drawnStepList[1];
                x3 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                y3 = area.getChartYCoordFromValue(chartHandleId, current.value);
            }
            else if (currentStep > 2) {
                var drawnStep2 = drawnStepList[2];
                x3 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep2.index);
                y3 = area.getChartYCoordFromValue(chartHandleId, drawnStep2.value);
            }
            var line2 = line1.getParallelLine(x3, y3);
            var resultOfLine2 = this.createExtLineWithSlope(x3, y3, slope);
            viewLine2 = resultOfLine2.lineForBoundRect;
            viewLine2ext = resultOfLine2.lineForBoundlessRect;
            if (viewLine1ext != null) {
                renderer.setLineWidth(this.styleLine1Width);
                renderer.setStrokeColorRgba(this.styleLine1ColorRgba);
                this.drawLine(viewLine1ext, this.styleLine1DashedLength);
            }
            if (viewLine2ext != null) {
                renderer.setLineWidth(this.styleLine2Width);
                renderer.setStrokeColorRgba(this.styleLine2ColorRgba);
                this.drawLine(viewLine2ext, this.styleLine2DashedLength);
                var virtualAxisLine = line1.getPerpendicular(x3, y3);
                var p1 = line1.getLineIntersection(virtualAxisLine);
                var p2 = line2.getLineIntersection(virtualAxisLine);
                if (p1 && p2) {
                    var divisionPointX = p1.getX() + (p2.getX() - p1.getX()) * 0.618;
                    var divisionPointY = p1.getY() + (p2.getY() - p1.getY()) * 0.618;
                    var resultOfDivisionLine = this.createPerpendicularLine(virtualAxisLine, divisionPointX, divisionPointY);
                    var viewDivisionLine = resultOfDivisionLine.lineForBoundRect;
                    if (viewDivisionLine) {
                        this.drawLine(viewDivisionLine, this.styleLine2DashedLength);
                    }
                    this.drawLineFromEndPoints(p1.getX(), p1.getY(), p2.getX(), p2.getY(), this.styleLine2DashedLength);
                }
            }
        };
        return DrawerOfGoldenSection;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfGoldenSection = DrawerOfGoldenSection;
})(CscImpl || (CscImpl = {}));
var CscApi;
(function (CscApi) {
    var Arc = (function () {
        function Arc(x, y) {
            this.x = x;
            this.y = y;
        }
        Arc.prototype.getX = function () {
            return this.x;
        };
        Arc.prototype.getY = function () {
            return this.y;
        };
        Arc.prototype.getR = function () {
            return this.r;
        };
        Arc.prototype.getSAngle = function () {
            return this.sAngle;
        };
        Arc.prototype.getEAngle = function () {
            return this.eAngle;
        };
        return Arc;
    })();
    CscApi.Arc = Arc;
})(CscApi || (CscApi = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var TYPE_SPANS = {};
    var TYPE_SPANS_MINUTES = TYPE_SPANS[CscApi.ScaleTypeEnum.MINUTES] = {};
    TYPE_SPANS_MINUTES[CscApi.SpanTypeEnum.YEAR] = true;
    TYPE_SPANS_MINUTES[CscApi.SpanTypeEnum.MONTH] = true;
    TYPE_SPANS_MINUTES[CscApi.SpanTypeEnum.DAY] = true;
    TYPE_SPANS_MINUTES[CscApi.SpanTypeEnum.HOUR] = true;
    TYPE_SPANS_MINUTES[CscApi.SpanTypeEnum.MINUTE] = true;
    var TYPE_SPANS_HOURS = TYPE_SPANS[CscApi.ScaleTypeEnum.HOURS] = {};
    TYPE_SPANS_HOURS[CscApi.SpanTypeEnum.YEAR] = true;
    TYPE_SPANS_HOURS[CscApi.SpanTypeEnum.MONTH] = true;
    TYPE_SPANS_HOURS[CscApi.SpanTypeEnum.DAY] = true;
    var TYPE_SPANS_DAYS = TYPE_SPANS[CscApi.ScaleTypeEnum.DAYS] = {};
    TYPE_SPANS_DAYS[CscApi.SpanTypeEnum.YEAR] = true;
    TYPE_SPANS_DAYS[CscApi.SpanTypeEnum.MONTH] = true;
    var TYPE_SPANS_WEEKS = TYPE_SPANS[CscApi.ScaleTypeEnum.WEEKS] = {};
    TYPE_SPANS_WEEKS[CscApi.SpanTypeEnum.YEAR] = true;
    TYPE_SPANS_WEEKS[CscApi.SpanTypeEnum.MONTH] = true;
    var TYPE_SPANS_MONTHS = TYPE_SPANS[CscApi.ScaleTypeEnum.MONTHS] = {};
    TYPE_SPANS_MONTHS[CscApi.SpanTypeEnum.YEAR] = true;
    CscImpl.FMT_SCALE_ALL_SPANS = {};
    CscImpl.FMT_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.YEAR] = 'yyyy';
    CscImpl.FMT_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.MONTH] = 'yyyy/MM';
    CscImpl.FMT_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.DAY] = 'MM/dd';
    CscImpl.FMT_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.HOUR] = 'hh:00';
    CscImpl.FMT_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.MINUTE] = 'mm';
    var TimeScale = (function () {
        function TimeScale(candlestickChart) {
            this.candlestickChart = candlestickChart;
            this.elements = null;
            this.totalWidth = 0;
            this.scaleType = null;
            this.scaleSpanTypeEnabled = null;
            this.scalePattern = null;
            this.cachedTickWidth = null;
            this.cachedTickAmount = null;
            this.betweenScaleHalfWidth = {};
            this.setType(CscApi.ScaleTypeEnum.MINUTES);
        }
        TimeScale.prototype.getTickIndexFromX = function (x) {
            var candlestickChart = this.candlestickChart;
            var context = candlestickChart.getContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var value = Math.floor(x / viewTickWidth);
            var tickIndex = value < 0 ? 0 : value >= numberOfOrderedTickList ? numberOfOrderedTickList - 1 : value;
            return tickIndex;
        };
        ;
        TimeScale.prototype.getXFromTickIndex = function (index) {
            var candlestickChart = this.candlestickChart;
            var viewTickWidth = candlestickChart.getViewTickWidth();
            return Math.floor(index * viewTickWidth + viewTickWidth * 0.5);
        };
        TimeScale.prototype.getTotalWidth = function () {
            return this.totalWidth;
        };
        TimeScale.prototype.getTimeScaleElements = function () {
            return this.elements;
        };
        TimeScale.prototype.getScaleType = function () {
            return this.scaleType;
        };
        TimeScale.prototype.update = function (tickDataIsDirty) {
            var candlestickChart = this.candlestickChart;
            var context = candlestickChart.getContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var spanTypes = [
                CscApi.SpanTypeEnum.MINUTE,
                CscApi.SpanTypeEnum.HOUR,
                CscApi.SpanTypeEnum.DAY,
                CscApi.SpanTypeEnum.MONTH,
                CscApi.SpanTypeEnum.YEAR
            ];
            var isDirtyOfScaleHalfWidth = false;
            for (var i = 0; i < spanTypes.length; ++i) {
                var pattern = CscImpl.FMT_SCALE_ALL_SPANS[i];
                var reserveChacacterSize = Math.ceil(pattern.length + 1.618);
                var prev = this.betweenScaleHalfWidth[i];
                var current = this.betweenScaleHalfWidth[i] = Math.floor(candlestickChart.getStyle().getTimeScaleFontSize(i) * reserveChacacterSize * 0.5);
                if (prev != current) {
                    isDirtyOfScaleHalfWidth = true;
                }
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var viewTickHalfWidth = viewTickWidth * 0.5;
            var isTickWidthChanged = this.cachedTickWidth != viewTickWidth;
            var isTickAmountChanged = this.cachedTickAmount != numberOfOrderedTickList;
            if (false == isDirtyOfScaleHalfWidth && isTickWidthChanged === false && isTickAmountChanged === false) {
                if (false == tickDataIsDirty) {
                    return;
                }
            }
            else {
                this.cachedTickWidth = viewTickWidth;
                this.cachedTickAmount = numberOfOrderedTickList;
            }
            var elements = this.elements = new Array(numberOfOrderedTickList);
            var numberOfElements = elements.length;
            var viewTickWidth = candlestickChart.getViewTickWidth();
            for (var i = 0; i < numberOfElements; ++i) {
                var xCoord = i * viewTickWidth;
                elements[i] = {
                    spanType: null,
                    viewXCoord: Math.floor(xCoord + viewTickHalfWidth),
                    viewXLeftCoord: Math.floor(xCoord),
                    viewXRightCoord: Math.floor(xCoord + viewTickWidth),
                };
            }
            this.totalWidth = Math.ceil(viewTickWidth * numberOfOrderedTickList);
            if (numberOfOrderedTickList > 0) {
                var endIndex = numberOfOrderedTickList - 1;
                var tickBegin = orderedTickList[0];
                var tickEnd = orderedTickList[endIndex];
                var timezoneOffsetInMinutes = candlestickChart.getTimezoneOffsetInMinutes();
                var timezoneOffsetInMsec = timezoneOffsetInMinutes * 60 * 1000;
                var offsetTimeOfBegin = new Date(tickBegin.getDatetime().getTime() + timezoneOffsetInMsec);
                var offsetTimeOfEnd = new Date(tickEnd.getDatetime().getTime() + timezoneOffsetInMsec);
                if (offsetTimeOfBegin.getUTCFullYear() != offsetTimeOfEnd.getUTCFullYear()) {
                    this.generateSpansForUpdating(orderedTickList, 0, endIndex, CscApi.SpanTypeEnum.YEAR, 'getUTCFullYear');
                }
                else if (offsetTimeOfBegin.getUTCMonth() != offsetTimeOfEnd.getUTCMonth()) {
                    this.generateSpansForUpdating(orderedTickList, 0, endIndex, CscApi.SpanTypeEnum.MONTH, 'getUTCMonth');
                }
                else if (offsetTimeOfBegin.getUTCDate() != offsetTimeOfEnd.getUTCDate()) {
                    this.generateSpansForUpdating(orderedTickList, 0, endIndex, CscApi.SpanTypeEnum.DAY, 'getUTCDate');
                }
                else if (offsetTimeOfBegin.getUTCHours() != offsetTimeOfEnd.getUTCHours()) {
                    this.generateSpansForUpdating(orderedTickList, 0, endIndex, CscApi.SpanTypeEnum.HOUR, 'getUTCHours');
                }
                else if (offsetTimeOfBegin.getUTCMinutes() != offsetTimeOfEnd.getUTCMinutes()) {
                    this.generateSpansForUpdating(orderedTickList, 0, endIndex, CscApi.SpanTypeEnum.MINUTE, 'getUTCMinutes');
                }
                else {
                }
            }
            return true;
        };
        TimeScale.prototype.setType = function (scaleType) {
            switch (scaleType) {
                case CscApi.ScaleTypeEnum.MINUTES:
                    this.scalePattern = 'mm';
                    break;
                case CscApi.ScaleTypeEnum.HOURS:
                    this.scalePattern = 'hh';
                    break;
                case CscApi.ScaleTypeEnum.DAYS:
                case CscApi.ScaleTypeEnum.WEEKS:
                    this.scalePattern = 'dd';
                    break;
                case CscApi.ScaleTypeEnum.MONTHS:
                case CscApi.ScaleTypeEnum.YEARS:
                    this.scalePattern = 'MM';
                    break;
                default:
                    console.error('unknown scale type.');
                    return;
            }
            this.scaleType = scaleType;
            this.scaleSpanTypeEnabled = TYPE_SPANS[scaleType];
        };
        ;
        TimeScale.prototype.generateSpansForUpdating = function (orderedTickList, fromIndex, toIndex, spanType, getterOnDate) {
            if (true !== this.scaleSpanTypeEnabled[spanType]) {
                return;
            }
            var i = fromIndex;
            var elements = this.elements;
            var n1Datetime = orderedTickList[i].getDatetime();
            var n1 = n1Datetime[getterOnDate]();
            if (spanType !== CscApi.SpanTypeEnum.MINUTE) {
                var scaleHalfWidth = this.betweenScaleHalfWidth[spanType];
                var occupiedFromIndexList = [];
                var occupiedToIndexList = [];
                while (++i <= toIndex) {
                    var tickData = orderedTickList[i];
                    var n2Datetime = tickData.getDatetime();
                    var n2 = n2Datetime[getterOnDate]();
                    if (n1 !== n2) {
                        n1 = n2;
                        var element = elements[i];
                        element.spanType = spanType;
                        var xFrom = element.viewXCoord - scaleHalfWidth;
                        var xTo = element.viewXCoord + scaleHalfWidth;
                        var newFromIndex = this.getTickIndexFromX(xFrom);
                        var newToIndex = this.getTickIndexFromX(xTo);
                        occupiedFromIndexList.push(newFromIndex);
                        occupiedToIndexList.push(newToIndex);
                        i = newToIndex;
                    }
                }
                occupiedFromIndexList.push(toIndex);
                occupiedToIndexList.push(toIndex);
                var numberofOccupied = occupiedFromIndexList.length;
                var nextBeginIndex = fromIndex;
                var nextSpanType;
                var nextGetterOnDate;
                switch (spanType) {
                    case CscApi.SpanTypeEnum.HOUR:
                        nextSpanType = CscApi.SpanTypeEnum.MINUTE;
                        nextGetterOnDate = 'getUTCMinutes';
                        break;
                    case CscApi.SpanTypeEnum.DAY:
                        nextSpanType = CscApi.SpanTypeEnum.HOUR;
                        nextGetterOnDate = 'getUTCHours';
                        break;
                    case CscApi.SpanTypeEnum.MONTH:
                        nextSpanType = CscApi.SpanTypeEnum.DAY;
                        nextGetterOnDate = 'getUTCDate';
                        break;
                    case CscApi.SpanTypeEnum.YEAR:
                        nextSpanType = CscApi.SpanTypeEnum.MONTH;
                        nextGetterOnDate = 'getUTCMonth';
                        break;
                }
                for (var i = 0; i < numberofOccupied; ++i) {
                    var nextEndIndex = occupiedFromIndexList[i];
                    this.generateSpansForUpdating(orderedTickList, nextBeginIndex, nextEndIndex, nextSpanType, nextGetterOnDate);
                    nextBeginIndex = occupiedToIndexList[i];
                }
            }
            else {
                var scaleHalfWidth = this.betweenScaleHalfWidth[spanType];
                while (++i <= toIndex) {
                    var tickData = orderedTickList[i];
                    var n2Datetime = tickData.getDatetime();
                    var n2 = n2Datetime.getUTCMinutes();
                    if (n1 !== n2) {
                        n1 = n2;
                        var element = elements[i];
                        element.spanType = spanType;
                        var xTo = element.viewXCoord + scaleHalfWidth;
                        var newToIndex = this.getTickIndexFromX(xTo);
                        i = newToIndex;
                    }
                }
            }
        };
        return TimeScale;
    })();
    CscImpl.TimeScale = TimeScale;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfRsi = (function (_super) {
        __extends(ChartOfRsi, _super);
        function ChartOfRsi(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.RSI, area, handleId, width, height, DECIMAL_DIGITS, 'RSI');
            this.elementDiffRisingList = null;
            this.elementDiffFallingList = null;
            this.elementRsiShortList = null;
            this.elementRsiLongList = null;
            this.elementViewRsiShortDragon = null;
            this.elementViewRsiLongDragon = null;
        }
        ChartOfRsi.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configShortPeriod = config.params['shortPeriod'];
            var configLongPeriod = config.params['longPeriod'];
            var configRsiShortLineWidth = config.params['rsiShortLineWidth'];
            var configRsiShortLineColorRgba = config.params['rsiShortLineColorRgba'];
            var configRsiLongLineWidth = config.params['rsiLongLineWidth'];
            var configRsiLongLineColorRgba = config.params['rsiLongLineColorRgba'];
            this.argShortPeriod = configShortPeriod.value;
            this.argLongPeriod = configLongPeriod.value;
            this.styleRsiShortLineWidth = configRsiShortLineWidth.value;
            this.styleRsiShortLineColorRgba = configRsiShortLineColorRgba.value;
            this.styleRsiLongLineWidth = configRsiLongLineWidth.value;
            this.styleRsiLongLineColorRgba = configRsiLongLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfRsi.prototype.getArgShortPeriod = function () {
            return this.argShortPeriod;
        };
        ChartOfRsi.prototype.setArgShortPeriod = function (period) {
            this.argShortPeriod = period;
            this.config.params['shortPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfRsi.prototype.getArgLongPeriod = function () {
            return this.argLongPeriod;
        };
        ChartOfRsi.prototype.setArgLongPeriod = function (period) {
            this.argLongPeriod = period;
            this.config.params['longPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfRsi.prototype.getStyleRsiShortLineWidth = function () {
            return this.styleRsiShortLineWidth;
        };
        ChartOfRsi.prototype.setStyleRsiShortLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleRsiShortLineWidth = lineWidth;
            this.config.params['rsiShortLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfRsi.prototype.getStyleRsiShortLineColorRgba = function () {
            return this.styleRsiShortLineColorRgba;
        };
        ChartOfRsi.prototype.setStyleRsiShortLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleRsiShortLineColorRgba = colorRgba;
            this.config.params['rsiShortLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfRsi.prototype.getStyleRsiLongLineWidth = function () {
            return this.styleRsiLongLineWidth;
        };
        ChartOfRsi.prototype.setStyleRsiLongLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleRsiLongLineWidth = lineWidth;
            this.config.params['rsiLongLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfRsi.prototype.getStyleRsiLongLineColorRgba = function () {
            return this.styleRsiLongLineColorRgba;
        };
        ChartOfRsi.prototype.setStyleRsiLongLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleRsiLongLineColorRgba = colorRgba;
            this.config.params['rsiLongLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfRsi.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementRsiShortList.length) {
                return this.elementRsiShortList[index];
            }
            return null;
        };
        ChartOfRsi.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewRsiShortDragon == null || this.elementViewRsiShortDragon.length !== numberOfDragonComponents) {
                this.elementViewRsiShortDragon = CscApi.Utility.resizeFloat32Array(this.elementViewRsiShortDragon, numberOfDragonComponents);
            }
            if (this.elementViewRsiLongDragon == null || this.elementViewRsiLongDragon.length !== numberOfDragonComponents) {
                this.elementViewRsiLongDragon = CscApi.Utility.resizeFloat32Array(this.elementViewRsiLongDragon, numberOfDragonComponents);
            }
            if (this.elementDiffRisingList == null || this.elementDiffRisingList.length !== numberOfOrderedTickList) {
                this.elementDiffRisingList = CscApi.Utility.resizeFloat32Array(this.elementDiffRisingList, numberOfOrderedTickList);
            }
            if (this.elementDiffFallingList == null || this.elementDiffFallingList.length !== numberOfOrderedTickList) {
                this.elementDiffFallingList = CscApi.Utility.resizeFloat32Array(this.elementDiffFallingList, numberOfOrderedTickList);
            }
            if (this.elementRsiShortList == null || this.elementRsiShortList.length !== numberOfOrderedTickList) {
                this.elementRsiShortList = CscApi.Utility.resizeFloat32Array(this.elementRsiShortList, numberOfOrderedTickList);
            }
            if (this.elementRsiLongList == null || this.elementRsiLongList.length !== numberOfOrderedTickList) {
                this.elementRsiLongList = CscApi.Utility.resizeFloat32Array(this.elementRsiLongList, numberOfOrderedTickList);
            }
            var elementDiffRisingList = this.elementDiffRisingList;
            var elementDiffFallingList = this.elementDiffFallingList;
            var elementShortList = this.elementRsiShortList;
            var elementLongList = this.elementRsiLongList;
            var shortPeriod = this.argShortPeriod;
            var longPeriod = this.argLongPeriod;
            var sumRisingShort = 0;
            var sumRisingLong = 0;
            var sumFallingShort = 0;
            var sumFallingLong = 0;
            for (var i = 1; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var prevTickData = orderedTickList[i - 1];
                var diff = tickData.getClose() - prevTickData.getClose();
                var diffRising = diff > 0 ? diff : 0;
                var diffFalling = diff < 0 ? -diff : 0;
                elementDiffRisingList[i] = diffRising;
                elementDiffFallingList[i] = diffFalling;
                sumRisingShort += diffRising;
                sumFallingShort += diffFalling;
                sumRisingLong += diffRising;
                sumFallingLong += diffFalling;
                if (i >= shortPeriod) {
                    var spi = i - shortPeriod;
                    sumRisingShort -= elementDiffRisingList[spi];
                    sumFallingShort -= elementDiffFallingList[spi];
                    if (i >= longPeriod) {
                        var lpi = i - longPeriod;
                        sumRisingLong -= elementDiffRisingList[lpi];
                        sumFallingLong -= elementDiffFallingList[lpi];
                    }
                }
                var pShort = i < shortPeriod ? i + 1 : shortPeriod;
                var pLong = i < longPeriod ? i + 1 : longPeriod;
                var avgRisingShort = sumRisingShort / pShort;
                var avgFallingShort = sumFallingShort / pShort;
                var avgRisingLong = sumRisingLong / pLong;
                var avgFallingLong = sumFallingLong / pLong;
                elementShortList[i] = 100 * avgRisingShort / (avgRisingShort + avgFallingShort);
                elementLongList[i] = 100 * avgRisingLong / (avgRisingLong + avgFallingLong);
            }
        };
        ChartOfRsi.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementRsiShortList = this.elementRsiShortList;
            var elementRsiLongList = this.elementRsiLongList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var rsiShort = elementRsiShortList[vi];
                var rsiLong = elementRsiLongList[vi];
                if (false == isNaN(rsiShort)) {
                    if (rsiShort > highestValue)
                        highestValue = rsiShort;
                    if (rsiShort < lowestValue)
                        lowestValue = rsiShort;
                }
                if (false == isNaN(rsiLong)) {
                    if (rsiLong > highestValue)
                        highestValue = rsiLong;
                    if (rsiLong < lowestValue)
                        lowestValue = rsiLong;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfRsi.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementRsiShortList = this.elementRsiShortList;
            var elementRsiLongList = this.elementRsiLongList;
            var elementViewRsiShortDragon = this.elementViewRsiShortDragon;
            var elementViewRsiLongDragon = this.elementViewRsiLongDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argShortPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementRsiShortList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var rsiShort = elementRsiShortList[i];
                var rsiLong = elementRsiLongList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewRsiShortDragon[vi] = viewXCoord;
                elementViewRsiShortDragon[vyi] = isNaN(rsiShort) ? NaN : Math.floor(valueToYCoordConvertor(rsiShort));
                elementViewRsiLongDragon[vi] = viewXCoord;
                elementViewRsiLongDragon[vyi] = isNaN(rsiLong) ? NaN : Math.floor(valueToYCoordConvertor(rsiLong));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfRsi.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argShortPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementRsiShortList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argShortPeriod ? viewStartTickIndex : this.argShortPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleRsiShortLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleRsiShortLineColorRgba);
                this.drawDragon(this.elementViewRsiShortDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleRsiLongLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleRsiLongLineColorRgba);
                this.drawDragon(this.elementViewRsiLongDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfRsi.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var rsiShort = this.elementRsiShortList[focusElementIndex];
                var rsiLong = this.elementRsiLongList[focusElementIndex];
                valueInfoList = [
                    { name: 'Short Period', value: this.argShortPeriod.toString(), valueColor: null },
                    { name: 'Long Period', value: this.argLongPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(rsiShort))
                    valueInfoList.push({ name: 'RSI Short', value: rsiShort.toFixed(DECIMAL_DIGITS), valueColor: this.styleRsiShortLineColorRgba });
                if (false === isNaN(rsiLong))
                    valueInfoList.push({ name: 'RSI Long', value: rsiLong.toFixed(DECIMAL_DIGITS), valueColor: this.styleRsiLongLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfRsi;
    })(CscImpl.Chart);
    CscImpl.ChartOfRsi = ChartOfRsi;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfOsMa = (function (_super) {
        __extends(ChartOfOsMa, _super);
        function ChartOfOsMa(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.OSMA, area, handleId, width, height, DECIMAL_DIGITS, 'OSMA');
            this.elementDiffList = null;
            this.elementDemList = null;
            this.elementMacdList = null;
            this.elementViewMacd = null;
        }
        ChartOfOsMa.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configShortPeriod = config.params['shortPeriod'];
            var configLongPeriod = config.params['longPeriod'];
            var configPeriodSignal = config.params['periodSignal'];
            var configMacdPositiveColorRgba = config.params['macdPositiveColorRgba'];
            var configMacdNegativeColorRgba = config.params['macdNegativeColorRgba'];
            this.argShortPeriod = configShortPeriod.value;
            this.argLongPeriod = configLongPeriod.value;
            this.argPeriodSignal = configPeriodSignal.value;
            this.styleMacdPositiveColorRgba = configMacdPositiveColorRgba.value;
            this.styleMacdNegativeColorRgba = configMacdNegativeColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfOsMa.prototype.getArgShortPeriod = function () {
            return this.argShortPeriod;
        };
        ChartOfOsMa.prototype.setArgShortPeriod = function (period) {
            this.argShortPeriod = period;
            this.config.params['shortPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfOsMa.prototype.getArgLongPeriod = function () {
            return this.argLongPeriod;
        };
        ChartOfOsMa.prototype.setArgLongPeriod = function (period) {
            this.argLongPeriod = period;
            this.config.params['longPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfOsMa.prototype.getArgPeriodSignal = function () {
            return this.argPeriodSignal;
        };
        ChartOfOsMa.prototype.setArgPeriodSignal = function (periodSignal) {
            this.argPeriodSignal = periodSignal;
            this.config.params['periodSignal'].value = periodSignal;
            this.setArgDirty(true);
            return true;
        };
        ChartOfOsMa.prototype.getStyleMacdPositiveColorRgba = function () {
            return this.styleMacdPositiveColorRgba;
        };
        ChartOfOsMa.prototype.setStyleMacdPositiveColorRgba = function (colorRgba) {
            this.styleMacdPositiveColorRgba = colorRgba;
            this.config.params['macdPositiveColorRgba'].value = colorRgba;
        };
        ChartOfOsMa.prototype.getStyleMacdNegativeColorRgba = function () {
            return this.styleMacdNegativeColorRgba;
        };
        ChartOfOsMa.prototype.setStyleMacdNegativeColorRgba = function (colorRgba) {
            this.styleMacdNegativeColorRgba = colorRgba;
            this.config.params['macdNegativeColorRgba'].value = colorRgba;
        };
        ChartOfOsMa.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementDiffList.length) {
                return this.elementDiffList[index];
            }
            return null;
        };
        ChartOfOsMa.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewMacd == null || this.elementViewMacd.length !== numberOfOrderedTickList) {
                this.elementViewMacd = CscApi.Utility.resizeFloat32Array(this.elementViewMacd, numberOfOrderedTickList);
            }
            if (this.elementDiffList == null || this.elementDiffList.length !== numberOfOrderedTickList) {
                this.elementDiffList = CscApi.Utility.resizeFloat32Array(this.elementDiffList, numberOfOrderedTickList);
            }
            if (this.elementDemList == null || this.elementDemList.length !== numberOfOrderedTickList) {
                this.elementDemList = CscApi.Utility.resizeFloat32Array(this.elementDemList, numberOfOrderedTickList);
            }
            if (this.elementMacdList == null || this.elementMacdList.length !== numberOfOrderedTickList) {
                this.elementMacdList = CscApi.Utility.resizeFloat32Array(this.elementMacdList, numberOfOrderedTickList);
            }
            var elementDiffList = this.elementDiffList;
            var elementDemList = this.elementDemList;
            var elementMacdList = this.elementMacdList;
            var shortPeriod = this.argShortPeriod;
            var longPeriod = this.argLongPeriod;
            var periodSignal = this.argPeriodSignal;
            var sumShort = 0;
            var sumLong = 0;
            var sumDiff = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                elementDiffList[i] = NaN;
                elementDemList[i] = NaN;
                elementMacdList[i] = NaN;
                sumShort += tickData.getClose();
                sumLong += tickData.getClose();
                if (i >= shortPeriod) {
                    sumShort -= orderedTickList[i - shortPeriod].getClose();
                    if (i >= longPeriod) {
                        sumLong -= orderedTickList[i - longPeriod].getClose();
                        var diff = sumShort / shortPeriod - sumLong / longPeriod;
                        elementDiffList[i] = diff;
                        sumDiff += diff;
                        if (i >= longPeriod + periodSignal) {
                            sumDiff -= elementDiffList[i - periodSignal];
                            var dem = sumDiff / periodSignal;
                            elementDemList[i] = dem;
                            elementMacdList[i] = diff - dem;
                        }
                    }
                }
            }
        };
        ChartOfOsMa.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementDiffList = this.elementDiffList;
            var elementDemList = this.elementDemList;
            var elementMacdList = this.elementMacdList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var diff = elementDiffList[vi];
                var dem = elementDemList[vi];
                var macd = elementMacdList[vi];
                if (false == isNaN(diff)) {
                    if (diff > highestValue)
                        highestValue = diff;
                    if (diff < lowestValue)
                        lowestValue = diff;
                }
                if (false == isNaN(dem)) {
                    if (dem > highestValue)
                        highestValue = dem;
                    if (dem < lowestValue)
                        lowestValue = dem;
                }
                if (false == isNaN(macd)) {
                    if (macd > highestValue)
                        highestValue = macd;
                    if (macd < lowestValue)
                        lowestValue = macd;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfOsMa.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementDiffList = this.elementDiffList;
            var elementDemList = this.elementDemList;
            var elementMacdList = this.elementMacdList;
            var elementViewMacd = this.elementViewMacd;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argShortPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementDiffList.length - 1) {
                viewEndTickIndex++;
            }
            var viewZeroValueYCoord = this.viewZeroValueYCoord = Math.floor(valueToYCoordConvertor(0));
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var macd = elementMacdList[i];
                elementViewMacd[i] = Math.floor(valueToYCoordConvertor(macd)) - viewZeroValueYCoord;
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfOsMa.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndexOfShort = viewStartTickIndex >= this.argShortPeriod ? viewStartTickIndex : this.argShortPeriod;
            var firstPointIndexOfLong = viewStartTickIndex >= this.argLongPeriod ? viewStartTickIndex : this.argLongPeriod;
            renderer.translate(-viewStartXCoord, 0);
            var elementViewMacdHeight = this.elementViewMacd;
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var macdPoleWidth = Math.floor(viewTickWidth * 0.8);
            if (macdPoleWidth < 1) {
                macdPoleWidth = 1;
            }
            var macdPoleHalfWidth = Math.floor(macdPoleWidth * 0.5);
            if (macdPoleHalfWidth < 0) {
                macdPoleHalfWidth = 0;
            }
            var timeScale = candlestickChart.getTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var elementMacdList = this.elementMacdList;
            var styleMacdPositiveColorRgba = this.styleMacdPositiveColorRgba;
            var styleMacdNegativeColorRgba = this.styleMacdNegativeColorRgba;
            var viewZeroValueYCoord = this.viewZeroValueYCoord;
            renderer.translate(-macdPoleHalfWidth, 0);
            if (macdPoleWidth > 1) {
                renderer.setFillColorRgba(styleMacdPositiveColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd > 0) {
                        renderer.fillRect(viewXCoord, viewZeroValueYCoord, macdPoleWidth, macdHeight);
                    }
                }
                renderer.setFillColorRgba(styleMacdNegativeColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd < 0) {
                        renderer.fillRect(viewXCoord, viewZeroValueYCoord, macdPoleWidth, macdHeight);
                    }
                }
            }
            else {
                var prevViewXCoord = null;
                renderer.setStrokeColorRgba(styleMacdPositiveColorRgba);
                var highestMacd = -Infinity;
                var highestMacdPoleHeight;
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd > 0) {
                        if (macd > highestMacd) {
                            highestMacd = macd;
                            highestMacdPoleHeight = macdHeight;
                        }
                        if (prevViewXCoord !== viewXCoord) {
                            prevViewXCoord = viewXCoord;
                            highestMacd = -Infinity;
                            renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + highestMacdPoleHeight);
                        }
                    }
                }
                if (isFinite(highestMacd)) {
                    renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + highestMacdPoleHeight);
                }
                renderer.setStrokeColorRgba(styleMacdNegativeColorRgba);
                var lowestMacd = Infinity;
                var lowestMacdPoleHeight;
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd < 0) {
                        if (macd < lowestMacd) {
                            lowestMacd = macd;
                            lowestMacdPoleHeight = macdHeight;
                        }
                        if (prevViewXCoord !== viewXCoord) {
                            prevViewXCoord = viewXCoord;
                            lowestMacd = Infinity;
                            renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + lowestMacdPoleHeight);
                        }
                    }
                }
                if (isFinite(lowestMacd)) {
                    renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + lowestMacdPoleHeight);
                }
            }
            renderer.translate(macdPoleHalfWidth, 0);
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfOsMa.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var macd = this.elementMacdList[focusElementIndex];
                valueInfoList = [
                    { name: 'Short', value: this.argShortPeriod.toString(), valueColor: null },
                    { name: 'Long', value: this.argLongPeriod.toString(), valueColor: null },
                    { name: 'Signal', value: this.argPeriodSignal.toString(), valueColor: null },
                ];
                if (false === isNaN(macd))
                    valueInfoList.push({ name: 'OSMA', value: macd.toFixed(DECIMAL_DIGITS), valueColor: macd >= 0 ? this.styleMacdPositiveColorRgba : this.styleMacdNegativeColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfOsMa;
    })(CscImpl.Chart);
    CscImpl.ChartOfOsMa = ChartOfOsMa;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfAtr = (function (_super) {
        __extends(ChartOfAtr, _super);
        function ChartOfAtr(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.ATR, area, handleId, width, height, DECIMAL_DIGITS, 'ATR');
            this.elementTrList = null;
            this.elementAtrList = null;
            this.elementViewAtrDragon = null;
        }
        ChartOfAtr.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configAtrLineWidth = config.params['atrLineWidth'];
            var configAtrLineColorRgba = config.params['atrLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleAtrLineWidth = configAtrLineWidth.value;
            this.styleAtrLineColorRgba = configAtrLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfAtr.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfAtr.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfAtr.prototype.getStyleAtrLineWidth = function () {
            return this.styleAtrLineWidth;
        };
        ChartOfAtr.prototype.setStyleAtrLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleAtrLineWidth = lineWidth;
            this.config.params['atrLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfAtr.prototype.getStyleAtrLineColorRgba = function () {
            return this.styleAtrLineColorRgba;
        };
        ChartOfAtr.prototype.setStyleAtrLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleAtrLineColorRgba = colorRgba;
            this.config.params['atrLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfAtr.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementAtrList.length) {
                return this.elementAtrList[index];
            }
            return null;
        };
        ChartOfAtr.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewAtrDragon == null || this.elementViewAtrDragon.length !== numberOfDragonComponents) {
                this.elementViewAtrDragon = CscApi.Utility.resizeFloat32Array(this.elementViewAtrDragon, numberOfDragonComponents);
            }
            if (this.elementTrList == null || this.elementTrList.length !== numberOfOrderedTickList) {
                this.elementTrList = CscApi.Utility.resizeFloat32Array(this.elementTrList, numberOfOrderedTickList);
            }
            if (this.elementAtrList == null || this.elementAtrList.length !== numberOfOrderedTickList) {
                this.elementAtrList = CscApi.Utility.resizeFloat32Array(this.elementAtrList, numberOfOrderedTickList);
            }
            var elementTrList = this.elementTrList;
            var elementAtrList = this.elementAtrList;
            var period = this.argPeriod;
            var sumTr = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var tr;
                if (i > 0) {
                    var prevTickData = orderedTickList[i - 1];
                    var prevClose = prevTickData.getClose();
                    tr = elementTrList[i] = Math.max(tickData.getHigh(), prevClose) - Math.min(tickData.getLow(), prevClose);
                }
                else {
                    tr = elementTrList[i] = tickData.getHigh() - tickData.getLow();
                }
                if (i >= period) {
                    elementAtrList[i] = sumTr / period;
                    sumTr -= elementTrList[i - period];
                }
                else {
                    elementAtrList[i] = NaN;
                }
                sumTr += tr;
            }
        };
        ChartOfAtr.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementAtrList = this.elementAtrList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var atr = elementAtrList[vi];
                if (false == isNaN(atr)) {
                    if (atr > highestValue)
                        highestValue = atr;
                    if (atr < lowestValue)
                        lowestValue = atr;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfAtr.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementAtrList = this.elementAtrList;
            var elementViewAtrDragon = this.elementViewAtrDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementAtrList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var atr = elementAtrList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewAtrDragon[vi] = viewXCoord;
                elementViewAtrDragon[vyi] = isNaN(atr) ? NaN : Math.floor(valueToYCoordConvertor(atr));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfAtr.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementAtrList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleAtrLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleAtrLineColorRgba);
                this.drawDragon(this.elementViewAtrDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfAtr.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var atr = this.elementAtrList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(atr))
                    valueInfoList.push({ name: 'ATR', value: atr.toFixed(DECIMAL_DIGITS), valueColor: this.styleAtrLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfAtr;
    })(CscImpl.Chart);
    CscImpl.ChartOfAtr = ChartOfAtr;
})(CscImpl || (CscImpl = {}));
var CscApi;
(function (CscApi) {
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
    var Utility = (function () {
        function Utility() {
        }
        Utility.getCurrentTimeMsec = function () {
            if (performance) {
                return performance.now();
            }
            else {
                return new Date().getTime();
            }
        };
        Utility.anchorProfile = function () {
            var lastAnchorTime = Utility.anchorTime;
            Utility.anchorTime = Utility.getCurrentTimeMsec();
            if (lastAnchorTime != undefined) {
                return Utility.anchorTime - lastAnchorTime;
            }
        };
        Utility.getLocale = function () {
            return navigator.language;
        };
        Utility.registerEvent = function (dom, eventName, caller, callback) {
            var handler = function () {
                callback.apply(caller, arguments);
            };
            var useCapture = false;
            eventName = eventName.replace(/^on/, '');
            dom.addEventListener(eventName, handler, useCapture);
            return function () {
                dom.removeEventListener(eventName, handler, useCapture);
            };
        };
        ;
        Utility.leadingZero = function (value, digits) {
            return (new Array(digits).join('0') + value).slice(-digits);
        };
        Utility.colorStringToArray = function (colorStr) {
            if (colorStr.indexOf('rgba') != -1) {
                return Utility.rgbaStringToArray(colorStr);
            }
            return Utility.rgbStringToArray(colorStr);
        };
        Utility.rgbStringToArray = function (rgbStr) {
            var arr = [];
            rgbStr.replace(/rgb\((.*),(.*),(.*)\)/, function ($str, $1, $2, $3, $4) {
                var r = parseInt($1);
                var g = parseInt($2);
                var b = parseInt($3);
                arr = arr.concat([r, g, b]);
            });
            return arr;
        };
        Utility.rgbaStringToArray = function (rgbaStr) {
            var arr = [];
            rgbaStr.replace(/rgba\((.*),(.*),(.*),(.*)\)/, function ($str, $1, $2, $3, $4) {
                var r = parseInt($1);
                var g = parseInt($2);
                var b = parseInt($3);
                var a = Math.floor(parseFloat($4) * 255);
                arr = arr.concat([r, g, b, a]);
            });
            return arr;
        };
        Utility.rgbArrayToHexStr = function (rgbArr) {
            return '#' +
                Utility.leadingZero(rgbArr[0].toString(16), 2) +
                Utility.leadingZero(rgbArr[1].toString(16), 2) +
                Utility.leadingZero(rgbArr[2].toString(16), 2);
        };
        Utility.rgbaArrayToStr = function (rgbaArr) {
            return 'rgba(' +
                rgbaArr[0] + ',' +
                rgbaArr[1] + ',' +
                rgbaArr[2] + ',' +
                (rgbaArr[3] / 255).toFixed(3) + ')';
        };
        Utility.getContrastiveColor = function (color, contrast, alpha) {
            if (color == null) {
                console.log('getContrastiveColor: arg of color is invalid.');
                return null;
            }
            var rgb = color.replace(/[^\d,]/g, '').split(',');
            var r = parseFloat(rgb[0]) * 1;
            var g = parseFloat(rgb[1]) * 1;
            var b = parseFloat(rgb[2]) * 1;
            if (alpha && alpha >= 0 && alpha <= 1) {
                return 'rgba('
                    + Math.floor((r < 128 ? r + (255 - r) * contrast : r - r * contrast)) + ','
                    + Math.floor((g < 128 ? g + (255 - g) * contrast : g - g * contrast)) + ','
                    + Math.floor((b < 128 ? b + (255 - b) * contrast : b - b * contrast)) + ','
                    + alpha
                    + ')';
            }
            else {
                return 'rgb('
                    + Math.floor((r < 128 ? r + (255 - r) * contrast : r - r * contrast)) + ','
                    + Math.floor((g < 128 ? g + (255 - g) * contrast : g - g * contrast)) + ','
                    + Math.floor((b < 128 ? b + (255 - b) * contrast : b - b * contrast))
                    + ')';
            }
        };
        Utility.round = function (value, decimalDigits) {
            var tmpPow = Math.pow(10, decimalDigits);
            return Math.round(value * tmpPow) / tmpPow;
        };
        Utility.getTimezone = function () {
            return -(new Date().getTimezoneOffset() / 60);
        };
        ;
        Utility.getTimezoneMinutes = function () {
            return -(new Date().getTimezoneOffset());
        };
        ;
        Utility.isDateValid = function (d) {
            return false == isNaN(d.getTime());
        };
        Utility.offsetTimestampByMinutes = function (timestamp, timezoneOffsetInMinutes) {
            return timestamp + timezoneOffsetInMinutes * 60 * 1000;
        };
        Utility.resizeArray = function (original, resizeNumberOfElements) {
            if (original == null) {
                return Array(resizeNumberOfElements);
            }
            original.length = resizeNumberOfElements;
            return original;
        };
        Utility.resizeUint8Array = function (original, resizeNumberOfElements) {
            if (resizeNumberOfElements <= 0) {
                resizeNumberOfElements = 0;
            }
            if (original == null) {
                return new Uint8Array(resizeNumberOfElements);
            }
            else if (resizeNumberOfElements > original.length) {
                var result = new Uint8Array(resizeNumberOfElements);
                result.set(original);
                return result;
            }
            else if (resizeNumberOfElements < original.length) {
                return original.subarray(0, resizeNumberOfElements);
            }
            return original;
        };
        Utility.resizeFloat32Array = function (original, resizeNumberOfElements) {
            if (resizeNumberOfElements <= 0) {
                resizeNumberOfElements = 0;
            }
            if (original == null) {
                return new Float32Array(resizeNumberOfElements);
            }
            else if (resizeNumberOfElements > original.length) {
                var result = new Float32Array(resizeNumberOfElements);
                result.set(original);
                return result;
            }
            else if (resizeNumberOfElements < original.length) {
                return original.subarray(0, resizeNumberOfElements);
            }
            return original;
        };
        Utility.anchorTime = Utility.anchorProfile();
        Utility.formatDate = function (date, pattern) {
            var o = {
                "M+": date.getMonth() + 1,
                "d+": date.getDate(),
                "h+": date.getHours(),
                "m+": date.getMinutes(),
                "s+": date.getSeconds(),
                "q+": Math.floor((date.getMonth() + 3) / 3),
                "S": date.getMilliseconds()
            };
            if (/(y+)/.test(pattern)) {
                pattern = pattern.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
            }
            for (var k in o) {
                if (new RegExp("(" + k + ")").test(pattern)) {
                    pattern = pattern.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                }
            }
            return pattern;
        };
        Utility.formatUTCDate = function (date, pattern) {
            var o = {
                "M+": date.getUTCMonth() + 1,
                "d+": date.getUTCDate(),
                "h+": date.getUTCHours(),
                "m+": date.getUTCMinutes(),
                "s+": date.getUTCSeconds(),
                "q+": Math.floor((date.getUTCMonth() + 3) / 3),
                "S": date.getUTCMilliseconds()
            };
            if (/(y+)/.test(pattern)) {
                pattern = pattern.replace(RegExp.$1, (date.getUTCFullYear() + "").substr(4 - RegExp.$1.length));
            }
            for (var k in o) {
                if (new RegExp("(" + k + ")").test(pattern)) {
                    pattern = pattern.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                }
            }
            return pattern;
        };
        Utility.formatUTCTimestamp = function (timestamp, pattern, timezoneOffsetInMinutes) {
            var offsetDatetime = Utility.offsetTimestampByMinutes(timestamp, timezoneOffsetInMinutes);
            return Utility.formatUTCDate(new Date(offsetDatetime), pattern);
        };
        return Utility;
    })();
    CscApi.Utility = Utility;
})(CscApi || (CscApi = {}));
var CscApi;
(function (CscApi) {
    var SnGenerator = (function () {
        function SnGenerator() {
            this.sn = 0;
            this.recycleSnList = [];
        }
        SnGenerator.prototype.allocate = function () {
            if (this.recycleSnList.length > 0) {
                return this.recycleSnList.pop();
            }
            return this.sn++;
        };
        SnGenerator.prototype.recycle = function (sn) {
            this.recycleSnList.push(sn);
        };
        return SnGenerator;
    })();
    CscApi.SnGenerator = SnGenerator;
})(CscApi || (CscApi = {}));
/// <reference path="candlestickChartApi.ts" />
var CscApi;
(function (CscApi) {
    var ChartType = CscApi.ChartType;
    var ChartParameterValueType = CscApi.ConfigParameterValueType;
    CscApi.defaultChartConfigs = {};
    CscApi.defaultChartConfigs[ChartType.TIME_SCALE] = {
        name: 'TIME SCALE',
        params: {}
    };
    CscApi.defaultChartConfigs[ChartType.OHLC] = {
        name: 'OHLC',
        params: {
            'ohlcType': {
                valueType: ChartParameterValueType.ENUM,
                value: CscApi.OhlcType.REALITY,
                visible: false,
                enumList: [CscApi.OhlcType.REALITY, CscApi.OhlcType.HEIKIN_ASHI],
            },
            'ohlcBarType': {
                valueType: ChartParameterValueType.ENUM,
                value: CscApi.OhlcBarType.CANDLESTICK,
                visible: false,
                enumList: [CscApi.OhlcBarType.BAR, CscApi.OhlcBarType.CANDLESTICK],
            },
            'candlestickRisingColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [255, 64, 64, 76],
                visible: false,
            },
            'candlestickFallingColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 255, 64, 76],
                visible: false,
            },
            'barRisingColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [215, 32, 32, 255],
                visible: false,
            },
            'barFallingColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [32, 205, 32, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.AO] = {
        name: 'AO',
        params: {
            'shortPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 12,
                visible: true,
            },
            'longPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 26,
                visible: true,
            },
            'positiveColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 64, 255, 255],
                visible: false,
            },
            'negativeColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 64, 64, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.ARBR] = {
        name: 'ARBR',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 12,
                visible: true,
            },
            'arLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'arLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 64, 255, 255],
                visible: false,
            },
            'brLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'brLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 64, 64, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.ATR] = {
        name: 'ATR',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 12,
                visible: true,
            },
            'atrLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'atrLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 128, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.BIAS] = {
        name: 'BIAS',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 14,
                visible: true,
            },
            'biasLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'biasLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 128, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.BIAS_AB] = {
        name: 'A-B BIAS',
        params: {
            'shortPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 3,
                visible: true,
            },
            'longPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 6,
                visible: true,
            },
            'biasLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'biasLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 128, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.BOLLINGER_BAND] = {
        name: 'Bollinger Band',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 20,
                visible: true,
            },
            'k': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: true,
            },
            'lineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 1,
                visible: false,
            },
            'lineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [96, 140, 225, 255],
                visible: false,
            },
            'fillColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 128, 255, 20],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.CCI] = {
        name: 'CCI',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 14,
                visible: true,
            },
            'cciLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'cciLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 128, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.DMI] = {
        name: 'DMI',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 14,
                visible: true,
            },
            'dmipLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'dmipLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 0, 255],
                visible: false,
            },
            'dminLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'dminLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 0, 0, 255],
                visible: false,
            },
            'adxLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'adxLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 168, 0, 255],
                visible: false,
            },
            'adxrLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'adxrLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 168, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.KDJ] = {
        name: 'KDJ',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 9,
                visible: true,
            },
            'kLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'kLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 0, 0, 255],
                visible: false,
            },
            'dLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'dLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 168, 0, 255],
                visible: false,
            },
            'jLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'jLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.MA] = {
        name: 'MA',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 20,
                visible: true,
            },
            'maLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'maLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 128, 255, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.MACD] = {
        name: 'MACD',
        params: {
            'shortPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 12,
                visible: true,
            },
            'longPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 26,
                visible: true,
            },
            'periodSignal': {
                valueType: ChartParameterValueType.NUMBER,
                value: 9,
                visible: true,
            },
            'diffLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'diffLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 220, 0, 255],
                visible: false,
            },
            'demLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'demLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 220, 64, 255],
                visible: false,
            },
            'macdPositiveColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 64, 255, 255],
                visible: false,
            },
            'macdNegativeColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 64, 64, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.MTM] = {
        name: 'MTM',
        params: {
            'mtmPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 10,
                visible: true,
            },
            'mtmMaPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 10,
                visible: true,
            },
            'mtmLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'mtmLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 0, 168, 255],
                visible: false,
            },
            'mtmMaLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'mtmMaLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 192, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.OBV] = {
        name: 'OBV',
        params: {
            'obvPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 10,
                visible: true,
            },
            'obvMaPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 10,
                visible: true,
            },
            'obvLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'obvLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 0, 168, 255],
                visible: false,
            },
            'obvMaLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'obvMaLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 192, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.PSY] = {
        name: 'PSY',
        params: {
            'psyPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 10,
                visible: true,
            },
            'psyMaPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 10,
                visible: true,
            },
            'psyLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'psyLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 0, 168, 255],
                visible: false,
            },
            'psyMaLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'psyMaLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 192, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.ROC] = {
        name: 'ROC',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 12,
                visible: true,
            },
            'rocLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'rocLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 128, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.RSI] = {
        name: 'RSI',
        params: {
            'shortPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 3,
                visible: true,
            },
            'longPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 6,
                visible: true,
            },
            'rsiShortLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'rsiShortLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [32, 140, 32, 255],
                visible: false,
            },
            'rsiLongLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'rsiLongLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 32, 32, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.RSI_SMOOTH] = {
        name: 'RSI Smooth',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 14,
                visible: true,
            },
            'rsiSmoothLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'rsiSmoothLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.VOLUME] = {
        name: 'Volume',
        params: {
            'volumePoleColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [240, 215, 96, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.VR] = {
        name: 'VR',
        params: {
            'vrPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 24,
                visible: true,
            },
            'vrMaPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 6,
                visible: true,
            },
            'vrLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'vrLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 128, 0, 255],
                visible: false,
            },
            'vrMaLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'vrMaLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [168, 0, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.WR] = {
        name: 'WR',
        params: {
            'period': {
                valueType: ChartParameterValueType.NUMBER,
                value: 14,
                visible: true,
            },
            'wrLineWidth': {
                valueType: ChartParameterValueType.NUMBER,
                value: 2,
                visible: false,
            },
            'wrLineColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [0, 168, 0, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.OSMA] = {
        name: 'OSMA',
        params: {
            'shortPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 12,
                visible: true,
            },
            'longPeriod': {
                valueType: ChartParameterValueType.NUMBER,
                value: 26,
                visible: true,
            },
            'periodSignal': {
                valueType: ChartParameterValueType.NUMBER,
                value: 9,
                visible: true,
            },
            'macdPositiveColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [64, 64, 255, 255],
                visible: false,
            },
            'macdNegativeColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [220, 64, 64, 255],
                visible: false,
            },
        }
    };
    CscApi.defaultChartConfigs[ChartType.SAR] = {
        name: 'SAR',
        params: {
            'sarAfInit': {
                valueType: ChartParameterValueType.NUMBER,
                value: 0.02,
                visible: true,
            },
            'sarAfStep': {
                valueType: ChartParameterValueType.NUMBER,
                value: 0.02,
                visible: true,
            },
            'sarAfLimit': {
                valueType: ChartParameterValueType.NUMBER,
                value: 0.2,
                visible: true,
            },
            'sarDotSize': {
                valueType: ChartParameterValueType.NUMBER,
                value: 1,
                visible: true,
            },
            'sarDotColorRgba': {
                valueType: ChartParameterValueType.COLOR_RGBA,
                value: [255, 255, 255, 255],
                visible: false,
            },
        }
    };
})(CscApi || (CscApi = {}));
var CscApi;
(function (CscApi) {
    var OrderedHashMap = (function () {
        function OrderedHashMap() {
            this._map = {};
            this._orderedKey = [];
        }
        OrderedHashMap.prototype._InsertIntoOrderedKeyBeforeIndex = function (index, key) {
            this._orderedKey.splice(index, 0, key);
        };
        OrderedHashMap.prototype._GetIndex = function (key) {
            var orderedKey = this._orderedKey;
            var upperBoundIndex = orderedKey.length;
            var lowerBoundIndex = -1;
            while (upperBoundIndex - lowerBoundIndex > 1) {
                var index = (upperBoundIndex + lowerBoundIndex) >> 1;
                if (key < orderedKey[index]) {
                    upperBoundIndex = index;
                }
                else if (key > orderedKey[index]) {
                    lowerBoundIndex = index;
                }
                else {
                    return index;
                }
            }
            return null;
        };
        OrderedHashMap.prototype._GetLowerBoundIndex = function (key) {
            var orderedKey = this._orderedKey;
            if (orderedKey.length === 0) {
                return -1;
            }
            var upperBoundIndex = orderedKey.length;
            var lowerBoundIndex = -1;
            while (upperBoundIndex - lowerBoundIndex > 1) {
                var index = (upperBoundIndex + lowerBoundIndex) >> 1;
                if (key < orderedKey[index]) {
                    upperBoundIndex = index;
                }
                else if (key > orderedKey[index]) {
                    lowerBoundIndex = index;
                }
                else {
                    return index;
                }
            }
            return lowerBoundIndex;
        };
        OrderedHashMap.prototype.FindKeyBoundaries = function (key) {
            var points = this.FindKeyBoundaryPointers(key);
            var result = [];
            for (var i = 0; i < points.length; ++i) {
                var point = points[i];
                result.push(point.key);
            }
            return result;
        };
        OrderedHashMap.prototype.FindKeyBoundaryPointers = function (key) {
            var lowerBoundIndex = this._GetLowerBoundIndex(key);
            if (lowerBoundIndex === -1) {
                return [];
            }
            var orderedKey = this._orderedKey;
            var upperBoundIndex = lowerBoundIndex + 1;
            if (upperBoundIndex < orderedKey.length) {
                return [
                    {
                        key: orderedKey[lowerBoundIndex],
                        index: lowerBoundIndex,
                    },
                    {
                        key: orderedKey[upperBoundIndex],
                        index: upperBoundIndex,
                    }
                ];
            }
            return [
                {
                    key: orderedKey[lowerBoundIndex],
                    index: lowerBoundIndex,
                },
            ];
        };
        OrderedHashMap.prototype.GetKeys = function () {
            return this._orderedKey.slice(0);
        };
        OrderedHashMap.prototype.RefKeys = function () {
            return this._orderedKey;
        };
        OrderedHashMap.prototype.GetOrderedValueList = function () {
            var orderedList = [];
            var orderedKey = this._orderedKey;
            var numberOfKey = orderedKey.length;
            var map = this._map;
            for (var i = 0; i < numberOfKey; ++i) {
                orderedList.push(map[orderedKey[i]]);
            }
            return orderedList;
        };
        OrderedHashMap.prototype.Get = function (key) {
            return this._map[key];
        };
        OrderedHashMap.prototype.GetIndex = function (key) {
            return this._GetIndex(key);
        };
        OrderedHashMap.prototype.Clear = function () {
            this._map = {};
            this._orderedKey = [];
        };
        OrderedHashMap.prototype.Put = function (key, value) {
            return this.PutAndCheckIndex(key, value) != null;
        };
        OrderedHashMap.prototype.PutAndCheckIndex = function (key, value) {
            if (this._map[key] !== undefined) {
                return null;
            }
            var orderedKey = this._orderedKey;
            var lowerBoundIndex = this._GetLowerBoundIndex(key);
            var insertIndex = lowerBoundIndex + 1;
            this._InsertIntoOrderedKeyBeforeIndex(insertIndex, key);
            this._map[key] = value;
            return insertIndex;
        };
        OrderedHashMap.prototype.Remove = function (key) {
            var index = this._GetIndex(key);
            if (index != null && index < this._orderedKey.length) {
                this._orderedKey.splice(index, 1);
                var value = this._map[key];
                delete this._map[key];
                return value;
            }
            return null;
        };
        return OrderedHashMap;
    })();
    CscApi.OrderedHashMap = OrderedHashMap;
})(CscApi || (CscApi = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = null;
    var Y_SCALE_ALL_SPANS = {};
    Y_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.YEAR] = 6;
    Y_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.MONTH] = 4;
    Y_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.DAY] = 3;
    Y_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.HOUR] = 2;
    Y_SCALE_ALL_SPANS[CscApi.SpanTypeEnum.MINUTE] = 1;
    var ChartOfTimeScale = (function (_super) {
        __extends(ChartOfTimeScale, _super);
        function ChartOfTimeScale(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.TIME_SCALE, area, handleId, width, height, DECIMAL_DIGITS, 'TIME');
            this.elements = null;
        }
        ChartOfTimeScale.prototype.setConfig = function (config) {
            return true;
        };
        ChartOfTimeScale.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            renderer.clearRect(0, 0, this.getWidth(), this.getHeight());
            renderer.setFillColorRgb([0, 0, 0]);
            renderer.fillRect(0, 0, this.getWidth(), this.getHeight());
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            renderer.translate(-viewStartXCoord, 0);
            renderer.setTextAlignToCenter();
            renderer.setTextBaseLineToTop();
            var candlestickChart = this.refCandlestickChart();
            var style = candlestickChart.getStyle();
            var timeScale = candlestickChart.getTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var context = candlestickChart.getContext();
            var viewStartTickIndex = area.getViewStartTickIndex();
            var viewEndTickIndex = area.getViewEndTickIndex();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            renderer.setTextAlignToCenter();
            renderer.setTextBaseLineToTop();
            var prevSpanType = null;
            var yFix = null;
            var timezoneOffsetInMinutes = candlestickChart.getTimezoneOffsetInMinutes();
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var spanType = timeScaleElement.spanType;
                if (null != spanType) {
                    var tickData = orderedTickList[i];
                    var pattern = CscImpl.FMT_SCALE_ALL_SPANS[spanType];
                    yFix = Y_SCALE_ALL_SPANS[spanType];
                    var s = CscApi.Utility.formatUTCTimestamp(tickData.getDatetime().getTime(), pattern, timezoneOffsetInMinutes);
                    if (prevSpanType != spanType) {
                        prevSpanType = spanType;
                        renderer.setTextFontName(style.getTimeScaleFontName(spanType));
                        renderer.setTextFontSize(style.getTimeScaleFontSize(spanType));
                        renderer.setTextFontBold(style.getTimeScaleFontBold(spanType));
                        renderer.setFillColorRgba(style.getTimeScaleTextColorRgba(spanType));
                    }
                    renderer.fillText(s, timeScaleElement.viewXCoord, 2 + yFix);
                }
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfTimeScale.prototype.renderValueInfo = function (focusElementIndex) {
            if (focusElementIndex == null) {
                return;
            }
            var renderer = this.refRenderer();
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var timeScaleElement = timeScaleElements[focusElementIndex];
            var orderedTickList = this.refContext().getOrderedTickList();
            var tickData = orderedTickList[focusElementIndex];
            var datetime = tickData.getDatetime();
            var scaleType = timeScale.getScaleType();
            var pattern;
            switch (scaleType) {
                case CscApi.ScaleTypeEnum.MINUTES:
                case CscApi.ScaleTypeEnum.HOURS:
                    pattern = 'yyyy/MM/dd hh:mm';
                    break;
                case CscApi.ScaleTypeEnum.DAYS:
                case CscApi.ScaleTypeEnum.WEEKS:
                    pattern = 'yyyy/MM/dd';
                    break;
                case CscApi.ScaleTypeEnum.MONTHS:
                case CscApi.ScaleTypeEnum.YEARS:
                    pattern = 'yyyy/MM';
                    break;
            }
            var candlestickChart = this.refCandlestickChart();
            var style = candlestickChart.getStyle();
            var textHeight = style.getTimeScaleLabelFontSize();
            renderer.setTextAlignToCenter();
            renderer.setTextBaseLineToTop();
            renderer.setTextFontSize(textHeight);
            renderer.setTextFontBold(true);
            var text = CscApi.Utility.formatUTCTimestamp(datetime.getTime(), pattern, candlestickChart.getTimezoneOffsetInMinutes());
            var textWidth = renderer.getTextWidth(text) + 10;
            var textHalfWidth = Math.floor(textWidth * 0.5);
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var x = timeScaleElement.viewXCoord - viewStartXCoord - textHalfWidth;
            var y = Math.floor((this.height - textHeight) * 0.5);
            renderer.setFillColorRgb([0, 0, 0]);
            renderer.fillRect(x - 1, y - 1, textWidth + 1, textHeight + 1);
            renderer.setFillColorRgb([255, 255, 255]);
            renderer.fillText(text, timeScaleElement.viewXCoord - viewStartXCoord, y);
            renderer.setStrokeColorRgb([128, 128, 128]);
            renderer.strokeRect(x - 2, y - 2, textWidth + 2, textHeight + 2);
        };
        return ChartOfTimeScale;
    })(CscImpl.Chart);
    CscImpl.ChartOfTimeScale = ChartOfTimeScale;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var MAX_ABS_AR = 300;
    var MAX_ABS_BR = 800;
    var ChartOfArBr = (function (_super) {
        __extends(ChartOfArBr, _super);
        function ChartOfArBr(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.ARBR, area, handleId, width, height, DECIMAL_DIGITS, 'ARBR');
            this.elementArList = null;
            this.elementBrList = null;
            this.elementViewArDragon = null;
            this.elementViewBrDragon = null;
        }
        ChartOfArBr.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configArLineWidth = config.params['arLineWidth'];
            var configArLineColorRgba = config.params['arLineColorRgba'];
            var configBrLineWidth = config.params['brLineWidth'];
            var configBrLineColorRgba = config.params['brLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleArLineWidth = configArLineWidth.value;
            this.styleArLineColorRgba = configArLineColorRgba.value;
            this.styleBrLineWidth = configBrLineWidth.value;
            this.styleBrLineColorRgba = configBrLineColorRgba.value;
            this.config = config;
            return true;
        };
        ChartOfArBr.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfArBr.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfArBr.prototype.getStyleArLineWidth = function () {
            return this.styleArLineWidth;
        };
        ChartOfArBr.prototype.setStyleArLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleArLineWidth = lineWidth;
            this.config.params['arLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfArBr.prototype.getStyleArLineColorRgba = function () {
            return this.styleArLineColorRgba;
        };
        ChartOfArBr.prototype.setStyleArLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleArLineColorRgba = colorRgba;
            this.config.params['arLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfArBr.prototype.getStyleBrLineWidth = function () {
            return this.styleBrLineWidth;
        };
        ChartOfArBr.prototype.setStyleBrLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleBrLineWidth = lineWidth;
            this.config.params['brLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfArBr.prototype.getStyleBrLineColorRgba = function () {
            return this.styleBrLineColorRgba;
        };
        ChartOfArBr.prototype.setStyleBrLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleBrLineColorRgba = colorRgba;
            this.config.params['brLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfArBr.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementArList.length) {
                return this.elementArList[index];
            }
            return null;
        };
        ChartOfArBr.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewArDragon == null || this.elementViewArDragon.length !== numberOfDragonComponents) {
                this.elementViewArDragon = CscApi.Utility.resizeFloat32Array(this.elementViewArDragon, numberOfDragonComponents);
            }
            if (this.elementViewBrDragon == null || this.elementViewBrDragon.length !== numberOfDragonComponents) {
                this.elementViewBrDragon = CscApi.Utility.resizeFloat32Array(this.elementViewBrDragon, numberOfDragonComponents);
            }
            if (this.elementArList == null || this.elementArList.length !== numberOfOrderedTickList) {
                this.elementArList = CscApi.Utility.resizeFloat32Array(this.elementArList, numberOfOrderedTickList);
            }
            if (this.elementBrList == null || this.elementBrList.length !== numberOfOrderedTickList) {
                this.elementBrList = CscApi.Utility.resizeFloat32Array(this.elementBrList, numberOfOrderedTickList);
            }
            var elementArList = this.elementArList;
            var elementBrList = this.elementBrList;
            var period = this.argPeriod;
            var periodSumHO = 0;
            var periodSumOL = 0;
            var periodSumHPC = 0;
            var periodSumPCL = 0;
            for (var i = 1; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var prevTickData = orderedTickList[i - 1];
                periodSumHO += tickData.getHigh() - tickData.getOpen();
                periodSumOL += tickData.getOpen() - tickData.getLow();
                periodSumHPC += tickData.getHigh() - prevTickData.getClose();
                periodSumPCL += prevTickData.getClose() - tickData.getLow();
                if (i > period) {
                    var pi = i - period;
                    periodSumHO -= orderedTickList[pi].getHigh() - orderedTickList[pi].getOpen();
                    periodSumOL -= orderedTickList[pi].getOpen() - orderedTickList[pi].getLow();
                    periodSumHPC -= orderedTickList[pi].getHigh() - orderedTickList[pi - 1].getClose();
                    periodSumPCL -= orderedTickList[pi - 1].getClose() - orderedTickList[pi].getLow();
                }
                if (i >= period) {
                    var ar = 100 * periodSumHO / periodSumOL;
                    var br = 100 * periodSumHPC / periodSumPCL;
                    if (ar > MAX_ABS_AR)
                        ar = MAX_ABS_AR;
                    else if (ar < -MAX_ABS_AR)
                        ar = -MAX_ABS_AR;
                    if (br > MAX_ABS_BR)
                        br = MAX_ABS_BR;
                    else if (br < -MAX_ABS_BR)
                        br = -MAX_ABS_BR;
                    elementArList[i] = ar;
                    elementBrList[i] = br;
                }
                else {
                    elementArList[i] = NaN;
                    elementBrList[i] = NaN;
                }
            }
        };
        ChartOfArBr.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementArList = this.elementArList;
            var elementBrList = this.elementBrList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var ar = elementArList[vi];
                var br = elementBrList[vi];
                if (false == isNaN(ar)) {
                    if (ar > highestValue)
                        highestValue = ar;
                    if (ar < lowestValue)
                        lowestValue = ar;
                }
                if (false == isNaN(br)) {
                    if (br > highestValue)
                        highestValue = br;
                    if (br < lowestValue)
                        lowestValue = br;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfArBr.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementArList = this.elementArList;
            var elementBrList = this.elementBrList;
            var elementViewArDragon = this.elementViewArDragon;
            var elementViewBrDragon = this.elementViewBrDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementArList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var ar = elementArList[i];
                var br = elementBrList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewArDragon[vi] = viewXCoord;
                elementViewArDragon[vyi] = isNaN(ar) ? NaN : Math.floor(valueToYCoordConvertor(ar));
                elementViewBrDragon[vi] = viewXCoord;
                elementViewBrDragon[vyi] = isNaN(br) ? NaN : Math.floor(valueToYCoordConvertor(br));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfArBr.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementArList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                renderer.setLineWidth(Math.floor(Math.min(this.styleArLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleArLineColorRgba);
                this.drawDragon(this.elementViewArDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleBrLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleBrLineColorRgba);
                this.drawDragon(this.elementViewBrDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfArBr.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var ar = this.elementArList[focusElementIndex];
                var br = this.elementBrList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(ar))
                    valueInfoList.push({ name: 'AR', value: ar.toFixed(DECIMAL_DIGITS), valueColor: this.styleArLineColorRgba });
                if (false === isNaN(br))
                    valueInfoList.push({ name: 'BR', value: br.toFixed(DECIMAL_DIGITS), valueColor: this.styleBrLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfArBr;
    })(CscImpl.Chart);
    CscImpl.ChartOfArBr = ChartOfArBr;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfRoc = (function (_super) {
        __extends(ChartOfRoc, _super);
        function ChartOfRoc(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.ROC, area, handleId, width, height, DECIMAL_DIGITS, 'ROC');
            this.elementRocList = null;
            this.elementViewRocDragon = null;
        }
        ChartOfRoc.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configRocLineWidth = config.params['rocLineWidth'];
            var configRocLineColorRgba = config.params['rocLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleRocLineWidth = configRocLineWidth.value;
            this.styleRocLineColorRgba = configRocLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfRoc.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfRoc.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfRoc.prototype.getStyleRocLineWidth = function () {
            return this.styleRocLineWidth;
        };
        ChartOfRoc.prototype.setStyleRocLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleRocLineWidth = lineWidth;
            this.config.params['rocLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfRoc.prototype.getStyleRocLineColorRgba = function () {
            return this.styleRocLineColorRgba;
        };
        ChartOfRoc.prototype.setStyleRocLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleRocLineColorRgba = colorRgba;
            this.config.params['rocLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfRoc.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementRocList.length) {
                return this.elementRocList[index];
            }
            return null;
        };
        ChartOfRoc.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewRocDragon == null || this.elementViewRocDragon.length !== numberOfDragonComponents) {
                this.elementViewRocDragon = CscApi.Utility.resizeFloat32Array(this.elementViewRocDragon, numberOfDragonComponents);
            }
            if (this.elementRocList == null || this.elementRocList.length !== numberOfOrderedTickList) {
                this.elementRocList = CscApi.Utility.resizeFloat32Array(this.elementRocList, numberOfOrderedTickList);
            }
            var elementRocList = this.elementRocList;
            var period = this.argPeriod;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                if (i >= period) {
                    var p1 = orderedTickList[i - period].getClose();
                    elementRocList[i] = (tickData.getClose() - p1) / p1;
                }
                else {
                    elementRocList[i] = NaN;
                }
            }
        };
        ChartOfRoc.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementRocList = this.elementRocList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var atr = elementRocList[vi];
                if (false == isNaN(atr)) {
                    if (atr > highestValue)
                        highestValue = atr;
                    if (atr < lowestValue)
                        lowestValue = atr;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfRoc.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementRocList = this.elementRocList;
            var elementViewRocDragon = this.elementViewRocDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementRocList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var atr = elementRocList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewRocDragon[vi] = viewXCoord;
                elementViewRocDragon[vyi] = isNaN(atr) ? NaN : Math.floor(valueToYCoordConvertor(atr));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfRoc.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementRocList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleRocLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleRocLineColorRgba);
                this.drawDragon(this.elementViewRocDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfRoc.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var atr = this.elementRocList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(atr))
                    valueInfoList.push({ name: 'ROC', value: atr.toFixed(DECIMAL_DIGITS), valueColor: this.styleRocLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfRoc;
    })(CscImpl.Chart);
    CscImpl.ChartOfRoc = ChartOfRoc;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfBiasAB = (function (_super) {
        __extends(ChartOfBiasAB, _super);
        function ChartOfBiasAB(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.BIAS_AB, area, handleId, width, height, DECIMAL_DIGITS, 'A-B BIAS');
            this.elementBiasList = null;
            this.elementViewBiasDragon = null;
        }
        ChartOfBiasAB.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configShortPeriod = config.params['shortPeriod'];
            var configLongPeriod = config.params['longPeriod'];
            var configBiasLineWidth = config.params['biasLineWidth'];
            var configBiasLineColorRgba = config.params['biasLineColorRgba'];
            this.argShortPeriod = configShortPeriod.value;
            this.argLongPeriod = configLongPeriod.value;
            this.styleBiasLineWidth = configBiasLineWidth.value;
            this.styleBiasLineColorRgba = configBiasLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBiasAB.prototype.getArgShortPeriod = function () {
            return this.argShortPeriod;
        };
        ChartOfBiasAB.prototype.setArgShortPeriod = function (period) {
            this.argShortPeriod = period;
            this.config.params['shortPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBiasAB.prototype.getArgLongPeriod = function () {
            return this.argLongPeriod;
        };
        ChartOfBiasAB.prototype.setArgLongPeriod = function (period) {
            this.argLongPeriod = period;
            this.config.params['longPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBiasAB.prototype.getStyleBiasLineWidth = function () {
            return this.styleBiasLineWidth;
        };
        ChartOfBiasAB.prototype.setStyleBiasLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleBiasLineWidth = lineWidth;
            this.config.params['biasLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfBiasAB.prototype.getStyleBiasLineColorRgba = function () {
            return this.styleBiasLineColorRgba;
        };
        ChartOfBiasAB.prototype.setStyleBiasLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleBiasLineColorRgba = colorRgba;
            this.config.params['biasLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfBiasAB.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementBiasList.length) {
                return this.elementBiasList[index];
            }
            return null;
        };
        ChartOfBiasAB.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewBiasDragon == null || this.elementViewBiasDragon.length !== numberOfDragonComponents) {
                this.elementViewBiasDragon = CscApi.Utility.resizeFloat32Array(this.elementViewBiasDragon, numberOfDragonComponents);
            }
            if (this.elementBiasList == null || this.elementBiasList.length !== numberOfOrderedTickList) {
                this.elementBiasList = CscApi.Utility.resizeFloat32Array(this.elementBiasList, numberOfOrderedTickList);
            }
            var elementBiasList = this.elementBiasList;
            var shortPeriod = this.argShortPeriod;
            var longPeriod = this.argLongPeriod;
            var sumShort = 0;
            var sumLong = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var c = tickData.getClose();
                sumShort += c;
                sumLong += c;
                if (i >= shortPeriod) {
                    sumShort -= orderedTickList[i - shortPeriod].getClose();
                    if (i >= longPeriod) {
                        sumLong -= orderedTickList[i - longPeriod].getClose();
                        elementBiasList[i] = sumShort / shortPeriod - sumLong / longPeriod;
                    }
                }
            }
        };
        ChartOfBiasAB.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementBiasList = this.elementBiasList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var bias = elementBiasList[vi];
                if (false == isNaN(bias)) {
                    if (bias > highestValue)
                        highestValue = bias;
                    if (bias < lowestValue)
                        lowestValue = bias;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfBiasAB.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementBiasList = this.elementBiasList;
            var elementViewBiasDragon = this.elementViewBiasDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argShortPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementBiasList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var bias = elementBiasList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewBiasDragon[vi] = viewXCoord;
                elementViewBiasDragon[vyi] = isNaN(bias) ? NaN : Math.floor(valueToYCoordConvertor(bias));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfBiasAB.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argShortPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementBiasList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argShortPeriod ? viewStartTickIndex : this.argShortPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleBiasLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleBiasLineColorRgba);
                this.drawDragon(this.elementViewBiasDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfBiasAB.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var bias = this.elementBiasList[focusElementIndex];
                valueInfoList = [
                    { name: 'Short(A)', value: this.argShortPeriod.toString(), valueColor: null },
                    { name: 'Long(B)', value: this.argLongPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(bias))
                    valueInfoList.push({ name: 'BIAS', value: bias.toFixed(DECIMAL_DIGITS), valueColor: this.styleBiasLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfBiasAB;
    })(CscImpl.Chart);
    CscImpl.ChartOfBiasAB = ChartOfBiasAB;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfCci = (function (_super) {
        __extends(ChartOfCci, _super);
        function ChartOfCci(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.CCI, area, handleId, width, height, DECIMAL_DIGITS, 'CCI');
            this.elementTpList = null;
            this.elementCciList = null;
            this.elementViewCciDragon = null;
        }
        ChartOfCci.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configCciLineWidth = config.params['cciLineWidth'];
            var configCciLineColorRgba = config.params['cciLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleCciLineWidth = configCciLineWidth.value;
            this.styleCciLineColorRgba = configCciLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfCci.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfCci.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfCci.prototype.getStyleCciLineWidth = function () {
            return this.styleCciLineWidth;
        };
        ChartOfCci.prototype.setStyleCciLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleCciLineWidth = lineWidth;
            this.config.params['cciLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfCci.prototype.getStyleCciLineColorRgba = function () {
            return this.styleCciLineColorRgba;
        };
        ChartOfCci.prototype.setStyleCciLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleCciLineColorRgba = colorRgba;
            this.config.params['cciLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfCci.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementCciList.length) {
                return this.elementCciList[index];
            }
            return null;
        };
        ChartOfCci.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewCciDragon == null || this.elementViewCciDragon.length !== numberOfDragonComponents) {
                this.elementViewCciDragon = CscApi.Utility.resizeFloat32Array(this.elementViewCciDragon, numberOfDragonComponents);
            }
            if (this.elementTpList == null || this.elementTpList.length !== numberOfOrderedTickList) {
                this.elementTpList = CscApi.Utility.resizeFloat32Array(this.elementTpList, numberOfOrderedTickList);
            }
            if (this.elementCciList == null || this.elementCciList.length !== numberOfOrderedTickList) {
                this.elementCciList = CscApi.Utility.resizeFloat32Array(this.elementCciList, numberOfOrderedTickList);
            }
            var elementTpList = this.elementTpList;
            var elementCciList = this.elementCciList;
            var period = this.argPeriod;
            var sumTp = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                var tp = elementTpList[i] = (tickData.getHigh() + tickData.getLow() + tickData.getClose()) / 3;
                sumTp += tp;
                if (i >= period - 1) {
                    var tpAvg = sumTp / period;
                    sumTp -= elementTpList[i - period + 1];
                    var sumDiff = 0;
                    for (var n = i - period + 1; n <= i; ++n) {
                        sumDiff += Math.abs(elementTpList[n] - tpAvg);
                    }
                    var md = sumDiff / period;
                    elementCciList[i] = (tp - tpAvg) / (md * 0.015);
                }
                else {
                    elementCciList[i] = NaN;
                }
            }
        };
        ChartOfCci.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementCciList = this.elementCciList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var cci = elementCciList[vi];
                if (false == isNaN(cci)) {
                    if (cci > highestValue)
                        highestValue = cci;
                    if (cci < lowestValue)
                        lowestValue = cci;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfCci.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementCciList = this.elementCciList;
            var elementViewCciDragon = this.elementViewCciDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementCciList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var cci = elementCciList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewCciDragon[vi] = viewXCoord;
                elementViewCciDragon[vyi] = isNaN(cci) ? NaN : Math.floor(valueToYCoordConvertor(cci));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfCci.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementCciList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleCciLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleCciLineColorRgba);
                this.drawDragon(this.elementViewCciDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfCci.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var cci = this.elementCciList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(cci))
                    valueInfoList.push({ name: 'CCI', value: cci.toFixed(DECIMAL_DIGITS), valueColor: this.styleCciLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfCci;
    })(CscImpl.Chart);
    CscImpl.ChartOfCci = ChartOfCci;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfVolume = (function (_super) {
        __extends(ChartOfVolume, _super);
        function ChartOfVolume(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.VOLUME, area, handleId, width, height, DECIMAL_DIGITS, 'VOLUME');
            this.elementViewVolumePole = null;
        }
        ChartOfVolume.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configVolumePoleColorRgba = config.params['volumePoleColorRgba'];
            this.styleVolumePoleColorRgba = configVolumePoleColorRgba.value;
            this.config = config;
            return true;
        };
        ChartOfVolume.prototype.getStyleVolumePoleColorRgba = function () {
            return this.styleVolumePoleColorRgba;
        };
        ChartOfVolume.prototype.setStyleVolumePoleColorRgba = function (colorRgba) {
            this.styleVolumePoleColorRgba = colorRgba;
            this.config.params['volumePoleColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfVolume.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementVolumeList.length) {
                return this.elementVolumeList[index];
            }
            return null;
        };
        ChartOfVolume.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewVolumePole == null || this.elementViewVolumePole.length !== numberOfOrderedTickList) {
                this.elementViewVolumePole = CscApi.Utility.resizeFloat32Array(this.elementViewVolumePole, numberOfOrderedTickList);
            }
            if (this.elementVolumeList == null || this.elementVolumeList.length !== numberOfOrderedTickList) {
                this.elementVolumeList = CscApi.Utility.resizeFloat32Array(this.elementVolumeList, numberOfOrderedTickList);
            }
            var elementVolumeList = this.elementVolumeList;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                elementVolumeList[i] = tickData.getVolume();
            }
        };
        ChartOfVolume.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementVolumeList = this.elementVolumeList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var vol = elementVolumeList[vi];
                if (false == isNaN(vol)) {
                    if (vol > highestValue)
                        highestValue = vol;
                    if (vol < lowestValue)
                        lowestValue = vol;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfVolume.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementVolumeList = this.elementVolumeList;
            var elementViewVolumePole = this.elementViewVolumePole;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var viewZeroValueYCoord = this.viewZeroValueYCoord = Math.floor(valueToYCoordConvertor(0));
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var vol = elementVolumeList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewVolumePole[i] = Math.floor(valueToYCoordConvertor(vol)) - viewZeroValueYCoord;
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfVolume.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            renderer.translate(-viewStartXCoord, 0);
            var elementViewVolumePole = this.elementViewVolumePole;
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var poleWidth = Math.floor(viewTickWidth * 0.8);
            if (poleWidth < 1) {
                poleWidth = 1;
            }
            var poleHalfWidth = Math.floor(poleWidth * 0.5);
            if (poleHalfWidth < 0) {
                poleHalfWidth = 0;
            }
            poleWidth = Math.floor(poleWidth);
            poleHalfWidth = Math.floor(poleHalfWidth);
            var timeScale = candlestickChart.getTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var elementVolumeList = this.elementVolumeList;
            var styleVolumeColorRgba = this.styleVolumePoleColorRgba;
            var viewZeroValueYCoord = this.viewZeroValueYCoord;
            renderer.translate(-poleHalfWidth, 0);
            if (poleWidth > 1) {
                renderer.setFillColorRgba(styleVolumeColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var vol = elementVolumeList[i];
                    var poleHeight = elementViewVolumePole[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    renderer.fillRect(viewXCoord, viewZeroValueYCoord, poleWidth, poleHeight);
                }
            }
            else {
                renderer.setStrokeColorRgba(styleVolumeColorRgba);
                renderer.setLineWidth(1);
                var prevViewXCoord = null;
                var highestVolume = -Infinity;
                var highestVolumePoleHeight;
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var vol = elementVolumeList[i];
                    var poleHeight = elementViewVolumePole[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (vol > highestVolume) {
                        highestVolumePoleHeight = poleHeight;
                        highestVolume = vol;
                    }
                    if (prevViewXCoord !== viewXCoord) {
                        prevViewXCoord = viewXCoord;
                        highestVolume = -Infinity;
                        renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + highestVolumePoleHeight);
                    }
                }
                if (isFinite(highestVolume)) {
                    renderer.strokeLine(prevViewXCoord, viewZeroValueYCoord, prevViewXCoord, viewZeroValueYCoord + highestVolumePoleHeight);
                }
            }
            renderer.translate(poleHalfWidth, 0);
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfVolume.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var vol = this.elementVolumeList[focusElementIndex];
                valueInfoList = [];
                if (false === isNaN(vol))
                    valueInfoList.push({ name: 'VOL', value: vol.toFixed(DECIMAL_DIGITS), valueColor: this.styleVolumePoleColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfVolume;
    })(CscImpl.Chart);
    CscImpl.ChartOfVolume = ChartOfVolume;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    (function (TouchEventType) {
        TouchEventType[TouchEventType["START"] = 0] = "START";
        TouchEventType[TouchEventType["MOVE"] = 1] = "MOVE";
        TouchEventType[TouchEventType["END"] = 2] = "END";
    })(CscImpl.TouchEventType || (CscImpl.TouchEventType = {}));
    var TouchEventType = CscImpl.TouchEventType;
    (function (MouseEventType) {
        MouseEventType[MouseEventType["DOWN"] = 0] = "DOWN";
        MouseEventType[MouseEventType["MOVE"] = 1] = "MOVE";
        MouseEventType[MouseEventType["UP"] = 2] = "UP";
    })(CscImpl.MouseEventType || (CscImpl.MouseEventType = {}));
    var MouseEventType = CscImpl.MouseEventType;
    var CandlestickChart = (function () {
        function CandlestickChart(canvas, context) {
            this.canvas = canvas;
            this.context = context != null ? context : new CscImpl.Context();
            this.renderer = null;
            this.controller = null;
            this.style = new CscImpl.Style();
            this.snGeneratorOfAreaHandleId = null;
            this.areaContexts = null;
            this.decimalFormat = null;
            this.decimalDigits = null;
            this.timezone = null;
            this.timeScale = new CscImpl.TimeScale(this);
            this.tickDataIsDirty = true;
            this.modifiedLowerestIndex = Infinity;
            this.viewTickWidth = null;
            this.isPendingForPresent = false;
            this.handleIdOfOnTickUpdate = null;
            this.autoScrollEnabled = true;
            this.lockFocusElementToLast = false;
            this.opDragging = false;
            this.opDragged = false;
            this.prevDragStartX = null;
            this.prevDragStartY = null;
            this.prevTouchX = null;
            this.prevTouchY = null;
            this.prevTouchGapX = null;
            this.pendingTouchGapX = null;
            this.snGeneratorOfEvents = new CscApi.SnGenerator();
            this.eventsOfDrawerTerminated = {};
            this.setTimezoneOffsetInMinutes(CscApi.Utility.getTimezoneMinutes());
        }
        CandlestickChart.prototype.getContext = function () {
            return this.context;
        };
        CandlestickChart.prototype.setContext = function (context) {
            var _this = this;
            if (context == null) {
                return;
            }
            if (this.context != null && this.handleIdOfOnTickUpdate != null) {
                this.context.removeEventListener(this.handleIdOfOnTickUpdate);
            }
            this.context = context;
            this.context.addEventListenerOnTickUpdate(function (modifiedLowerestIndex) { _this.onTickUpdate(modifiedLowerestIndex); });
            this.tickDataIsDirty = true;
            this.modifiedLowerestIndex = 0;
            this.update();
            this.onTickUpdate(0);
            this.present();
        };
        CandlestickChart.prototype.getRenderer = function () {
            return this.renderer;
        };
        CandlestickChart.prototype.getLang = function () {
            return this.lang;
        };
        CandlestickChart.prototype.setLang = function (lang) {
            if (lang != null) {
                this.lang = lang;
            }
        };
        CandlestickChart.prototype.setStyle = function (style) {
            this.style = style;
        };
        CandlestickChart.prototype.getStyle = function () {
            return this.style;
        };
        CandlestickChart.prototype.getAutoScrollEnabled = function () {
            return this.autoScrollEnabled;
        };
        CandlestickChart.prototype.setAutoScrollEnabled = function (enabled) {
            this.autoScrollEnabled = enabled;
        };
        CandlestickChart.prototype.getLockFocusElementToLast = function () {
            return this.lockFocusElementToLast;
        };
        CandlestickChart.prototype.setLockFocusElementToLast = function (lockFocusElementToLast) {
            this.lockFocusElementToLast = lockFocusElementToLast;
            this.ensureLockFocusElement();
            this.present();
        };
        CandlestickChart.prototype.getTimeScale = function () {
            return this.timeScale;
        };
        CandlestickChart.prototype.getViewTickWidth = function () {
            return this.viewTickWidth;
        };
        CandlestickChart.prototype.setViewTickWidth = function (tickWidth) {
            if (tickWidth <= 0 || tickWidth > 200) {
                return;
            }
            this.viewTickWidth = tickWidth;
        };
        CandlestickChart.prototype.getDecimalDigits = function () {
            return this.decimalDigits;
        };
        CandlestickChart.prototype.setDecimalDigits = function (decimalDigits) {
            if (decimalDigits < 0) {
                return;
            }
            var dfString = '#,###,###,##0.';
            for (var i = 0; i < decimalDigits; ++i) {
                dfString += '0';
            }
            this.decimalFormat = new CscImpl.DecimalFormat(dfString);
            this.decimalDigits = decimalDigits;
        };
        ;
        CandlestickChart.prototype.getTickIndexFromXInArea = function (areaHandleId, xInArea) {
            var areaContext = this.areaContexts[areaHandleId];
            if (areaContext) {
                return this.timeScale.getTickIndexFromX(xInArea + areaContext.area.getViewStartXCoord());
            }
            return null;
        };
        CandlestickChart.prototype.getXInAreaFromTickIndex = function (areaHandleId, index) {
            var areaContext = this.areaContexts[areaHandleId];
            if (areaContext) {
                return Math.floor(this.timeScale.getXFromTickIndex(index) - areaContext.area.getViewStartXCoord());
            }
            return null;
        };
        CandlestickChart.prototype.getTimezone = function () {
            return this.timezone;
        };
        ;
        CandlestickChart.prototype.getTimezoneOffsetInMinutes = function () {
            return this.timezoneOffsetInMinutes;
        };
        ;
        CandlestickChart.prototype.setTimezoneOffsetInMinutes = function (timezoneOffsetInMinutes) {
            var sign = (timezoneOffsetInMinutes >= 0) ? '+' : '-';
            this.timezone = sign + CscApi.Utility.leadingZero(Math.floor(Math.abs(timezoneOffsetInMinutes) / 60).toString(), 2) + '00';
            this.timezoneOffsetInMinutes = timezoneOffsetInMinutes;
            this.tickDataIsDirty = true;
            this.present();
        };
        CandlestickChart.prototype.isDrawing = function () {
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                if (area.isDrawing()) {
                    return true;
                }
            }
            return false;
        };
        CandlestickChart.prototype.init = function () {
            var _this = this;
            var controller = this.controller = new CscImpl.Controller(this.canvas);
            if (false == controller.init()) {
                console.error('failed to initialize controller.');
                return false;
            }
            controller.addEventListenerOnKeyDown(function (key, state) { _this.onKeyDown(key, state); });
            controller.addEventListenerOnKeyUp(function (key, state) { _this.onKeyUp(key, state); });
            controller.addEventListenerOnMouseDown(function (button, state) { _this.onMouseDown(button, state); });
            controller.addEventListenerOnMouseUp(function (button, state) { _this.onMouseUp(button, state); });
            controller.addEventListenerOnMouseMove(function (state) { _this.onMouseMove(state); });
            controller.addEventListenerOnMouseWheel(function (state) { _this.onMouseWheel(state); });
            controller.addEventListenerOnTouchStart(function (event) { _this.onTouchStart(event); });
            controller.addEventListenerOnTouchMove(function (event) { _this.onTouchMove(event); });
            controller.addEventListenerOnTouchEnd(function (event) { _this.onTouchEnd(event); });
            this.renderer = new CscImpl.Renderer(this.canvas);
            this.snGeneratorOfAreaHandleId = new CscApi.SnGenerator();
            this.areaContexts = {};
            this.setViewTickWidth(20);
            this.setDecimalDigits(2);
            return true;
        };
        CandlestickChart.prototype.release = function () {
            this.controller.release();
        };
        CandlestickChart.prototype.addArea = function (x, y, width, height) {
            var handleId = this.snGeneratorOfAreaHandleId.allocate();
            var area = new CscImpl.Area(this, handleId, width, height);
            this.areaContexts[handleId] = {
                x: x,
                y: y,
                area: area,
            };
            return handleId;
        };
        CandlestickChart.prototype.getArea = function (handleId) {
            var areaContexts = this.areaContexts[handleId];
            return areaContexts ? areaContexts.area : null;
        };
        CandlestickChart.prototype.removeArea = function (handleId) {
            if (this.areaContexts[handleId]) {
                delete this.areaContexts[handleId];
                this.snGeneratorOfAreaHandleId.recycle(handleId);
                return true;
            }
            return false;
        };
        CandlestickChart.prototype.reshapeArea = function (handleId, x, y, width, height) {
            var areaContext = this.areaContexts[handleId];
            if (areaContext == null) {
                return false;
            }
            areaContext.x = x;
            areaContext.y = y;
            areaContext.area.setWidth(width);
            areaContext.area.setHeight(height);
            return true;
        };
        CandlestickChart.prototype.update = function () {
            this.timeScale.update(this.tickDataIsDirty);
            var updateTickFromIndex = isFinite(this.modifiedLowerestIndex) ? this.modifiedLowerestIndex : null;
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                area.update(updateTickFromIndex);
            }
            this.tickDataIsDirty = false;
            this.modifiedLowerestIndex = Infinity;
        };
        CandlestickChart.prototype.render = function () {
            this.update();
            var renderer = this.renderer;
            if (false == renderer.beginRendering()) {
                console.error('failed to begin render.');
                return false;
            }
            var style = this.style;
            var styleAreaBorderLineWidth = style.getAreaBorderLineWidth();
            var styleAreaBorderLineColorRgba = style.getAreaBorderColorRgba();
            var canvas = this.canvas;
            renderer.setFillColorRgba(style.getBackgroundColorRgba());
            renderer.fillRect(0, 0, canvas.width, canvas.height);
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                var areaX = areaContext.x;
                var areaY = areaContext.y;
                var areaW = area.getWidth();
                var areaH = area.getHeight();
                renderer.beginViewport(areaX, areaY, areaW, areaH, false);
                area.renderYScaleValues(areaW);
                if (styleAreaBorderLineWidth > 0) {
                    renderer.setLineWidth(styleAreaBorderLineWidth);
                    renderer.setStrokeColorRgba(styleAreaBorderLineColorRgba);
                    renderer.strokeRect(0, 0, areaW - 1, areaH - 1);
                }
                renderer.endViewport();
                renderer.beginViewport(areaX, areaY, areaW, areaH, true);
                area.render();
                renderer.endViewport();
            }
            renderer.endRender();
            return true;
        };
        CandlestickChart.prototype.present = function () {
            var _this = this;
            if (this.isPendingForPresent) {
                return false;
            }
            this.isPendingForPresent = true;
            requestAnimationFrame(function () {
                _this.isPendingForPresent = false;
                _this.render();
            });
            return true;
        };
        CandlestickChart.prototype.zoom = function (scala) {
            var origViewTickWidth = this.getViewTickWidth();
            var newViewTickWidth = origViewTickWidth * scala;
            this.setViewTickWidth(newViewTickWidth);
            this.update();
            this.present();
        };
        CandlestickChart.prototype.getMaxViewStartXCoord = function () {
            var maxXCoord = 0;
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                var maxXCoordInArea = area.getViewMaxStartXCoord();
                if (maxXCoordInArea > maxXCoord) {
                    maxXCoord = maxXCoordInArea;
                }
            }
            return maxXCoord;
        };
        CandlestickChart.prototype.setViewStartXCoord = function (xCoord) {
            xCoord = Math.floor(xCoord);
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                area.setViewStartXCoord(xCoord);
            }
        };
        CandlestickChart.prototype.onKeyDown = function (key, state) {
        };
        CandlestickChart.prototype.onKeyUp = function (key, state) {
        };
        CandlestickChart.prototype.onMouseDown = function (button, state) {
            this.prevDragStartX = state.GetPositionX();
            this.prevDragStartY = state.GetPositionY();
            this.processMouseEvent(button, state, MouseEventType.DOWN);
        };
        CandlestickChart.prototype.onMouseUp = function (button, state) {
            this.opDragging = false;
            this.prevDragStartX = null;
            this.prevDragStartY = null;
            if (this.opDragged) {
                this.opDragged = false;
                this.present();
                return;
            }
            this.processMouseEvent(button, state, MouseEventType.UP);
        };
        CandlestickChart.prototype.onMouseMove = function (state) {
            var movX = state.GetMovementX();
            if (this.opDragging && movX != 0) {
                this.opDragged = true;
                var areaContexts = this.areaContexts;
                for (var handleId in areaContexts) {
                    var areaContext = areaContexts[handleId];
                    var area = areaContext.area;
                    area.setViewStartXCoord(Math.floor(area.getViewStartXCoord() - movX));
                }
            }
            this.processMouseEvent(null, state, MouseEventType.MOVE);
        };
        CandlestickChart.prototype.processMouseEvent = function (button, state, eventType) {
            if (eventType === MouseEventType.DOWN) {
                if (button == CscApi.MouseButton.LEFT) {
                    if (this.lockFocusElementToLast) {
                        this.lockFocusElementToLast = false;
                        this.update();
                    }
                }
            }
            else if (eventType === MouseEventType.MOVE) {
                var posX = state.GetPositionX();
                var posY = state.GetPositionY();
                if (this.prevDragStartX != null && this.opDragging == false && Math.abs(posX - this.prevDragStartX) > 4) {
                    this.opDragging = true;
                }
                this.processFocusAreas(posX, posY);
            }
            var posX = state.GetPositionX();
            var posY = state.GetPositionY();
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                var xInArea = posX - areaContext.x;
                var yInArea = posY - areaContext.y;
                if (this.isHitArea(xInArea, yInArea, areaContext)) {
                    if (eventType === MouseEventType.DOWN)
                        area.processMouseDown(button, xInArea, yInArea);
                    else if (eventType === MouseEventType.MOVE)
                        area.processMouseMove(xInArea, yInArea);
                    else if (eventType === MouseEventType.UP) {
                        area.processMouseUp(button, xInArea, yInArea);
                    }
                }
            }
            this.present();
        };
        CandlestickChart.prototype.onMouseWheel = function (state) {
            var wheelDelta = state.GetWheelDelta();
            if (wheelDelta == 0) {
                return;
            }
            var zoomOut = wheelDelta > 0;
            this.zoom(zoomOut ? 1.1 : 0.9);
            var posX = state.GetPositionX();
            var posY = state.GetPositionY();
            this.processFocusAreas(posX, posY);
            this.present();
            var posX = state.GetPositionX();
            var posY = state.GetPositionY();
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                var xInArea = posX - areaContext.x;
                var yInArea = posY - areaContext.y;
                if (this.isHitArea(xInArea, yInArea, areaContext)) {
                    area.processMouseWheel(zoomOut, xInArea, yInArea);
                }
            }
        };
        CandlestickChart.prototype.onTouchStart = function (state) {
            this.prevDragStartX = state.GetPositionXList()[0];
            this.prevDragStartY = state.GetPositionYList()[0];
            this.processTouchEvent(state, TouchEventType.START);
        };
        CandlestickChart.prototype.onTouchMove = function (state) {
            var _this = this;
            var posXList = state.GetPositionXList();
            if (posXList.length > 1) {
                var touchGapX = Math.abs(posXList[0] - posXList[1]);
                if (this.prevTouchGapX == null) {
                    this.prevTouchGapX = touchGapX;
                    this.pendingTouchGapX = null;
                }
                else {
                    if (this.pendingTouchGapX == null) {
                        setTimeout(function () {
                            var distance = Math.abs(_this.prevTouchGapX - _this.pendingTouchGapX);
                            if (distance > 2) {
                                var zoomOut = touchGapX > _this.prevTouchGapX;
                                _this.zoom(zoomOut ? 1.05 : 0.95);
                                _this.prevTouchGapX = touchGapX;
                            }
                            _this.pendingTouchGapX = null;
                        });
                    }
                    this.pendingTouchGapX = touchGapX;
                }
                this.opDragged = true;
                return;
            }
            else {
                this.prevTouchGapX = null;
            }
            if (this.opDragging == false && Math.abs(posXList[0] - this.prevDragStartX) > 4) {
                this.opDragging = true;
            }
            if (this.opDragging) {
                var prevTouchX = this.prevTouchX;
                if (prevTouchX != null && isFinite(prevTouchX)) {
                    var movX = posXList[0] - prevTouchX;
                    var areaContexts = this.areaContexts;
                    for (var handleId in areaContexts) {
                        var areaContext = areaContexts[handleId];
                        var area = areaContext.area;
                        area.setViewStartXCoord(Math.floor(area.getViewStartXCoord() - movX));
                    }
                }
            }
            this.processTouchEvent(state, TouchEventType.MOVE);
        };
        CandlestickChart.prototype.onTouchEnd = function (state) {
            this.opDragging = false;
            this.prevDragStartX = null;
            this.prevDragStartY = null;
            if (this.opDragged) {
                this.present();
                return;
            }
            this.processTouchEvent(state, TouchEventType.END);
        };
        CandlestickChart.prototype.onTickUpdate = function (modifiedLowerestIndex) {
            this.tickDataIsDirty = true;
            if (modifiedLowerestIndex < this.modifiedLowerestIndex) {
                this.modifiedLowerestIndex = modifiedLowerestIndex;
            }
            var areaContexts = this.areaContexts;
            var orderedTickDataList = this.context.getOrderedTickList();
            var numberOfTicks = orderedTickDataList.length;
            var lastTickIndex = Math.max(numberOfTicks - 1, 0);
            if (this.autoScrollEnabled) {
                var timeScaleElements = this.timeScale.getTimeScaleElements();
                if (timeScaleElements != null) {
                    var numberOfElements = timeScaleElements.length;
                    for (var handleId in areaContexts) {
                        var areaContext = areaContexts[handleId];
                        var area = areaContext.area;
                        var si = area.getViewStartTickIndex();
                        var ei = area.getViewEndTickIndex();
                        if (si != 0 && ei >= numberOfElements - 1) {
                            area.setViewEndTickIndex(lastTickIndex);
                        }
                    }
                }
            }
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                area.setViewIsDirty(true);
                if (this.lockFocusElementToLast) {
                    area.setFocusElementIndex(numberOfTicks - 1);
                }
                else {
                    var focusElementIndex = area.getFocusElementIndex();
                    if (numberOfTicks <= 0 || focusElementIndex >= numberOfTicks) {
                        if (numberOfTicks <= 0) {
                            focusElementIndex = null;
                        }
                        else {
                            focusElementIndex = lastTickIndex;
                        }
                        area.setFocusElementIndex(focusElementIndex);
                    }
                }
            }
            this.ensureLockFocusElement();
            this.update();
            this.present();
        };
        CandlestickChart.prototype.ensureLockFocusElement = function () {
            if (this.lockFocusElementToLast) {
                var areaContexts = this.areaContexts;
                var orderedTickDataList = this.context.getOrderedTickList();
                var numberOfTicks = orderedTickDataList.length;
                var lastTickIndex = Math.max(numberOfTicks - 1, 0);
                for (var handleId in areaContexts) {
                    var areaContext = areaContexts[handleId];
                    var area = areaContext.area;
                    area.setFocusElementIndex(lastTickIndex);
                    area.focusYByFocusedElement();
                }
            }
        };
        CandlestickChart.prototype.isHitArea = function (xInArea, yInArea, areaContext) {
            if (xInArea >= 0 && xInArea <= areaContext.area.getWidth() &&
                yInArea >= 0 && yInArea <= areaContext.area.getHeight()) {
                return true;
            }
            return false;
        };
        CandlestickChart.prototype.processTouchEvent = function (state, touchType) {
            if (touchType == TouchEventType.START) {
                if (this.lockFocusElementToLast) {
                    this.lockFocusElementToLast = false;
                    this.update();
                }
            }
            var posXList = state.GetPositionXList();
            var posYList = state.GetPositionYList();
            this.prevTouchX = posXList[0];
            this.prevTouchY = posYList[0];
            if (touchType != TouchEventType.END) {
                this.processFocusAreas(posXList[0], posYList[0]);
            }
            var numberOfCoords = posXList.length;
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                var areaX = areaContext.x;
                var areaY = areaContext.y;
                var posXListInArea = new Array();
                var posYListInArea = new Array();
                for (var i = 0; i < posXList.length; ++i) {
                    var xInArea = posXList[i] - areaX;
                    var yInArea = posYList[i] - areaY;
                    if (this.isHitArea(xInArea, yInArea, areaContext)) {
                        posXListInArea.push(xInArea);
                        posYListInArea.push(yInArea);
                    }
                }
                if (posXListInArea.length > 0) {
                    if (touchType == TouchEventType.START)
                        area.processTouchStart(posXListInArea, posYListInArea);
                    else if (touchType == TouchEventType.MOVE)
                        area.processTouchMove(posXListInArea, posYListInArea);
                    else if (touchType == TouchEventType.END) {
                        area.processTouchEnd(posXListInArea, posYListInArea);
                    }
                }
            }
            this.present();
        };
        CandlestickChart.prototype.processFocusAreas = function (posX, posY) {
            if (true) {
                this.processFocusAreasUnanimously(posX, posY);
            }
            else {
                this.processFocusAreasByOneself(posX, posY);
            }
        };
        CandlestickChart.prototype.processFocusAreasUnanimously = function (posX, posY) {
            var areaContexts = this.areaContexts;
            var lockFocusElementToLast = this.lockFocusElementToLast;
            var focusElementIndex = null;
            var focusAreaHandleId = null;
            var orderedTickList = this.getContext().getOrderedTickList();
            var numberOfTicks = orderedTickList.length;
            var lastTickIndex = Math.max(numberOfTicks - 1, 0);
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                var xInArea = posX - areaContext.x;
                var yInArea = posY - areaContext.y;
                if (this.isHitArea(xInArea, yInArea, areaContext)) {
                    focusAreaHandleId = handleId;
                    if (lockFocusElementToLast) {
                        focusElementIndex = lastTickIndex;
                    }
                    else {
                        area.focusY(yInArea);
                        focusElementIndex = area.focusX(xInArea);
                    }
                }
            }
            if (focusElementIndex != null) {
                for (var handleId in areaContexts) {
                    var areaContext = areaContexts[handleId];
                    var area = areaContext.area;
                    area.setFocusElementIndex(focusElementIndex);
                    if (focusAreaHandleId != handleId) {
                        area.unfocusValue();
                    }
                }
            }
            else {
                for (var handleId in areaContexts) {
                    var areaContext = areaContexts[handleId];
                    var area = areaContext.area;
                    area.unfocus();
                }
            }
        };
        CandlestickChart.prototype.processFocusAreasByOneself = function (posX, posY) {
            var areaContexts = this.areaContexts;
            for (var handleId in areaContexts) {
                var areaContext = areaContexts[handleId];
                var area = areaContext.area;
                var xInArea = posX - areaContext.x;
                var yInArea = posY - areaContext.y;
                if (this.isHitArea(xInArea, yInArea, areaContext)) {
                    area.focusY(yInArea);
                    if (false == this.lockFocusElementToLast) {
                        area.focusX(xInArea);
                    }
                }
                else {
                    area.unfocus();
                }
            }
        };
        CandlestickChart.prototype.processDrawerTerminated = function (drawer) {
            var eventsOfDrawerTerminated = this.eventsOfDrawerTerminated;
            for (var handleId in eventsOfDrawerTerminated) {
                var callback = eventsOfDrawerTerminated[handleId];
                callback(drawer);
            }
        };
        CandlestickChart.prototype.addEventListenerOnDrawerTerminated = function (callback) {
            if (callback == null) {
                return null;
            }
            var handleId = this.snGeneratorOfEvents.allocate();
            this.eventsOfDrawerTerminated[handleId] = callback;
            return handleId;
        };
        CandlestickChart.prototype.removeEventListener = function (handleId) {
            if (handleId == null) {
                return;
            }
            delete this.eventsOfDrawerTerminated[handleId];
            this.snGeneratorOfEvents.recycle(handleId);
        };
        return CandlestickChart;
    })();
    CscImpl.CandlestickChart = CandlestickChart;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfBias = (function (_super) {
        __extends(ChartOfBias, _super);
        function ChartOfBias(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.BIAS, area, handleId, width, height, DECIMAL_DIGITS, 'BIAS');
            this.elementBiasList = null;
            this.elementViewBiasDragon = null;
        }
        ChartOfBias.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configBiasLineWidth = config.params['biasLineWidth'];
            var configBiasLineColorRgba = config.params['biasLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleBiasLineWidth = configBiasLineWidth.value;
            this.styleBiasLineColorRgba = configBiasLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBias.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfBias.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfBias.prototype.getStyleBiasLineWidth = function () {
            return this.styleBiasLineWidth;
        };
        ChartOfBias.prototype.setStyleBiasLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleBiasLineWidth = lineWidth;
            this.config.params['biasLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfBias.prototype.getStyleBiasLineColorRgba = function () {
            return this.styleBiasLineColorRgba;
        };
        ChartOfBias.prototype.setStyleBiasLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleBiasLineColorRgba = colorRgba;
            this.config.params['biasLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfBias.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementBiasList.length) {
                return this.elementBiasList[index];
            }
            return null;
        };
        ChartOfBias.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewBiasDragon == null || this.elementViewBiasDragon.length !== numberOfDragonComponents) {
                this.elementViewBiasDragon = CscApi.Utility.resizeFloat32Array(this.elementViewBiasDragon, numberOfDragonComponents);
            }
            if (this.elementBiasList == null || this.elementBiasList.length !== numberOfOrderedTickList) {
                this.elementBiasList = CscApi.Utility.resizeFloat32Array(this.elementBiasList, numberOfOrderedTickList);
            }
            var elementBiasList = this.elementBiasList;
            var period = this.argPeriod;
            var sum = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                if (i >= period) {
                    var ema = sum / period;
                    elementBiasList[i] = (tickData.getClose() - ema) / ema;
                    sum -= orderedTickList[i - period].getClose();
                }
                else {
                    elementBiasList[i] = NaN;
                }
                sum += tickData.getClose();
            }
        };
        ChartOfBias.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementBiasList = this.elementBiasList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var bias = elementBiasList[vi];
                if (false == isNaN(bias)) {
                    if (bias > highestValue)
                        highestValue = bias;
                    if (bias < lowestValue)
                        lowestValue = bias;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfBias.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementBiasList = this.elementBiasList;
            var elementViewBiasDragon = this.elementViewBiasDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementBiasList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var bias = elementBiasList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewBiasDragon[vi] = viewXCoord;
                elementViewBiasDragon[vyi] = isNaN(bias) ? NaN : Math.floor(valueToYCoordConvertor(bias));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfBias.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementBiasList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleBiasLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleBiasLineColorRgba);
                this.drawDragon(this.elementViewBiasDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfBias.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var bias = this.elementBiasList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(bias))
                    valueInfoList.push({ name: 'BIAS', value: bias.toFixed(DECIMAL_DIGITS), valueColor: this.styleBiasLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfBias;
    })(CscImpl.Chart);
    CscImpl.ChartOfBias = ChartOfBias;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var lineScales = [
        [1, 1],
        [1, 8],
        [1, 4],
        [1, 3],
        [1, 2],
        [8, 1],
        [4, 1],
        [3, 1],
        [2, 1],
    ];
    var DrawerOfGannFan = (function (_super) {
        __extends(DrawerOfGannFan, _super);
        function DrawerOfGannFan(chart, handleId) {
            var maxStep = 2;
            _super.call(this, chart, handleId, CscApi.DrawerType.GANN_FAN, maxStep);
        }
        DrawerOfGannFan.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configFanLineWidth = config.params['fanLineWidth'];
            var configFanLineDashedlength = config.params['fanLineDashedLength'];
            var configFanLineColorRgba = config.params['fanLineColorRgba'];
            this.styleFanLineWidth = configFanLineWidth.value;
            this.styleFanLineDashedLength = configFanLineDashedlength.value;
            this.styleFanLineColorRgba = configFanLineColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfGannFan.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var x1;
            var y1;
            var x2;
            var y2;
            var slope;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, current.value);
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep1.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, drawnStep1.value);
            }
            renderer.setLineWidth(this.styleFanLineWidth);
            renderer.setStrokeColorRgba(this.styleFanLineColorRgba);
            var dx = x2 - x1;
            var dy = y2 - y1;
            var slope = dy / dx;
            var length = Math.sqrt(dx * dx + dy * dy);
            var horizontalLine = new CscApi.Line(x1, y1, x2, y1);
            horizontalLine.setLengthBaseOnX1Y1(length);
            this.drawLine(horizontalLine, this.styleFanLineDashedLength);
            var verticalLine = new CscApi.Line(x1, y1, x1, y2);
            verticalLine.setLengthBaseOnX1Y1(length);
            this.drawLine(verticalLine, this.styleFanLineDashedLength);
            if (dx != 0) {
                renderer.setTextFontSize(12);
                renderer.setTextFontName('monospace');
                renderer.setTextFontBold(false);
                renderer.setTextAlignToLeft();
                renderer.setTextBaseLineToMiddle();
                renderer.setFillColorRgba(this.styleFanLineColorRgba);
                var numberOfLines = lineScales.length;
                for (var i = 0; i < numberOfLines; ++i) {
                    var lineScale = lineScales[i];
                    var yScale = lineScale[0];
                    var xScale = lineScale[1];
                    var lineDx = dx / xScale;
                    var lineDy = dy / yScale;
                    var line = new CscApi.Line(x1, y1, x1 + lineDx, y1 + lineDy);
                    line.setLengthBaseOnX1Y1(length);
                    this.drawLine(line, this.styleFanLineDashedLength);
                    renderer.fillText(yScale + 'x' + xScale, line.getX2(), line.getY2());
                }
            }
        };
        return DrawerOfGannFan;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfGannFan = DrawerOfGannFan;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var Renderer = (function () {
        function Renderer(canvas) {
            this.canvas = canvas;
            this.ctx = canvas.getContext('2d');
            this.ctx.setTransform(1, 0, 0, 1, 0.5, 0.5);
            this.viewportStack = [];
            this.isViewportBegin = false;
            this.textFontSize = 10;
            this.textFontName = 'Arial';
            this.textFontBold = false;
            this.textFontAttrIsDirty = true;
        }
        Renderer.prototype.beginRendering = function () {
            this.ctx.save();
            return true;
        };
        Renderer.prototype.endRender = function () {
            this.ctx.restore();
        };
        Renderer.prototype.clear = function () {
            var ctx = this.ctx;
            var canvas = ctx.canvas;
            var w = canvas.width;
            var h = canvas.height;
            ctx.clearRect(0, 0, w, h);
        };
        Renderer.prototype.clearRect = function (x, y, width, height) {
            this.ctx.clearRect(x, y, width, height);
        };
        Renderer.prototype.save = function () {
            this.ctx.save();
        };
        Renderer.prototype.restore = function () {
            this.ctx.restore();
        };
        Renderer.prototype.applyViewport = function (viewportContext) {
            var ctx = this.ctx;
            if (viewportContext.clip) {
                ctx.save();
                ctx.setTransform(1, 0, 0, 1, 0.5 + viewportContext.x, 0.5 + viewportContext.y);
                ctx.beginPath();
                ctx.rect(-0.5, -0.5, viewportContext.width - 0.5, viewportContext.height - 0.5);
                ctx.clip();
            }
            else {
                ctx.setTransform(1, 0, 0, 1, 0.5 + viewportContext.x, 0.5 + viewportContext.y);
            }
        };
        Renderer.prototype.beginViewport = function (x, y, width, height, clip) {
            var viewportContext = {
                x: x,
                y: y,
                width: width,
                height: height,
                clip: clip,
            };
            this.applyViewport(viewportContext);
            this.viewportStack.push(viewportContext);
        };
        Renderer.prototype.endViewport = function () {
            var ctx = this.ctx;
            var viewportStack = this.viewportStack;
            if (viewportStack.length == 0) {
                console.warn('could not pop previous viewport.');
                return;
            }
            var viewportContext = viewportStack.pop();
            if (viewportContext.clip) {
                ctx.restore();
            }
            var n = viewportStack.length;
            if (n > 0) {
                this.applyViewport(viewportStack[n - 1]);
            }
            else {
                ctx.setTransform(1, 0, 0, 1, 0.5, 0.5);
            }
        };
        Renderer.prototype.getTextWidth = function (text) {
            this.updateFontAttribute();
            this.textFontAttrIsDirty = false;
            return this.ctx.measureText(text).width;
        };
        Renderer.prototype.updateFontAttribute = function () {
            this.ctx.font = this.textFontSize + 'px ' + this.textFontName + ' ' + (this.textFontBold ? 'bold' : '');
        };
        Renderer.prototype.setTextFontSize = function (size) {
            this.textFontSize = size;
            this.textFontAttrIsDirty = true;
        };
        Renderer.prototype.setTextFontName = function (name) {
            this.textFontName = name;
            this.textFontAttrIsDirty = true;
        };
        Renderer.prototype.setTextFontBold = function (isBold) {
            this.textFontBold = isBold;
            this.textFontAttrIsDirty = true;
        };
        Renderer.prototype.setTextAlignToLeft = function () {
            this.ctx.textAlign = 'left';
        };
        Renderer.prototype.setTextAlignToCenter = function () {
            this.ctx.textAlign = 'center';
        };
        Renderer.prototype.setTextAlignToRight = function () {
            this.ctx.textAlign = 'right';
        };
        Renderer.prototype.setTextBaseLineToHanging = function () {
            this.ctx.textBaseline = 'hanging';
        };
        Renderer.prototype.setTextBaseLineToTop = function () {
            this.ctx.textBaseline = 'top';
        };
        Renderer.prototype.setTextBaseLineToMiddle = function () {
            this.ctx.textBaseline = 'middle';
        };
        Renderer.prototype.setLineWidth = function (lineWidth) {
            this.ctx.lineWidth = lineWidth;
        };
        Renderer.prototype.setFillColorRgb = function (rgb) {
            this.ctx.fillStyle = CscApi.Utility.rgbArrayToHexStr(rgb);
        };
        Renderer.prototype.setFillColorRgba = function (rgba) {
            this.ctx.fillStyle = CscApi.Utility.rgbaArrayToStr(rgba);
        };
        Renderer.prototype.setStrokeColorRgb = function (rgb) {
            this.ctx.strokeStyle = CscApi.Utility.rgbArrayToHexStr(rgb);
        };
        Renderer.prototype.setStrokeColorRgba = function (rgba) {
            this.ctx.strokeStyle = CscApi.Utility.rgbaArrayToStr(rgba);
        };
        Renderer.prototype.translate = function (x, y) {
            this.ctx.translate(x, y);
        };
        Renderer.prototype.fillText = function (text, x, y) {
            if (this.textFontAttrIsDirty) {
                this.updateFontAttribute();
                this.textFontAttrIsDirty = false;
            }
            this.ctx.fillText(text, x, y);
        };
        Renderer.prototype.fillRect = function (x, y, width, height) {
            this.ctx.fillRect(x, y, width, height);
        };
        Renderer.prototype.fillPolygon = function (lineStrip) {
            var ctx = this.ctx;
            ctx.beginPath();
            var numberOfComponents = lineStrip.length;
            ctx.moveTo(lineStrip[0], lineStrip[1]);
            for (var i = 2; i < numberOfComponents; i += 2) {
                ctx.lineTo(lineStrip[i], lineStrip[i + 1]);
            }
            ctx.closePath();
            ctx.fill();
        };
        Renderer.prototype.strokeText = function (text, x, y) {
            if (this.textFontAttrIsDirty) {
                this.updateFontAttribute();
                this.textFontAttrIsDirty = false;
            }
            this.ctx.strokeText(text, x, y);
        };
        Renderer.prototype.strokeRect = function (x, y, width, height) {
            this.ctx.strokeRect(x, y, width, height);
        };
        Renderer.prototype.strokeDashedRect = function (dashLength, x, y, width, height) {
            if (dashLength > 0) {
                var ctx = this.ctx;
                ctx.setLineDash([dashLength, Math.round(dashLength * 0.618)]);
                this.strokeRect(x, y, width, height);
                ctx.setLineDash([]);
            }
            else {
                this.strokeRect(x, y, width, height);
            }
        };
        Renderer.prototype.strokePoints = function (vector2dComponentList, startPointIndex, numberOfPoints, stridePoints) {
            var numberOfComponents = vector2dComponentList.length;
            if (numberOfComponents < 2) {
                console.error('invalid number of components.');
                return;
            }
            if (startPointIndex == null)
                startPointIndex = 0;
            if (numberOfPoints == null) {
                numberOfPoints = (Math.floor(numberOfComponents * 0.5)) - startPointIndex - 1;
                if (numberOfPoints < 2) {
                    numberOfPoints = 2;
                }
            }
            else if (numberOfPoints < 2) {
                console.error('invalid number of components.');
                return;
            }
            var lowerBound = startPointIndex * 2;
            var upperBound = (startPointIndex + numberOfPoints - 1) * 2;
            if (upperBound > numberOfComponents) {
                console.error('invalid number of components.');
                return;
            }
            if (stridePoints == null) {
                stridePoints = 1;
            }
            var ctx = this.ctx;
            ctx.beginPath();
            var strideIndex = stridePoints * 2;
            for (var i = lowerBound; i <= upperBound; i += strideIndex) {
                var x = vector2dComponentList[i];
                var y = vector2dComponentList[i + 1];
                ctx.rect(x, y, 1, 1);
            }
            ctx.stroke();
        };
        Renderer.prototype.strokeLine = function (x1, y1, x2, y2) {
            var ctx = this.ctx;
            ctx.beginPath();
            ctx.moveTo(x1, y1);
            ctx.lineTo(x2, y2);
            ctx.stroke();
        };
        Renderer.prototype.strokeDashedLine = function (dashLength, x1, y1, x2, y2) {
            if (dashLength > 0) {
                var ctx = this.ctx;
                ctx.setLineDash([dashLength, Math.round(dashLength * 0.618)]);
                this.strokeLine(x1, y1, x2, y2);
                ctx.setLineDash([]);
            }
            else {
                this.strokeLine(x1, y1, x2, y2);
            }
        };
        Renderer.prototype.strokeLines = function (vector2dComponentList) {
            var numberOfComponents = vector2dComponentList.length;
            if (numberOfComponents < 4) {
                console.error('invalid number of components.');
                return;
            }
            var ctx = this.ctx;
            ctx.beginPath();
            for (var i = 0; i < numberOfComponents;) {
                ctx.moveTo(vector2dComponentList[i++], vector2dComponentList[i++]);
                ctx.lineTo(vector2dComponentList[i++], vector2dComponentList[i++]);
            }
            ctx.stroke();
        };
        Renderer.prototype.strokeDashedLines = function (dashLength, vector2dComponentList) {
            if (dashLength > 0) {
                var ctx = this.ctx;
                ctx.setLineDash([dashLength, Math.round(dashLength * 0.618)]);
                this.strokeLines(vector2dComponentList);
                ctx.setLineDash([]);
            }
            else {
                this.strokeLines(vector2dComponentList);
            }
        };
        Renderer.prototype.strokeLineStrips = function (vector2dComponentList, startPointIndex, numberOfPoints, stridePoints) {
            var numberOfComponents = vector2dComponentList.length;
            if (numberOfComponents < 4) {
                console.error('invalid number of components.');
                return;
            }
            if (startPointIndex == null)
                startPointIndex = 0;
            if (numberOfPoints == null) {
                numberOfPoints = (Math.floor(numberOfComponents * 0.5)) - startPointIndex - 1;
                if (numberOfPoints < 2) {
                    numberOfPoints = 2;
                }
            }
            else if (numberOfPoints < 2) {
                console.error('invalid number of components.');
                return;
            }
            var lowerBound = startPointIndex * 2;
            var upperBound = (startPointIndex + numberOfPoints - 1) * 2;
            if (upperBound > numberOfComponents) {
                console.error('invalid number of components.');
                return;
            }
            if (stridePoints == null) {
                stridePoints = 1;
            }
            var ctx = this.ctx;
            ctx.beginPath();
            var startComponentIndex = startPointIndex * 2;
            ctx.moveTo(vector2dComponentList[lowerBound], vector2dComponentList[++lowerBound]);
            var strideIndex = stridePoints * 2;
            for (var i = lowerBound + 1; i <= upperBound; i += strideIndex) {
                ctx.lineTo(vector2dComponentList[i], vector2dComponentList[i + 1]);
            }
            ctx.stroke();
        };
        Renderer.prototype.strokeDashedLineStrips = function (dashLength, vector2dComponentList, startPointIndex, numberOfPoints, stridePoints) {
            if (dashLength > 0) {
                var ctx = this.ctx;
                ctx.setLineDash([dashLength, Math.round(dashLength * 0.618)]);
                this.strokeLineStrips(vector2dComponentList, startPointIndex, numberOfPoints, stridePoints);
                ctx.setLineDash([]);
            }
            else {
                this.strokeLineStrips(vector2dComponentList, startPointIndex, numberOfPoints, stridePoints);
            }
        };
        Renderer.prototype.strokeArc = function (x, y, radius, startRad, endRad) {
            var ctx = this.ctx;
            ctx.beginPath();
            ctx.arc(x, y, radius, startRad, endRad);
            ctx.stroke();
        };
        ;
        Renderer.prototype.strokeDashedArc = function (dashLength, x, y, radius, startRad, endRad) {
            if (dashLength > 0) {
                var ctx = this.ctx;
                ctx.setLineDash([dashLength, Math.round(dashLength * 0.618)]);
                this.strokeArc(x, y, radius, startRad, endRad);
                ctx.setLineDash([]);
            }
            else {
                this.strokeArc(x, y, radius, startRad, endRad);
            }
        };
        Renderer.prototype.strokeFan = function (x, y, radius, startRad, endRad) {
            var ctx = this.ctx;
            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.lineTo(x + Math.floor(Math.cos(startRad) * radius), y + Math.floor(Math.sin(startRad) * radius));
            ctx.arc(x, y, radius, startRad, endRad);
            ctx.lineTo(x, y);
            ctx.stroke();
        };
        Renderer.prototype.strokeDashedFan = function (dashLength, x, y, radius, startRad, endRad) {
            if (dashLength > 0) {
                var ctx = this.ctx;
                ctx.setLineDash([dashLength, Math.round(dashLength * 0.618)]);
                this.strokeFan(x, y, radius, startRad, endRad);
                ctx.setLineDash([]);
            }
            else {
                this.strokeFan(x, y, radius, startRad, endRad);
            }
        };
        return Renderer;
    })();
    CscImpl.Renderer = Renderer;
})(CscImpl || (CscImpl = {}));
///<reference path="../cscApi/candlestickChartApi.ts"/>
var CscImpl;
(function (CscImpl) {
    var MouseState = (function () {
        function MouseState() {
            this.Reset();
        }
        MouseState.prototype.Reset = function () {
            this._btnLeftClick = false;
            this._btnRightClick = false;
            this._btnMiddleClick = false;
            this._btnLeftUp = false;
            this._btnRightUp = false;
            this._btnMiddleUp = false;
            this._domPositionX = 0;
            this._domPositionY = 0;
            this._domMovementX = 0;
            this._domMovementY = 0;
            this._positionX = 0;
            this._positionY = 0;
            this._movementX = 0;
            this._movementY = 0;
            this._wheelDelta = 0;
        };
        MouseState.prototype.IsButtonDown = function (mouseButton) {
            switch (mouseButton) {
                case CscApi.MouseButton.LEFT: return this._btnLeftDown;
                case CscApi.MouseButton.RIGHT: return this._btnRightDown;
                case CscApi.MouseButton.META: return this._btnMiddleDown;
            }
            throw 'unknown mouse button.';
        };
        MouseState.prototype.IsButtonUp = function (mouseButton) {
            switch (mouseButton) {
                case CscApi.MouseButton.LEFT: return this._btnLeftUp;
                case CscApi.MouseButton.RIGHT: return this._btnRightUp;
                case CscApi.MouseButton.META: return this._btnMiddleUp;
            }
            throw 'unknown mouse button.';
        };
        MouseState.prototype.GetDomPositionX = function () {
            return this._domPositionX;
        };
        MouseState.prototype.GetDomPositionY = function () {
            return this._domPositionY;
        };
        MouseState.prototype.GetDomMovementX = function () {
            return this._domMovementX;
        };
        MouseState.prototype.GetDomMovementY = function () {
            return this._domMovementY;
        };
        MouseState.prototype.GetPositionX = function () {
            return this._positionX;
        };
        MouseState.prototype.GetPositionY = function () {
            return this._positionY;
        };
        MouseState.prototype.GetMovementX = function () {
            return this._movementX;
        };
        MouseState.prototype.GetMovementY = function () {
            return this._movementY;
        };
        MouseState.prototype.GetWheelDelta = function () {
            return this._wheelDelta;
        };
        MouseState.prototype.SetButtonDown = function (mouseButton, status) {
            switch (mouseButton) {
                case CscApi.MouseButton.LEFT:
                    this._btnLeftDown = status;
                    break;
                case CscApi.MouseButton.RIGHT:
                    this._btnRightDown = status;
                    break;
                case CscApi.MouseButton.META:
                    this._btnMiddleDown = status;
                    break;
                default: throw 'unknown mouse button.';
            }
        };
        MouseState.prototype.SetButtonUp = function (mouseButton, status) {
            switch (mouseButton) {
                case CscApi.MouseButton.LEFT:
                    this._btnLeftUp = status;
                    break;
                case CscApi.MouseButton.RIGHT:
                    this._btnRightUp = status;
                    break;
                case CscApi.MouseButton.META:
                    this._btnMiddleUp = status;
                    break;
                default: throw 'unknown mouse button.';
            }
        };
        MouseState.prototype.SetDomPosition = function (x, y) {
            this._domPositionX = x;
            this._domPositionY = y;
        };
        MouseState.prototype.SetDomMovement = function (x, y) {
            this._domMovementX = x;
            this._domMovementY = y;
        };
        MouseState.prototype.SetPosition = function (x, y) {
            this._positionX = x;
            this._positionY = y;
        };
        MouseState.prototype.SetMovement = function (x, y) {
            this._movementX = x;
            this._movementY = y;
        };
        MouseState.prototype.SetWheelDelta = function (wheelDelta) {
            this._wheelDelta = wheelDelta;
        };
        return MouseState;
    })();
    CscImpl.MouseState = MouseState;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfMacd = (function (_super) {
        __extends(ChartOfMacd, _super);
        function ChartOfMacd(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.MACD, area, handleId, width, height, DECIMAL_DIGITS, 'MACD');
            this.elementDiffList = null;
            this.elementViewDiffDragon = null;
            this.elementViewDemDragon = null;
            this.elementViewMacd = null;
        }
        ChartOfMacd.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configShortPeriod = config.params['shortPeriod'];
            var configLongPeriod = config.params['longPeriod'];
            var configPeriodSignal = config.params['periodSignal'];
            var configDiffLineWidth = config.params['diffLineWidth'];
            var configDiffLineColorRgba = config.params['diffLineColorRgba'];
            var configDemLineWidth = config.params['demLineWidth'];
            var configDemLineColorRgba = config.params['demLineColorRgba'];
            var configMacdPositiveColorRgba = config.params['macdPositiveColorRgba'];
            var configMacdNegativeColorRgba = config.params['macdNegativeColorRgba'];
            this.argShortPeriod = configShortPeriod.value;
            this.argLongPeriod = configLongPeriod.value;
            this.argPeriodSignal = configPeriodSignal.value;
            this.styleDiffLineWidth = configDiffLineWidth.value;
            this.styleDiffLineColorRgba = configDiffLineColorRgba.value;
            this.styleDemLineWidth = configDemLineWidth.value;
            this.styleDemLineColorRgba = configDemLineColorRgba.value;
            this.styleMacdPositiveColorRgba = configMacdPositiveColorRgba.value;
            this.styleMacdNegativeColorRgba = configMacdNegativeColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMacd.prototype.getArgShortPeriod = function () {
            return this.argShortPeriod;
        };
        ChartOfMacd.prototype.setArgShortPeriod = function (period) {
            this.argShortPeriod = period;
            this.config.params['shortPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMacd.prototype.getArgLongPeriod = function () {
            return this.argLongPeriod;
        };
        ChartOfMacd.prototype.setArgLongPeriod = function (period) {
            this.argLongPeriod = period;
            this.config.params['longPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMacd.prototype.getArgPeriodSignal = function () {
            return this.argPeriodSignal;
        };
        ChartOfMacd.prototype.setArgPeriodSignal = function (periodSignal) {
            this.argPeriodSignal = periodSignal;
            this.config.params['periodSignal'].value = periodSignal;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMacd.prototype.getStyleDiffLineWidth = function () {
            return this.styleDiffLineWidth;
        };
        ChartOfMacd.prototype.setStyleDiffLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleDiffLineWidth = lineWidth;
            this.config.params['diffLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfMacd.prototype.getStyleDiffLineColorRgba = function () {
            return this.styleDiffLineColorRgba;
        };
        ChartOfMacd.prototype.setStyleDiffLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleDiffLineColorRgba = colorRgba;
            this.config.params['diffLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfMacd.prototype.getStyleDemLineWidth = function () {
            return this.styleDemLineWidth;
        };
        ChartOfMacd.prototype.setStyleDemLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleDemLineWidth = lineWidth;
            this.config.params['diffLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfMacd.prototype.getStyleDemLineColorRgba = function () {
            return this.styleDemLineColorRgba;
        };
        ChartOfMacd.prototype.setStyleDemLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleDemLineColorRgba = colorRgba;
            this.config.params['demLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfMacd.prototype.getStyleMacdPositiveColorRgba = function () {
            return this.styleMacdPositiveColorRgba;
        };
        ChartOfMacd.prototype.setStyleMacdPositiveColorRgba = function (colorRgba) {
            this.styleMacdPositiveColorRgba = colorRgba;
            this.config.params['macdPositiveColorRgba'].value = colorRgba;
        };
        ChartOfMacd.prototype.getStyleMacdNegativeColorRgba = function () {
            return this.styleMacdNegativeColorRgba;
        };
        ChartOfMacd.prototype.setStyleMacdNegativeColorRgba = function (colorRgba) {
            this.styleMacdNegativeColorRgba = colorRgba;
            this.config.params['macdNegativeColorRgba'].value = colorRgba;
        };
        ChartOfMacd.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementDiffList.length) {
                return this.elementDiffList[index];
            }
            return null;
        };
        ChartOfMacd.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewDiffDragon == null || this.elementViewDiffDragon.length !== numberOfDragonComponents) {
                this.elementViewDiffDragon = CscApi.Utility.resizeFloat32Array(this.elementViewDiffDragon, numberOfDragonComponents);
            }
            if (this.elementViewDemDragon == null || this.elementViewDemDragon.length !== numberOfDragonComponents) {
                this.elementViewDemDragon = CscApi.Utility.resizeFloat32Array(this.elementViewDemDragon, numberOfDragonComponents);
            }
            if (this.elementViewMacd == null || this.elementViewMacd.length !== numberOfOrderedTickList) {
                this.elementViewMacd = CscApi.Utility.resizeFloat32Array(this.elementViewMacd, numberOfOrderedTickList);
            }
            if (this.elementDiffList == null || this.elementDiffList.length !== numberOfOrderedTickList) {
                this.elementDiffList = CscApi.Utility.resizeFloat32Array(this.elementDiffList, numberOfOrderedTickList);
            }
            if (this.elementDemList == null || this.elementDemList.length !== numberOfOrderedTickList) {
                this.elementDemList = CscApi.Utility.resizeFloat32Array(this.elementDemList, numberOfOrderedTickList);
            }
            if (this.elementMacdList == null || this.elementMacdList.length !== numberOfOrderedTickList) {
                this.elementMacdList = CscApi.Utility.resizeFloat32Array(this.elementMacdList, numberOfOrderedTickList);
            }
            var elementDiffList = this.elementDiffList;
            var elementDemList = this.elementDemList;
            var elementMacdList = this.elementMacdList;
            var shortPeriod = this.argShortPeriod;
            var longPeriod = this.argLongPeriod;
            var periodSignal = this.argPeriodSignal;
            var sumShort = 0;
            var sumLong = 0;
            var sumDiff = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                elementDiffList[i] = NaN;
                elementDemList[i] = NaN;
                elementMacdList[i] = NaN;
                sumShort += tickData.getClose();
                sumLong += tickData.getClose();
                if (i >= shortPeriod) {
                    sumShort -= orderedTickList[i - shortPeriod].getClose();
                    if (i >= longPeriod) {
                        sumLong -= orderedTickList[i - longPeriod].getClose();
                        var diff = sumShort / shortPeriod - sumLong / longPeriod;
                        elementDiffList[i] = diff;
                        sumDiff += diff;
                        if (i >= longPeriod + periodSignal) {
                            sumDiff -= elementDiffList[i - periodSignal];
                            var dem = sumDiff / periodSignal;
                            elementDemList[i] = dem;
                            elementMacdList[i] = diff - dem;
                        }
                    }
                }
            }
        };
        ChartOfMacd.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementDiffList = this.elementDiffList;
            var elementDemList = this.elementDemList;
            var elementMacdList = this.elementMacdList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var diff = elementDiffList[vi];
                var dem = elementDemList[vi];
                var macd = elementMacdList[vi];
                if (false == isNaN(diff)) {
                    if (diff > highestValue)
                        highestValue = diff;
                    if (diff < lowestValue)
                        lowestValue = diff;
                }
                if (false == isNaN(dem)) {
                    if (dem > highestValue)
                        highestValue = dem;
                    if (dem < lowestValue)
                        lowestValue = dem;
                }
                if (false == isNaN(macd)) {
                    if (macd > highestValue)
                        highestValue = macd;
                    if (macd < lowestValue)
                        lowestValue = macd;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfMacd.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementDiffList = this.elementDiffList;
            var elementDemList = this.elementDemList;
            var elementMacdList = this.elementMacdList;
            var elementViewDiffDragon = this.elementViewDiffDragon;
            var elementViewDemDragon = this.elementViewDemDragon;
            var elementViewMacd = this.elementViewMacd;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argShortPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementDiffList.length - 1) {
                viewEndTickIndex++;
            }
            var viewZeroValueYCoord = this.viewZeroValueYCoord = Math.floor(valueToYCoordConvertor(0));
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var diff = elementDiffList[i];
                var dem = elementDemList[i];
                var macd = elementMacdList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewDiffDragon[vi] = viewXCoord;
                elementViewDiffDragon[vyi] = isNaN(diff) ? NaN : Math.floor(valueToYCoordConvertor(diff));
                elementViewDemDragon[vi] = viewXCoord;
                elementViewDemDragon[vyi] = isNaN(dem) ? NaN : Math.floor(valueToYCoordConvertor(dem));
                elementViewMacd[i] = Math.floor(valueToYCoordConvertor(macd)) - viewZeroValueYCoord;
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfMacd.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argShortPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementDiffList.length - 1) {
                viewEndTickIndex++;
            }
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndexOfShort = viewStartTickIndex >= this.argShortPeriod ? viewStartTickIndex : this.argShortPeriod;
            var firstPointIndexOfLong = viewStartTickIndex >= this.argLongPeriod ? viewStartTickIndex : this.argLongPeriod;
            renderer.translate(-viewStartXCoord, 0);
            var elementViewMacdHeight = this.elementViewMacd;
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var macdPoleWidth = Math.floor(viewTickWidth * 0.8);
            if (macdPoleWidth < 1) {
                macdPoleWidth = 1;
            }
            var macdPoleHalfWidth = Math.floor(macdPoleWidth * 0.5);
            if (macdPoleHalfWidth < 0) {
                macdPoleHalfWidth = 0;
            }
            var timeScale = candlestickChart.getTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var elementMacdList = this.elementMacdList;
            var styleMacdPositiveColorRgba = this.styleMacdPositiveColorRgba;
            var styleMacdNegativeColorRgba = this.styleMacdNegativeColorRgba;
            var viewZeroValueYCoord = this.viewZeroValueYCoord;
            renderer.translate(-macdPoleHalfWidth, 0);
            if (macdPoleWidth > 1) {
                renderer.setFillColorRgba(styleMacdPositiveColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd > 0) {
                        renderer.fillRect(viewXCoord, viewZeroValueYCoord, macdPoleWidth, macdHeight);
                    }
                }
                renderer.setFillColorRgba(styleMacdNegativeColorRgba);
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd < 0) {
                        renderer.fillRect(viewXCoord, viewZeroValueYCoord, macdPoleWidth, macdHeight);
                    }
                }
            }
            else {
                var prevViewXCoord = null;
                renderer.setStrokeColorRgba(styleMacdPositiveColorRgba);
                var highestMacd = -Infinity;
                var highestMacdPoleHeight;
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd > 0) {
                        if (macd > highestMacd) {
                            highestMacd = macd;
                            highestMacdPoleHeight = macdHeight;
                        }
                        if (prevViewXCoord !== viewXCoord) {
                            prevViewXCoord = viewXCoord;
                            highestMacd = -Infinity;
                            renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + highestMacdPoleHeight);
                        }
                    }
                }
                if (isFinite(highestMacd)) {
                    renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + highestMacdPoleHeight);
                }
                renderer.setStrokeColorRgba(styleMacdNegativeColorRgba);
                var lowestMacd = Infinity;
                var lowestMacdPoleHeight;
                for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                    var macd = elementMacdList[i];
                    var macdHeight = elementViewMacdHeight[i];
                    var timeScaleElement = timeScaleElements[i];
                    var viewXCoord = timeScaleElement.viewXCoord;
                    if (macd < 0) {
                        if (macd < lowestMacd) {
                            lowestMacd = macd;
                            lowestMacdPoleHeight = macdHeight;
                        }
                        if (prevViewXCoord !== viewXCoord) {
                            prevViewXCoord = viewXCoord;
                            lowestMacd = Infinity;
                            renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + lowestMacdPoleHeight);
                        }
                    }
                }
                if (isFinite(lowestMacd)) {
                    renderer.strokeLine(viewXCoord, viewZeroValueYCoord, viewXCoord, viewZeroValueYCoord + lowestMacdPoleHeight);
                }
            }
            renderer.translate(macdPoleHalfWidth, 0);
            var numberOfPointsOfShort = viewEndTickIndex - firstPointIndexOfShort + 1;
            if (numberOfPointsOfShort > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleDiffLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleDiffLineColorRgba);
                this.drawDragon(this.elementViewDiffDragon, firstPointIndexOfShort, numberOfPointsOfShort);
            }
            var numberOfPointsOfLong = viewEndTickIndex - firstPointIndexOfLong + 1;
            if (numberOfPointsOfLong > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleDemLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleDemLineColorRgba);
                this.drawDragon(this.elementViewDemDragon, firstPointIndexOfLong, numberOfPointsOfLong);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfMacd.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var diff = this.elementDiffList[focusElementIndex];
                var dem = this.elementDemList[focusElementIndex];
                var macd = this.elementMacdList[focusElementIndex];
                valueInfoList = [
                    { name: 'Short', value: this.argShortPeriod.toString(), valueColor: null },
                    { name: 'Long', value: this.argLongPeriod.toString(), valueColor: null },
                    { name: 'Signal', value: this.argPeriodSignal.toString(), valueColor: null },
                ];
                if (false === isNaN(diff))
                    valueInfoList.push({ name: 'DIFF', value: diff.toFixed(DECIMAL_DIGITS), valueColor: this.styleDiffLineColorRgba });
                if (false === isNaN(dem))
                    valueInfoList.push({ name: 'DEM', value: dem.toFixed(DECIMAL_DIGITS), valueColor: this.styleDemLineColorRgba });
                if (false === isNaN(macd))
                    valueInfoList.push({ name: 'MACD', value: macd.toFixed(DECIMAL_DIGITS), valueColor: macd >= 0 ? this.styleMacdPositiveColorRgba : this.styleMacdNegativeColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfMacd;
    })(CscImpl.Chart);
    CscImpl.ChartOfMacd = ChartOfMacd;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfSar = (function (_super) {
        __extends(ChartOfSar, _super);
        function ChartOfSar(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.SAR, area, handleId, width, height, DECIMAL_DIGITS, 'SAR');
            this.elementSarRisingList = null;
            this.elementSarAfList = null;
            this.elementSarEpList = null;
            this.elementSarList = null;
            this.elementViewSar = null;
        }
        ChartOfSar.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configSarAfInit = config.params['sarAfInit'];
            var configSarAfStep = config.params['sarAfStep'];
            var configSarAfLimit = config.params['sarAfLimit'];
            var configSarDotWidth = config.params['sarDotSize'];
            var configSarDotColorRgba = config.params['sarDotColorRgba'];
            this.argAfInit = configSarAfInit.value;
            this.argAfStep = configSarAfStep.value;
            this.argAfLimit = configSarAfLimit.value;
            this.styleSarDotSize = configSarDotWidth.value;
            this.styleSarDotColorRgba = configSarDotColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfSar.prototype.getArgAfInit = function () {
            return this.argAfInit;
        };
        ChartOfSar.prototype.setArgAfInit = function (value) {
            if (value == null) {
                return false;
            }
            this.argAfInit = value;
            this.config.params['sarAfInit'].value = value;
            this.setArgDirty(true);
            return true;
        };
        ChartOfSar.prototype.getArgAfStep = function () {
            return this.argAfStep;
        };
        ChartOfSar.prototype.setArgAfStep = function (value) {
            if (value == null) {
                return false;
            }
            this.argAfStep = value;
            this.config.params['sarAfStep'].value = value;
            this.setArgDirty(true);
            return true;
        };
        ChartOfSar.prototype.getArgAfLimit = function () {
            return this.argAfLimit;
        };
        ChartOfSar.prototype.setArgAfLimit = function (value) {
            if (value == null) {
                return false;
            }
            this.argAfLimit = value;
            this.config.params['sarAfLimit'].value = value;
            this.setArgDirty(true);
            return true;
        };
        ChartOfSar.prototype.getStyleSarDotSize = function () {
            return this.styleSarDotSize;
        };
        ChartOfSar.prototype.setStyleSarDotSize = function (size) {
            if (size == null) {
                return false;
            }
            this.styleSarDotSize = size;
            this.config.params['sarDotSize'].value = size;
            return true;
        };
        ChartOfSar.prototype.getStyleSarDotColorRgba = function () {
            return this.styleSarDotColorRgba;
        };
        ChartOfSar.prototype.setStyleSarDotColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleSarDotColorRgba = colorRgba;
            this.config.params['sarDotColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfSar.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementSarList.length) {
                return this.elementSarList[index];
            }
            return null;
        };
        ChartOfSar.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfElementsForViewSar = numberOfOrderedTickList * 2;
            if (this.elementViewSar == null || this.elementViewSar.length !== numberOfElementsForViewSar) {
                this.elementViewSar = CscApi.Utility.resizeFloat32Array(this.elementViewSar, numberOfElementsForViewSar);
            }
            if (this.elementSarRisingList == null || this.elementSarRisingList.length != numberOfOrderedTickList) {
                this.elementSarRisingList = CscApi.Utility.resizeUint8Array(this.elementSarRisingList, numberOfOrderedTickList);
            }
            if (this.elementSarAfList == null || this.elementSarAfList.length != numberOfOrderedTickList) {
                this.elementSarAfList = CscApi.Utility.resizeFloat32Array(this.elementSarAfList, numberOfOrderedTickList);
            }
            if (this.elementSarEpList == null || this.elementSarEpList.length != numberOfOrderedTickList) {
                this.elementSarEpList = CscApi.Utility.resizeFloat32Array(this.elementSarEpList, numberOfOrderedTickList);
            }
            if (this.elementSarList == null || this.elementSarList.length != numberOfOrderedTickList) {
                this.elementSarList = CscApi.Utility.resizeFloat32Array(this.elementSarList, numberOfOrderedTickList);
            }
            var elementSarRisingList = this.elementSarRisingList;
            var elementSarAfList = this.elementSarAfList;
            var elementSarEpList = this.elementSarEpList;
            var elementSarList = this.elementSarList;
            var afInit = this.argAfInit;
            var afStep = this.argAfStep;
            var afLimit = this.argAfLimit;
            for (var i = updateTickFromIndex; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                if (i == 0) {
                    elementSarAfList[i] = afInit;
                    var isRising = tickData.getClose() >= tickData.getOpen();
                    if (isRising) {
                        elementSarRisingList[i] = 1;
                        elementSarList[i] = tickData.getLow();
                        elementSarEpList[i] = tickData.getHigh();
                    }
                    else {
                        elementSarRisingList[i] = 0;
                        elementSarList[i] = tickData.getHigh();
                        elementSarEpList[i] = tickData.getLow();
                    }
                }
                else {
                    var prevIndex = i - 1;
                    var prevAf = elementSarAfList[prevIndex];
                    var prevEp = elementSarEpList[prevIndex];
                    var prevSar = elementSarList[prevIndex];
                    var prevSarIsRising = elementSarRisingList[prevIndex] > 0 ? true : false;
                    var sar;
                    if (prevSarIsRising) {
                        sar = prevSar + prevAf * (tickData.getHigh() - prevSar);
                    }
                    else {
                        sar = prevSar + prevAf * (tickData.getLow() - prevSar);
                    }
                    var reverse = false;
                    var isRising = prevSarIsRising;
                    var ep = prevEp;
                    var af;
                    if (prevSarIsRising) {
                        if (tickData.getLow() < sar) {
                            isRising = false;
                            reverse = true;
                            sar = tickData.getHigh();
                            ep = tickData.getLow();
                            af = afInit;
                        }
                    }
                    else {
                        if (tickData.getHigh() > sar) {
                            isRising = true;
                            reverse = true;
                            sar = tickData.getLow();
                            ep = tickData.getHigh();
                            af = afInit;
                        }
                    }
                    if (true != reverse) {
                        if (isRising) {
                            if (tickData.getHigh() > ep) {
                                ep = tickData.getHigh();
                                af = Math.min(afLimit, prevAf + afStep);
                            }
                            if (orderedTickList[i - 1].getLow() < sar) {
                                sar = orderedTickList[i - 1].getLow();
                            }
                        }
                        else {
                            if (tickData.getLow() < ep) {
                                ep = tickData.getLow();
                                af = Math.min(afLimit, prevAf + afStep);
                            }
                            if (orderedTickList[i - 1].getHigh() > sar) {
                                sar = orderedTickList[i - 1].getHigh();
                            }
                        }
                    }
                    elementSarRisingList[i] = isRising ? 1 : 0;
                    elementSarAfList[i] = af;
                    elementSarEpList[i] = ep;
                    elementSarList[i] = sar;
                }
            }
        };
        ChartOfSar.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementSarList = this.elementSarList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var sar = elementSarList[vi];
                if (false == isNaN(sar)) {
                    if (sar > highestValue)
                        highestValue = sar;
                    if (sar < lowestValue)
                        lowestValue = sar;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfSar.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementSarList = this.elementSarList;
            var elementViewSar = this.elementViewSar;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var sar = elementSarList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewSar[vi] = Math.floor(timeScaleElement.viewXCoord);
                elementViewSar[vyi] = Math.floor(valueToYCoordConvertor(sar));
            }
            return yAxisEnabled ? this.generateValueScale(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfSar.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            var viewTickWidth = candlestickChart.getViewTickWidth();
            renderer.setLineWidth(Math.floor(Math.min(this.styleSarDotSize, viewTickWidth)));
            renderer.setStrokeColorRgba(this.styleSarDotColorRgba);
            var area = this.getArea();
            var timeScale = candlestickChart.getTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            var elementViewSar = this.elementViewSar;
            var viewStartXCoord = area.getViewStartXCoord();
            var numberOfPoints = viewEndTickIndex - viewStartTickIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            this.drawPoints(elementViewSar, viewStartTickIndex, numberOfPoints);
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfSar.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var sar = this.elementSarList[focusElementIndex];
                var trendIsRising = this.elementSarRisingList[focusElementIndex] > 0 ? true : false;
                valueInfoList = [
                    { name: 'AF-Init', value: this.argAfInit.toString(), valueColor: null },
                    { name: 'AF-Step', value: this.argAfStep.toString(), valueColor: null },
                    { name: 'AF-Limit', value: this.argAfLimit.toString(), valueColor: null },
                ];
                if (false === isNaN(sar))
                    valueInfoList.push({ name: 'SAR', value: sar.toFixed(DECIMAL_DIGITS), valueColor: this.styleSarDotColorRgba });
                valueInfoList.push({ name: 'Trend', value: trendIsRising ? 'Up' : 'Down', valueColor: null });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfSar;
    })(CscImpl.Chart);
    CscImpl.ChartOfSar = ChartOfSar;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var DrawerOfGoldenCircle = (function (_super) {
        __extends(DrawerOfGoldenCircle, _super);
        function DrawerOfGoldenCircle(chart, handleId) {
            var maxStep = 2;
            _super.call(this, chart, handleId, CscApi.DrawerType.GOLDEN_CIRCLE, maxStep);
        }
        DrawerOfGoldenCircle.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configCircleLineWidth = config.params['circleLineWidth'];
            var configCircleLineDashedlength = config.params['circleLineDashedLength'];
            var configCircleLineColorRgba = config.params['circleLineColorRgba'];
            var configFanLineWidth = config.params['fanLineWidth'];
            var configFanLineDashedlength = config.params['fanLineDashedLength'];
            var configFanLineColorRgba = config.params['fanLineColorRgba'];
            var configGoldenArcLineWidth = config.params['goldenArcLineWidth'];
            var configGoldenArcLineDashedlength = config.params['goldenArcLineDashedLength'];
            var configGoldenArcLineColorRgba = config.params['goldenArcLineColorRgba'];
            this.styleCircleLineWidth = configCircleLineWidth.value;
            this.styleCircleLineDashedLength = configCircleLineDashedlength.value;
            this.styleCircleLineColorRgba = configCircleLineColorRgba.value;
            this.styleFanLineWidth = configFanLineWidth.value;
            this.styleFanLineDashedLength = configFanLineDashedlength.value;
            this.styleFanLineColorRgba = configFanLineColorRgba.value;
            this.styleGoldenArcLineWidth = configGoldenArcLineWidth.value;
            this.styleGoldenArcLineDashedLength = configGoldenArcLineDashedlength.value;
            this.styleGoldenArcLineColorRgba = configGoldenArcLineColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfGoldenCircle.prototype.getStyleCircleLineWidth = function () {
            return this.styleCircleLineWidth;
        };
        DrawerOfGoldenCircle.prototype.setStyleCircleLineWidth = function (lineWidth) {
            this.styleCircleLineWidth = lineWidth;
        };
        DrawerOfGoldenCircle.prototype.getStyleCircleLineDashedLength = function () {
            return this.styleCircleLineDashedLength;
        };
        DrawerOfGoldenCircle.prototype.setStyleCircleLineDashedLength = function (dashedLength) {
            this.styleCircleLineDashedLength = dashedLength;
        };
        DrawerOfGoldenCircle.prototype.getStyleCircleLineColorRgba = function () {
            return this.styleCircleLineColorRgba;
        };
        DrawerOfGoldenCircle.prototype.setStyleCircleLineColorRgba = function (colorRgba) {
            this.styleCircleLineColorRgba = colorRgba;
        };
        DrawerOfGoldenCircle.prototype.getStyleFanLineWidth = function () {
            return this.styleFanLineWidth;
        };
        DrawerOfGoldenCircle.prototype.setStyleFanLineWidth = function (lineWidth) {
            this.styleFanLineWidth = lineWidth;
        };
        DrawerOfGoldenCircle.prototype.getStyleFanLineDashedLength = function () {
            return this.styleFanLineDashedLength;
        };
        DrawerOfGoldenCircle.prototype.setStyleFanLineDashedLength = function (dashedLength) {
            this.styleFanLineDashedLength = dashedLength;
        };
        DrawerOfGoldenCircle.prototype.getStyleFanLineColorRgba = function () {
            return this.styleFanLineColorRgba;
        };
        DrawerOfGoldenCircle.prototype.setStyleFanLineColorRgba = function (colorRgba) {
            this.styleFanLineColorRgba = colorRgba;
        };
        DrawerOfGoldenCircle.prototype.getStyleGoldenArcLineWidth = function () {
            return this.styleGoldenArcLineWidth;
        };
        DrawerOfGoldenCircle.prototype.setStyleGoldenArcLineWidth = function (lineWidth) {
            this.styleGoldenArcLineWidth = lineWidth;
        };
        DrawerOfGoldenCircle.prototype.getStyleGoldenArcLineDashedLength = function () {
            return this.styleGoldenArcLineDashedLength;
        };
        DrawerOfGoldenCircle.prototype.setStyleGoldenArcLineColorRgba = function (colorRgba) {
            this.styleGoldenArcLineColorRgba = colorRgba;
        };
        DrawerOfGoldenCircle.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var x1;
            var y1;
            var x2;
            var y2;
            var line1;
            var line2;
            var slope;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, current.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, current.value);
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep0.index);
                y1 = area.getChartYCoordFromValue(chartHandleId, drawnStep0.value);
                x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, drawnStep1.index);
                y2 = area.getChartYCoordFromValue(chartHandleId, drawnStep1.value);
            }
            var dx = x2 - x1;
            var dy = y2 - y1;
            var radius = Math.sqrt(dx * dx + dy * dy);
            if (radius > 0) {
                var angleInRad = Math.atan2(dy, dx);
                var arcHalfAngle = Math.PI / 3;
                renderer.setLineWidth(this.styleCircleLineWidth);
                renderer.setStrokeColorRgba(this.styleCircleLineColorRgba);
                renderer.strokeDashedArc(this.styleCircleLineDashedLength, x1, y1, radius * 0.618, angleInRad + arcHalfAngle, angleInRad - arcHalfAngle);
                renderer.strokeDashedArc(this.styleCircleLineDashedLength, x1, y1, radius, angleInRad + arcHalfAngle, angleInRad - arcHalfAngle);
                renderer.setLineWidth(this.styleFanLineWidth);
                renderer.setStrokeColorRgba(this.styleFanLineColorRgba);
                renderer.strokeDashedLine(this.styleFanLineDashedLength, x1, y1, x2, y2);
                renderer.strokeDashedFan(this.styleFanLineDashedLength, x1, y1, radius, angleInRad - arcHalfAngle, angleInRad + arcHalfAngle);
                renderer.setLineWidth(this.styleGoldenArcLineWidth);
                renderer.setStrokeColorRgba(this.styleGoldenArcLineColorRgba);
                renderer.strokeDashedArc(this.styleGoldenArcLineDashedLength, x1, y1, radius * 0.618, angleInRad - arcHalfAngle, angleInRad + arcHalfAngle);
            }
        };
        return DrawerOfGoldenCircle;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfGoldenCircle = DrawerOfGoldenCircle;
})(CscImpl || (CscImpl = {}));
var CscApi;
(function (CscApi) {
    var Line = (function () {
        function Line(x1, y1, x2, y2) {
            this.x1 = x1;
            this.y1 = y1;
            this.x2 = x2;
            this.y2 = y2;
        }
        Line.newLineByPointSlope = function (x, y, slope) {
            var x2;
            var y2;
            if (slope == 0) {
                x2 = x + 1;
                y2 = y;
            }
            else if (slope == Infinity) {
                x2 = x;
                y2 = y + 1;
            }
            else if (slope == -Infinity) {
                x2 = x;
                y2 = y - 1;
            }
            else {
                x2 = x + 1;
                y2 = x * slope;
            }
            return new Line(x, y, x2, y2);
        };
        Line.prototype.getX1 = function () {
            return this.x1;
        };
        Line.prototype.setX1 = function (value) {
            this.x1 = value;
        };
        Line.prototype.getY1 = function () {
            return this.y1;
        };
        Line.prototype.setY1 = function (value) {
            this.y1 = value;
        };
        Line.prototype.getX2 = function () {
            return this.x2;
        };
        Line.prototype.setX2 = function (value) {
            this.x2 = value;
        };
        Line.prototype.getY2 = function () {
            return this.y2;
        };
        Line.prototype.setY2 = function (value) {
            this.y2 = value;
        };
        Line.prototype.getMidPoint = function () {
            return new CscApi.Point((this.x1 + this.x2) * 0.5, (this.y1 + this.y2) * 0.5);
        };
        Line.prototype.getSlope = function () {
            return (this.y2 - this.y1) / (this.x2 - this.x1);
        };
        Line.prototype.getNormalSlope = function () {
            return this.y2 != this.y1 ? -1 / ((this.y2 - this.y1) / (this.x2 - this.x1)) : Infinity;
        };
        Line.prototype.getParallelLine = function (x, y) {
            var slope = this.getSlope();
            return this.newLineBySlope(x, y, slope);
        };
        Line.prototype.newLineBySlope = function (x, y, slope) {
            if (slope == 0) {
                if (this.x1 == x) {
                    x += 1;
                }
                return new Line(this.x1, y, x, y);
            }
            else if (isNaN(slope) || slope == Infinity || slope == -Infinity) {
                var yOffset = slope == -Infinity ? -1 : 1;
                return new Line(x, y + yOffset, x, y);
            }
            else {
                var y1 = y - slope * (x - this.x1);
                var y2 = slope * (this.x2 - x) + y;
                return new Line(this.x1, y1, this.x2, y2);
            }
        };
        Line.prototype.getPerpendicular = function (x, y) {
            var slope = this.getNormalSlope();
            return this.newLineBySlope(x, y, slope);
        };
        Line.prototype.getLineIntersection = function (line2) {
            var a1 = this.y2 - this.y1;
            var b1 = this.x1 - this.x2;
            var c1 = (this.x2 - this.x1) * this.y1 - (this.y2 - this.y1) * this.x1;
            var a2 = line2.y2 - line2.y1;
            var b2 = line2.x1 - line2.x2;
            var c2 = (line2.x2 - line2.x1) * line2.y1 - (line2.y2 - line2.y1) * line2.x1;
            var m = a1 * b2 - a2 * b1;
            return m != 0 ? new CscApi.Point((c2 * b1 - c1 * b2) / m, (c1 * a2 - c2 * a1) / m) : null;
        };
        ;
        Line.prototype.getSegmentIntersection = function (line2) {
            var pi = this.getLineIntersection(line2);
            if (pi && this.possiblyContains(pi) && line2.possiblyContains(pi))
                return pi;
            return null;
        };
        ;
        Line.prototype.possiblyContains = function (point) {
            return point.getX() + 0.01 >= Math.min(this.x1, this.x2)
                && point.getX() - 0.01 <= Math.max(this.x1, this.x2)
                && point.getY() + 0.01 >= Math.min(this.y1, this.y2)
                && point.getY() - 0.01 <= Math.max(this.y1, this.y2);
        };
        ;
        Line.prototype.getMagnitudeSquared = function () {
            var x1 = this.x1;
            var y1 = this.y1;
            var x2 = this.x2;
            var y2 = this.y2;
            var dx = x2 - x1;
            var dy = y2 - y1;
            return dx * dx + dy * dy;
        };
        Line.prototype.getMagnitude = function () {
            return Math.sqrt(this.getMagnitudeSquared());
        };
        Line.prototype.setLengthBaseOnX1Y1 = function (length) {
            var x1 = this.x1;
            var y1 = this.y1;
            var x2 = this.x2;
            var y2 = this.y2;
            var dx = x2 - x1;
            var dy = y2 - y1;
            var magnitude = Math.sqrt(dx * dx + dy * dy);
            var unitDx = dx / magnitude;
            var unitDy = dy / magnitude;
            this.x2 = x1 + unitDx * length;
            this.y2 = y1 + unitDy * length;
        };
        return Line;
    })();
    CscApi.Line = Line;
})(CscApi || (CscApi = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfPsy = (function (_super) {
        __extends(ChartOfPsy, _super);
        function ChartOfPsy(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.PSY, area, handleId, width, height, DECIMAL_DIGITS, 'PSY');
            this.elementPsyList = null;
            this.elementPsyMaList = null;
            this.elementViewPsyDragon = null;
            this.elementViewPsyMaDragon = null;
        }
        ChartOfPsy.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPsyPeriod = config.params['psyPeriod'];
            var configPsyMaPeriod = config.params['psyMaPeriod'];
            var configPsyLineWidth = config.params['psyLineWidth'];
            var configPsyLineColorRgba = config.params['psyLineColorRgba'];
            var configPsyMaLineWidth = config.params['psyMaLineWidth'];
            var configPsyMaLineColorRgba = config.params['psyMaLineColorRgba'];
            this.argPsyPeriod = configPsyPeriod.value;
            this.argPsyMaPeriod = configPsyMaPeriod.value;
            this.stylePsyLineWidth = configPsyLineWidth.value;
            this.stylePsyLineColorRgba = configPsyLineColorRgba.value;
            this.stylePsyMaLineWidth = configPsyMaLineWidth.value;
            this.stylePsyMaLineColorRgba = configPsyMaLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfPsy.prototype.getArgPsyPeriod = function () {
            return this.argPsyPeriod;
        };
        ChartOfPsy.prototype.setArgPsyPeriod = function (period) {
            this.argPsyPeriod = period;
            this.config.params['psyPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfPsy.prototype.getArgPsyMaPeriod = function () {
            return this.argPsyMaPeriod;
        };
        ChartOfPsy.prototype.setArgPsyMaPeriod = function (period) {
            this.argPsyMaPeriod = period;
            this.config.params['psyMaPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfPsy.prototype.getStylePsyLineWidth = function () {
            return this.stylePsyLineWidth;
        };
        ChartOfPsy.prototype.setStylePsyLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.stylePsyLineWidth = lineWidth;
            this.config.params['psyLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfPsy.prototype.getStylePsyLineColorRgba = function () {
            return this.stylePsyLineColorRgba;
        };
        ChartOfPsy.prototype.setStylePsyLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.stylePsyLineColorRgba = colorRgba;
            this.config.params['psyLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfPsy.prototype.getStylePsyMaLineWidth = function () {
            return this.stylePsyMaLineWidth;
        };
        ChartOfPsy.prototype.setStylePsyMaLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.stylePsyMaLineWidth = lineWidth;
            this.config.params['psyMaLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfPsy.prototype.getStylePsyMaLineColorRgba = function () {
            return this.stylePsyMaLineColorRgba;
        };
        ChartOfPsy.prototype.setStylePsyMaLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.stylePsyMaLineColorRgba = colorRgba;
            this.config.params['psyMaLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfPsy.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementPsyList.length) {
                return this.elementPsyList[index];
            }
            return null;
        };
        ChartOfPsy.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewPsyDragon == null || this.elementViewPsyDragon.length !== numberOfDragonComponents) {
                this.elementViewPsyDragon = CscApi.Utility.resizeFloat32Array(this.elementViewPsyDragon, numberOfDragonComponents);
            }
            if (this.elementViewPsyMaDragon == null || this.elementViewPsyMaDragon.length !== numberOfDragonComponents) {
                this.elementViewPsyMaDragon = CscApi.Utility.resizeFloat32Array(this.elementViewPsyMaDragon, numberOfDragonComponents);
            }
            if (this.elementPsyList == null || this.elementPsyList.length !== numberOfOrderedTickList) {
                this.elementPsyList = CscApi.Utility.resizeFloat32Array(this.elementPsyList, numberOfOrderedTickList);
            }
            if (this.elementPsyMaList == null || this.elementPsyMaList.length !== numberOfOrderedTickList) {
                this.elementPsyMaList = CscApi.Utility.resizeFloat32Array(this.elementPsyMaList, numberOfOrderedTickList);
            }
            var elementPsyList = this.elementPsyList;
            var elementPsyMaList = this.elementPsyMaList;
            var psyPeriod = this.argPsyPeriod;
            var psyMaPeriod = this.argPsyMaPeriod;
            var nRaising = 0;
            var periodSum = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                if (i >= psyPeriod) {
                    var psy = elementPsyList[i] = 100 * nRaising / psyPeriod;
                    var periodTickData = orderedTickList[i - psyPeriod];
                    if (periodTickData.getClose() > periodTickData.getOpen()) {
                        --nRaising;
                    }
                    if (i < psyPeriod + psyMaPeriod) {
                        elementPsyMaList[i] = NaN;
                        periodSum += psy;
                    }
                    else {
                        elementPsyMaList[i] = periodSum / psyMaPeriod;
                        periodSum += (psy - elementPsyList[i - psyMaPeriod]);
                    }
                }
                else {
                    elementPsyList[i] = elementPsyMaList[i] = NaN;
                }
                if (tickData.getClose() > tickData.getOpen()) {
                    ++nRaising;
                }
            }
        };
        ChartOfPsy.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementPsyList = this.elementPsyList;
            var elementPsyMaList = this.elementPsyMaList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var psy = elementPsyList[vi];
                var psyMa = elementPsyMaList[vi];
                if (false == isNaN(psy)) {
                    if (psy > highestValue)
                        highestValue = psy;
                    if (psy < lowestValue)
                        lowestValue = psy;
                }
                if (false == isNaN(psyMa)) {
                    if (psyMa > highestValue)
                        highestValue = psyMa;
                    if (psyMa < lowestValue)
                        lowestValue = psyMa;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfPsy.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementPsyList = this.elementPsyList;
            var elementPsyMaList = this.elementPsyMaList;
            var elementViewPsyDragon = this.elementViewPsyDragon;
            var elementViewPsyMaDragon = this.elementViewPsyMaDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPsyPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementPsyList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var psy = elementPsyList[i];
                var psyMa = elementPsyMaList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewPsyDragon[vi] = viewXCoord;
                elementViewPsyDragon[vyi] = isNaN(psy) ? NaN : Math.floor(valueToYCoordConvertor(psy));
                elementViewPsyMaDragon[vi] = viewXCoord;
                elementViewPsyMaDragon[vyi] = isNaN(psyMa) ? NaN : Math.floor(valueToYCoordConvertor(psyMa));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfPsy.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPsyPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementPsyList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPsyPeriod ? viewStartTickIndex : this.argPsyPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                renderer.setLineWidth(Math.floor(Math.min(this.stylePsyLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.stylePsyLineColorRgba);
                this.drawDragon(this.elementViewPsyDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.stylePsyMaLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.stylePsyMaLineColorRgba);
                this.drawDragon(this.elementViewPsyMaDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfPsy.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var psy = this.elementPsyList[focusElementIndex];
                var psyMa = this.elementPsyMaList[focusElementIndex];
                valueInfoList = [
                    { name: 'PSY Period', value: this.argPsyPeriod.toString(), valueColor: null },
                    { name: 'PSY MA Period', value: this.argPsyMaPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(psy))
                    valueInfoList.push({ name: 'PSY', value: psy.toFixed(DECIMAL_DIGITS), valueColor: this.stylePsyLineColorRgba });
                if (false === isNaN(psyMa))
                    valueInfoList.push({ name: 'PSY MA', value: psyMa.toFixed(DECIMAL_DIGITS), valueColor: this.stylePsyMaLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfPsy;
    })(CscImpl.Chart);
    CscImpl.ChartOfPsy = ChartOfPsy;
})(CscImpl || (CscImpl = {}));
///<reference path="../cscApi/candlestickChartApi.ts"/>
var CscImpl;
(function (CscImpl) {
    var KeyboardState = (function () {
        function KeyboardState() {
            this._state = new Uint8Array(255);
        }
        KeyboardState.prototype.Reset = function () {
            this._state.fill(0);
        };
        KeyboardState.prototype._GetStatus = function (key, maskValue) {
            return (this._state[key] & maskValue) != 0;
        };
        KeyboardState.prototype.IsKeyDown = function (key) {
            return this._GetStatus(key, KeyboardState.MASK_VALUE_OF_DOWN);
        };
        KeyboardState.prototype.IsKeyUp = function (key) {
            return this._GetStatus(key, KeyboardState.MASK_VALUE_OF_UP);
        };
        KeyboardState.prototype._SetStatus = function (key, status, maskValue) {
            if (status) {
                this._state[key] |= maskValue;
            }
            else {
                this._state[key] &= ~maskValue;
            }
        };
        KeyboardState.prototype.SetDown = function (key, status) {
            this._SetStatus(key, status, KeyboardState.MASK_VALUE_OF_DOWN);
        };
        KeyboardState.prototype.SetUp = function (key, status) {
            this._SetStatus(key, status, KeyboardState.MASK_VALUE_OF_UP);
        };
        KeyboardState.MASK_VALUE_OF_DOWN = 1;
        KeyboardState.MASK_VALUE_OF_UP = 2;
        return KeyboardState;
    })();
    CscImpl.KeyboardState = KeyboardState;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfVr = (function (_super) {
        __extends(ChartOfVr, _super);
        function ChartOfVr(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.VR, area, handleId, width, height, DECIMAL_DIGITS, 'VR');
            this.elementVolList = null;
            this.elementVrList = null;
            this.elementVrMaList = null;
            this.elementViewVrDragon = null;
            this.elementViewVrMaDragon = null;
        }
        ChartOfVr.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configVrPeriod = config.params['vrPeriod'];
            var configVrMaPeriod = config.params['vrMaPeriod'];
            var configVrLineWidth = config.params['vrLineWidth'];
            var configVrLineColorRgba = config.params['vrLineColorRgba'];
            var configVrMaLineWidth = config.params['vrMaLineWidth'];
            var configVrMaLineColorRgba = config.params['vrMaLineColorRgba'];
            this.argVrPeriod = configVrPeriod.value;
            this.argVrMaPeriod = configVrMaPeriod.value;
            this.styleVrLineWidth = configVrLineWidth.value;
            this.styleVrLineColorRgba = configVrLineColorRgba.value;
            this.styleVrMaLineWidth = configVrMaLineWidth.value;
            this.styleVrMaLineColorRgba = configVrMaLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfVr.prototype.getArgVrPeriod = function () {
            return this.argVrPeriod;
        };
        ChartOfVr.prototype.setArgVrPeriod = function (period) {
            this.argVrPeriod = period;
            this.config.params['vrPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfVr.prototype.getArgVrMaPeriod = function () {
            return this.argVrMaPeriod;
        };
        ChartOfVr.prototype.setArgVrMaPeriod = function (period) {
            this.argVrMaPeriod = period;
            this.config.params['vrMaPeriod'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfVr.prototype.getStyleVrLineWidth = function () {
            return this.styleVrLineWidth;
        };
        ChartOfVr.prototype.setStyleVrLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleVrLineWidth = lineWidth;
            this.config.params['vrLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfVr.prototype.getStyleVrLineColorRgba = function () {
            return this.styleVrLineColorRgba;
        };
        ChartOfVr.prototype.setStyleVrLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleVrLineColorRgba = colorRgba;
            this.config.params['vrLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfVr.prototype.getStyleVrMaLineWidth = function () {
            return this.styleVrMaLineWidth;
        };
        ChartOfVr.prototype.setStyleVrMaLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleVrMaLineWidth = lineWidth;
            this.config.params['vrMaLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfVr.prototype.getStyleVrMaLineColorRgba = function () {
            return this.styleVrMaLineColorRgba;
        };
        ChartOfVr.prototype.setStyleVrMaLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleVrMaLineColorRgba = colorRgba;
            this.config.params['vrMaLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfVr.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementVrList.length) {
                return this.elementVrList[index];
            }
            return null;
        };
        ChartOfVr.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewVrDragon == null || this.elementViewVrDragon.length !== numberOfDragonComponents) {
                this.elementViewVrDragon = CscApi.Utility.resizeFloat32Array(this.elementViewVrDragon, numberOfDragonComponents);
            }
            if (this.elementViewVrMaDragon == null || this.elementViewVrMaDragon.length !== numberOfDragonComponents) {
                this.elementViewVrMaDragon = CscApi.Utility.resizeFloat32Array(this.elementViewVrMaDragon, numberOfDragonComponents);
            }
            if (this.elementVolList == null || this.elementVolList.length !== numberOfOrderedTickList) {
                this.elementVolList = CscApi.Utility.resizeFloat32Array(this.elementVolList, numberOfOrderedTickList);
            }
            if (this.elementVrList == null || this.elementVrList.length !== numberOfOrderedTickList) {
                this.elementVrList = CscApi.Utility.resizeFloat32Array(this.elementVrList, numberOfOrderedTickList);
            }
            if (this.elementVrMaList == null || this.elementVrMaList.length !== numberOfOrderedTickList) {
                this.elementVrMaList = CscApi.Utility.resizeFloat32Array(this.elementVrMaList, numberOfOrderedTickList);
            }
            var elementVolList = this.elementVolList;
            var elementVrList = this.elementVrList;
            var elementVrMaList = this.elementVrMaList;
            var vrPeriod = this.argVrPeriod;
            var vrMaPeriod = this.argVrMaPeriod;
            var sumRaising = 0;
            var sumFalling = 0;
            var sumUnchanged = 0;
            var sumVr = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                var tickData = orderedTickList[i];
                if (i >= vrPeriod) {
                    var halfSumUnchanged = sumUnchanged * 0.5;
                    var vr = 100 * (sumRaising + halfSumUnchanged) / (sumFalling + halfSumUnchanged);
                    elementVrList[i] = vr;
                    if (i >= vrPeriod + vrMaPeriod) {
                        elementVrMaList[i] = sumVr / vrMaPeriod;
                        sumVr -= elementVrList[i - vrMaPeriod];
                    }
                    else {
                        elementVrMaList[i] = NaN;
                    }
                    sumVr += vr;
                    var periodTickData = orderedTickList[i - vrPeriod];
                    var periodTickClose = periodTickData.getClose();
                    var periodTickOpen = periodTickData.getOpen();
                    if (periodTickClose > periodTickOpen) {
                        sumRaising -= periodTickData.getVolume();
                    }
                    else if (periodTickClose < periodTickOpen) {
                        sumFalling -= periodTickData.getVolume();
                    }
                    else {
                        sumUnchanged -= periodTickData.getVolume();
                    }
                }
                else {
                    elementVrList[i] = elementVrMaList[i] = NaN;
                }
                var close = tickData.getClose();
                var open = tickData.getOpen();
                if (close > open) {
                    sumRaising += tickData.getVolume();
                }
                else if (close < open) {
                    sumFalling += tickData.getVolume();
                }
                else {
                    sumUnchanged += tickData.getVolume();
                }
            }
        };
        ChartOfVr.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementVrList = this.elementVrList;
            var elementVrMaList = this.elementVrMaList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var vr = elementVrList[vi];
                var vrMa = elementVrMaList[vi];
                if (false == isNaN(vr)) {
                    if (vr > highestValue)
                        highestValue = vr;
                    if (vr < lowestValue)
                        lowestValue = vr;
                }
                if (false == isNaN(vrMa)) {
                    if (vrMa > highestValue)
                        highestValue = vrMa;
                    if (vrMa < lowestValue)
                        lowestValue = vrMa;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfVr.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementVrList = this.elementVrList;
            var elementVrMaList = this.elementVrMaList;
            var elementViewVrDragon = this.elementViewVrDragon;
            var elementViewVrMaDragon = this.elementViewVrMaDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argVrPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementVrList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var vr = elementVrList[i];
                var vrMa = elementVrMaList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewVrDragon[vi] = viewXCoord;
                elementViewVrDragon[vyi] = isNaN(vr) ? NaN : Math.floor(valueToYCoordConvertor(vr));
                elementViewVrMaDragon[vi] = viewXCoord;
                elementViewVrMaDragon[vyi] = isNaN(vrMa) ? NaN : Math.floor(valueToYCoordConvertor(vrMa));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfVr.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argVrPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementVrList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argVrPeriod ? viewStartTickIndex : this.argVrPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                renderer.setLineWidth(Math.floor(Math.min(this.styleVrLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleVrLineColorRgba);
                this.drawDragon(this.elementViewVrDragon, firstPointIndex, numberOfPoints);
                renderer.setLineWidth(Math.floor(Math.min(this.styleVrMaLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleVrMaLineColorRgba);
                this.drawDragon(this.elementViewVrMaDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfVr.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var vr = this.elementVrList[focusElementIndex];
                var vrMa = this.elementVrMaList[focusElementIndex];
                valueInfoList = [
                    { name: 'VR Period', value: this.argVrPeriod.toString(), valueColor: null },
                    { name: 'VR MA Period', value: this.argVrMaPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(vr))
                    valueInfoList.push({ name: 'VR', value: vr.toFixed(DECIMAL_DIGITS), valueColor: this.styleVrLineColorRgba });
                if (false === isNaN(vrMa))
                    valueInfoList.push({ name: 'VR MA', value: vrMa.toFixed(DECIMAL_DIGITS), valueColor: this.styleVrMaLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfVr;
    })(CscImpl.Chart);
    CscImpl.ChartOfVr = ChartOfVr;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var DrawerOfHorizontalLine = (function (_super) {
        __extends(DrawerOfHorizontalLine, _super);
        function DrawerOfHorizontalLine(chart, handleId) {
            var maxStep = 1;
            _super.call(this, chart, handleId, CscApi.DrawerType.HORIZONTAL_LINE, maxStep);
        }
        DrawerOfHorizontalLine.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configLineWidth = config.params['lineWidth'];
            var configLineDashedlength = config.params['lineDashedLength'];
            var configLineColorRgba = config.params['lineColorRgba'];
            this.styleLine1Width = configLineWidth.value;
            this.styleLine1DashedLength = configLineDashedlength.value;
            this.styleLine1ColorRgba = configLineColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfHorizontalLine.prototype.getStyleLine1Width = function () {
            return this.styleLine1Width;
        };
        DrawerOfHorizontalLine.prototype.setStyleLine1Width = function (lineWidth) {
            this.styleLine1Width = lineWidth;
        };
        DrawerOfHorizontalLine.prototype.getStyleLineDashedLength = function () {
            return this.styleLine1DashedLength;
        };
        DrawerOfHorizontalLine.prototype.setStyleLineDashedLength = function (dashedLength) {
            this.styleLine1DashedLength = dashedLength;
        };
        DrawerOfHorizontalLine.prototype.getStyleLine1ColorRgba = function () {
            return this.styleLine1ColorRgba;
        };
        DrawerOfHorizontalLine.prototype.setStyleLine1ColorRgba = function (colorRgba) {
            this.styleLine1ColorRgba = colorRgba;
        };
        DrawerOfHorizontalLine.prototype.render = function () {
            _super.prototype.render.call(this);
            var decimalDigits = this.getChart().getDecimalDigits();
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            renderer.setLineWidth(this.styleLine1Width);
            renderer.setStrokeColorRgba(this.styleLine1ColorRgba);
            renderer.setFillColorRgba(this.styleLine1ColorRgba);
            renderer.setTextFontSize(14);
            renderer.setTextFontName('Arial');
            renderer.setTextFontBold(false);
            renderer.setTextAlignToLeft();
            renderer.setTextBaseLineToTop();
            switch (currentStep) {
                case 0:
                    if (this.current.value != null) {
                        var y = this.refArea().getChartYCoordFromValue(this.chart.getHandleId(), this.current.value);
                        renderer.strokeDashedLine(this.styleLine1DashedLength, 0, y, this.chart.getWidth(), y);
                        renderer.fillText(this.current.value.toFixed(decimalDigits), 0, y);
                    }
                    break;
                case 1:
                    var drawnStepList = this.drawnStepList;
                    var drawnStep = drawnStepList[drawnStepList.length - 1];
                    if (drawnStep.value != null) {
                        var y = this.refArea().getChartYCoordFromValue(this.chart.getHandleId(), drawnStep.value);
                        renderer.strokeDashedLine(this.styleLine1DashedLength, 0, y, this.chart.getWidth(), y);
                        renderer.fillText(drawnStep.value.toFixed(decimalDigits), 0, y);
                    }
                    break;
            }
        };
        return DrawerOfHorizontalLine;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfHorizontalLine = DrawerOfHorizontalLine;
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfMa = (function (_super) {
        __extends(ChartOfMa, _super);
        function ChartOfMa(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.MA, area, handleId, width, height, DECIMAL_DIGITS, 'MA');
            this.elementMaList = null;
            this.elementViewMaDragon = null;
        }
        ChartOfMa.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configMaLineWidth = config.params['maLineWidth'];
            var configMaLineColorRgba = config.params['maLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleMaLineWidth = configMaLineWidth.value;
            this.styleMaLineColorRgba = configMaLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMa.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfMa.prototype.setArgPeriod = function (period) {
            if (period == null) {
                return false;
            }
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfMa.prototype.getStyleMaLineWidth = function () {
            return this.styleMaLineWidth;
        };
        ChartOfMa.prototype.setStyleMaLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleMaLineWidth = lineWidth;
            this.config.params['maLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfMa.prototype.getStyleMaLineColorRgba = function () {
            return this.styleMaLineColorRgba;
        };
        ChartOfMa.prototype.setStyleMaLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleMaLineColorRgba = colorRgba;
            this.config.params['maLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfMa.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementMaList.length) {
                return this.elementMaList[index];
            }
            return null;
        };
        ChartOfMa.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewMaDragon == null || this.elementViewMaDragon.length !== numberOfDragonComponents) {
                this.elementViewMaDragon = CscApi.Utility.resizeFloat32Array(this.elementViewMaDragon, numberOfDragonComponents);
            }
            if (this.elementMaList == null || this.elementMaList.length != numberOfOrderedTickList) {
                this.elementMaList = CscApi.Utility.resizeFloat32Array(this.elementMaList, numberOfOrderedTickList);
            }
            var elementMaList = this.elementMaList;
            var period = this.argPeriod;
            var periodSum = 0;
            var startIndex = Math.max(updateTickFromIndex - period, 0);
            for (var i = startIndex; i < numberOfOrderedTickList; ++i) {
                if (i - startIndex < period) {
                    periodSum += orderedTickList[i].getClose();
                    if (i < period) {
                        elementMaList[i] = NaN;
                    }
                }
                else {
                    elementMaList[i] = periodSum / period;
                    periodSum = periodSum - orderedTickList[i - period].getClose() + orderedTickList[i].getClose();
                }
            }
        };
        ChartOfMa.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementMaList = this.elementMaList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var ma = elementMaList[vi];
                if (false == isNaN(ma)) {
                    if (ma > highestValue)
                        highestValue = ma;
                    if (ma < lowestValue)
                        lowestValue = ma;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfMa.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementMaList = this.elementMaList;
            var elementViewMaDragon = this.elementViewMaDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementMaList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var ma = elementMaList[i];
                var vi = i * 2;
                elementViewMaDragon[vi] = timeScaleElement.viewXCoord;
                elementViewMaDragon[vi + 1] = (ma >= 0 ? Math.floor(valueToYCoordConvertor(ma)) : -1);
            }
            return yAxisEnabled ? this.generateValueScale(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfMa.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var viewTickWidth = this.refCandlestickChart().getViewTickWidth();
            renderer.setLineWidth(Math.floor(Math.min(this.styleMaLineWidth, viewTickWidth)));
            renderer.setStrokeColorRgba(this.styleMaLineColorRgba);
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementMaList.length - 1) {
                viewEndTickIndex++;
            }
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            if (numberOfPoints > 1) {
                renderer.translate(-viewStartXCoord, 0);
                this.drawDragon(this.elementViewMaDragon, firstPointIndex, numberOfPoints);
                renderer.translate(viewStartXCoord, 0);
            }
            return true;
        };
        ChartOfMa.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var ma = this.elementMaList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(ma))
                    valueInfoList.push({ name: 'MA', value: ma.toFixed(DECIMAL_DIGITS), valueColor: this.styleMaLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfMa;
    })(CscImpl.Chart);
    CscImpl.ChartOfMa = ChartOfMa;
})(CscImpl || (CscImpl = {}));
var CscImpl;
(function (CscImpl) {
    /*!
    The MIT License (MIT)
     
    Copyright (c) 2014, Gerger (www.gerger.co)
     
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
     
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
     
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
    */
    var DecimalFormat = (function () {
        function DecimalFormat(formatStr) {
            this.prefix = '';
            this.suffix = '';
            this.comma = 0;
            this.minInt = 1;
            this.minFrac = 0;
            this.maxFrac = 0;
            for (var i = 0; i < formatStr.length; i++) {
                if (formatStr.charAt(i) == '#' || formatStr.charAt(i) == '0') {
                    this.prefix = formatStr.substring(0, i);
                    formatStr = formatStr.substring(i);
                    break;
                }
            }
            this.suffix = formatStr.replace(/[#]|[0]|[,]|[.]/g, '');
            var numberStr = formatStr.replace(/[^0#,.]/g, '');
            var intStr = '';
            var fracStr = '';
            var point = numberStr.indexOf('.');
            if (point != -1) {
                intStr = numberStr.substring(0, point);
                fracStr = numberStr.substring(point + 1);
            }
            else {
                intStr = numberStr;
            }
            var commaPos = intStr.lastIndexOf(',');
            if (commaPos != -1) {
                this.comma = intStr.length - 1 - commaPos;
            }
            intStr = intStr.replace(/[,]/g, '');
            fracStr = fracStr.replace(/[,]|[.]+/g, '');
            this.maxFrac = fracStr.length;
            var tmp = intStr.replace(/[^0]/g, '');
            if (tmp.length > this.minInt)
                this.minInt = tmp.length;
            tmp = fracStr.replace(/[^0]/g, '');
            this.minFrac = tmp.length;
        }
        DecimalFormat.prototype.format = function (numStr) {
            var numberStr = this.formatBack(numStr).toLowerCase();
            if (isNaN(Number(numberStr)) || numberStr.length == 0)
                return numStr;
            if (numberStr.indexOf("e") != -1) {
                var n = Number(numberStr);
                if (n == Infinity || n == -Infinity)
                    return numberStr;
                numberStr = n + "";
                if (numberStr.indexOf('e') != -1)
                    return numberStr;
            }
            var negative = false;
            if (numberStr.charAt(0) == '-') {
                negative = true;
                numberStr = numberStr.substring(1);
            }
            else if (numberStr.charAt(0) == '+') {
                numberStr = numberStr.substring(1);
            }
            var point = numberStr.indexOf('.');
            var intStr = '';
            var fracStr = '';
            if (point != -1) {
                intStr = numberStr.substring(0, point);
                fracStr = numberStr.substring(point + 1);
            }
            else {
                intStr = numberStr;
            }
            fracStr = fracStr.replace(/[.]/, '');
            var isPercentage = this.suffix && this.suffix.charAt(0) === '%';
            var minInt = this.minInt, minFrac = this.minFrac, maxFrac = this.maxFrac;
            if (isPercentage) {
                intStr = intStr + ('00' + (fracStr + '00').substr(0, 2)).substr(-2);
                fracStr = fracStr.substr(2);
            }
            if (fracStr.length > maxFrac) {
                var num = new Number('0.' + fracStr);
                num = (maxFrac == 0) ? Math.round(num) : Number(num.toFixed(maxFrac));
                fracStr = num.toString(10).substr(2);
                var c = (num >= 1) ? 1 : 0;
                var x, i = intStr.length - 1;
                while (c) {
                    if (i == -1) {
                        intStr = '1' + intStr;
                        break;
                    }
                    else {
                        x = intStr.charAt(i);
                        if (x == 9) {
                            x = '0';
                            c = 1;
                        }
                        else {
                            x = (++x) + '';
                            c = 0;
                        }
                        intStr = intStr.substring(0, i) + x + intStr.substring(i + 1, intStr.length);
                        i--;
                    }
                }
            }
            for (var i = fracStr.length; i < minFrac; i++) {
                fracStr = fracStr + '0';
            }
            while (fracStr.length > minFrac && fracStr.charAt(fracStr.length - 1) == '0') {
                fracStr = fracStr.substring(0, fracStr.length - 1);
            }
            for (var i = intStr.length; i < minInt; i++) {
                intStr = '0' + intStr;
            }
            while (intStr.length > minInt && intStr.charAt(0) == '0') {
                intStr = intStr.substring(1);
            }
            var j = 0;
            for (var i = intStr.length; i > 0; i--) {
                if (j != 0 && j % this.comma == 0) {
                    intStr = intStr.substring(0, i) + ',' + intStr.substring(i);
                    j = 0;
                }
                j++;
            }
            var formattedValue;
            if (fracStr.length > 0)
                formattedValue = this.prefix + intStr + '.' + fracStr + this.suffix;
            else
                formattedValue = this.prefix + intStr + this.suffix;
            if (negative) {
                formattedValue = '-' + formattedValue;
            }
            return formattedValue;
        };
        DecimalFormat.prototype.formatBack = function (fNumStr) {
            fNumStr += '';
            if (!fNumStr)
                return '';
            if (!isNaN(fNumStr))
                return this.getNumericString(fNumStr);
            var fNumberStr = fNumStr;
            var negative = false;
            if (fNumStr.charAt(0) == '-') {
                fNumberStr = fNumberStr.substr(1);
                negative = true;
            }
            var pIndex = fNumberStr.indexOf(this.prefix);
            var sIndex = (this.suffix == '') ? fNumberStr.length : fNumberStr.indexOf(this.suffix, this.prefix.length + 1);
            if (pIndex == 0 && sIndex > 0) {
                fNumberStr = fNumberStr.substr(0, sIndex);
                fNumberStr = fNumberStr.substr(this.prefix.length);
                fNumberStr = fNumberStr.replace(/,/g, '');
                if (negative)
                    fNumberStr = '-' + fNumberStr;
                if (!isNaN(fNumberStr))
                    return this.getNumericString(fNumberStr);
            }
            return fNumStr;
        };
        DecimalFormat.prototype.getNumericString = function (str) {
            var num = new Number(str);
            var numStr = num + '';
            if (str.indexOf('.') > -1 && numStr.indexOf('.') < 0) {
                for (var i = str.indexOf('.') + 1; i < str.length; i++) {
                    if (str.charAt(i) !== '0')
                        return str;
                }
                return numStr;
            }
            return str;
        };
        return DecimalFormat;
    })();
    CscImpl.DecimalFormat = DecimalFormat;
})(CscImpl || (CscImpl = {}));
/// <reference path="drawer.ts" />
var CscImpl;
(function (CscImpl) {
    var DrawerOfLinearRegression = (function (_super) {
        __extends(DrawerOfLinearRegression, _super);
        function DrawerOfLinearRegression(chart, handleId) {
            var maxStep = 2;
            _super.call(this, chart, handleId, CscApi.DrawerType.LINEAR_REGRESSION, maxStep);
        }
        DrawerOfLinearRegression.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configLineWidth = config.params['lineWidth'];
            var configLineDashedlength = config.params['lineDashedLength'];
            var configLineColorRgba = config.params['lineColorRgba'];
            this.styleLine1Width = configLineWidth.value;
            this.styleLine1DashedLength = configLineDashedlength.value;
            this.styleLine1ColorRgba = configLineColorRgba.value;
            this.config = config;
            return true;
        };
        DrawerOfLinearRegression.prototype.getStyleLine1Width = function () {
            return this.styleLine1Width;
        };
        DrawerOfLinearRegression.prototype.setStyleLine1Width = function (lineWidth) {
            this.styleLine1Width = lineWidth;
        };
        DrawerOfLinearRegression.prototype.getStyleLine1DashedLength = function () {
            return this.styleLine1DashedLength;
        };
        DrawerOfLinearRegression.prototype.setStyleLine1DashedLength = function (dashedLength) {
            this.styleLine1DashedLength = dashedLength;
        };
        DrawerOfLinearRegression.prototype.getStyleLine1ColorRgba = function () {
            return this.styleLine1ColorRgba;
        };
        DrawerOfLinearRegression.prototype.setStyleLine1ColorRgba = function (colorRgba) {
            this.styleLine1ColorRgba = colorRgba;
        };
        DrawerOfLinearRegression.prototype.render = function () {
            _super.prototype.render.call(this);
            if (currentStep == 0) {
                return;
            }
            var renderer = this.refRenderer();
            var currentStep = this.drawnStepList.length;
            var candlestickChart = this.refCandlestickChart();
            var chart = this.chart;
            var area = this.refArea();
            var areaHandleId = area.getHandleId();
            var chartHandleId = this.chart.getHandleId();
            var drawnStepList = this.drawnStepList;
            var current = this.current;
            var firstIndex;
            var lastIndex;
            if (currentStep == 1) {
                var drawnStep0 = drawnStepList[0];
                if (current.index >= drawnStep0.index) {
                    firstIndex = drawnStep0.index;
                    lastIndex = current.index;
                }
                else {
                    lastIndex = drawnStep0.index;
                    firstIndex = current.index;
                }
            }
            else if (currentStep > 1) {
                var drawnStep0 = drawnStepList[0];
                var drawnStep1 = drawnStepList[1];
                if (drawnStep1.index >= drawnStep0.index) {
                    firstIndex = drawnStep0.index;
                    lastIndex = drawnStep1.index;
                }
                else {
                    lastIndex = drawnStep0.index;
                    firstIndex = drawnStep1.index;
                }
            }
            if (firstIndex != null && lastIndex != null) {
                var x1 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, firstIndex);
                var x2 = candlestickChart.getXInAreaFromTickIndex(areaHandleId, lastIndex);
                var orderedTickList = this.refCandlestickChart().getContext().getOrderedTickList();
                if (lastIndex >= orderedTickList.length) {
                    lastIndex = orderedTickList.length - 1;
                }
                var sumX = 0;
                var sumY = 0;
                var sumXy = 0;
                var sumXx = 0;
                var sumYy = 0;
                var n = lastIndex - firstIndex + 1;
                for (var i = firstIndex; i <= lastIndex; ++i) {
                    var tick = orderedTickList[i];
                    var y = tick.getClose();
                    var x = candlestickChart.getXInAreaFromTickIndex(areaHandleId, i);
                    sumX += x;
                    sumY += y;
                    sumXx += x * x;
                    sumXy += x * y;
                    sumYy += y * y;
                }
                var sxx = n * sumXx - sumX * sumX;
                var sxy = n * sumXy - sumX * sumY;
                var b = sxy / sxx;
                var avgScale = 1 / n;
                var avgX = sumX * avgScale;
                var avgY = sumY * avgScale;
                var a = avgY - b * avgX;
                var y1 = area.getChartYCoordFromValue(chartHandleId, a + b * x1);
                var y2 = area.getChartYCoordFromValue(chartHandleId, a + b * x2);
                var linearRegressionLine = new CscApi.Line(x1, y1, x2, y2);
                renderer.setLineWidth(this.styleLine1Width);
                renderer.setStrokeColorRgba(this.styleLine1ColorRgba);
                this.drawLine(linearRegressionLine, this.styleLine1DashedLength);
            }
        };
        return DrawerOfLinearRegression;
    })(CscImpl.Drawer);
    CscImpl.DrawerOfLinearRegression = DrawerOfLinearRegression;
})(CscImpl || (CscImpl = {}));
/// <reference path="../cscApi/candlestickChartApi.ts" />
var CscImpl;
(function (CscImpl) {
    var Controller = (function () {
        function Controller(canvas) {
            this.convertPixelSpaceFromDomClientSpace = function (clientX, clientY) {
                var canvas = this.canvas;
                var offsetX = 0;
                var offsetY = 0;
                for (var domParentNode = canvas; domParentNode; domParentNode = domParentNode.offsetParent) {
                    offsetX += domParentNode.offsetLeft;
                    offsetY += domParentNode.offsetTop;
                }
                var x = clientX - offsetX;
                var y = clientY - offsetY;
                var sx = canvas.width / canvas.clientWidth;
                var sy = canvas.height / canvas.clientHeight;
                var px = sx * x;
                var py = sy * y;
                return [px, py];
            };
            this.canvas = canvas;
            this.initialized = false;
            this.mouseState = new CscImpl.MouseState();
            this.keyboardState = new CscImpl.KeyboardState();
            this.touchState = new CscImpl.TouchState();
            this.eventRemoverOfKeyDown = null;
            this.eventRemoverOfKeyUp = null;
            this.eventRemoverOfMouseDown = null;
            this.eventRemoverOfMouseUp = null;
            this.eventRemoverOfMouseMove = null;
            this.eventRemoverOfMouseWheel = null;
            this.eventRemoverOfTouchStart = null;
            this.eventRemoverOfTouchMove = null;
            this.eventRemoverOfTouchEnd = null;
            this.snGeneratorOfHandleId = new CscApi.SnGenerator();
            this.eventsOfKeyDown = {};
            this.eventsOfKeyUp = {};
            this.eventsOfMouseDown = {};
            this.eventsOfMouseUp = {};
            this.eventsOfMouseMove = {};
            this.eventsOfMouseWheel = {};
            this.eventsOfTouchStart = {};
            this.eventsOfTouchMove = {};
            this.eventsOfTouchEnd = {};
        }
        Controller.prototype.init = function () {
            var _this = this;
            if (this.initialized) {
                return false;
            }
            var eventNameOfMousewheel = ('onmousewheel' in this.canvas) ? 'mousewheel' : 'DOMMouseScroll';
            this.eventRemoverOfKeyDown = CscApi.Utility.registerEvent(this.canvas, 'keydown', this, function (e) { _this.onKeyDown(e); });
            this.eventRemoverOfKeyUp = CscApi.Utility.registerEvent(this.canvas, 'keyup', this, function (e) { _this.onKeyUp(e); });
            this.eventRemoverOfMouseDown = CscApi.Utility.registerEvent(this.canvas, 'mousedown', this, function (e) { _this.onMouseDown(e); });
            this.eventRemoverOfMouseUp = CscApi.Utility.registerEvent(this.canvas, 'mouseup', this, function (e) { _this.onMouseUp(e); });
            this.eventRemoverOfMouseMove = CscApi.Utility.registerEvent(this.canvas, 'mousemove', this, function (e) { _this.onMouseMove(e); });
            this.eventRemoverOfMouseWheel = CscApi.Utility.registerEvent(this.canvas, eventNameOfMousewheel, this, function (e) { _this.onMouseWheel(e); });
            this.eventRemoverOfTouchStart = CscApi.Utility.registerEvent(this.canvas, 'touchstart', this, function (e) { _this.onTouchStart(e); });
            this.eventRemoverOfTouchMove = CscApi.Utility.registerEvent(this.canvas, 'touchmove', this, function (e) { _this.onTouchMove(e); });
            this.eventRemoverOfTouchEnd = CscApi.Utility.registerEvent(this.canvas, 'touchend', this, function (e) { _this.onTouchEnd(e); });
            var attrTabindex = this.canvas.getAttribute("tabindex");
            if (attrTabindex == null) {
                this.canvas.setAttribute("tabindex", "-1");
            }
            this.initialized = true;
            return true;
        };
        Controller.prototype.release = function () {
            if (false == this.initialized) {
                return;
            }
            if (this.eventRemoverOfKeyDown)
                this.eventRemoverOfKeyDown();
            if (this.eventRemoverOfKeyUp)
                this.eventRemoverOfKeyUp();
            if (this.eventRemoverOfMouseDown)
                this.eventRemoverOfMouseDown();
            if (this.eventRemoverOfMouseUp)
                this.eventRemoverOfMouseUp();
            if (this.eventRemoverOfMouseMove)
                this.eventRemoverOfMouseMove();
            if (this.eventRemoverOfMouseWheel)
                this.eventRemoverOfMouseWheel();
            if (this.eventRemoverOfTouchStart)
                this.eventRemoverOfTouchStart();
            if (this.eventRemoverOfTouchMove)
                this.eventRemoverOfTouchMove();
            if (this.eventRemoverOfTouchEnd)
                this.eventRemoverOfTouchEnd();
            this.initialized = false;
        };
        Controller.prototype.addEventListener = function (eventContainer, callback) {
            var handleId = this.snGeneratorOfHandleId.allocate();
            eventContainer[handleId] = callback;
            return handleId;
        };
        Controller.prototype.addEventListenerOnKeyDown = function (callback) {
            return this.addEventListener(this.eventsOfKeyDown, callback);
        };
        Controller.prototype.addEventListenerOnKeyUp = function (callback) {
            return this.addEventListener(this.eventsOfKeyUp, callback);
        };
        Controller.prototype.addEventListenerOnMouseDown = function (callback) {
            return this.addEventListener(this.eventsOfMouseDown, callback);
        };
        Controller.prototype.addEventListenerOnMouseUp = function (callback) {
            return this.addEventListener(this.eventsOfMouseUp, callback);
        };
        Controller.prototype.addEventListenerOnMouseMove = function (callback) {
            return this.addEventListener(this.eventsOfMouseMove, callback);
        };
        Controller.prototype.addEventListenerOnMouseWheel = function (callback) {
            return this.addEventListener(this.eventsOfMouseWheel, callback);
        };
        Controller.prototype.addEventListenerOnTouchStart = function (callback) {
            return this.addEventListener(this.eventsOfTouchStart, callback);
        };
        Controller.prototype.addEventListenerOnTouchMove = function (callback) {
            return this.addEventListener(this.eventsOfTouchMove, callback);
        };
        Controller.prototype.addEventListenerOnTouchEnd = function (callback) {
            return this.addEventListener(this.eventsOfTouchEnd, callback);
        };
        Controller.prototype.removeEventListener = function (handleId) {
            delete this.eventsOfKeyDown[handleId];
            delete this.eventsOfKeyUp[handleId];
            delete this.eventsOfMouseDown[handleId];
            delete this.eventsOfMouseUp[handleId];
            delete this.eventsOfMouseMove[handleId];
            delete this.eventsOfTouchStart[handleId];
            delete this.eventsOfTouchMove[handleId];
            delete this.eventsOfTouchEnd[handleId];
            this.snGeneratorOfHandleId.recycle(handleId);
        };
        Controller.prototype.callbackEvent = function (callbackContainer, touchState) {
            for (var key in callbackContainer) {
                var callback = callbackContainer[key];
                if (callback) {
                    callback.call(this, touchState);
                }
            }
        };
        Controller.prototype.callbackEventForKeyboard = function (callbackContainer, key) {
            for (var handleId in callbackContainer) {
                var callback = callbackContainer[handleId];
                if (callback) {
                    callback.call(this, key, this.keyboardState);
                }
            }
        };
        Controller.prototype.callbackEventForMouse = function (callbackContainer, button) {
            if (button != null) {
                for (var handleId in callbackContainer) {
                    var callback = callbackContainer[handleId];
                    if (callback) {
                        callback.call(this, button, this.mouseState);
                    }
                }
            }
            else {
                for (var handleId in callbackContainer) {
                    var callback = callbackContainer[handleId];
                    if (callback) {
                        callback.call(this, this.mouseState);
                    }
                }
            }
        };
        Controller.prototype.onKeyDown = function (event) {
            var keyCode = event.which ? event.which : event.keyCode;
            var key = keyCodeToKey[keyCode];
            if (key == null) {
                console.warn('unknown keycode: ' + keyCode);
                return;
            }
            this.keyboardState.SetDown(key, true);
            this.callbackEventForKeyboard(this.eventsOfKeyDown, key);
        };
        Controller.prototype.onKeyUp = function (event) {
            var keyCode = event.which ? event.which : event.keyCode;
            var key = keyCodeToKey[keyCode];
            if (key == null) {
                console.warn('unknown keycode: ' + keyCode);
                return;
            }
            this.keyboardState.SetUp(key, true);
            this.callbackEventForKeyboard(this.eventsOfKeyUp, key);
        };
        Controller.prototype.onMouseDown = function (event) {
            var mouseButton;
            switch (event.button) {
                case 0:
                    mouseButton = CscApi.MouseButton.LEFT;
                    break;
                case 1:
                    mouseButton = CscApi.MouseButton.META;
                    break;
                case 2:
                    mouseButton = CscApi.MouseButton.RIGHT;
                    break;
                default: return;
            }
            this.mouseState.SetButtonDown(mouseButton, true);
            this.callbackEventForMouse(this.eventsOfMouseDown, mouseButton);
        };
        Controller.prototype.onMouseUp = function (event) {
            var mouseButton;
            switch (event.button) {
                case 0:
                    mouseButton = CscApi.MouseButton.LEFT;
                    break;
                case 1:
                    mouseButton = CscApi.MouseButton.META;
                    break;
                case 2:
                    mouseButton = CscApi.MouseButton.RIGHT;
                    break;
                default: return;
            }
            this.mouseState.SetButtonUp(mouseButton, true);
            this.callbackEventForMouse(this.eventsOfMouseUp, mouseButton);
        };
        Controller.prototype.onMouseMove = function (event) {
            var domPosX = event.clientX;
            var domPosY = event.clientY;
            var domMovX = event.movementX || event.mozMovementX || event.webkitMovementX || null;
            var domMovY = event.movementY || event.mozMovementY || event.webkitMovementY || null;
            this.mouseState.SetDomPosition(domPosX, domPosY);
            this.mouseState.SetDomMovement(domMovX, domMovY);
            var posCoords = this.convertPixelSpaceFromDomClientSpace(domPosX, domPosY);
            this.mouseState.SetPosition(posCoords[0], posCoords[1]);
            var movCoords = this.convertPixelSpaceFromDomClientSpace(domMovX, domMovY);
            this.mouseState.SetMovement(movCoords[0], movCoords[1]);
            this.callbackEventForMouse(this.eventsOfMouseMove, null);
        };
        Controller.prototype.onMouseWheel = function (event) {
            var wheelDelta = event.wheelDelta || event.detail * -1;
            this.mouseState.SetWheelDelta(Math.max(-1, Math.min(1, wheelDelta)));
            this.callbackEventForMouse(this.eventsOfMouseWheel, null);
        };
        Controller.prototype.onTouchStart = function (event) {
            this.setupTouchState(event);
            ;
            return this.callbackEvent(this.eventsOfTouchStart, this.touchState);
        };
        Controller.prototype.onTouchMove = function (event) {
            this.setupTouchState(event);
            return this.callbackEvent(this.eventsOfTouchMove, this.touchState);
        };
        Controller.prototype.onTouchEnd = function (event) {
            this.setupTouchState(event);
            return this.callbackEvent(this.eventsOfTouchEnd, this.touchState);
        };
        Controller.prototype.setupTouchState = function (event) {
            var domPosXList = new Array();
            var domPosYList = new Array();
            var posXList = new Array();
            var posYList = new Array();
            var touches = event.touches;
            var targetTouches = event.targetTouches;
            if (touches) {
                var numberofTouches = touches.length;
                for (var i = 0; i < numberofTouches; ++i) {
                    var domPosX = touches[i].clientX;
                    var domPosY = touches[i].clientY;
                    domPosXList.push(domPosX);
                    domPosYList.push(domPosY);
                    var posCoords = this.convertPixelSpaceFromDomClientSpace(domPosX, domPosY);
                    posXList.push(posCoords[0]);
                    posYList.push(posCoords[1]);
                }
            }
            else if (targetTouches) {
                var numberOfChangedTouches = targetTouches.length;
                for (var i = 0; i < numberOfChangedTouches; ++i) {
                    var domPosX = targetTouches[i].clientX;
                    var domPosY = targetTouches[i].clientY;
                    domPosXList.push(domPosX);
                    domPosYList.push(domPosY);
                    var posCoords = this.convertPixelSpaceFromDomClientSpace(domPosX, domPosY);
                    posXList.push(posCoords[0]);
                    posYList.push(posCoords[1]);
                }
            }
            this.touchState.SetDomPositionList(domPosXList, domPosYList);
            this.touchState.SetPositionList(posXList, posYList);
        };
        return Controller;
    })();
    CscImpl.Controller = Controller;
    var keyCodeToKey = {
        8: CscApi.Key.BACKSPACE,
        9: CscApi.Key.TAB,
        13: CscApi.Key.RETURN,
        16: CscApi.Key.SHIFT,
        17: CscApi.Key.CTRL,
        18: CscApi.Key.ALT,
        19: CscApi.Key.PAUSE_BREAK,
        20: CscApi.Key.CAPSLOCK,
        27: CscApi.Key.ESC,
        32: CscApi.Key.SPACE,
        33: CscApi.Key.PAGEUP,
        34: CscApi.Key.PAGEDOWN,
        35: CscApi.Key.END,
        36: CscApi.Key.HOME,
        37: CscApi.Key.LEFT,
        38: CscApi.Key.UP,
        39: CscApi.Key.RIGHT,
        40: CscApi.Key.DOWN,
        44: CscApi.Key.PRINTSCR,
        45: CscApi.Key.INSERT,
        46: CscApi.Key.DELETE,
        48: CscApi.Key.NUM_0,
        49: CscApi.Key.NUM_1,
        50: CscApi.Key.NUM_2,
        51: CscApi.Key.NUM_3,
        52: CscApi.Key.NUM_4,
        53: CscApi.Key.NUM_5,
        54: CscApi.Key.NUM_6,
        55: CscApi.Key.NUM_7,
        56: CscApi.Key.NUM_8,
        57: CscApi.Key.NUM_9,
        65: CscApi.Key.A,
        66: CscApi.Key.B,
        67: CscApi.Key.C,
        68: CscApi.Key.D,
        69: CscApi.Key.E,
        70: CscApi.Key.F,
        71: CscApi.Key.G,
        72: CscApi.Key.H,
        73: CscApi.Key.I,
        74: CscApi.Key.J,
        75: CscApi.Key.K,
        76: CscApi.Key.L,
        77: CscApi.Key.M,
        78: CscApi.Key.N,
        79: CscApi.Key.O,
        80: CscApi.Key.P,
        81: CscApi.Key.Q,
        82: CscApi.Key.R,
        83: CscApi.Key.S,
        84: CscApi.Key.T,
        85: CscApi.Key.U,
        86: CscApi.Key.V,
        87: CscApi.Key.W,
        88: CscApi.Key.X,
        89: CscApi.Key.Y,
        90: CscApi.Key.Z,
        94: CscApi.Key.TURNOFF,
        95: CscApi.Key.SLEEP,
        96: CscApi.Key.NUMPAD_0,
        97: CscApi.Key.NUMPAD_1,
        98: CscApi.Key.NUMPAD_2,
        99: CscApi.Key.NUMPAD_3,
        100: CscApi.Key.NUMPAD_4,
        101: CscApi.Key.NUMPAD_5,
        102: CscApi.Key.NUMPAD_6,
        103: CscApi.Key.NUMPAD_7,
        104: CscApi.Key.NUMPAD_8,
        105: CscApi.Key.NUMPAD_9,
        106: CscApi.Key.NUMPAD_MULTIPLY,
        107: CscApi.Key.NUMPAD_ADD,
        109: CscApi.Key.NUMPAD_SUBTRACT,
        110: CscApi.Key.NUMPAD_COMMA,
        111: CscApi.Key.NUMPAD_DIVIDE,
        112: CscApi.Key.F1,
        113: CscApi.Key.F2,
        114: CscApi.Key.F3,
        115: CscApi.Key.F4,
        116: CscApi.Key.F5,
        117: CscApi.Key.F6,
        118: CscApi.Key.F7,
        119: CscApi.Key.F8,
        120: CscApi.Key.F9,
        121: CscApi.Key.F10,
        122: CscApi.Key.F11,
        123: CscApi.Key.F12,
        144: CscApi.Key.NUMLOCK,
        145: CscApi.Key.SCROLLLOCK,
        187: CscApi.Key.ADD,
        188: CscApi.Key.COMMA,
        189: CscApi.Key.SUBTRACT,
        190: CscApi.Key.DECIMAL,
        219: CscApi.Key.LEFT_QUOTE,
        255: CscApi.Key.WAKEUP,
    };
    function ConvertKeyToKeyCode(key) {
        switch (key) {
            case CscApi.Key.BACKSPACE: return 8;
            case CscApi.Key.TAB: return 9;
            case CscApi.Key.RETURN: return 13;
            case CscApi.Key.SHIFT: return 16;
            case CscApi.Key.CTRL: return 17;
            case CscApi.Key.ALT: return 18;
            case CscApi.Key.PAUSE_BREAK: return 19;
            case CscApi.Key.CAPSLOCK: return 20;
            case CscApi.Key.ESC: return 27;
            case CscApi.Key.SPACE: return 32;
            case CscApi.Key.PAGEUP: return 33;
            case CscApi.Key.PAGEDOWN: return 34;
            case CscApi.Key.END: return 35;
            case CscApi.Key.HOME: return 36;
            case CscApi.Key.LEFT: return 37;
            case CscApi.Key.UP: return 38;
            case CscApi.Key.RIGHT: return 39;
            case CscApi.Key.DOWN: return 40;
            case CscApi.Key.PRINTSCR: return 44;
            case CscApi.Key.INSERT: return 45;
            case CscApi.Key.DELETE: return 46;
            case CscApi.Key.NUM_0: return 48;
            case CscApi.Key.NUM_1: return 49;
            case CscApi.Key.NUM_2: return 50;
            case CscApi.Key.NUM_3: return 51;
            case CscApi.Key.NUM_4: return 52;
            case CscApi.Key.NUM_5: return 53;
            case CscApi.Key.NUM_6: return 54;
            case CscApi.Key.NUM_7: return 55;
            case CscApi.Key.NUM_8: return 56;
            case CscApi.Key.NUM_9: return 57;
            case CscApi.Key.A: return 65;
            case CscApi.Key.B: return 66;
            case CscApi.Key.C: return 67;
            case CscApi.Key.D: return 68;
            case CscApi.Key.E: return 69;
            case CscApi.Key.F: return 70;
            case CscApi.Key.G: return 71;
            case CscApi.Key.H: return 72;
            case CscApi.Key.I: return 73;
            case CscApi.Key.J: return 74;
            case CscApi.Key.K: return 75;
            case CscApi.Key.L: return 76;
            case CscApi.Key.M: return 77;
            case CscApi.Key.N: return 78;
            case CscApi.Key.O: return 79;
            case CscApi.Key.P: return 80;
            case CscApi.Key.Q: return 81;
            case CscApi.Key.R: return 82;
            case CscApi.Key.S: return 83;
            case CscApi.Key.T: return 84;
            case CscApi.Key.U: return 85;
            case CscApi.Key.V: return 86;
            case CscApi.Key.W: return 87;
            case CscApi.Key.X: return 88;
            case CscApi.Key.Y: return 89;
            case CscApi.Key.Z: return 90;
            case CscApi.Key.TURNOFF: return 94;
            case CscApi.Key.SLEEP: return 95;
            case CscApi.Key.NUMPAD_0: return 96;
            case CscApi.Key.NUMPAD_1: return 97;
            case CscApi.Key.NUMPAD_2: return 98;
            case CscApi.Key.NUMPAD_3: return 99;
            case CscApi.Key.NUMPAD_4: return 100;
            case CscApi.Key.NUMPAD_5: return 101;
            case CscApi.Key.NUMPAD_6: return 102;
            case CscApi.Key.NUMPAD_7: return 103;
            case CscApi.Key.NUMPAD_8: return 104;
            case CscApi.Key.NUMPAD_9: return 105;
            case CscApi.Key.NUMPAD_MULTIPLY: return 106;
            case CscApi.Key.NUMPAD_ADD: return 107;
            case CscApi.Key.NUMPAD_SUBTRACT: return 109;
            case CscApi.Key.NUMPAD_COMMA: return 110;
            case CscApi.Key.NUMPAD_DIVIDE: return 111;
            case CscApi.Key.F1: return 112;
            case CscApi.Key.F2: return 113;
            case CscApi.Key.F3: return 114;
            case CscApi.Key.F4: return 115;
            case CscApi.Key.F5: return 116;
            case CscApi.Key.F6: return 117;
            case CscApi.Key.F7: return 118;
            case CscApi.Key.F8: return 119;
            case CscApi.Key.F9: return 120;
            case CscApi.Key.F10: return 121;
            case CscApi.Key.F11: return 122;
            case CscApi.Key.F12: return 123;
            case CscApi.Key.NUMLOCK: return 144;
            case CscApi.Key.SCROLLLOCK: return 145;
            case CscApi.Key.ADD: return 187;
            case CscApi.Key.COMMA: return 188;
            case CscApi.Key.SUBTRACT: return 189;
            case CscApi.Key.DECIMAL: return 190;
            case CscApi.Key.LEFT_QUOTE: return 219;
            case CscApi.Key.WAKEUP: return 255;
        }
        throw 'unknown key.';
    }
})(CscImpl || (CscImpl = {}));
/// <reference path="chart.ts" />
var CscImpl;
(function (CscImpl) {
    var DECIMAL_DIGITS = 4;
    var ChartOfWr = (function (_super) {
        __extends(ChartOfWr, _super);
        function ChartOfWr(area, handleId, width, height) {
            _super.call(this, CscApi.ChartType.WR, area, handleId, width, height, DECIMAL_DIGITS, 'WR');
            this.elementWrList = null;
            this.elementViewWrDragon = null;
        }
        ChartOfWr.prototype.setConfig = function (config) {
            config = this.cloneConfig(config);
            var configPeriod = config.params['period'];
            var configWrLineWidth = config.params['wrLineWidth'];
            var configWrLineColorRgba = config.params['wrLineColorRgba'];
            this.argPeriod = configPeriod.value;
            this.styleWrLineWidth = configWrLineWidth.value;
            this.styleWrLineColorRgba = configWrLineColorRgba.value;
            this.config = config;
            this.setArgDirty(true);
            return true;
        };
        ChartOfWr.prototype.getArgPeriod = function () {
            return this.argPeriod;
        };
        ChartOfWr.prototype.setArgPeriod = function (period) {
            this.argPeriod = period;
            this.config.params['period'].value = period;
            this.setArgDirty(true);
            return true;
        };
        ChartOfWr.prototype.getStyleWrLineWidth = function () {
            return this.styleWrLineWidth;
        };
        ChartOfWr.prototype.setStyleWrLineWidth = function (lineWidth) {
            if (lineWidth == null) {
                return false;
            }
            this.styleWrLineWidth = lineWidth;
            this.config.params['wrLineWidth'].value = lineWidth;
            return true;
        };
        ChartOfWr.prototype.getStyleWrLineColorRgba = function () {
            return this.styleWrLineColorRgba;
        };
        ChartOfWr.prototype.setStyleWrLineColorRgba = function (colorRgba) {
            if (colorRgba == null) {
                return false;
            }
            this.styleWrLineColorRgba = colorRgba;
            this.config.params['wrLineColorRgba'].value = colorRgba;
            return true;
        };
        ChartOfWr.prototype.getValueOfElement = function (index) {
            if (index >= 0 && index < this.elementWrList.length) {
                return this.elementWrList[index];
            }
            return null;
        };
        ChartOfWr.prototype.updateElements = function (updateTickFromIndex) {
            _super.prototype.updateElements.call(this, updateTickFromIndex);
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var numberOfDragonComponents = numberOfOrderedTickList * 2;
            if (this.elementViewWrDragon == null || this.elementViewWrDragon.length !== numberOfDragonComponents) {
                this.elementViewWrDragon = CscApi.Utility.resizeFloat32Array(this.elementViewWrDragon, numberOfDragonComponents);
            }
            if (this.elementWrList == null || this.elementWrList.length !== numberOfOrderedTickList) {
                this.elementWrList = CscApi.Utility.resizeFloat32Array(this.elementWrList, numberOfOrderedTickList);
            }
            var elementWrList = this.elementWrList;
            var period = this.argPeriod;
            var sumTr = 0;
            for (var i = 0; i < numberOfOrderedTickList; ++i) {
                if (i >= period) {
                    var periodLow = Number.POSITIVE_INFINITY;
                    var periodHigh = Number.NEGATIVE_INFINITY;
                    for (var n = i - period + 1; n <= i; ++n) {
                        var periodTickData = orderedTickList[n];
                        var periodTickLow = periodTickData.getLow();
                        var periodTickHigh = periodTickData.getHigh();
                        if (periodTickLow < periodLow) {
                            periodLow = periodTickLow;
                        }
                        if (periodTickHigh > periodHigh) {
                            periodHigh = periodTickHigh;
                        }
                    }
                    var tickData = orderedTickList[i];
                    elementWrList[i] = 100 * (periodHigh - tickData.getClose()) / (periodHigh - periodLow);
                }
                else {
                    elementWrList[i] = NaN;
                }
            }
        };
        ChartOfWr.prototype.updateViewYRange = function (viewStartTickIndex, viewEndTickIndex) {
            var context = this.refContext();
            var orderedTickList = context.getOrderedTickList();
            var numberOfOrderedTickList = orderedTickList.length;
            var lowestValue = Number.POSITIVE_INFINITY;
            var highestValue = Number.NEGATIVE_INFINITY;
            var elementWrList = this.elementWrList;
            for (var vi = viewStartTickIndex; vi <= viewEndTickIndex; ++vi) {
                var wr = elementWrList[vi];
                if (false == isNaN(wr)) {
                    if (wr > highestValue)
                        highestValue = wr;
                    if (wr < lowestValue)
                        lowestValue = wr;
                }
            }
            return {
                lowestValue: lowestValue,
                highestValue: highestValue,
            };
        };
        ChartOfWr.prototype.updateForRendering = function (viewStartTickIndex, viewEndTickIndex, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor, yAxisEnabled) {
            var elementWrList = this.elementWrList;
            var elementViewWrDragon = this.elementViewWrDragon;
            var timeScale = this.refTimeScale();
            var timeScaleElements = timeScale.getTimeScaleElements();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < elementWrList.length - 1) {
                viewEndTickIndex++;
            }
            for (var i = viewStartTickIndex; i <= viewEndTickIndex; ++i) {
                var timeScaleElement = timeScaleElements[i];
                var viewXCoord = timeScaleElement.viewXCoord;
                var wr = elementWrList[i];
                var vi = i * 2;
                var vyi = vi + 1;
                elementViewWrDragon[vi] = viewXCoord;
                elementViewWrDragon[vyi] = isNaN(wr) ? NaN : Math.floor(valueToYCoordConvertor(wr));
            }
            return yAxisEnabled ? this.generateValueScaleIncludeZero(this.styleValueScaleSpanMargin, areaLowestValue, areaHighestValue, pixelsPerValue, valueToYCoordConvertor) : null;
        };
        ChartOfWr.prototype.render = function (viewStartTickIndex, viewEndTickIndex) {
            var renderer = this.refRenderer();
            var candlestickChart = this.refCandlestickChart();
            if (viewStartTickIndex > 0 && viewStartTickIndex > this.argPeriod) {
                viewStartTickIndex--;
            }
            if (viewEndTickIndex < this.elementWrList.length - 1) {
                viewEndTickIndex++;
            }
            var viewTickWidth = candlestickChart.getViewTickWidth();
            var area = this.getArea();
            var viewStartXCoord = area.getViewStartXCoord();
            var firstPointIndex = viewStartTickIndex >= this.argPeriod ? viewStartTickIndex : this.argPeriod;
            var numberOfPoints = viewEndTickIndex - firstPointIndex + 1;
            renderer.translate(-viewStartXCoord, 0);
            if (numberOfPoints > 1) {
                renderer.setLineWidth(Math.floor(Math.min(this.styleWrLineWidth, viewTickWidth)));
                renderer.setStrokeColorRgba(this.styleWrLineColorRgba);
                this.drawDragon(this.elementViewWrDragon, firstPointIndex, numberOfPoints);
            }
            renderer.translate(viewStartXCoord, 0);
            return true;
        };
        ChartOfWr.prototype.renderValueInfo = function (focusElementIndex) {
            var valueInfoList;
            if (focusElementIndex != null) {
                var wr = this.elementWrList[focusElementIndex];
                valueInfoList = [
                    { name: 'Period', value: this.argPeriod.toString(), valueColor: null },
                ];
                if (false === isNaN(wr))
                    valueInfoList.push({ name: 'WR', value: wr.toFixed(DECIMAL_DIGITS), valueColor: this.styleWrLineColorRgba });
            }
            this.drawValueInfo(valueInfoList);
        };
        return ChartOfWr;
    })(CscImpl.Chart);
    CscImpl.ChartOfWr = ChartOfWr;
})(CscImpl || (CscImpl = {}));
var CscImpl;
(function (CscImpl) {
    var ChartFactory = (function () {
        function ChartFactory() {
        }
        ChartFactory.generate = function (chartType, area, handleId, chartWidth, chartHeight) {
            var chart;
            switch (chartType) {
                case CscApi.ChartType.TIME_SCALE:
                    chart = new CscImpl.ChartOfTimeScale(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.OHLC:
                    chart = new CscImpl.ChartOfOhlc(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.MA:
                    chart = new CscImpl.ChartOfMa(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.MACD:
                    chart = new CscImpl.ChartOfMacd(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.AO:
                    chart = new CscImpl.ChartOfAo(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.ARBR:
                    chart = new CscImpl.ChartOfArBr(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.ATR:
                    chart = new CscImpl.ChartOfAtr(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.BIAS:
                    chart = new CscImpl.ChartOfBias(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.BIAS_AB:
                    chart = new CscImpl.ChartOfBiasAB(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.CCI:
                    chart = new CscImpl.ChartOfCci(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.DMI:
                    chart = new CscImpl.ChartOfDmi(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.KDJ:
                    chart = new CscImpl.ChartOfKdj(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.MTM:
                    chart = new CscImpl.ChartOfMtm(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.OBV:
                    chart = new CscImpl.ChartOfObv(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.PSY:
                    chart = new CscImpl.ChartOfPsy(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.ROC:
                    chart = new CscImpl.ChartOfRoc(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.RSI:
                    chart = new CscImpl.ChartOfRsi(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.RSI_SMOOTH:
                    chart = new CscImpl.ChartOfRsiSmooth(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.VOLUME:
                    chart = new CscImpl.ChartOfVolume(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.BOLLINGER_BAND:
                    chart = new CscImpl.ChartOfBollingerBand(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.VR:
                    chart = new CscImpl.ChartOfVr(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.WR:
                    chart = new CscImpl.ChartOfWr(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.OSMA:
                    chart = new CscImpl.ChartOfOsMa(area, handleId, chartWidth, chartHeight);
                    break;
                case CscApi.ChartType.SAR:
                    chart = new CscImpl.ChartOfSar(area, handleId, chartWidth, chartHeight);
                    break;
                default:
                    chart = null;
                    break;
            }
            return chart;
        };
        return ChartFactory;
    })();
    CscImpl.ChartFactory = ChartFactory;
})(CscImpl || (CscImpl = {}));
//# sourceMappingURL=app.js.map