//
//  EchoData.m
//  IOSClientApiTester
//
//  Created by felix on 7/25/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "EchoData.h"

static NSString * gs_EchoData_jsonId = @"EchoData";

@implementation EchoData

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:gs_EchoData_jsonId];
    }
    
    return self;
}

@end
