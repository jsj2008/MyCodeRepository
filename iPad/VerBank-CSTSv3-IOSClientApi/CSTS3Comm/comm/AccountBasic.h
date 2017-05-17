//
//  AccountBasic.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface AccountBasic : AbstractJsonData

- (id)init;

jsonValueInterface(Account, long long)
jsonValueInterface(Aeid, NSString*)
jsonValueInterface(RealName, NSString*)
jsonValueInterface(GroupName, NSString*)
jsonValueInterface(Currency, NSString*)
jsonValueInterface(Equity, double)

@end
