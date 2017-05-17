//
//  Info_TRADESERV1008.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"

static int ATTR_TRANSFER_WITH_FUND = 0;

@interface Info_TRADESERV1008 : InfoFather

jsonValueInterface(AccountID,   long long)
jsonValueInterface(AttrID,      int)

@end
