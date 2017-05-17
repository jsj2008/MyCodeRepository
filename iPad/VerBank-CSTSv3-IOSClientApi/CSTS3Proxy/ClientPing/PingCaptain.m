//
//  PingCaptain.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "PingCaptain.h"
#import "JEDISystem.h"
#import "JEDIDateTime.h"


static PingCaptain * gsPingCaptain = nil;

@interface PingCaptain ()

- (void) initDefault;
- (void) dealloc;

@end


@implementation PingCaptain

//---------------------------------------------------------------------------------------------
#pragma mark Public
//---------------------------------------------------------------------------------------------
+ (PingCaptain *) getInstance
{
    return gsPingCaptain;
}

//---------------------------------------------------------------------------------------------
- (id)   init
{
    self = [super init];
    
    if(self != nil)
    {
        [self initDefault];
        gsPingCaptain = self;
    }
    
    return self;
}

//---------------------------------------------------------------------------------------------
- (id)   initWithDelegate:(id) delegate
{
    self = [super init];
    
    if(self != nil)
    {
        [self initDefault];
        
        mPingDealerableDelegate = delegate;
        gsPingCaptain = self;
    }
    
    return self;
}

//---------------------------------------------------------------------------------------------
- (void) initPingCaptain
{
    if(mPingThread == nil)
    {
        mPingThread = [[NSThread alloc] initWithTarget:self selector:@selector(runInPingThread) object:nil];
        [mPingThread start];
    }
}

//---------------------------------------------------------------------------------------------
- (void) destory
{
    mIsDestory = YES;
    gsPingCaptain = nil;
    
    [JEDISystem log:@"destory ------> PingCaptain."];
    
    if(mPingThread != nil)
    {
        if([mPingThread isExecuting]){
            [mPingThread cancel];
        }
        
        mPingThread = nil;
    }
    
    @synchronized(mFinishedPingArray){
        [mFinishedPingArray removeAllObjects];
    }
    
    @synchronized(mRecentPingArray){
        [mRecentPingArray removeAllObjects];
    }
}

//---------------------------------------------------------------------------------------------
- (void) setPingDealerableDelegate:(id) delegate
{
     mPingDealerableDelegate = delegate;
}

//---------------------------------------------------------------------------------------------
- (void) setParamsTimeout:(long) timeout pingGap:(long) gap pingLostNumber:(int) lostNumber recMaxNum:(int) recNum
{
    self.TIMEOUTPING = timeout;
    self.PINGGAP = gap;
    self.PINGLOSTTIMES = lostNumber;
    self.RECMAXNUM = recNum;
}

//---------------------------------------------------------------------------------------------
- (void) clearTimeoutRecords
{
    @synchronized(mRecentPingArray){
        [mRecentPingArray removeAllObjects];
    }
}


//---------------------------------------------------------------------------------------------
#pragma mark Private
//---------------------------------------------------------------------------------------------
- (void) runInPingThread
{
    while(!mIsDestory)
    {
        @try
        {
            long timeUsed = [self doPing];
            long leftTime = self.PINGGAP - timeUsed;
            
            if(leftTime > 100){
                [NSThread sleepForTimeInterval:(leftTime/1000.0)];
            }
        }
        @catch (NSException *exception) {
            [JEDISystem log:@"PingCaptain.runInPingThread, Error: " withObject:exception];
        }
        @catch (...){
            [JEDISystem log:@"PingCaptain.runInPingThread, Error: unknow exception."];
        }
    }
}

//---------------------------------------------------------------------------------------------
- (long) doPing
{
    NSTimeInterval startTime = [JEDIDateTime currentTimeIntervalSince1970];
    CSTSPing * cstsPing = [[CSTSPing alloc] init];
    mCurrentPingPack = [[PingPack alloc] initWithPing:cstsPing];
    
    if(mPingDealerableDelegate != nil && [mPingDealerableDelegate sendPing:cstsPing])
    {
        [mCurrentPingPack doWait];
        [self onPingFinished:mCurrentPingPack];
    }else{
        //[JEDISystem log:@"PingCaptain.doPing, invalid delegate for send ping."];
    }
    
    mCurrentPingPack = nil;
    NSTimeInterval endTime = [JEDIDateTime currentTimeIntervalSince1970];
    return (long)((endTime - startTime) * 1000.0);
}

