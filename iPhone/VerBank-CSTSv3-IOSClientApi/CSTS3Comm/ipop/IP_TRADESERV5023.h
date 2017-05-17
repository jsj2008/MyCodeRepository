//
//  IP_TRADESERV5023.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

static const int    QUERYTYPE_BY_ACCOUNT = 0;
static const int    QUERYTYPE_BY_AEID    = 1;

@interface IP_TRADESERV5023 : IPFather

jsonValueInterface(QueryType,   int)
jsonValueInterface(AccountID,   long long)
jsonValueInterface(Aeid,        NSString *)

@end
