//
//  KickOutNode.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "KickOutNode.h"

static NSString * gs_KickOutNode_jsonId   = @"KickOutNode";
static NSString * gs_KickOutNode_kickerIp = @"1";

@implementation KickOutNode

- (id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [super setEntry:@"jsonId" entry:gs_KickOutNode_jsonId];
    }
    
    return self;
}

- (NSString *) getKickerIp
{
    @try
    {
        return [super getEntryString:gs_KickOutNode_kickerIp];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (void) setKickerIp:(NSString *)kickerIp
{
    [super setEntry:gs_KickOutNode_kickerIp entry:kickerIp];
}

@end
