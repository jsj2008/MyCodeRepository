//
//  SystemConfig.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ClientSystemConfig.h"
#import "JEDISystem.h"
#import "APIDoc.h"
#import "InstrumentStruct.h"

NSString *const systemConfigFileName = @"SystemConfigSaveData";

NSString *const instrumentArrayKey = @"instrumentArrayKey";
//NSString *const unselectInstrumentArray = @"unselectInstrumentArray";
NSString *const openPositionSortType = @"openPositionSortType";
NSString *const orderSortType = @"orderSortType";
NSString *const positionSumSortType = @"positionSumSortType";
NSString *const amountCustomArray = @"amountCustomArray";
NSString *const columnChoosArray = @"columnChoosArray";
NSString *const rssResourceArray = @"rssResourceArray";

static ClientSystemConfig *clientSystemConfig;

@interface ClientSystemConfig() {
    
    NSMutableArray *_instrumentArray;
    NSNumber *_openPositionSortType;
    NSNumber *_orderSortType;
    NSNumber *_positionSumSortType;
    NSMutableArray *_amountCustomArray;
    NSMutableArray *_columnChooseArray;
    NSMutableArray *_rssResourceArray;
    
    NSString *_fileName;
}

@end

@implementation ClientSystemConfig

@synthesize instrumentArray = _instrumentArray;
@synthesize openPositionSortType = _openPositionSortType;
@synthesize orderSortType = _orderSortType;
@synthesize positionSumSortType = _positionSumSortType;
@synthesize amountCustomArray = _amountCustomArray;
@synthesize columnChooseArray = _columnChooseArray;
@synthesize rssResourceArray = _rssResourceArray;

+ (ClientSystemConfig *)getInstance {
    if (clientSystemConfig == nil) {
        clientSystemConfig = [[ClientSystemConfig alloc] initWithFileName:systemConfigFileName];
    }
    return clientSystemConfig;
}

- (id)initWithFileName:(NSString *)fileName{
    if (self = [super init]) {
        _fileName = fileName;
        [self loadUserConfigSaveData];
    }
    return self;
}

- (void)saveConfigData {
    [self writeUserConfigPlist:_fileName];
}

-(void) loadUserConfigSaveData {
    //    JEDI_SYS_Try {
    //        NSString *dataPath = NSTemporaryDirectory();
    //        NSLog(@"%@", dataPath);
    //        dataPath = [NSString stringWithFormat:@"%@%@", dataPath, _fileName];
    NSString *dataPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //        NSLog(@"%@", dataPath);
    dataPath = [NSString stringWithFormat:@"%@/%@", dataPath, _fileName];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
    
    _instrumentArray = [[NSMutableArray alloc] init];
    NSMutableArray *archiveArray = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:instrumentArrayKey]];
    //        _instrumentArray = ;
    if ([archiveArray count] == 0) {
        _instrumentArray = [self getDefaultInstrumentArray];
    } else {
        for (NSData *data in archiveArray) {
            InstrumentStruct *s = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [_instrumentArray addObject:s];
        }
    }
    
    //        _unselectInstrumentArray = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:unselectInstrumentArray]];
    // 不会出现nil的情况
    //        if (_unselectInstrumentArray == nil || [_unselectInstrumentArray count] == 0) {
    //            _unselectInstrumentArray = [[NSMutableArray alloc] init];
    //        }
    
    _openPositionSortType = [dictionary objectForKey:openPositionSortType];
    if (_openPositionSortType == nil) {
        _openPositionSortType = [[NSNumber alloc] initWithInt:0];
    }
    
    _orderSortType = [dictionary objectForKey:orderSortType];
    if (_orderSortType == nil) {
        _orderSortType = [[NSNumber alloc] initWithInt:0];
    }
    
    _positionSumSortType = [dictionary objectForKey:positionSumSortType];
    if (_positionSumSortType == nil) {
        _positionSumSortType = [[NSNumber alloc] initWithInt:0];
    }
    
    _amountCustomArray = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:amountCustomArray]];
    if ([_amountCustomArray count] == 0) {
        _amountCustomArray = [[NSMutableArray alloc] initWithObjects:@"200,000", @"500,000", @"1,000,000", nil];
    }
    
    _columnChooseArray = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:columnChoosArray]];
    if ([_columnChooseArray count] == 0) {
        // 最高、 最低、 涨跌、 涨跌、 涨跌幅、 时间
        //            _columnChooseArray = [[NSMutableArray alloc] initWithObjects:@"true", @"true", @"true", @"true", @"false", @"true", nil];
        _columnChooseArray = [[NSMutableArray alloc] initWithObjects:@"true", @"true", @"true", @"true", @"true", nil];
    }
    
    //        "http://news.cnyes.com/RSS/FarEastBank_cnyes";
    
    _rssResourceArray = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:rssResourceArray]];
    if ([_rssResourceArray count] == 0) {
        _rssResourceArray = [[NSMutableArray alloc] init];
        if (dictionary == nil) {
            [_rssResourceArray addObject:@"http://news.cnyes.com/RSS/FarEastBank_cnyes"];
        }
    }
    
    //    }JEDI_SYS_EndTry
}

