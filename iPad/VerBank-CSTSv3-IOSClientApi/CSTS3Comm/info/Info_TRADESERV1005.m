//
//  Info_TRADESERV1005.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1005.h"

static NSString * jsonId        = @"Info_TRADESERV1005";

static NSString * changedAttrID = @"1";
static NSString * groupName     = @"2";
static NSString * accountID     = @"3";
static NSString * instrumentName= @"4";

@implementation Info_TRADESERV1005

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(ChangedAttrID,      changedAttrID)
jsonImplementionString(GroupName,       groupName)
jsonImplementionLongLong(AccountID,     accountID)
jsonImplementionString(InstrumentName,  instrumentName)

@end
