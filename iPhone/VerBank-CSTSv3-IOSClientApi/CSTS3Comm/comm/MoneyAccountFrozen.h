//
//  MoneyAccountFrozen.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface MoneyAccountFrozen : AbstractJsonData
jsonValueInterface(Guid,long long)
jsonValueInterface(Account,long long)
jsonValueInterface(CurrencyName,NSString*)
jsonValueInterface(Type,int)
jsonValueInterface(Amount,double)
jsonValueInterface(TradeDay,NSString*)
jsonValueInterface(FrozenTime,NSDate*)
jsonValueInterface(Comments,NSString*)
jsonValueInterface(UserName,NSString*)
jsonValueInterface(UserType,int)
jsonValueInterface(IpAddress,NSString*)
@end
