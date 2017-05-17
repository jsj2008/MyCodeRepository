//
//  Info_TRADESERV1003.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"
#import "MoneyAccount.h"

@interface Info_TRADESERV1003 : InfoFather

jsonValueInterface(AccountID,       long long)
jsonValueInterface(MoneyAccount,    MoneyAccount *)
jsonValueInterface(Margin2Vec,      NSArray *)
jsonValueInterface(FrozenVec,       NSArray *)

@end
