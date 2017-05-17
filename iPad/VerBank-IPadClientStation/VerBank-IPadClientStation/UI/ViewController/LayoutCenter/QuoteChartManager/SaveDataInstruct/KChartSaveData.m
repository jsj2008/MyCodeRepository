//
//  KChartSaveData.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/25.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "KChartSaveData.h"
#import "ParamTable.h"
#import "LangCaptain.h"
#import "KChartViewUtils.h"

@implementation KChartSaveData

@synthesize instrumentName;
//@synthesize cycleType;          // 週期
//@synthesize kChartType;         // 蠟燭線類型
//@synthesize technologyArray;    // 技術指標 隊列
//@synthesize maTechnologyArray;  // ma 指標 隊列

@synthesize tiDictionary;

@synthesize technologyNameArray;
@synthesize maNameArray;
@synthesize chartCycleType;
@synthesize chartType;
@synthesize tiArgumentConfig;

@synthesize isOrderLineDraw;
@synthesize orderLineCUIDArray;

//@synthesize tiArgumentConfig;   // 五个技术指标参数

@synthesize tiJsonString;

- (id)init {
    if (self = [super init]) {
        //        cycleType = ChartCycleMin60;// 默認是一小時
        //        kChartType = KChartTypeCANDLESTICK; // 默認是蠟燭線
        [self resetAllData];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:instrumentName forKey:@"instrumentName"];
    [aCoder encodeObject:chartType forKey:@"chartType"];
    [aCoder encodeObject:[NSNumber numberWithInt:chartCycleType] forKey:@"chartCycleType"];
    [aCoder encodeObject:tiDictionary forKey:@"tiDictionary"];
    [aCoder encodeObject:tiJsonString forKey:@"tiJsonString"];
    
    [aCoder encodeObject:isOrderLineDraw forKey:@"isOrderLineDraw"];
    [aCoder encodeObject:orderLineCUIDArray forKey:@"orderLineCUIDArray"];
}

//将对象解码(反序列化)
-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.instrumentName     = [aDecoder decodeObjectForKey:@"instrumentName"];
        self.chartCycleType     = [[aDecoder decodeObjectForKey:@"chartCycleType"] intValue];
        self.chartType          = [aDecoder decodeObjectForKey:@"chartType"];
        self.tiDictionary       = [aDecoder decodeObjectForKey:@"tiDictionary"];
        self.tiJsonString       = [aDecoder decodeObjectForKey:@"tiJsonString"];
        
        self.isOrderLineDraw    = [aDecoder decodeObjectForKey:@"isOrderLineDraw"];
//        self.orderLineCUIDArray = [aDecoder decodeObjectForKey:@"orderLineCUIDArray"];
        [self resetAllData];
    }
    return self;
}

- (void)resetAllData {
    [self resetTiDictionary];
    [self resetTechnologyArray];
    [self resetMaArray];
    [self resetChartCycleType];
    [self resetChartType];
    [self resetTiArgumentConfig];
    [self resetIsOrderLineDraw];
}

- (void)resetTiDictionary {
    if (tiDictionary == nil) {
        NSString *clientDefaultString = [[LangCaptain getInstance] getLangByCode:@"DefaultClientConfig"];
        tiDictionary = [[NSMutableDictionary alloc] initWithDictionary:[KChartViewUtils parseParam:clientDefaultString]];
    }
}

- (void)resetTechnologyArray {
    NSMutableArray *technologyArray = [[NSMutableArray alloc] init];
    for (NSString *key in [tiDictionary allKeys]) {
        int type = [key intValue];
        NSString *ti = [self getKey:type];
        if (ti != nil && ti != MA) {
            [technologyArray addObject:[self getKey:type]];
        }
    }
    self.technologyNameArray = technologyArray;
}

- (void)resetMaArray {
    NSMutableArray *maTechnologyArray = [[NSMutableArray alloc] initWithObjects:@"MA0", @"MA0", @"MA0", @"MA0", @"MA0", nil];
    for (NSString *key in [tiDictionary allKeys]) {
        int type = [key intValue];
        int index = type / 100;
        NSString *ti = [self getKey:type];
        if (ti != nil && ti == MA) {
            [maTechnologyArray replaceObjectAtIndex:index - 1 withObject:[NSString stringWithFormat:@"%@%d", [ti uppercaseString], index]];
        }
    }
    self.maNameArray = maTechnologyArray;
}

- (void)resetChartCycleType {
    if (self.chartCycleType == ChartCycleUnknow) {
        self.chartCycleType = ChartCycleMin60;
    }
}

- (void)resetChartType {
    if (self.chartType == nil || [self.chartType isEqualToString:@""]) {
        self.chartType = CANDLESTICK;
    }
}

- (void)resetTiArgumentConfig {
    TiArgumentConfig *config = [[TiArgumentConfig alloc] init];
    [config reloadDataBy:tiDictionary];
    self.tiArgumentConfig = config;
}

- (void)resetIsOrderLineDraw {
//    if (self.isOrderLineDraw == nil || [self.isOrderLineDraw isEqualToString:@""]) {
        self.isOrderLineDraw = @"false";
        self.orderLineCUIDArray = [[NSMutableArray alloc] init];
//    }
}

#pragma utils
- (NSString *)getKey:(TechnologyType)type {
    type = type %100;
    switch (type) {
        case ao:
            return AO;
        case arbr:
            return ARBR;
        case atr:
            return ATR;
        case bollinger_band:
            return BOLLINGERBAND;
        case bias:
            return BIAS;
        case bias_ab:
            return BIASAB;
        case cci:
            return CCI;
        case dmi:
            return DMI;
        case kdj:
            return KDJ;
        case ma:
            return MA;
        case macd:
            return MACD;
        case mtm:
            return MTM;
        case obv:
            return OBV;
        case psy:
            return PSY;
        case roc:
            return ROC;
        case rsi:
            return RSI;
        case rsi_smooth:
            return RSISMOOTH;
        case volume:
            return VOLUME;
        case vr:
            return VR;
        case wr:
            return WR;
        case osma:
            return OSMA;
        case sar:
            return SAR;
        default:
            break;
    }
    return nil;
}


@end
