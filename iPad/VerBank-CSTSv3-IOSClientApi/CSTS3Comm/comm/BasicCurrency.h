//
//  BasicCurrency.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface BasicCurrency : AbstractJsonData
jsonValueInterface(CurrencyName,            NSString*)
jsonValueInterface(ShortName,               NSString*)
jsonValueInterface(CanBeAccountCurrency,    int)
jsonValueInterface(Digit,                   int)
@end