-(void) writeUserConfigPlist:(NSString *) plistFile{
    //    JEDI_SYS_Try {
    NSString *dataPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    dataPath = [NSString stringWithFormat:@"%@/%@", dataPath, _fileName];
    NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:dataPath];
    //        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
    
    if (dictPlist == nil) {
        dictPlist =[[NSMutableDictionary alloc ] init];
    }
    
    NSMutableArray *instrumentArchiveArray = [[NSMutableArray alloc] init];
    for (InstrumentStruct *s in _instrumentArray) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:s];
        [instrumentArchiveArray addObject:data];
    }
    [dictPlist setObject:instrumentArchiveArray forKey:instrumentArrayKey];
    //        [dictPlist setObject:_unselectInstrumentArray forKey:unselectInstrumentArray];
    [dictPlist setObject:_openPositionSortType forKey:openPositionSortType];
    [dictPlist setObject:_orderSortType forKey:orderSortType];
    [dictPlist setObject:_positionSumSortType forKey:positionSumSortType];
    [dictPlist setObject:_amountCustomArray forKey:amountCustomArray];
    [dictPlist setObject:_columnChooseArray forKey:columnChoosArray];
    //        _rssResourceArray = [[NSMutableArray alloc] initWithObjects:@"123",@"1",@"2", nil];
    [dictPlist setObject:_rssResourceArray forKey:rssResourceArray];
    
    //        NSString *plistPath = NSTemporaryDirectory();
    //        plistPath = [NSString stringWithFormat:@"%@%@", plistPath, plistFile];
    
    if(![dictPlist writeToFile:dataPath atomically:YES]){
        NSLog(@"write user config file failed.");
    }
    //    } JEDI_SYS_EndTry
}

