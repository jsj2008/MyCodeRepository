//
//  TradeResult_OrderCFD.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TradeResult_OrderCFD.h"
#import "TradeServiceErrCodeTable.h"

//static int RESULT_SUCCEED = 0;
static int RESULT_MD5DigestDontMatch = -1;
static int RESULT_TradeDisabled = -2;
static int RESULT_PriceErr = -3;
static int RESULT_AmountErr = -4;
static int RESULT_OutofNOPL = -5;
static int RESULT_PreSellErr = -7;
static int RESULT_System_is_Close = -10;
static int RESULT_TooManyOrders=-11;
static int RESULT_Parameter_Error=-12;
static int RESULT_SIGNATURE_CHECK_FAILURE = -51;

static int RESULT_otherErr = -100;

@interface TradeResult_OrderCFD () {
    NSString *_errCode;
}

@end

@implementation TradeResult_OrderCFD

@synthesize result;
@synthesize _errMessage;
@synthesize order;

- (id)init{
    if (self = [super init]) {
        _errCode = @"";
        _errMessage = @"";
    }
    return self;
}

- (NSString *)getErrCode{
    return _errCode;
}

- (void)setErrCodeAndCreateResult:(NSString *)code{
    _errCode = code;
    if (code == nil) {
        return;
    } else if ([code isEqualToString:TS_ERR_MD5DigestDontMatch]){
        result = RESULT_MD5DigestDontMatch;
    } else if ([code isEqualToString:TS_ERR_TradeDisabled]){
        result = RESULT_TradeDisabled;
    } else if ([code isEqualToString:TS_ERR_System_is_Close]){
        result = RESULT_System_is_Close;
    } else if ([code isEqualToString:TS_ERR_Price]){
        result = RESULT_PriceErr;
    } else if ([code isEqualToString:TS_ERR_Amount_Match]){
        result = RESULT_AmountErr;
    } else if ([code isEqualToString:TS_ERR_Cut_Loss_User]){
        result = RESULT_OutofNOPL;
    } else if ([code isEqualToString:TS_ERR_Cut_Loss_Account]){
        result = RESULT_OutofNOPL;
    } else if ([code isEqualToString:ERR_TooManyOrders]){
        result = RESULT_TooManyOrders;
    } else if ([code isEqualToString:ERR_PreSellErr]){
        result = RESULT_PreSellErr;
    } else if ([code isEqualToString:TS_ERR_Trade_Param]){
        result = RESULT_Parameter_Error;
    } else if ([code isEqualToString:ERR_SIGNATURE_CHECK_FAILURE]){
        result = RESULT_SIGNATURE_CHECK_FAILURE;
    } else {
        result = RESULT_otherErr;
    }
}





@end
