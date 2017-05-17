//
//  PriceSnapShotUtil.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDS_PriceSnapShot.h"

@interface PriceSnapShotUtil : NSObject

+ (PriceSnapShotUtil *)newInstance:(CDS_PriceSnapShot *)priceSnapShot;

- (id)initWithPriceSnapShot:(CDS_PriceSnapShot *)priceSnapShot;
- (double)calculateRealPL4PositionWithAccount:(double)amount
                             OpenTradePrice:(double)openTradePrice
                                ToBuyOrSell:(int)toBuyOrSell;
- (double)calculateRealMoneyWithAmount:(double)amount
                           BuyOrSell:(int)buyOrSell;


@end