- (NSMutableArray *)getDefaultInstrumentArray {
    InstrumentStruct *inst0 = [[InstrumentStruct alloc] initWithInstrument:@"EUR/USD" selectType:InstrumentSelected];
    InstrumentStruct *inst1 = [[InstrumentStruct alloc] initWithInstrument:@"USD/JPY" selectType:InstrumentSelected];
    InstrumentStruct *inst2 = [[InstrumentStruct alloc] initWithInstrument:@"GBP/USD" selectType:InstrumentSelected];
    InstrumentStruct *inst3 = [[InstrumentStruct alloc] initWithInstrument:@"USD/CHF" selectType:InstrumentSelected];
    InstrumentStruct *inst4 = [[InstrumentStruct alloc] initWithInstrument:@"USD/CAD" selectType:InstrumentSelected];
    
    InstrumentStruct *inst5 = [[InstrumentStruct alloc] initWithInstrument:@"AUD/USD" selectType:InstrumentSelected];
    InstrumentStruct *inst6 = [[InstrumentStruct alloc] initWithInstrument:@"NZD/USD" selectType:InstrumentSelected];
    InstrumentStruct *inst7 = [[InstrumentStruct alloc] initWithInstrument:@"USD/ZAR" selectType:InstrumentSelected];
    InstrumentStruct *inst8 = [[InstrumentStruct alloc] initWithInstrument:@"EUR/JPY" selectType:InstrumentSelected];
    InstrumentStruct *inst9 = [[InstrumentStruct alloc] initWithInstrument:@"AUD/JPY" selectType:InstrumentSelected];
    
    InstrumentStruct *inst10 = [[InstrumentStruct alloc] initWithInstrument:@"NZD/JPY" selectType:InstrumentSelected];
    InstrumentStruct *inst11 = [[InstrumentStruct alloc] initWithInstrument:@"GBP/JPY" selectType:InstrumentSelected];
    InstrumentStruct *inst12 = [[InstrumentStruct alloc] initWithInstrument:@"EUR/AUD" selectType:InstrumentSelected];
    InstrumentStruct *inst13 = [[InstrumentStruct alloc] initWithInstrument:@"GBP/AUD" selectType:InstrumentSelected];
    InstrumentStruct *inst14 = [[InstrumentStruct alloc] initWithInstrument:@"EUR/GBP" selectType:InstrumentSelected];
    InstrumentStruct *inst15 = [[InstrumentStruct alloc] initWithInstrument:@"USD/CNH" selectType:InstrumentSelected];
    
    InstrumentStruct *inst16 = [[InstrumentStruct alloc] initWithInstrument:@"AUD/CAD" selectType:InstrumentUnselect];
    InstrumentStruct *inst17 = [[InstrumentStruct alloc] initWithInstrument:@"AUD/CHF" selectType:InstrumentUnselect];
    InstrumentStruct *inst18 = [[InstrumentStruct alloc] initWithInstrument:@"AUD/NZD" selectType:InstrumentUnselect];
    InstrumentStruct *inst19 = [[InstrumentStruct alloc] initWithInstrument:@"CAD/CHF" selectType:InstrumentUnselect];
    InstrumentStruct *inst20 = [[InstrumentStruct alloc] initWithInstrument:@"CAD/JPY" selectType:InstrumentUnselect];
    
    InstrumentStruct *inst21 = [[InstrumentStruct alloc] initWithInstrument:@"CHF/JPY" selectType:InstrumentUnselect];
    InstrumentStruct *inst22 = [[InstrumentStruct alloc] initWithInstrument:@"EUR/CAD" selectType:InstrumentUnselect];
    InstrumentStruct *inst23 = [[InstrumentStruct alloc] initWithInstrument:@"EUR/CHF" selectType:InstrumentUnselect];
    InstrumentStruct *inst24 = [[InstrumentStruct alloc] initWithInstrument:@"EUR/NZD" selectType:InstrumentUnselect];
    InstrumentStruct *inst25 = [[InstrumentStruct alloc] initWithInstrument:@"GBP/CAD" selectType:InstrumentUnselect];
    
    InstrumentStruct *inst26 = [[InstrumentStruct alloc] initWithInstrument:@"GBP/CHF" selectType:InstrumentUnselect];
    InstrumentStruct *inst27 = [[InstrumentStruct alloc] initWithInstrument:@"GBP/NZD" selectType:InstrumentUnselect];
    InstrumentStruct *inst28 = [[InstrumentStruct alloc] initWithInstrument:@"NZD/CAD" selectType:InstrumentUnselect];
    InstrumentStruct *inst29 = [[InstrumentStruct alloc] initWithInstrument:@"NZD/CHF" selectType:InstrumentUnselect];
    
    NSMutableArray *instrumentArray = [[NSMutableArray alloc] initWithObjects:
                                       inst0, inst1, inst2, inst3, inst4,
                                       inst5, inst6, inst7, inst8, inst9,
                                       inst10, inst11, inst12, inst13, inst14,
                                       inst15, inst16, inst17, inst18, inst19,
                                       inst20, inst21, inst22, inst23, inst24,
                                       inst25, inst26, inst27, inst28, inst29, nil];
    return instrumentArray;
}

- (NSArray *)getSelectedInstrumentArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Instrument *inst in [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentArray]) {
        [array addObject:[inst getInstrument]];
    }
    
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (InstrumentStruct *insStruct in _instrumentArray) {
        if ([insStruct selectType] == InstrumentSelected) {
            if ([array containsObject:[insStruct instrumentName]]) {
                [selectedArray addObject:[insStruct instrumentName]];
            }
        }
    }
    return selectedArray;
}

- (void)resetInstrumentArray {
    _instrumentArray = [self getDefaultInstrumentArray];
}

- (NSString *)getFirstInstrument {
    for (InstrumentStruct *s in _instrumentArray) {
        if ([s selectType] == InstrumentSelected) {
            return [s instrumentName];
        }
    }
    return nil;
}

@end
