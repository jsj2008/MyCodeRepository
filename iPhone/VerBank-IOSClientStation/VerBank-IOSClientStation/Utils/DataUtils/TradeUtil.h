//
//  TradeUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int CheckCode_Valid = 0;
static const int CheckCode_CloseAmtMoreThanOrderAmt = 1;
static const int CheckCode_BuySellAmtNotMatch = 2;

@interface TradeUtil : NSObject

+ (Boolean)isLegalTradeAmount:(double)amount;
+ (int)isHeadgeTradeAmountValiedBuyTicket:(NSArray *)toCloseBuyTickes sellNodes:(NSArray *)toCloseSellTickes;
+ (NSString *)transCheckCode:(int)code;

@end
