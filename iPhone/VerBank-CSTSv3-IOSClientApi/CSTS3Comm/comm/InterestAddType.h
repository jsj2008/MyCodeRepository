//
//  InterestAddType.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface InterestAddType : AbstractJsonData
jsonValueInterface(TypeId,NSString*)
jsonValueInterface(CurrencyName,NSString*)
jsonValueInterface(TypeName,NSString*)
jsonValueInterface(InterestBuyAdd,double)
jsonValueInterface(InterestSellAdd,double)
@end
