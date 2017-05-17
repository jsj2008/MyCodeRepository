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
#import "InstrumentStructNode.h"

NSString *const systemConfigFileName = @"SystemConfigSaveData";

NSString *const instrumentArrayKey = @"instrumentArrayKey";
//NSString *const unselectInstrumentArray = @"unselectInstrumentArray";
NSString *const openPositionSortType = @"openPositionSortType";
NSString *const orderSortType = @"orderSortType";
NSString *const positionSumSortType = @"positionSumSortType";
NSString *const quoteListUpDownType = @"quoteListUpDownType";
NSString *const amountCustomArray = @"amountCustomArray";
NSString *const columnChoosArray = @"columnChoosArray";
NSString *const rssResourceArray = @"rssResourceArray";

NSString *const currentKChartNumberKey = @"currentKChartNumberKey";

static ClientSystemConfig *clientSystemConfig;

@interface ClientSystemConfig() {
    
    NSMutableArray *_instrumentArray;
    NSNumber *_openPositionSortType;
    NSNumber *_orderSortType;
    NSNumber *_positionSumSortType;
    NSMutableArray *_amountCustomArray;
    NSMutableArray *_columnChooseArray;
    NSMutableArray *_rssResourceArray;
    
    NSNumber *_currentKChartNumber;
    
    NSString *_fileName;
}

@end

@implementation ClientSystemConfig

@synthesize instrumentArray = _instrumentArray;
@synthesize openPositionSortType = _openPositionSortType;
@synthesize orderSortType = _orderSortType;
@synthesize positionSumSortType = _positionSumSortType;
@synthesize amountCustomArray = _amountCustomArray;
@synthesize quoteListUpDownType = _quoteListUpDownType;
@synthesize columnChooseArray = _columnChooseArray;
@synthesize rssResourceArray = _rssResourceArray;

@synthesize currentKChartNumber = _currentKChartNumber;

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
    JEDI_SYS_Try {
        //        NSString *dataPath = NSTemporaryDirectory();
        //        //        NSLog(@"%@", dataPath);
        //        dataPath = [NSString stringWithFormat:@"%@%@", dataPath, _fileName];
        //
        //        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
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
                InstrumentStructNode *s = [NSKeyedUnarchiver unarchiveObjectWithData:data];
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
        
        _quoteListUpDownType = [dictionary objectForKey:quoteListUpDownType];
        if (_quoteListUpDownType == nil) {
            _quoteListUpDownType = [[NSNumber alloc] initWithInt:0];
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
        
        _currentKChartNumber = [dictionary objectForKey:currentKChartNumberKey];
        if (_currentKChartNumber == nil) {
            _currentKChartNumber = [[NSNumber alloc] initWithInt:4];
        }
        
        //        "http://news.cnyes.com/RSS/FarEastBank_cnyes";
        
        _rssResourceArray = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:rssResourceArray]];
        if ([_rssResourceArray count] == 0) {
            _rssResourceArray = [[NSMutableArray alloc] init];
            if (dictionary == nil) {
                [_rssResourceArray addObject:@"http://news.cnyes.com/RSS/FarEastBank_cnyes"];
                //                [_rssResourceArray addObject:@"http://www.appledaily.com.tw/rss/newcreate/kind/rnews/type/hot"];
            }
        }
        
    }JEDI_SYS_EndTry
}

-(void) writeUserConfigPlist:(NSString *) plistFile{
    //    JEDI_SYS_Try {
    //        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
    NSString *dataPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    dataPath = [NSString stringWithFormat:@"%@/%@", dataPath, _fileName];
    NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:dataPath];
    //        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
    
    if (dictPlist == nil) {
        dictPlist =[[NSMutableDictionary alloc ] init];
    }
    
    
    NSMutableArray *instrumentArchiveArray = [[NSMutableArray alloc] init];
    for (InstrumentStructNode *s in _instrumentArray) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:s];
        [instrumentArchiveArray addObject:data];
    }
    [dictPlist setObject:instrumentArchiveArray forKey:instrumentArrayKey];
    //        [dictPlist setObject:_unselectInstrumentArray forKey:unselectInstrumentArray];
    [dictPlist setObject:_openPositionSortType forKey:openPositionSortType];
    [dictPlist setObject:_orderSortType forKey:orderSortType];
    [dictPlist setObject:_positionSumSortType forKey:positionSumSortType];
    [dictPlist setObject:_quoteListUpDownType forKey:quoteListUpDownType];
    [dictPlist setObject:_amountCustomArray forKey:amountCustomArray];
    [dictPlist setObject:_columnChooseArray forKey:columnChoosArray];
    //        _rssResourceArray = [[NSMutableArray alloc] initWithObjects:@"123",@"1",@"2", nil];
    [dictPlist setObject:_rssResourceArray forKey:rssResourceArray];
    
    [dictPlist setObject:_currentKChartNumber forKey:currentKChartNumberKey];
    
    
    if(![dictPlist writeToFile:dataPath atomically:YES]){
        NSLog(@"write user config file failed.");
    }
    //    } JEDI_SYS_EndTry
}

