//
//  TradeResult_MerchandiseTrade.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TradeResult_MerchandiseTrade.h"

@interface TradeResult_MerchandiseTrade(){
    NSString *_errCode;
}

@end

@implementation TradeResult_MerchandiseTrade

@synthesize result;
@synthesize _errMessage;

- (void)setErrCodeAndCreateResult:(NSString *)code{
    _errCode = code;
}

- (NSString *)getErrCode{
    return _errCode;
}

@end
