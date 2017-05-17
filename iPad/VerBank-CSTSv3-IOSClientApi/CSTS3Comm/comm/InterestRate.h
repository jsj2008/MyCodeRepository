//
//  InterestRate.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface InterestRate : AbstractJsonData
jsonValueInterface(CurrencyName, NSString*)
jsonValueInterface(BankCostBid,double)
jsonValueInterface(BankCostOffer,double)
jsonValueInterface(CustomerCostBid,double)
jsonValueInterface(CustomerCostOffer,double)
jsonValueInterface(TradeDay , NSString*)
@end
