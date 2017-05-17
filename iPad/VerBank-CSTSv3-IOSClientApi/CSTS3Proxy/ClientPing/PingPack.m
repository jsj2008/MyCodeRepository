//
//  PingPack.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "PingPack.h"
#import "PingCaptain.h"
#import "JEDIDateTime.h"

#import "JEDISystem.h"

@implementation PingPack

//----------------------------------------------------------------------
- (id) init
{
    self = [super init];
    
    if(self != nil)
    {
        mIsTimeout = NO;
        mIsReturned = NO;
        mIsIgnore = NO;
        
        mPing = nil;
    }
    
    return self;
}

//----------------------------------------------------------------------
- (id) initWithPing:(CSTSPing *) ping
{
    self = [super self];
    
    if(self != nil)
    {
        mIsTimeout = NO;
        mIsReturned = NO;
        mIsIgnore = NO;
        
        mPing = ping;
    }
    
    return self;
}

//----------------------------------------------------------------------
- (void) dealloc
{
    mPing = nil;
}

//----------------------------------------------------------------------
- (NSString *) getKey
{
    return (mPing != nil) ? [mPing getID] : nil;
}

//----------------------------------------------------------------------
- (BOOL) isTimeout
{
    return mIsTimeout;
}

//----------------------------------------------------------------------
- (BOOL) isIgnore
{
    return mIsIgnore;
}

//----------------------------------------------------------------------
- (long) getPing
{
    if(mIsTimeout){
        return [PingCaptain getInstance].TIMEOUTPING;
    }
    
    if(mPing == nil){
        return 0;
    }
    
    if(!mIsReturned){
        return (long)([JEDIDateTime currentMillis] - [mPing getStartTime]);
    }
    
    return [mPing getPing];
}

//----------------------------------------------------------------------
- (void) pingReturn:(CSTSPing *) ping
{
    if(ping == nil || mPing == nil){
        return;
    }
    
    JEDI_SYS_Try
    {
        if(![[ping getID] isEqualToString:[mPing getID]]){
            return;
        }
        
        [ping pingReturned];
        
        mPing = ping;
        mIsReturned = YES;
        mIsTimeout = NO;
    }
    JEDI_SYS_EndTry
}

//----------------------------------------------------------------------
- (void) ignore
{
    mIsIgnore = YES;
}

//----------------------------------------------------------------------
- (void) doWait
{
    if(mIsReturned || mIsIgnore){
        return;
    }
    
    JEDI_SYS_Try
    {
        int nSleepTimes = (int)[PingCaptain getInstance].TIMEOUTPING / 100;
        
        for(int i=0; i<nSleepTimes; i++)
        {
            [NSThread sleepForTimeInterval:0.1]; // 0.1 s
            if(mIsReturned || mIsIgnore){
                return;
            }
        }
        
        mIsTimeout = YES;
    }
    JEDI_SYS_EndTry
}

@end
