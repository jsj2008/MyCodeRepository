//
//  JEDINetwork.m
//  JEDI-IOSClientApi-Socket
//
//  Created by felix on 7/9/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JEDINetwork.h"

#import "GCDAsyncSocket.h"

#import "JEDISecret.h"
#import "JEDIZip.h"

#import "JEDISystem.h"
//#import "JEDITestCode.h"
#import "JEDIDataRW.h"

//#define JEDI_NETWORK_DEBUGGING
//#define JEDI_NETWORK_DEBUGINFO


//===========================================================================================
@interface JEDINetwork ()
{
@private
    GCDAsyncSocket  * mAsyncSocket;
    NSLock          * mWriteLocker;
    
    id                mNetworkDelegate;
    
    NSString        * mServerAddress;
    NSInteger         mServerPort;
    NSTimeInterval    mNetTimeout;
    
    NSInteger         mNetState;
}

- (void) initAsyncSocket;
- (void) setNetworkState:(NSInteger) state;
- (void) postStateChangedNotify;

- (NSData *) getMsgHeaderWithSize:(NSInteger) size;
- (NSData *) getMsgHeaderWithType:(NSInteger) type andSize:(NSInteger) size;

#pragma mark Message handler

- (void) handleMessageHeader:(NSData *)nsData;
- (void) handleMessageBody:(NSData *)nsData;
- (void) handleMessageTestBody:(NSData *)nsData;

- (void) handleDefaultMsg:(NSData *)nsData;

- (void) handleGetAESKeyMsg:(NSData *)nsData;

@end


@implementation JEDINetwork
//===========================================================================================
#pragma mark -
#pragma mark Initialize

- (id) init
{
    self = [super init];
    
    if(self != nil)
    {
        mServerAddress = JEDI_DEFAULT_CSTS_IP;
        mServerPort    = JEDI_DEFAULT_CSTS_PORT;
        mNetTimeout    = JEDI_DEFAULT_TIMEOUT;

        [self initAsyncSocket];
    }
    
    return self;
}

- (id) initNetworkWithAddress:(NSString *)ip andPort:(NSInteger) port
{
    self = [super init];
    
    if(self != nil)
    {
        mServerAddress = [ip copy];
        mServerPort    = port;
        mNetTimeout    = JEDI_DEFAULT_TIMEOUT;
    
        [self initAsyncSocket];
    }
    
    return self;
}

- (void) dealloc
{
#ifdef JEDI_NETWORK_DEBUGINFO
    [JEDISystem log:@"dealloc -----> JEDINetwork."];
#endif
    
    if(mAsyncSocket != nil)
    {
        JEDI_SYS_Try
        {
            if([mAsyncSocket isConnected]) [mAsyncSocket disconnect];
            [mAsyncSocket synchronouslySetDelegate:nil delegateQueue:nil];
        }
        JEDI_SYS_EndTry
    }
    
    mAsyncSocket = nil;
    mNetworkDelegate = nil;
    mServerAddress = nil;
    mWriteLocker = nil;
}

//===========================================================================================
#pragma mark Configration

- (void) setTimeout:(NSTimeInterval) time
{
    mNetTimeout = time;
}

- (void) setNetworkDelegate:(id) delegate
{
    mNetworkDelegate = delegate;
}

- (void) setNetworkAddress:(NSString *)ip andPort:(NSInteger) port
{
    mServerAddress = [ip copy];
    mServerPort = port;
}

- (BOOL) isConnected
{
    return (mAsyncSocket != nil) && [mAsyncSocket isConnected];
}

- (NSInteger) getNetworkState
{
    return mNetState;
}

//===========================================================================================
#pragma mark Connect/Disconnect

- (BOOL) connectToServer
{
    if(JEDI_NETWORK_STATE_INITIALIZED != mNetState && JEDI_NETWORK_STATE_DISCONNECTED != mNetState){
        return NO;
    }
    
    if(mAsyncSocket == nil){
        [JEDISystem log:@"JEDINetwork.connectToServer, invalid socket or network lock."];
        return NO;
    }

    JEDI_SYS_Try
    {
        NSError *error = nil;
        [mAsyncSocket setPreferIPv4OverIPv6:NO];
        if (![mAsyncSocket connectToHost:mServerAddress onPort:(UInt16)mServerPort withTimeout:mNetTimeout error:&error])
        {
            [JEDISystem log:@"JEDINetwork.connectToServer, error: " withObject:error];
            return NO;
        }
        
        [self setNetworkState:JEDI_NETWORK_STATE_CONNECTING];
        return YES;
    }
    JEDI_SYS_EndTry
    
    return NO;
}

