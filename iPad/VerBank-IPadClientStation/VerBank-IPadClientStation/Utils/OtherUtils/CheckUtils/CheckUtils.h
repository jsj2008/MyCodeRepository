//
//  CheckUtils.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UpdateType) {
    UpdateTypeNull          = 0x00000,
    UpdateTypeLimit         = 0x00001,
    UpdateTypeStop          = 0x00002,
    UpdateTypeOCO           = 0x00003
};

static const int CheckCode_Valid = 0;
static const int CheckCode_CloseAmtMoreThanOrderAmt = 1;
static const int CheckCode_BuySellAmtNotMatch = 2;

@interface CheckUtils : NSObject

+ (Boolean)isLegalTradeAmount:(double)amount;
+ (int)isHeadgeTradeAmountValiedBuyTicket:(NSArray *)toCloseBuyTickes sellNodes:(NSArray *)toCloseSellTickes;
+ (NSString *)transCheckCode:(int)code;

+ (Boolean)checkAmount:(double)amount buySell:(Boolean)isBuySell instrument:(NSString *)instrument;

+ (UpdateType)getOCOTypeByStop:(double)stopPrice
                        limitPrice:(double)limitPrice;

+ (NSString *)getOCOStringByStop:(double)stopPrice
                      limitPrice:(double)limitPrice;

+ (Boolean)isPwdLegal:(NSString *)pwd accountID:(NSString *)accountID;
+ (Boolean)isPhonePinLegal:(NSString *)phonePin;

+ (Boolean)messageIsAllRead;

@end
