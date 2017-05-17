//
//  KChartParam.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/9.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "KChartParam.h"
#import "ParamTable.h"
#import "TiArgumentConfig.h"
#import "TiSaveData.h"


static KChartParam *instance = nil;

@interface KChartParam(){
    NSString *_instrumentName;
    NSString *_lastInstrumentName;
    NSDictionary *_tiConfigDic;
}

@end

@implementation KChartParam

+ (KChartParam *)getInstance {
    if (instance == nil) {
        instance = [[KChartParam alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        // 默認
        //        self.instrumentName = nil;
        _instrumentName = nil;
        _lastInstrumentName = nil;
        self.cycle = 306;
        self.kChartType = CANDLESTICK;
        staticMutableTiArray = [[NSMutableArray alloc] initWithObjects:@"MA", nil];
    }
    return self;
}

//@synthesize instrumentName;
- (void)setInstrumentName:(NSString *)instrumentName {
//    if (_instrumentName != nil) {
//        [[KChartView getInstance] saveToJsonString:_instrumentName];
//    }
    _lastInstrumentName = _instrumentName;
    _instrumentName = instrumentName;
}

- (NSString *)instrumentName {
    return _instrumentName;
}

- (NSString *)lastInstrumentName {
    return _lastInstrumentName;
}
@synthesize cycle;
@synthesize technologyArray;
@synthesize mutableTechnologyArray;
@synthesize kChartType;

@synthesize staticMutableTiArray;

- (void)resetConfig {
    self.cycle = 306;
    self.kChartType = CANDLESTICK;
//    [self.technologyArray removeAllObjects];
//    [self.mutableTechnologyArray removeAllObjects];
}

- (void)resetInstrument {
    _instrumentName = nil;
}

- (void)setTiConfigDic:(NSDictionary *)dic {
    _tiConfigDic = dic;
    
    [self resetTechnologyArray];
    [self resetCycle];
    [self resetBarType];
    [[TiArgumentConfig getInstance] reloadData];
}

- (NSDictionary *)getTiConfigDic {
    return _tiConfigDic;
}

- (void)resetTechnologyArray {
    if (self.technologyArray != nil) {
        [self.technologyArray removeAllObjects];
    } else {
        self.technologyArray = [[NSMutableArray alloc] init];
    }
    
    if (self.mutableTechnologyArray != nil) {
        [self.mutableTechnologyArray removeAllObjects];
        self.mutableTechnologyArray = [[NSMutableArray alloc] initWithObjects:@"MA0", @"MA0", @"MA0", @"MA0", @"MA0", nil];
    } else {
        self.mutableTechnologyArray = [[NSMutableArray alloc] initWithObjects:@"MA0", @"MA0", @"MA0", @"MA0", @"MA0", nil];
    }
    
    for (NSString *key in [_tiConfigDic allKeys]) {
        int type = [key intValue];
        int index = type / 100;

        NSString *ti = [self getKey:type];
//        if (index != 0) {
//            ti = [NSString stringWithFormat:@"%@%d", ti, index];
//        }
        if (ti != nil) {
            if ([staticMutableTiArray containsObject:[ti uppercaseString]]) {
//                [self.mutableTechnologyArray addObject:ti];

                [self.mutableTechnologyArray replaceObjectAtIndex:index - 1 withObject:[NSString stringWithFormat:@"%@%d", [ti uppercaseString], index]];
            } else {
                [self.technologyArray addObject:ti];
            }
        }
    }
}

- (void)resetCycle {
    self.cycle = [[_tiConfigDic objectForKey:[NSString stringWithFormat:@"%@Cycle", _instrumentName]] intValue];
    if (self.cycle == 0) {
        self.cycle = 306;
    }
}

- (void)resetBarType {
    int type = [[[_tiConfigDic objectForKey:@"1"] objectForKey:@"ohlcBarType"] intValue];
    if (_tiConfigDic == nil) {
        // 默認為candlestick
        self.kChartType = CANDLESTICK;
        return;
    }
    switch (type) {
        case 0:
            self.kChartType = BAR;
            break;
        case 1:
            self.kChartType = CANDLESTICK;
            break;
        default:
            break;
    }
}

- (NSString *)getKey:(ChartType)type {
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
