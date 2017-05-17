//
//  AddressChecker.m
//  IOSClientStation
//
//  Created by felix on 8/8/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "AddressChecker.h"
#import "JEDIDateTime.h"
#import "JEDISystem.h"

#define JEDI_ACS_NONE       1
#define JEDI_ACS_CHECKING   2
#define JEDI_ACS_FINISHED   3

@interface AddressChecker ()
{
    JEDINetwork *   mNetwork;
    AddressNode *   mNode;
    
    id              mDelegate;
    int             mCheckState;
    BOOL            mIsConnected;
    
    NSTimeInterval  mBeginTime;
    NSTimeInterval  mEndTime;
    
    NSLock      *   mLock;
}

//----------------------------------------------------------------------
#pragma mark Private

- (void)  runChecking;
- (void)  runFinished;

//----------------------------------------------------------------------
#pragma mark JEDINetworkDelegate

- (void)  onReadMessageBody:(NSData *) data;
- (void)  onNetworkStateChanged:(NSInteger) state;

@end


//----------------------------------------------------------------------
//
//
//----------------------------------------------------------------------
@implementation AddressChecker

- (id)  initWithNode:(AddressNode *) node andDelegate:(id <AddressCheckerDelegate>) delegate
{
    self = [super init];
    
    if(self != nil)
    {
        mNode = node;
        mNode.nWeight = INT32_MAX;
        mNode.nPing   = LONG_MAX;
        
        mDelegate   = delegate;
        mCheckState = JEDI_ACS_NONE;
        mIsConnected = NO;
        
        mNetwork = [[JEDINetwork alloc] initNetworkWithAddress:node.strIp andPort:node.nPort];
        [mNetwork setNetworkDelegate:self];
        
        mLock = [[NSLock alloc] init];
    }
    
    return self;
}

- (void) dealloc
{
    mNetwork = nil;
    mNode = nil;
    mLock = nil;
}

- (void)  startChecking
{
    [NSThread detachNewThreadSelector:@selector(runChecking) toTarget:self withObject:nil];
}

- (void)  stopChecking
{
    if(mCheckState == JEDI_ACS_CHECKING)
    {
        [self runFinished];
    }
}

- (void)  runChecking
{
    mCheckState = JEDI_ACS_CHECKING;
    mIsConnected = NO;
    [mLock lock];
    
    mBeginTime = [JEDIDateTime currentTimeIntervalSince1970];
    [mNetwork connectToServer];
    
    [mLock lock];
    [mLock unlock];
}

- (void)  runFinished
{
    [mLock unlock];
    mCheckState = JEDI_ACS_FINISHED;
    
    if(mNetwork != nil){
        [mNetwork disconnectFromServer];
        mNetwork = nil;
    }
    
    if([mDelegate respondsToSelector:@selector(didAddressCheck:)])
    {
        [mDelegate didAddressCheck:mNode];
    }
}


//----------------------------------------------------------------------
#pragma mark JEDINetworkDelegate

//----------------------------------------------------------------------
#pragma mark JEDINetworkDelegate

- (void) onReadMessageBody:(NSData *) data
{
    JEDI_SYS_Try
    {
        mEndTime = [JEDIDateTime currentTimeIntervalSince1970];
        
        NSString * strWeight = nil;
        if(data && data.length > 10 && mNode)
        {
            strWeight = [[NSString alloc] initWithBytes:[data bytes] length:10 encoding:NSUTF8StringEncoding];
            mNode.nWeight = (int)[strWeight integerValue];
        }
        
        if(mNode != nil)
        {
            mNode.nPing = (long) ((mEndTime - mBeginTime) * 1000);
        }
        
        [self runFinished];
    }
    JEDI_SYS_EndTry
}

- (void) onNetworkStateChanged:(NSInteger) state
{
    switch (state)
    {
        case JEDI_NETWORK_STATE_CONNECTED:
            [mNetwork sendInitNetworkWithType:10];
            mIsConnected = YES;
            break;
            
        case JEDI_NETWORK_STATE_SEND_CHECK:
            [mNetwork startToReadTestBody];
            break;
        
        case JEDI_NETWORK_STATE_DISCONNECTED:
            if(!mIsConnected)[self runFinished];
            break;
            
        default:
            break;
    }
}

@end
