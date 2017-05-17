//
//  APIDocCaptain.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "APIDocCaptain.h"
#import "TSettled.h"
#import "APIDoc.h"
#import "MTP4CommDataInterface.h"

static NSMutableDictionary *_otherClientConfigMap = nil;
static NSTimeZone *_timeZone;
static NSMutableArray *_settleArray = nil;
static NSMutableArray *_marketClosedInstrumentArray = nil;

@implementation APIDocCaptain


- (id)init{
    if (self = [super init]) {
        _otherClientConfigMap = [[NSMutableDictionary alloc] init];
        _timeZone = [[NSTimeZone alloc] init];
        _settleArray = [[NSMutableArray alloc] init];
        _marketClosedInstrumentArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NSMutableArray *)getSettleList{
    return _settleArray;
}

+ (void)addSettle:(NSArray *)settles{
    for (TSettled *ts in settles) {
        [_settleArray addObject:ts];
    }
}

+ (NSTimeZone *)getTimeZone{
    return _timeZone;
}

+ (void)setTimeZone:(NSTimeZone *)timeZone{
    _timeZone = timeZone;
}

+ (void)addOtnerClientConfig:(NSArray *)otherClientCfgs{
    if (otherClientCfgs == nil) {
        return;
    }
    for (OtherClientConfig *occ in otherClientCfgs) {
        [_otherClientConfigMap setObject:occ forKey:[occ getKey]];
    }
}

+ (OtherClientConfig *)getOtherClientConfig:(NSString *)key{
    return [_otherClientConfigMap objectForKey:key];
}

+ (Boolean)isMarketOpen:(NSString *)instrument{
    if (![APIDoc isInited]) {
        return false;
    }
    if ([[[APIDoc getSystemDocCaptain] systemConfig] getCloseStatus] != CLOSESTATUS_OPEN) {
        return false;
    }
    if ([_marketClosedInstrumentArray containsObject:instrument]) {
        return false;
    }
    return true;
}

+ (void)setClosedInstruments:(NSArray *)instruments{
    @synchronized(_marketClosedInstrumentArray){
        [_marketClosedInstrumentArray removeAllObjects];
        for (NSString *inst in instruments) {
            [_marketClosedInstrumentArray addObject:inst];
        }
    }
}

+ (Instrument *)getInstrumentWithcur1:(NSString *)cur1
                                 cur2:(NSString *)cur2{
    NSArray *instArray = [[APIDoc getSystemDocCaptain] getInstrumentArray];
    for (Instrument *inst in instArray) {
        if (([[inst getCcy1] isEqualToString:cur1] && [[inst getCcy2] isEqualToString:cur2]) || ([[inst getCcy1] isEqualToString:cur2] && [[inst getCcy2] isEqualToString:cur1])) {
            return inst;
        }
    }
    return nil;
}

+ (NSArray *)getPriceSnapShots:(long long)accountID{
    NSMutableArray *snapshotArray = [[NSMutableArray alloc] init];
    NSMutableArray *instrumentArray = [[NSMutableArray alloc] init];
    for (Instrument *instruent in instrumentArray) {
        InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:[instruent getInstrument]];
        CDS_PriceSnapShot *pss = [instUtil getPriceSnapShotWithAccountID:accountID];
        if (pss != nil) {
            [snapshotArray addObject:pss];
        }
    }
    return snapshotArray;
}

@end
