//
//  IP_TRADESERV5102.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5102 : IPFather

jsonValueInterface(Aeid, NSString *)
jsonValueInterface(AccountID, long long)
jsonValueInterface(Instrument, NSString *)
jsonValueInterface(AccountDigist, NSString *)
jsonValueInterface(CloseBuyTradeVec, NSArray *)
jsonValueInterface(CloseSellTradeVec, NSArray *)

- (NSString *)toString;

@end
