//
//  TradeResult_HedgeCFD.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TradeResult_HedgeCFD.h"
#import "TradeServiceErrCodeTable.h"

//static int RESULT_SUCCEED = 0;
static int RESULT_MD5DigestDontMatch = -1;
static int RESULT_TradeDisabled = -2;
static int RESULT_PriceErr = -3;
static int RESULT_System_is_Close = -10;
static int RESULT_SIGNATURE_CHECK_FAILURE = -51;
static int RESULT_otherErr = -100;

@interface TradeResult_HedgeCFD(){
    NSString *_errCode;
}

@end

@implementation TradeResult_HedgeCFD

@synthesize result;
@synthesize _errMessage;
@synthesize orderHis;

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
    } else if ([code isEqualToString:ERR_SIGNATURE_CHECK_FAILURE]){
        result = RESULT_SIGNATURE_CHECK_FAILURE;
    } else {
        result = RESULT_otherErr;
    }
}

@end
