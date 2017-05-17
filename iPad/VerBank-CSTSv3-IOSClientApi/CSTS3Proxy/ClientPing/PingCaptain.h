//
//  PingCaptain.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PingDealerableDelegate.h"
#import "PingPack.h"

//---------------------------------------------------------------------------------------------
@interface PingCaptain : NSObject
{
@private
    id<PingDealerableDelegate> mPingDealerableDelegate;
    BOOL             mIsDestory;
    
    NSMutableArray * mFinishedPingArray;
    NSMutableArray * mRecentPingArray;
    
    NSThread       * mPingThread;
    PingPack       * mCurrentPingPack;
}

@property (nonatomic) long TIMEOUTPING;
@property (nonatomic) int  RECMAXNUM;
@property (nonatomic) long PINGGAP;
@property (nonatomic) int  PINGLOSTTIMES;

//---------------------------------------------------------------------------------------------
#pragma mark Public

+ (PingCaptain *) getInstance;

- (id)   init;
- (id)   initWithDelegate:(id<PingDealerableDelegate>) delegate;

- (void) initPingCaptain;
- (void) destory;

- (void) setPingDealerableDelegate:(id) delegate;
- (void) setParamsTimeout:(long) timeout pingGap:(long) gap pingLostNumber:(int) lostNumber recMaxNum:(int)recNum;

- (void) clearTimeoutRecords;


//---------------------------------------------------------------------------------------------
#pragma mark Private

- (void) runInPingThread;

- (long) doPing;
- (void) onPingReturn:(CSTSPing *) ping;
- (void) onPingFinished:(PingPack *)pingPack;

- (void) notifyDelegatePingResult:(PingResult *) result;
- (PingResult *) getPingResult;

@end