- (BOOL) connectToServerWithAddress:(NSString *)ip andPort:(NSInteger) port
{
    [self setNetworkAddress:ip andPort:port];
    return [self connectToServer];
}

- (BOOL) disconnectFromServer
{
    if(mAsyncSocket != nil && [mAsyncSocket isConnected])
    {
        JEDI_SYS_Try
        {
            [mAsyncSocket disconnect];
            [self setNetworkState:JEDI_NETWORK_STATE_DISCONNECTING];
            return YES;
        }
        JEDI_SYS_EndTry
    }
    
    return NO;
}

- (BOOL) disconnectAfterReadingAndWritting
{
    if(mAsyncSocket != nil && [mAsyncSocket isConnected])
    {
        JEDI_SYS_Try
        {
            [mAsyncSocket disconnectAfterReadingAndWriting];
            [self setNetworkState:JEDI_NETWORK_STATE_DISCONNECTING];
            return YES;
        }
        JEDI_SYS_EndTry
    }
    
    return NO;
}

//===========================================================================================
#pragma mark Write

- (BOOL)        writeData:(NSData *) data
{
    if(data == nil || mWriteLocker == nil){
        return NO;
    }
    //
    // 用锁实现线程同步，方法2
    //
    [mWriteLocker lock];
    
    JEDI_SYS_Try
    {
        NSData *msgHearder = [self getMsgHeaderWithSize:[data length]];
        
        BOOL bHeader  = [self writeData:msgHearder withTag:JEDI_NWTAG_WRITE_HEADER];
        BOOL bMsgBody = [self writeData:data withTag:JEDI_NWTAG_WRITE_MSGBODY];
        
        [mWriteLocker unlock];
        return bHeader && bMsgBody;
    }
    JEDI_SYS_EndTry
    
    [mWriteLocker unlock];
    return NO;
}

- (BOOL)        writeData:(NSData *) data withType:(int) type
{
    if(type == 0 || data == nil || mWriteLocker == nil){
        return NO;
    }
    
    [mWriteLocker lock];
    JEDI_SYS_Try
    {
        NSData *msgHearder = [self getMsgHeaderWithType: type andSize:[data length]];
        
        BOOL bHeader  = [self writeData:msgHearder withTag:JEDI_NWTAG_WRITE_HEADER];
        BOOL bMsgBody = [self writeData:data withTag:JEDI_NWTAG_WRITE_MSGBODY];
        
        [mWriteLocker unlock];
        return bHeader && bMsgBody;
    }
    JEDI_SYS_EndTry
    
    [mWriteLocker unlock];
    return NO;
}

- (BOOL)       writeData:(NSData *) data withTag:(NSInteger) tag
{
    if(mAsyncSocket == nil || ![mAsyncSocket isConnected]){
        return NO;
    }
    
    JEDI_SYS_Try
    {
        [mAsyncSocket writeData:data withTimeout:mNetTimeout tag:tag];
        return YES;
    }
    JEDI_SYS_EndTry
    
    return NO;
}

//===========================================================================================

#pragma mark Read Setting

//
// Init network wity type 3 normaly, in case of networking testing it should be 10
//
- (void) sendInitNetworkWithType:(int) type
{
    //
    // pre-check-buffer + connect type
    //
//    Byte precheckbuf[] = {97, 65, 108, 111, 110, 25, type};
    Byte precheckbuf[] = { 1, 10, 2, 11, 205, type};
    NSData *nsCheck = [NSData dataWithBytes:precheckbuf length:sizeof(precheckbuf)];
    [self writeData:nsCheck withTag:JEDI_NWTAG_WRITE_NET_CHECK];
    
//    Byte connetType = (Byte)type;
//    NSData *nsType = [NSData dataWithBytes:&connetType length:1];
//    [self writeData:nsType withTag:JEDI_NWTAG_WRITE_NET_CTYPE];
    
    [self setNetworkState:JEDI_NETWORK_STATE_SEND_CHECK];
}

