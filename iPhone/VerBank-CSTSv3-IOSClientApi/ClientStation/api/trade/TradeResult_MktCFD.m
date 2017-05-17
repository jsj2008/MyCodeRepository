//
//  TradeResult_MktCFD.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TradeResult_MktCFD.h"
#import "TradeServiceErrCodeTable.h"



@interface TradeResult_MktCFD(){
    NSString *_errCode;
}

@end

@implementation TradeResult_MktCFD

@synthesize _errMessage;
@synthesize result;
@synthesize newMktPrice;
@synthesize orderHis;

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
    } else if ([code isEqualToString:TS_ERR_Amount_limit_by_USD]){
        result = RESULT_TooManyPositions;
    } else if ([code isEqualToString:TS_ERR_Amount_Max_by_USD]){
        result = RESULT_TooManyPositions;
    } else if ([code isEqualToString:ERR_PreSellErr]){
        result = RESULT_PreSellErr;
    } else if ([code isEqualToString:TS_ERR_MarginNotEnough_Trade]){
        result = RESULT_MarginIsNotEnoughToTrade;
    } else if ([code isEqualToString:TS_ERR_MarginNotEnough_UnLock]){
        result = RESULT_MarginIsNotEnoughToTrade;
    } else if ([code isEqualToString:TS_ERR_Uptrade]){
        result = RESULT_UPTradeFailed;
    } else if ([code isEqualToString:ERR_SIGNATURE_CHECK_FAILURE]){
        result = RESULT_SIGNATURE_CHECK_FAILURE;
    } else {
        result = RESULT_otherErr;
    }
}

@end
