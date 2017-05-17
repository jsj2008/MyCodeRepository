//
//  GeneralCalculateUtil.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "GeneralCalculateUtil.h"

#import "CommDocCaptain.h"
#import "Instrument.h"
#import "KeyNotFundException.h"
#import "MTP4CommDataInterface.h"

@implementation GeneralCalculateUtil

- (CDS_LongShotPair *)calculateLongShortInstrument:(NSString *)instrument
                                           buySell:(int)buySell
                                            amount:(double)amount
                                             price:(double)price{
    Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument];
    if (inst == nil) {
        @throw [[KeyNotFundException alloc] initWithKeyName:@"GeneralCalculateUtil.calculateLongShortInstrument.Instrument" Object:instrument];
    }
    return [self calculateLongShortCCy1:[inst getCcy1] ccy2:[inst getCcy2] buysell:buySell amount:amount price:price];
}

- (CDS_LongShotPair *)calculateLongShortCCy1:(NSString *)ccy1
                                        ccy2:(NSString *)ccy2
                                     buysell:(int)buysell
                                      amount:(double)amount
                                       price:(double)price{
    amount = fabs(amount);
    double amount2 = amount * price;
    CDS_LongShotPair *pair = [[CDS_LongShotPair alloc] init];
    [pair setCcy1:ccy1];
    [pair setCcy2:ccy2];
    if (buysell == BUY) {
        [pair setLong_ccy:ccy1];
        [pair setLong_amount:amount];
        [pair setShort_ccy:ccy2];
        [pair setShort_amount:amount2];
    } else {
        [pair setLong_ccy:ccy2];
        [pair setLong_amount:amount2];
        [pair setShort_ccy:ccy1];
        [pair setShort_amount:amount];
    }
    return pair;
}

@end
