//
//  IP_TRADESERV5109.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"
#import "PriceWarning.h"

static int OPERATETYPE_DELETE = 0;
static int OPERATETYPE_ADD = 1;
static int OPERATETYPE_READ = 2;
static int OPERATETYPE_MODIFY = 3;

@interface IP_TRADESERV5109 : IPFather

jsonValueInterface(OperateType, int)
jsonValueInterface(ToDeletePWGUID, NSString *)
jsonValueInterface(DealerDesc, NSString *)
jsonValueInterface(Aeid, NSString *)
jsonValueInterface(Price, double)
jsonValueInterface(ExpiryType, int)
jsonValueInterface(ExpiryTime, NSDate *)
jsonValueInterface(ToAddPW, PriceWarning *)

@end