- (void) sendRsaPublicKey
{
    NSString* strPublicKey = [[JEDISecret defaultSecret] getRSAPublicKey];
    
    NSData* msgBody = [strPublicKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData* msgHeader = [self getMsgHeaderWithSize:[msgBody length]];
    
    [self writeData:msgHeader withTag:JEDI_NWTAG_WRITE_HEADER];
    [self writeData:msgBody withTag:JEDI_NWTAG_WRITE_RSA_KEY];
    
    [self setNetworkState:JEDI_NETWORK_STATE_SEND_RSAKEY];
}

//
// Normaly, we start to read message from server.
//
- (void)        startToReadHeader
{
    [mAsyncSocket readDataToLength:JEDI_NWSIZE_READ_HEADER withTimeout:-1 tag:JEDI_NWTAG_READ_HEADER];
}

//
// In case of network testing, we start to read test body from server.
//
- (void)        startToReadTestBody
{
    [mAsyncSocket readDataToLength:JEDI_NWSIZE_READ_TESTBODY withTimeout:JEDI_DEFAULT_TIMEOUT tag:JEDI_NWTAG_READ_TESTBODY];
}

//
// In case of network normaly, we start to read message body with size.
//
- (void)        startToReadBodyWithSize:(int) size
{
    [mAsyncSocket readDataToLength:size withTimeout:JEDI_DEFAULT_TIMEOUT tag:JEDI_NWTAG_READ_BODY];
}

//===========================================================================================
#pragma mark Private Functions

- (void) initAsyncSocket
{
    JEDI_SYS_Try
    {
        dispatch_queue_t delegateQueue = dispatch_queue_create([JEDI_NETWORK_DELEGATE_QUEUE UTF8String], NULL);
        
        mAsyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:delegateQueue];
        mWriteLocker = [[NSLock alloc] init];
        
        [self setNetworkState:JEDI_NETWORK_STATE_INITIALIZED];
    }
    JEDI_SYS_EndTry
}

- (void) setNetworkState:(NSInteger) state
{
    if(mNetState == state){
        return;
    }
    
    mNetState = state;
    
    if(mNetworkDelegate && [mNetworkDelegate respondsToSelector:@selector(onNetworkStateChanged:)]){
        [mNetworkDelegate onNetworkStateChanged:mNetState];
    }else{
        [self postStateChangedNotify];
    }
}

- (void) postStateChangedNotify
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JEDI_NETWORK_STATE_CHANGED object:self];
}

- (NSData *) getMsgHeaderWithSize:(NSInteger) size
{
    NSString *strSize = [NSString stringWithFormat:@"%08d", ((int)size+8)];
    NSData *sizeData = [strSize dataUsingEncoding:NSUTF8StringEncoding];
    return sizeData;
}

- (NSData *) getMsgHeaderWithType:(NSInteger) type andSize:(NSInteger) size
{
    NSMutableData * muData = [[NSMutableData alloc] init];

    //[muData appendBytes:&type length:sizeof(type)];
    //[muData appendBytes:&size length:sizeof(size)];
    
    [JEDIDataRW writeInt:(int)type toData:muData];
    [JEDIDataRW writeInt:(int)size toData:muData];
    return muData;
}

//-------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Delegate
//-------------------------------------------------------------------------------------------
- (dispatch_queue_t) newSocketQueueForConnectionFromAddress:(NSData *)address onSocket:(GCDAsyncSocket *)sock
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.newSocketQueueForConnectionFromAddress"];
#endif
    //
    // it looks don't handle it in client.
    //
    return dispatch_get_main_queue();
}

//-------------------------------------------------------------------------------------------
- (void) socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:didAcceptNewSocket"];
#endif
}

//-------------------------------------------------------------------------------------------
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:didConnectToHost, " withObject:host];
#endif
    
    [self setNetworkState:JEDI_NETWORK_STATE_CONNECTED];
}

//-------------------------------------------------------------------------------------------
- (void) socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:didReadData"];
#endif
    
    if(tag == JEDI_NWTAG_READ_HEADER)
    {
        [self handleMessageHeader:data];
    }
    else if(tag == JEDI_NWTAG_READ_BODY)
    {
        [self handleMessageBody:data];
    }
    else if(tag == JEDI_NWTAG_READ_TESTBODY)
    {
        [self handleMessageTestBody:data];
    }
    else if(tag == JEDI_NWTAG_READ_DEFAULT)
    {
        [self handleDefaultMsg:data];
    }
}

