//
//  AccountStrategy.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface AccountStrategy : AbstractJsonData

jsonValueInterface(Account,         long long)
jsonValueInterface(Aeid,            NSString*)
jsonValueInterface(IsDead,          int)
jsonValueInterface(GroupName,       NSString*)
jsonValueInterface(IsUptrade,       int)
jsonValueInterface(IsTradeable,     int)
jsonValueInterface(AcName,          NSString *)
jsonValueInterface(MaxTradeAmount,  double)
jsonValueInterface(BasicCurrency,   NSString*)
jsonValueInterface(OpenTime,        NSDate*)
jsonValueInterface(FirstTradeTime,  NSDate*)
jsonValueInterface(LastTradeTime,   NSDate*)
jsonValueInterface(InterestAddType, NSString*)
jsonValueInterface(LiquidationType, int)
jsonValueInterface(Branch,          NSString*)
jsonValueInterface(RealName,        NSString*)
jsonValueInterface(BranchReceive,   NSString*)
jsonValueInterface(OneTradeLimit,   double)
@end
