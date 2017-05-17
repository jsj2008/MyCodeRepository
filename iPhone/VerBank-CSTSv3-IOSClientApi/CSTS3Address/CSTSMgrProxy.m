//
//  CSTSMgrProxy.m
//  IOSClientStation
//
//  Created by felix on 9/4/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "CSTSMgrProxy.h"
#import "JEDIDateTime.h"
#import "JEDIDataRW.h"
#import "JEDISystem.h"


#define JEDI_CMP_NONE       1
#define JEDI_CMP_CHECKING   2
#define JEDI_CMP_FINISHED   3

@interface CSTSMgrProxy ()
{
    JEDINetwork *   mNetwork;
    AddressNode *   mNode;
    NSString    *   mUserName;
    NSMutableArray* mNodeArray;
    
    id              mDelegate;
    int             mQueryState;
    BOOL            mIsConnected;
    BOOL            mIsMsgHeader;
    
    NSLock      *   mLock;
}

//----------------------------------------------------------------------
#pragma mark Private

-(void) runQuery;
-(void) runFinished;

-(void) handleConnect;
-(void) handleMsgHead:(NSData *) data;
-(void) handleMsgBody:(NSData *) data;

-(void) sendRequestMessage;

//----------------------------------------------------------------------
#pragma mark JEDINetworkDelegate

-(void) onReadMessageBody:(NSData *) data;
-(void) onNetworkStateChanged:(NSInteger) state;

@end


//----------------------------------------------------------------------
//
//
//----------------------------------------------------------------------
@implementation CSTSMgrProxy

- (id)  initWithNode:(AddressNode *)node userName:(NSString *)userName andDelegate:(id <CSTSMgrProxyDelegate>)delegate
{
    self = [super init];
    
    if(self != nil)
    {
        mNode = node;
        mUserName = userName;
        mNodeArray = nil;

        mDelegate   = delegate;
        mQueryState = JEDI_CMP_NONE;
        mIsConnected = NO;
        mIsMsgHeader = NO;
        
        mNetwork = [[JEDINetwork alloc] initNetworkWithAddress:node.strIp andPort:node.nPort];
        [mNetwork setNetworkDelegate:self];
        
        mLock = [[NSLock alloc] init];
    }
    
    return self;
}

//----------------------------------------------------------------------
- (void) dealloc
{
    if(mNodeArray != nil){
        [mNodeArray removeAllObjects];
    }
    
    mNetwork = nil;
    mNode = nil;
    mLock = nil;
    mNodeArray = nil;
}

//----------------------------------------------------------------------
- (void)  startQuery
{
    [NSThread detachNewThreadSelector:@selector(runQuery) toTarget:self withObject:nil];
}

//----------------------------------------------------------------------
- (void)  stopQuery
{
    if(mQueryState == JEDI_CMP_CHECKING)
    {
        [self runFinished];
    }
}

//----------------------------------------------------------------------
- (BOOL)  isNetworkOk
{
    return mIsConnected;
}

//----------------------------------------------------------------------
- (void)  runQuery
{
    mQueryState = JEDI_CMP_CHECKING;
    mIsConnected = NO;
    mIsMsgHeader = NO;
    [mLock lock];
    
    [mNetwork connectToServer];
    
    [mLock lock];
    [mLock unlock];
}

//----------------------------------------------------------------------
- (void)  runFinished
{
    [mLock unlock];
    mQueryState = JEDI_CMP_FINISHED;
    
    if(mNetwork != nil){
        [mNetwork disconnectFromServer];
        mNetwork = nil;
    }
    
    if([mDelegate respondsToSelector:@selector(didQueryFromServer:cstsProxy:)])
    {
        [mDelegate didQueryFromServer:mNodeArray cstsProxy:self];
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
        if(mIsMsgHeader){
            [self handleMsgHead:data];
        }else{
            [self handleMsgBody:data];
        }
    }
    JEDI_SYS_EndTry
}

- (void) onNetworkStateChanged:(NSInteger) state
{
    switch (state)
    {
        case JEDI_NETWORK_STATE_CONNECTED:
            [self handleConnect];
            break;
            
        case JEDI_NETWORK_STATE_DISCONNECTED:
            if(!mIsConnected)[self runFinished];
            break;
            
        default:
            break;
    }
}

-(void) handleConnect
{
    mIsConnected = YES;
    mIsMsgHeader = YES;
    
    [mNetwork startToReadBodyWithSize:CMP_NetMsgHeadSize];
    [self sendRequestMessage];
}

-(void) handleMsgHead:(NSData *) data
{
    JEDI_SYS_Try
    {
        if(data == nil || data.length != CMP_NetMsgHeadSize)
        {
            [self runFinished];
            return;
        }
        
        int nmType = [JEDIDataRW readIntFromData:data atIndex:0];
        int nmSize = [JEDIDataRW readIntFromData:data atIndex:4];
        
        if(nmType != CMP_NMTResponse010 || nmSize == 0)
        {
            [self runFinished];
            return;
        }
        
        //NSLog(@"||--> %02X, %d", nmType, nmSize);
        
        mIsMsgHeader = NO;
        [mNetwork startToReadBodyWithSize:nmSize];
    }
    JEDI_SYS_EndTry
}

-(void) handleMsgBody:(NSData *) data
{
    JEDI_SYS_Try
    {
        int rIndex = 0;
        BOOL isSuccess = [JEDIDataRW readBoolFromData:data atIndex:rIndex];
        rIndex += 1;
        
        if(isSuccess == NO){
            [self runFinished];
            return;
        }
        
        int nSize = [JEDIDataRW readIntFromData:data atIndex:rIndex];
        rIndex += 4;
        
        if(mNodeArray != nil){
            [mNodeArray removeAllObjects];
        }else if(nSize > 0){
            mNodeArray = [[NSMutableArray alloc] init];
        }
        
        int nStrSize = 0;
        AddressNode * node = nil;
        
        for(int i=0; i<nSize; i++)
        {
            node = [[AddressNode alloc] init];

            nStrSize = [JEDIDataRW readIntFromData:data atIndex:rIndex];
            rIndex += 4;
            
            node.strIp = [JEDIDataRW readStringFromData:data atIndex:rIndex bySize:nStrSize];
            rIndex += nStrSize;
            
            node.nPort = [JEDIDataRW readIntFromData:data atIndex:rIndex];
            rIndex += 4;
            
            [mNodeArray addObject:node];
            
            //NSLog(@"||--> %d %@  %d", nStrSize, node.strIp, node.nPort);
        }
        
    }
    JEDI_SYS_EndTry
    
    [self runFinished];
}

-(void) sendRequestMessage
{
    NSData * nameData = [mUserName dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData * muData = [[NSMutableData alloc] init];
    
    [JEDIDataRW writeInt:(int)nameData.length toData:muData];
    [muData appendData:nameData];
    
    if(mNetwork && [mNetwork isConnected])
    {
        [mNetwork writeData:muData withType:CMP_NMTRequest010];
    }
}



@end
