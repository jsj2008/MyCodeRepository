//
//  IP_REPORT2007.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

static const int Report2007_TYPE_ALL       = 1;
static const int Report2007_TYPE_GROUP     = 2;
static const int Report2007_TYPE_ACCOUNT   = 3;
static const int Report2007_TYPE_ORDERID   = 4;

@interface IP_REPORT2007 : IPFather

jsonValueInterface(Type,        int)
jsonValueInterface(Account,     long long)
jsonValueInterface(GroupName,   NSString *)
jsonValueInterface(FromTime,    NSDate *)
jsonValueInterface(EndTime,     NSDate *)
jsonValueInterface(OrderID,     long long)

@end
