//
//  TradeResult_MktCFD.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOrderHis.h"

static int RESULT_SUCCEED = 0;
static int RESULT_PRICECHANGED = 1;
static int RESULT_MD5DigestDontMatch = -1;
static int RESULT_TradeDisabled = -2;
static int RESULT_PriceErr = -3;
static int RESULT_AmountErr = -4;
static int RESULT_OutofNOPL = -5;
static int RESULT_TooManyPositions = -6;
static int RESULT_PreSellErr = -7;
static int RESULT_MarginIsNotEnoughToTrade = -8;
static int RESULT_UPTradeFailed = -9;
static int RESULT_System_is_Close = -10;
static int RESULT_SIGNATURE_CHECK_FAILURE = -51;
static int RESULT_otherErr = -100;

@interface TradeResult_MktCFD : NSObject

@property int result;
@property NSString *_errMessage;
@property double newMktPrice;
@property TOrderHis *orderHis;

- (NSString *)getErrCode;
- (void)setErrCodeAndCreateResult:(NSString *)code;

@end
