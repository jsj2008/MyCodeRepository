//
//  IP_REPORT2011.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

static int IP_REPORT2011_TYPE_ALL       = 1;
static int IP_REPORT2011_TYPE_GROUP     = 2;
static int IP_REPORT2011_TYPE_ACCOUNT   = 3;

@interface IP_REPORT2011 : IPFather

jsonValueInterface(Type,            int)
jsonValueInterface(Account,         long long)
jsonValueInterface(GroupName,       NSString *)
jsonValueInterface(TypeVec,         NSArray *)
jsonValueInterface(FromTime,        NSDate *)
jsonValueInterface(EndTime,         NSDate *)

@end
