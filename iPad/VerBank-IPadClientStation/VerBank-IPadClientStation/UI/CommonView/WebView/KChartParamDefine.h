//
//  KChartParamDefine.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#ifndef KChartParamDefine_h
#define KChartParamDefine_h

typedef NS_ENUM(NSUInteger, ChartCycleType) {
    
    ChartCycleUnknow    = 0,
    ChartCycleMin1      = 301,
    ChartCycleMin5      = 302,
    ChartCycleMin10     = 303,
    ChartCycleMin15     = 304,
    ChartCycleMin30     = 305,
    ChartCycleMin60     = 306,
    ChartCycleMin90     = 307,
    ChartCycleMin180    = 308,
    
    ChartCycleDay       = 309,
    ChartCycleWeek      = 310,
    ChartCycleMonth     = 311,
    ChartCycleYear      = 312,
    
    ChartCycleHour2     = 313,
    ChartCycleHour4     = 314,
    ChartCycleHour6     = 315,
    ChartCycleHour8     = 316
};

typedef NS_ENUM(NSUInteger, TechnologyType) {
    time_scale,     // 時間刻度。
    ohlc,           // 開高收低。
    ao,             // 動量震動指標。
    arbr,           // 人氣意願指標。
    atr,            // 真實波幅。
    bollinger_band, // 布林通道。
    bias,           // 乖離率。
    bias_ab,        // a減b乖離率。
    cci,            // 順勢指標。
    dmi,            // 動向指標。
    kdj,            // 隨機指標。
    ma,             // 移動平均。
    macd,           // 指數平滑異同移動平均線。
    mtm,            // 動量指標。
    obv,            // 能量潮。
    psy,            // 心理線。
    roc,            // 變動率。
    rsi,            // 相對強弱指標。
    rsi_smooth,     // 平滑相對強弱指標。
    volume,         // 交易量。
    vr,             // 容量指標。
    wr,             // 威廉指標。
    osma,           //移動振動平均震蕩器指標.
    sar,            //停損點轉向操作系統
};

typedef NS_ENUM(NSUInteger, ChooseType) {
    ChooseTypeUnknow            = 0,
    ChooseTypeCycleChooseType   = 1,
    ChooseTypeTechnologyType    = 2,
    ChooseTypeDrawType          = 3,
    ChooseTypeCandleStickType   = 4,
    ChooseTypeMaSubArrayType    = 5,
};

typedef NS_ENUM(NSUInteger, KChartType) {
    KChartTypeCANDLESTICK   = 0,
    KChartTypeBar           = 1,
};

#endif /* KChartParamDefine_h */