//---------------------------------------------------------------------------------------------
- (void) onPingReturn:(CSTSPing *) ping
{
    if(mCurrentPingPack == nil){
        return;
    }
    
    JEDI_SYS_Try
    {
        if([[mCurrentPingPack getKey] isEqualToString:[ping getID]]){
            [mCurrentPingPack pingReturn:ping];
        }
    }
    JEDI_SYS_EndTry
}

//---------------------------------------------------------------------------------------------
- (void) onPingFinished:(PingPack *)pingPack
{
    if(![pingPack isIgnore])
    {
        @synchronized(mFinishedPingArray)
        {
            [mFinishedPingArray addObject:pingPack];
            while([mFinishedPingArray count] > self.RECMAXNUM){
                [mFinishedPingArray removeObjectAtIndex:0];
            }
            
            [mRecentPingArray addObject:pingPack];
            while ([mRecentPingArray count] > self.PINGLOSTTIMES){
                [mRecentPingArray removeObjectAtIndex:0];
            }
        }
    }
    
    [self notifyDelegatePingResult:[self getPingResult]];
}

//---------------------------------------------------------------------------------------------
- (void) notifyDelegatePingResult:(PingResult *) result
{
    if(mPingDealerableDelegate){
        [mPingDealerableDelegate onPingResult:result];
    }else{
        //[JEDISystem log:@"PingCaptain.notifyDelegatePingResult, invalid delegate for ping result."];
    }
}

//---------------------------------------------------------------------------------------------
- (PingResult *) getPingResult
{
    PingResult *pingResult = [[PingResult alloc] init];
    
    @synchronized(mFinishedPingArray)
    {
        if([mFinishedPingArray count] == 0){
            pingResult.IsTimeout = false;
            return pingResult;
        }
        
        PingPack * lastPing = [mFinishedPingArray lastObject];
        long curPing = [lastPing getPing];
        int totalNum = 0;
        int totalPing = 0;
        int totalLost = 0;
        int timeoutInFirstPart = 0;
        
        totalNum += [mFinishedPingArray count];
        
        NSEnumerator *enumerator = [mFinishedPingArray objectEnumerator];
        PingPack *pingPack;
        
        while (pingPack = [enumerator nextObject])
        {
            totalPing += [pingPack getPing];
            if([pingPack isTimeout]){
                totalLost ++;
            }
        }
        
        int index = 0;
        enumerator = [mRecentPingArray objectEnumerator];
        while(pingPack = [enumerator nextObject])
        {
            if([pingPack isTimeout]){
                timeoutInFirstPart ++;
            }
            index ++;
            if(index >= self.PINGLOSTTIMES){
                break;
            }
        }
        
        pingResult.IsTimeout = (timeoutInFirstPart >= self.PINGLOSTTIMES);
        if(totalNum > 0){
            pingResult.AveragePing = (totalPing / totalNum);
            pingResult.LostPerc = ((double) totalLost / (double) totalNum);
        }
        
        pingResult.TimeOfPing = curPing;
    }

    return pingResult;
}


//---------------------------------------------------------------------------------------------
- (void) initDefault
{
    self.TIMEOUTPING = 3000;
    self.RECMAXNUM = 30;
    self.PINGGAP = 3000;
    self.PINGLOSTTIMES = 3;
    
    mFinishedPingArray = [[NSMutableArray alloc] init];
    mRecentPingArray = [[NSMutableArray alloc] init];
    
    mIsDestory = NO;
    mPingThread = nil;
    mCurrentPingPack = nil;
    mPingDealerableDelegate = nil;
}

//---------------------------------------------------------------------------------------------
- (void) dealloc
{
    if(mPingThread != nil && [mPingThread isExecuting]){
            [mPingThread cancel];
    }
    
    if(mFinishedPingArray != nil){
        [mFinishedPingArray removeAllObjects];
    }
    
    if(mRecentPingArray != nil){
        [mRecentPingArray removeAllObjects];
    }
    
    mPingDealerableDelegate = nil;
    mFinishedPingArray = nil;
    mRecentPingArray = nil;
    
    mCurrentPingPack = nil;
    mPingThread = nil;
}

@end
