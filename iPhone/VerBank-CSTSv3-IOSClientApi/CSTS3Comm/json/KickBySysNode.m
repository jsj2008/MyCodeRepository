//
//  KickBySysNode.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "KickBySysNode.h"

static NSString * gs_KickBySysNode_JsonId = @"KickBySysNode";

@implementation KickBySysNode

- (id) init
{
    self = [super init];
    
    if(self != nil)
    {
        [self setEntry:@"jsonId" entry:gs_KickBySysNode_JsonId];
    }
    
    return nil;
}

@end
