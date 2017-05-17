//
//  IP_REPORT2001.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

static const int Report2001_YPE_ALL       = 1;
static const int Report2001_TYPE_GROUP     = 2;
static const int Report2001_TYPE_ACCOUNT   = 3;
static const int Report2001_TYPE_GROUPVEC  = 4;

@interface IP_REPORT2001 : IPFather

jsonValueInterface(Type,        int)
jsonValueInterface(Account,     long long)
jsonValueInterface(GroupName,   NSString *)
jsonValueInterface(GroupVec,    NSArray *)
jsonValueInterface(FromTime,    NSDate *)
jsonValueInterface(EndTime,     NSDate *)

@end
