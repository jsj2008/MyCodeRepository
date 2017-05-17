//
//  IP_Ctrl4003.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_Ctrl4003.h"

static NSString * jsonId        = @"IP_Ctrl4003";

static NSString * aeid          = @"1";
static NSString * userId        = @"2";

@implementation IP_Ctrl4003

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid,    aeid)
jsonImplementionString(UserId,  userId)

@end