//-------------------------------------------------------------------------------------------
- (void) socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:didReadPartialDataOfLength"];
#endif
}

//-------------------------------------------------------------------------------------------
- (void) socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:didWriteDataWithTag"];
#endif
    
    if(tag == JEDI_NWTAG_WRITE_NET_CTYPE){//JEDI_NWTAG_WRITE_NET_CHECK
        //[self sendRsaPublicKey];
    }
    else if(tag == JEDI_NWTAG_WRITE_RSA_KEY){
        [self setNetworkState:JEDI_NETWORK_STATE_GET_AES_KEY];
    }
}

//-------------------------------------------------------------------------------------------
- (void) socket:(GCDAsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:didWritePartialDataOfLength"];
#endif
}

//-------------------------------------------------------------------------------------------
- (NSTimeInterval) socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
                  elapsed:(NSTimeInterval)elapsed
                bytesDone:(NSUInteger)length
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:shouldTimeoutReadWithTag"];
#endif
    return -1;
}

//-------------------------------------------------------------------------------------------
- (NSTimeInterval) socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag
                  elapsed:(NSTimeInterval)elapsed
                bytesDone:(NSUInteger)length
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socket:shouldTimeoutWriteWithTag"];
#endif
    return -1;
}

//-------------------------------------------------------------------------------------------
- (void) socketDidCloseReadStream:(GCDAsyncSocket *)sock
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socketDidCloseReadStream"];
#endif
}

//-------------------------------------------------------------------------------------------
- (void) socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    //[JEDISystem log:@"JEDINetwork.socketDidDisconnect, error info: " withObject:err];
    [self setNetworkState:JEDI_NETWORK_STATE_DISCONNECTED];
}

//-------------------------------------------------------------------------------------------
- (void) socketDidSecure:(GCDAsyncSocket *)sock
{
#ifdef JEDI_NETWORK_DEBUGGING
    [JEDISystem log:@"JEDINetwork.socketDidSecure:"];
#endif
}

//-------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Message Handler
//-------------------------------------------------------------------------------------------
- (void) handleMessageHeader:(NSData *)nsData
{
    NSString *strSize = [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
    
    NSNumber *numSize = [NSNumber numberWithInteger:[strSize integerValue]];
#ifdef JEDI_NETWORK_DEBUGINFO
    [JEDISystem log:@"JEDINetwork.handleMessageHeader, size = @" withObject:numSize];
#endif
    
    [mAsyncSocket readDataToLength:([numSize integerValue] - 8) withTimeout:mNetTimeout tag:JEDI_NWTAG_READ_BODY];
}

- (void) handleMessageBody:(NSData *)nsData
{
    JEDI_SYS_Try
    {
        if([self getNetworkState] == JEDI_NETWORK_STATE_GET_AES_KEY)
        {
            [self handleGetAESKeyMsg:nsData];
        }
        else if(mNetworkDelegate && [mNetworkDelegate respondsToSelector:@selector(onReadMessageBody:)])
        {
            [mNetworkDelegate onReadMessageBody:nsData];
        }
        
        [mAsyncSocket readDataToLength:JEDI_NWSIZE_READ_HEADER withTimeout:-1 tag:JEDI_NWTAG_READ_HEADER];
    }
    JEDI_SYS_EndTry
}

- (void) handleMessageTestBody:(NSData *)nsData
{
    JEDI_SYS_Try
    {
        if(mNetworkDelegate && [mNetworkDelegate respondsToSelector:@selector(onReadMessageBody:)])
        {
            [mNetworkDelegate onReadMessageBody:nsData];
        }
    }
    JEDI_SYS_EndTry
}

- (void) handleDefaultMsg:(NSData *)nsData
{
    NSString *strResponse = [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
    [JEDISystem log:@"DefaultMsg: " withObject:strResponse];
    
    [mAsyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:JEDI_NWTAG_READ_DEFAULT];
}

- (void) handleGetAESKeyMsg:(NSData *)nsData
{
    BOOL bKeyResult = [[JEDISecret defaultSecret] setAESKeyWithData:nsData];
    
    if(bKeyResult){
        [self setNetworkState:JEDI_NETWORK_STATE_INIT_FINISHED];
    }else{
        [JEDISystem log:@"JEDINetwork.handleGetAESKeyMsg, error: AES key invalid!"];
    }
}

@end