- (NSMutableArray *)getDefaultInstrumentArray {
    InstrumentStructNode *inst0 = [[InstrumentStructNode alloc] initWithInstrument:@"EUR/USD" selectType:InstrumentSelected];
    InstrumentStructNode *inst1 = [[InstrumentStructNode alloc] initWithInstrument:@"USD/JPY" selectType:InstrumentSelected];
    InstrumentStructNode *inst2 = [[InstrumentStructNode alloc] initWithInstrument:@"GBP/USD" selectType:InstrumentSelected];
    InstrumentStructNode *inst3 = [[InstrumentStructNode alloc] initWithInstrument:@"USD/CHF" selectType:InstrumentSelected];
    InstrumentStructNode *inst4 = [[InstrumentStructNode alloc] initWithInstrument:@"USD/CAD" selectType:InstrumentSelected];
    
    InstrumentStructNode *inst5 = [[InstrumentStructNode alloc] initWithInstrument:@"AUD/USD" selectType:InstrumentSelected];
    InstrumentStructNode *inst6 = [[InstrumentStructNode alloc] initWithInstrument:@"NZD/USD" selectType:InstrumentSelected];
    InstrumentStructNode *inst7 = [[InstrumentStructNode alloc] initWithInstrument:@"USD/ZAR" selectType:InstrumentSelected];
    InstrumentStructNode *inst8 = [[InstrumentStructNode alloc] initWithInstrument:@"EUR/JPY" selectType:InstrumentSelected];
    InstrumentStructNode *inst9 = [[InstrumentStructNode alloc] initWithInstrument:@"AUD/JPY" selectType:InstrumentSelected];
    
    InstrumentStructNode *inst10 = [[InstrumentStructNode alloc] initWithInstrument:@"NZD/JPY" selectType:InstrumentSelected];
    InstrumentStructNode *inst11 = [[InstrumentStructNode alloc] initWithInstrument:@"GBP/JPY" selectType:InstrumentSelected];
    InstrumentStructNode *inst12 = [[InstrumentStructNode alloc] initWithInstrument:@"EUR/AUD" selectType:InstrumentSelected];
    InstrumentStructNode *inst13 = [[InstrumentStructNode alloc] initWithInstrument:@"GBP/AUD" selectType:InstrumentSelected];
    InstrumentStructNode *inst14 = [[InstrumentStructNode alloc] initWithInstrument:@"EUR/GBP" selectType:InstrumentSelected];
    InstrumentStructNode *inst15 = [[InstrumentStructNode alloc] initWithInstrument:@"USD/CNH" selectType:InstrumentSelected];
    
    InstrumentStructNode *inst16 = [[InstrumentStructNode alloc] initWithInstrument:@"AUD/CAD" selectType:InstrumentUnselect];
    InstrumentStructNode *inst17 = [[InstrumentStructNode alloc] initWithInstrument:@"AUD/CHF" selectType:InstrumentUnselect];
    InstrumentStructNode *inst18 = [[InstrumentStructNode alloc] initWithInstrument:@"AUD/NZD" selectType:InstrumentUnselect];
    InstrumentStructNode *inst19 = [[InstrumentStructNode alloc] initWithInstrument:@"CAD/CHF" selectType:InstrumentUnselect];
    InstrumentStructNode *inst20 = [[InstrumentStructNode alloc] initWithInstrument:@"CAD/JPY" selectType:InstrumentUnselect];
    
    InstrumentStructNode *inst21 = [[InstrumentStructNode alloc] initWithInstrument:@"CHF/JPY" selectType:InstrumentUnselect];
    InstrumentStructNode *inst22 = [[InstrumentStructNode alloc] initWithInstrument:@"EUR/CAD" selectType:InstrumentUnselect];
    InstrumentStructNode *inst23 = [[InstrumentStructNode alloc] initWithInstrument:@"EUR/CHF" selectType:InstrumentUnselect];
    InstrumentStructNode *inst24 = [[InstrumentStructNode alloc] initWithInstrument:@"EUR/NZD" selectType:InstrumentUnselect];
    InstrumentStructNode *inst25 = [[InstrumentStructNode alloc] initWithInstrument:@"GBP/CAD" selectType:InstrumentUnselect];
    
    InstrumentStructNode *inst26 = [[InstrumentStructNode alloc] initWithInstrument:@"GBP/CHF" selectType:InstrumentUnselect];
    InstrumentStructNode *inst27 = [[InstrumentStructNode alloc] initWithInstrument:@"GBP/NZD" selectType:InstrumentUnselect];
    InstrumentStructNode *inst28 = [[InstrumentStructNode alloc] initWithInstrument:@"NZD/CAD" selectType:InstrumentUnselect];
    InstrumentStructNode *inst29 = [[InstrumentStructNode alloc] initWithInstrument:@"NZD/CHF" selectType:InstrumentUnselect];
    
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
    for (InstrumentStructNode *insStruct in _instrumentArray) {
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
    for (InstrumentStructNode *s in _instrumentArray) {
        if ([s selectType] == InstrumentSelected) {
            return [s instrumentName];
        }
    }
    return nil;
}

@end
