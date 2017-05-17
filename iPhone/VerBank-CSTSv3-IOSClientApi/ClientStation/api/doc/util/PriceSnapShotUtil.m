//
//  PriceSnapShotUtil.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "PriceSnapShotUtil.h"
#import "MTP4CommDataInterface.h"

@interface PriceSnapShotUtil(){
    CDS_PriceSnapShot *_priceSnapShot;
}

@end

@implementation PriceSnapShotUtil
+ (PriceSnapShotUtil *)newInstance:(CDS_PriceSnapShot *)priceSnapShot{
    return [[PriceSnapShotUtil alloc] initWithPriceSnapShot:priceSnapShot];
}

- (id)initWithPriceSnapShot:(CDS_PriceSnapShot *)priceSnapShot{
    if (self = [super init]) {
        _priceSnapShot = priceSnapShot;
    }
    return self;
}

- (double)calculateRealPL4PositionWithAccount:(double)amount
                             OpenTradePrice:(double)openTradePrice
                                ToBuyOrSell:(int)toBuyOrSell{
    double tempTradePrice = [_priceSnapShot tradePrice:(toBuyOrSell == BUY ? SELL : BUY)];
    amount = fabs(amount);
    if (toBuyOrSell == BUY) {
        return (tempTradePrice - openTradePrice) * amount;
    } else {
        return (openTradePrice - tempTradePrice) * amount;
    }
}

- (double)calculateRealMoneyWithAmount:(double)amount
                           BuyOrSell:(int)buyOrSell{
    double tempTradePrice = [_priceSnapShot tradePrice:buyOrSell];
    return tempTradePrice * amount;
}

- (void)dealloc {
    _priceSnapShot = nil;
}
@end
