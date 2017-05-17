//
//  CSTSTradeWaitObject.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "CSTSTradeWaitObject.h"
#import "JEDISystem.h"
#import "IPOPErrCodeTable.h"


@implementation CSTSTradeWaitObject

//--------------------------------------------------------------------------
- (id) init
{
    self = [self init];
    
    if(self != nil)
    {
        mIp = nil;
        mOp = nil;
        mHashCode = nil;
        mWaitLock = [[NSLock alloc] init];
    }
    
    return self;
}

//--------------------------------------------------------------------------
- (id) initWithIp:(IPFather *) ip
{
    self = [super init];
    
    if(self != nil)
    {
        mIp = ip;
        mOp = nil;
        mHashCode = mIp ? [mIp getOperateId] : nil;
        mWaitLock = [[NSLock alloc] init];
    }
    
    return self;
}

//--------------------------------------------------------------------------
- (void) dealloc
{
    mHashCode = nil;
    mWaitLock = nil;
    mIp = nil;
    mOp = nil;
}

//--------------------------------------------------------------------------
- (OPFather *) waitTradeForTime:(long) waitTime
{
    if(mOp != nil){
        return mOp;
    }
    
    @try
    {
        [mWaitLock lock];
        
        NSDate *nsDate = [NSDate dateWithTimeIntervalSinceNow:(waitTime/1000.0)];
        if(![mWaitLock lockBeforeDate:nsDate]){
            // time out for wait
        }
        
        [mWaitLock unlock];
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"CSTSTradeWaitObject.waitTradeForTime, Error: " withObject:exception];
    }
    
    if(mOp == nil){
        OPFather * op = [[OPFather alloc] initWithIp:mIp];
        [op setSuccess:NO];
        [op setErrCode:ERR_Timeout]; //IPOPErrCodeTable.ERR_Timeout
        [op setErrMessage:@"CSTSTrade timeout!"];
        return op;
    }else{
        return mOp;
    }
}

//--------------------------------------------------------------------------
- (OPFather *) waitTrade
{
    return [self waitTradeForTime:JEDI_CSTS_TRADE_WAIT_GAP];
}

//--------------------------------------------------------------------------
- (void) tradeReturn:(OPFather *)op
{
    mOp = op;
    
    if(mWaitLock != nil){
        [mWaitLock unlock];
    }
}

//--------------------------------------------------------------------------
- (void) setError
{
    if(mOp != nil)
    {
        if(mWaitLock) [mWaitLock unlock];
    }
    else
    {
        mOp = [[OPFather alloc] initWithIp:mIp];
        
        [mOp setSuccess:NO];
        [mOp setErrCode:ERR_NetErr];
        [mOp setErrMessage:@"CSTSTrade network erro!"];
        [self tradeReturn:mOp];
    }
}

//--------------------------------------------------------------------------
- (NSString *) getHashCode
{
    return mHashCode;
}

@end
