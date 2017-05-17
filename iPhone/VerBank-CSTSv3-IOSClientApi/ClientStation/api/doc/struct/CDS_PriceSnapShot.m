//
//  CDS_PriceSnapShot.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CDS_PriceSnapShot.h"
#import "MTP4CommDataInterface.h"
//#import <math.h>

@implementation CDS_PriceSnapShot

@synthesize instrumentName;
@synthesize digits;
@synthesize accountID;
@synthesize bankName_bid;
@synthesize bankName_ask;
@synthesize quoteID_bid;
@synthesize quoteID_ask;
@synthesize basicBid;
@synthesize basicAsk;
@synthesize priceShift4Account;
@synthesize priceShift4Group;
@synthesize tradePrice;
@synthesize snapshotTime;
@synthesize openPrice;
@synthesize highPrice;
@synthesize lowPrice;
@synthesize yClosePrice;
@synthesize lastBid;
@synthesize lastAsk;
@synthesize quoteDay;
@synthesize close;

//- (id)initWithInstrumentName:(NSString *)_instrumentName{
//    if (self = [super init]) {
//        instrumentName = _instrumentName;
//        accountID = -1;
//        tradePrice = -1;
//        priceShift4Account = nil;
//        priceShift4Group = nil;
//    }
//    return self;
//}

- (id)init {
    if (self = [super init]) {
        self.instrumentName = nil;
        self.accountID = -1;
        self.tradePrice = -1;
        self.priceShift4Account = nil;
        self.priceShift4Group = nil;
        self.bankName_bid = nil;
        self.bankName_ask = nil;
        self.quoteID_bid = nil;
        self.quoteID_ask = nil;
        self.quoteDay = nil;
    }
    return self;
}

- (double)tradePrice:(int)buySell{
    if (tradePrice >= 0) {
        return tradePrice;
    } else {
        if (buySell == BUY) {
            return [self getAsk];
        } else {
            return [self getBid];
        }
    }
}

- (double)getBid{
    double shift = 0;
    if (priceShift4Account != nil) {
        shift += [priceShift4Account bidShift];
    }
    if (priceShift4Group != nil) {
        shift += [priceShift4Group bidShift];
    }
    return [self roundPrice:basicBid - shift];
}

- (double)getAsk{
    double shift = 0;
    if (priceShift4Account != nil) {
        shift += [priceShift4Account askShift];
    }
    if (priceShift4Group != nil) {
        shift += [priceShift4Group askShift];
    }
    return [self roundPrice:basicAsk + shift];
}

- (double)roundPrice:(double)price{
    if (digits <= 0) {
        return price;
    }
    double n = pow(10, digits);
    double absV = fabs(price);
    if (absV < 1 / (n * 10)) {
        return 0;
    }
    double tempV = absV * n + 0.00000001;
    return ((double)((long)(tempV + 0.5))) /n;
}

- (void)dealloc {
    self.instrumentName = nil;
    self.accountID = -1;
    self.tradePrice = -1;
    self.priceShift4Account = nil;
    self.priceShift4Group = nil;
    self.bankName_bid = nil;
    self.bankName_ask = nil;
    self.quoteID_bid = nil;
    self.quoteID_ask = nil;
    self.quoteDay = nil;
}

@end
