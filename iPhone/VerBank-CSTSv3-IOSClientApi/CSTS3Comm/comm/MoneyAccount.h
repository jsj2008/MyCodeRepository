//
//  MoneyAccount.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface MoneyAccount : AbstractJsonData
jsonValueInterface(Account, long long)
jsonValueInterface(CurrencyName, NSString*)
jsonValueInterface(CashBalance, double)
jsonValueInterface(FixedDeposit , double)
jsonValueInterface(Tbs , double)
jsonValueInterface(Margin2 , double)
@end
