//
//  Margin2.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface Margin2 : AbstractJsonData
jsonValueInterface(Account,long long)
jsonValueInterface(CurrencyName, NSString*)
jsonValueInterface(Amount,double)
jsonValueInterface(ShrinkRate,double)
jsonValueInterface(ExRate,double)
jsonValueInterface(AmountUSD,double)
@end
