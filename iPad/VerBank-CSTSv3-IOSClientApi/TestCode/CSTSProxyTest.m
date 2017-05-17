//
//  CSTSProxyTest.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "CSTSProxyTest.h"
#import "CSTSProxy.h"


static CSTSProxy * cstsProxy = nil;

@implementation CSTSProxyTest

- (id) init
{
    self = [super init];
    return self;
}

- (id) initToTest
{
    self = [super init];
    
    if(self != nil)
    {
        cstsProxy = [[CSTSProxy alloc] initWithHost:@"192.168.0.15" port:29240 listener:self];
    }
    
    return self;
}

- (void) dealloc
{
    NSLog(@"CSTSProxy.dealloc, ----------------------> Test End");
    cstsProxy = nil;
}


//----------------------------------------------------------------------------
- (void) onQuoteRec:(NSMutableArray *)quote
{
}

- (void) onVolumnRec:(NSMutableArray *)quoteSize
{
}

- (void) onInforRec:(InfoFather *) info
{
    NSLog(@"TEST-CSTSProxy --? onInfoRec");
}

- (void) onNetLost;
{
}

- (void) onPing:(long)ping avePing:(long)avePing lostPerc:(long)lostPerc
{
    NSLog(@"TEST-CSTSProxy --? onPing: %ld, %ld, %ld", ping, avePing, lostPerc);
}

- (void) onKickedOut:(KickOutNode *)kicknode
{
}

- (void) onKickedOutBySys
{
}

- (void) onPingTimeOut
{
    NSLog(@"TEST-CSTSProxy --? onPingTimeOut");
}

@end
