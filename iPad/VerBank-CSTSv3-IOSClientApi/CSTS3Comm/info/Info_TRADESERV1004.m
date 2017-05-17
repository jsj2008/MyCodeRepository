//
//  Info_TRADESERV1004.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1004.h"

static NSString * jsonId        = @"Info_TRADESERV1004";

static NSString * changedAttrID = @"1";
static NSString * attriName     = @"2";

@implementation Info_TRADESERV1004

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(ChangedAttrID,      changedAttrID)
jsonImplementionString(AttriName,    attriName)

@end
