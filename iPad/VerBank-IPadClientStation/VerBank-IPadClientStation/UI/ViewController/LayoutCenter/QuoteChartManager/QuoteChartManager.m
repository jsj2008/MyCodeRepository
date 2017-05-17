//
//  QuoteChartManager.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/25.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QuoteChartManager.h"
#import "KChartSaveData.h"
#import "TiSaveDataCaptain.h"
#import "ClientSystemConfig.h"

static QuoteChartManager *instance = nil;

@interface QuoteChartManager() {
    NSMutableDictionary *dataDictionaryA;
    NSMutableDictionary *dataDictionaryB;
    NSMutableDictionary *dataDictionaryC;
    NSMutableDictionary *dataDictionaryD;
}

@end

@implementation QuoteChartManager

+ (QuoteChartManager *)getInstance {
    if (instance == nil) {
        instance = [[QuoteChartManager alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        dataDictionaryA = [[TiSaveDataCaptain getInstance] saveDataNodeA];
        dataDictionaryB = [[TiSaveDataCaptain getInstance] saveDataNodeB];
        dataDictionaryC = [[TiSaveDataCaptain getInstance] saveDataNodeC];
        dataDictionaryD = [[TiSaveDataCaptain getInstance] saveDataNodeD];
    }
    return self;
}

- (void)saveConfigData {
    [[TiSaveDataCaptain getInstance] saveConfigData];
}

- (KChartSaveData *)getSaveDataByViewName:(ViewName)viewName instrumentName:(NSString *)instrumentName {
    NSDictionary *dictionary = nil;
    switch (viewName) {
        case ViewNameA:
            dictionary = dataDictionaryA;
            break;
        case ViewNameB:
            dictionary = dataDictionaryB;
            break;
        case ViewNameC:
            dictionary = dataDictionaryC;
            break;
        case ViewNameD:
            dictionary = dataDictionaryD;
            break;
            
        default:
            break;
    }
    KChartSaveData *data = [dictionary objectForKey:instrumentName];
    if (data == nil) {
        data = [[KChartSaveData alloc] init];
        [dictionary setValue:data forKey:instrumentName];
    }
    
    return data;
}

- (NSString *)getInstrumentByViewName:(ViewName)viewName {
    NSString *instrumentName = nil;
    switch (viewName) {
        case ViewNameA:
            instrumentName = [[TiSaveDataCaptain getInstance] instrumentA];
            break;
        case ViewNameB:
            instrumentName = [[TiSaveDataCaptain getInstance] instrumentB];
            break;
        case ViewNameC:
            instrumentName = [[TiSaveDataCaptain getInstance] instrumentC];
            break;
        case ViewNameD:
            instrumentName = [[TiSaveDataCaptain getInstance] instrumentD];
            break;
        default:
            break;
    }
    
    if (instrumentName == nil) {
        instrumentName = [[[[ClientSystemConfig getInstance] instrumentArray] objectAtIndex:0] instrumentName];
        [self setInstrument:instrumentName byViewName:viewName];
    }
    return instrumentName;
}

- (void)setInstrument:(NSString *)instrument byViewName:(ViewName)viewName {
    switch (viewName) {
        case ViewNameA:
            [[TiSaveDataCaptain getInstance] setInstrumentA:instrument];
            break;
        case ViewNameB:
            [[TiSaveDataCaptain getInstance] setInstrumentB:instrument];
            break;
        case ViewNameC:
            [[TiSaveDataCaptain getInstance] setInstrumentC:instrument];
            break;
        case ViewNameD:
            [[TiSaveDataCaptain getInstance] setInstrumentD:instrument];
            break;
            
        default:
            break;
    }
}

@end
