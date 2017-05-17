//
//  IP_REPORT2023.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

static int R_TYPE_ALL       = 1;
static int R_TYPE_GROUP     = 2;
static int R_TYPE_AEID      = 3;

@interface IP_REPORT2023 : IPFather

jsonValueInterface(IsClient,    Boolean)
jsonValueInterface(Type,        int)
jsonValueInterface(Aeid,        NSString *)
jsonValueInterface(FromTime,    NSDate *)
jsonValueInterface(EndTime,     NSDate *)

@end
