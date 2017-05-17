//
//  CSTSProxy.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/16/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "CSTSProxy.h"

#import "JEDISystem.h"
#import "JEDINetwork.h"

#import "CSTSPing.h"
#import "PingCaptain.h"

#import "BasicFixData.h"
#import "JsonData4Fix.h"
#import "JsonFactory.h"

#import "DataListener.h"

#import "IPOPErrCodeTable.h"
#import "CSTSTradeWaitObject.h"
#import "MTP4CommDataInterface.h"

#import "KickOutNode.h"
#import "KickBySysNode.h"
#import "QuoteList.h"
#import "QuoteData.h"
#import "QuoteSizeList.h"
#import "QuoteSizeData.h"

//#import "OP_TRADESERV5001.h"
//#import "OP_Web1001.h"
//#import "OP_Ctrl1001.h"

#import "IP_Ctrl1001.h"
#import "OP_Ctrl1001.h"

//#define CSTS_PROXY_DEBUGGING

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
@interface CSTSProxy ()
{
@private
    BOOL                mIsDestroy;
    BOOL                mIsLogined;
    
    long                mLastSendTime;
    id                  mDataListener;
    
    JEDINetwork         * mNetwork;
    PingCaptain         * mPingCaptain;
    
    NSMutableDictionary * mTradeDict;
    NSMutableDictionary * mQuoteDict;
    
    NSMutableArray      * mSendList; // list of AbstrctJsonData
    
    NSLock              * mTradeLock;
    NSLock              * mReadLock;
}


//----------------------------------------------------------------------
#pragma mark JEDINetworkDelegate

- (void)  onReadMessageBody:(NSData *) data;
- (void)  onNetworkStateChanged:(NSInteger) state;

//----------------------------------------------------------------------
#pragma mark Private

- (void)  startWhenNetworkInitFinished;

- (void)  clearNetwork;

- (OPFather *) checkTradeWithIp:(IPFather *) ip;

- (BOOL)  sendTradeObject:(IPFather *) ip;
- (BOOL)  sendFixData:(BasicFixData *) fixData;

- (id)    objectFromData:(NSData *) data;
- (void)  dealWithQuotes:(NSMutableArray *) quoteDataArray;
- (void)  dealWithJsonData:(AbstractJsonData *) data;

- (void)  tradeReturned:(OPFather *) op;
- (void)  onKickedOut:(KickOutNode *) node;
- (void)  onKickedOutBySys;

- (void)  setErrorToTradeWaitObject;

@end


//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
@implementation CSTSProxy
//----------------------------------------------------------------------
#pragma mark Init

- (id)      init
{
    self = [super init];
    
    if(self != nil)
    {
        mIsDestroy = NO;
        mIsLogined = NO;
        
        mDataListener = nil;
        
        mNetwork = nil;
        mPingCaptain = nil;
        
        mTradeDict = nil;
        mQuoteDict = nil;
        
        mSendList  = nil;
        mTradeLock = nil;
        mReadLock  = nil;
    }
    
    return self;
}

//----------------------------------------------------------------------
- (id)      initWithHost:(NSString *) ip  port:(NSInteger) port  listener:(id)listener
{
    self = [super init];
    
    if(self != nil)
    {
        JEDI_SYS_Try
        {
            mIsDestroy = NO;
            mIsLogined = NO;
            
            mDataListener = listener;
            mPingCaptain  = [[PingCaptain alloc] initWithDelegate:self];
            
            mTradeLock = [[NSLock alloc] init];
            mReadLock  = [[NSLock alloc] init];
            
            mSendList  = [[NSMutableArray alloc] init];
            
            mTradeDict = [[NSMutableDictionary alloc] init];
            mQuoteDict = [[NSMutableDictionary alloc] init];
            
            mNetwork = [[JEDINetwork alloc] initNetworkWithAddress:ip  andPort:port];
            [mNetwork setNetworkDelegate:self];
            [mNetwork connectToServer];
        }
        JEDI_SYS_EndTry
    }
    
    return self;
}

//----------------------------------------------------------------------
- (void) dealloc
{
    [self destroy];
}

//----------------------------------------------------------------------
- (BOOL)    waitInitFinished
{
    while(mNetwork)
    {
        if([mNetwork getNetworkState] == JEDI_NETWORK_STATE_INIT_FINISHED){
            return TRUE;
        }
        
        if([mNetwork getNetworkState] > JEDI_NETWORK_STATE_INIT_FINISHED){
            return FALSE;
        }
        
        [NSThread sleepForTimeInterval:0.10]; // 0.1 s
    }
    
    return NO;
}

//----------------------------------------------------------------------
- (BOOL)    isDestroy
{
    return mIsDestroy;
}

//----------------------------------------------------------------------
- (BOOL)    isNetInit
{
    return (mNetwork != nil && [mNetwork getNetworkState] == JEDI_NETWORK_STATE_INIT_FINISHED);
}

//----------------------------------------------------------------------
- (BOOL)    isLogined
{
    return mIsLogined;
}

//----------------------------------------------------------------------
- (void)    destroy
{
    if(!mIsDestroy)
    {
        [JEDISystem log:@"destroy -----> CSTSCaptain."];
        
        mIsDestroy = YES;
        [self setErrorToTradeWaitObject];
        
        if(mNetwork != nil){
            [self clearNetwork];
            mNetwork = nil;
        }
        
        if(mPingCaptain != nil){
            [mPingCaptain destory];
            mPingCaptain = nil;
        }
        
        if(mDataListener != nil){
            [mDataListener onNetLost];
            mDataListener = nil;
        }
        
        if(mTradeDict != nil){
            [mTradeDict removeAllObjects];
            mTradeDict = nil;
        }
        
        if(mQuoteDict != nil){
            [mQuoteDict removeAllObjects];
            mQuoteDict = nil;
        }
        
        if(mSendList != nil){
            [mSendList removeAllObjects];
            mSendList = nil;
        }
        
        mReadLock = nil;
        mTradeLock = nil;
    }
}

//----------------------------------------------------------------------
#pragma mark Trade

- (OPFather *)  doTrade:(IPFather *) ip
{
    NSLog(@"doTrade Thread = %p, MainThread = %p", [NSThread currentThread], [NSThread mainThread]);
    NSLog(@"ip name is %@", [ip getID]);
    //if(![NSThread isMainThread]){
    //    NSLog(@"=============== Do Trade Not IN MainThread !!!! ===============");
    //}
    
    [mTradeLock lock];
    OPFather * opFather = nil;
    
    JEDI_SYS_Try
    {
        opFather = [self checkTradeWithIp:ip];
        
        if(opFather != nil)
        {
            [mTradeLock unlock];
            return opFather;
        }
        
        CSTSTradeWaitObject * waitor = [[CSTSTradeWaitObject alloc] initWithIp:ip];
        [mTradeDict setValue:waitor forKey:[waitor getHashCode]];
        
        [self sendTradeObject:ip];
        
        //        if([[ip getID] isEqualToString:@"TRADESERV5001"]){
        if([[ip getID] isEqualToString:@"Ctrl1001"]){
            opFather = [waitor waitTradeForTime:(60 * 1000)];
        }else{
            opFather = [waitor waitTrade];
        }
        
        [mTradeDict removeObjectForKey:[waitor getHashCode]];
        
        //        if(!mIsLogined && [[ip getID] isEqualToString:@"TRADESERV5001"] && [opFather isSuccessed])
        if(!mIsLogined && [[ip getID] isEqualToString:@"Ctrl1001"] && [opFather isSuccessed])
        {
            //
            // set login flag if trade success
            //
            //            if([opFather isKindOfClass:[OP_TRADESERV5001 class]])
            if([opFather isKindOfClass:[OP_Ctrl1001 class]])
            {
                //                OP_TRADESERV5001 * op5001 = (OP_TRADESERV5001 *)opFather;
                //                mIsLogined = ([op5001 getResult] == USERIDENTIFY_RESULT_SUCCEED);
                OP_Ctrl1001 *op1001 = (OP_Ctrl1001 *)opFather;
                mIsLogined = ([op1001 getResult] == USERIDENTIFY_RESULT_SUCCEED);
            }
        }
    }
    JEDI_SYS_EndTry
    
    [mTradeLock unlock];
    return opFather;
}

//----------------------------------------------------------------------
- (void)        sendObject:(AbstractJsonData *) obj
{
    if(mIsDestroy == NO && obj != nil)
    {
        JsonData4Fix * fixData = [[JsonData4Fix alloc] init];
        
        [fixData setJsonData:obj];
        fixData.isEncrypt = YES;
        fixData.isZip = YES;
        
        [self sendFixData:fixData];
    }
}

//----------------------------------------------------------------------
#pragma mark PingDealerableDelegate

- (BOOL) sendPing:(CSTSPing *)ping
{
    if(mIsDestroy || !mIsLogined || ping == nil){
        return NO;
    }
    
    JsonData4Fix * fixData = [[JsonData4Fix alloc] init];
    
    [fixData setJsonData:ping];
    fixData.isEncrypt = NO;
    fixData.isZip = NO;
    
    return [self sendFixData:fixData];
}

- (void) onPingResult:(PingResult *) pingResult
{
    if(mDataListener && [mDataListener respondsToSelector:@selector(onPing:avePing:lostPerc:)])
    {
        [mDataListener onPing:pingResult.TimeOfPing avePing:pingResult.AveragePing lostPerc:pingResult.LostPerc];
        
        if(pingResult.IsTimeout && [mDataListener respondsToSelector:@selector(onPingTimeOut)]){
            [mDataListener onPingTimeOut];
        }
    }
}


//----------------------------------------------------------------------
#pragma mark JEDINetworkDelegate

- (void) onReadMessageBody:(NSData *) data
{
    [mReadLock lock];
    
    JEDI_SYS_Try
    {
        id obj = [self objectFromData:data];
        
        if(obj != nil && [obj isKindOfClass:[JsonData4Fix class]])
        {
            JsonData4Fix * fixJsonData = obj;
            AbstractJsonData * jsonData = [fixJsonData getJsonData];
            
#ifdef CSTS_PROXY_DEBUGGING
            if([jsonData isKindOfClass:[OP_Web1001 class]])
            {
                [JEDISystem log:[fixJsonData getJsonString]];
                [JEDISystem log:[jsonData getJsonString]];
            }
#endif
            
            if([jsonData isKindOfClass:[QuoteList class]])
            {
#ifdef CSTS_PROXY_DEBUGGING
                [JEDISystem log:@"CSTSProxy.onReadMessageBody ---> QuoteList"];
#endif
                
                QuoteList * quoteList = (QuoteList *) jsonData;
                [self dealWithQuotes:[quoteList getQuotes]];
            }
            else if([jsonData isKindOfClass:[QuoteSizeList class]])
            {
#ifdef CSTS_PROXY_DEBUGGING
                [JEDISystem log:@"CSTSProxy.onReadMessageBody ---> QuoteSizeList"];
#endif
                
                if(mDataListener != nil && [mDataListener respondsToSelector:@selector(onVolumnRec:)]){
                    QuoteSizeList * sizeList = (QuoteSizeList *)jsonData;
                    [mDataListener onVolumnRec:[sizeList getSizes]];
                }
            }
            else
            {
#ifdef CSTS_PROXY_DEBUGGING
                [JEDISystem log:@"CSTSProxy.onReadMessageBody ---> " withObject:NSStringFromClass([jsonData class])];
#endif
                
                [self dealWithJsonData:jsonData];
            }
        }
    }
    JEDI_SYS_EndTry
    
    [mReadLock unlock];
}

- (void) onNetworkStateChanged:(NSInteger) state
{
    NSLog(@"CSTSProxy --> NState: %d", (int)state);
    
    switch (state)
    {
        case JEDI_NETWORK_STATE_CONNECTED:
            [mNetwork sendInitNetworkWithType:7];
            break;
            
        case JEDI_NETWORK_STATE_SEND_CHECK:
            [mNetwork sendRsaPublicKey];
            break;
            
        case JEDI_NETWORK_STATE_SEND_RSAKEY:
            [mNetwork startToReadHeader];
            break;
            
        case JEDI_NETWORK_STATE_INIT_FINISHED:
            [self startWhenNetworkInitFinished];
            break;
            
        case JEDI_NETWORK_STATE_DISCONNECTED:
            [self destroy];
            break;
            
        default:
            break;
    }
}

//----------------------------------------------------------------------
#pragma mark Private

- (void)  startWhenNetworkInitFinished
{
    if(mPingCaptain != nil){
        [mPingCaptain initPingCaptain];
    }
}

- (void)  clearNetwork
{
    if(mNetwork != nil && [mNetwork isConnected]){
        [mNetwork disconnectFromServer];
    }
}

- (OPFather *) checkTradeWithIp:(IPFather *) ip
{
    if(ip == nil)
    {
        OPFather * op = [[OPFather alloc] initWithIp:ip];
        [op setSuccess:NO];
        [op setErrCode:ERR_Unknown];
        [op setErrMessage:@"ip is nil, it's invalid."];
        return op;
    }
    
    //    if([[ip getID] isEqualToString:@"TRADESERV5001"])
    if([[ip getID] isEqualToString:@"Ctrl1001"])
    {
        if(mIsLogined){
            OPFather * op = [[OPFather alloc] initWithIp:ip];
            [op setSuccess:NO];
            [op setErrCode:ERR_Unknown];
            [op setErrMessage:@"Already logined."];
            return op;
        }
    }
    else if(!mIsLogined || mIsDestroy)
    {
        OPFather * op = [[OPFather alloc] initWithIp:ip];
        [op setSuccess:NO];
        [op setErrCode:ERR_Unknown];
        [op setErrMessage:@"Not login yet, or proxy already destroy!"];
        return op;
    }
    
    return nil;
}

- (BOOL)  sendTradeObject:(IPFather *) ip
{
    if(mIsDestroy){
        return NO;
    }
    
    JsonData4Fix * fixData = [[JsonData4Fix alloc] init];
    
    [fixData setJsonData:ip];
    fixData.isEncrypt = YES;
    fixData.isZip = YES;
    
    return [self sendFixData:fixData];
    
}

- (BOOL)  sendFixData:(BasicFixData *) fixData
{
    JEDI_SYS_Try
    {
        if(mNetwork != nil && [mNetwork isConnected])
        {
            [mNetwork writeData:[fixData format]];
            return YES;
        }
    }
    JEDI_SYS_EndTry
    
    return NO;
}

- (id)    objectFromData:(NSData *) data
{
    JEDI_SYS_Try
    {
        if(data == nil || data.length < FMS_LENGTH_MSINFO){
            [JEDISystem log:@"CSTSProxy.objectFromData, invalid message body."];
            return nil;
        }
        
        const Byte * dataByte = [data bytes];
        
        int dataType  = [JEDISystem intFromBuffer:dataByte withLength:2];
        int isZip     = [JEDISystem intFromBuffer:(dataByte + 2) withLength:1];
        int isEncrypt = [JEDISystem intFromBuffer:(dataByte + 3) withLength:1];
        
        NSData * msgData = [NSData dataWithBytes:(dataByte + 4) length:([data length] - FMS_LENGTH_MSINFO)];
        BasicFixData * fixData = nil;
        
        if(dataType == FI_DATATYPE_ECHO){
        }
        else if(dataType == FI_DATATYPE_BYTE){
        }
        else if(dataType == FI_DATATYPE_JSON){
            fixData = [[JsonData4Fix alloc] initWithType:dataType];
        }
        
        fixData.isEncrypt = isEncrypt;
        fixData.isZip = isZip;
        
        [fixData setData:msgData];
        [fixData parse];
        
        return fixData;
    }
    JEDI_SYS_EndTry
    
    return nil;
}

- (void)  dealWithQuotes:(NSMutableArray *) quoteDataArray
{
    if(mQuoteDict == nil){
        [JEDISystem log:@"CSTSProxy.dealWithQuotes, Invalid QuoteDictionary!"];
        return;
    }
    
    JEDI_SYS_Try
    {
        @synchronized(mQuoteDict)
        {
            for(int i=0; i<quoteDataArray.count; i++)
            {
                QuoteData * data = [quoteDataArray objectAtIndex:i];
                [mQuoteDict setObject:data forKey:[data getInstrument]];
            }
        }
        
        [NSThread detachNewThreadSelector:@selector(dispatchQuote) toTarget:self withObject:nil];
    }
    JEDI_SYS_EndTry
}

- (void)  dealWithJsonData:(AbstractJsonData *) data
{
    JEDI_SYS_Try
    {
        if(data == nil){
            return;
        }
        
        if([data isKindOfClass:[CSTSPing class]])
        {
            if(mPingCaptain != nil){
                [mPingCaptain onPingReturn:(CSTSPing *)data];
            }
        }
        else if([data isKindOfClass:[OPFather class]])
        {
            [self tradeReturned:(OPFather *)data];
        }
        else if([data isKindOfClass:[InfoFather class]])
        {
            [self dealWithInfoData:(InfoFather *)data];
        }
        else if([data isKindOfClass:[KickOutNode class]])
        {
            [self onKickedOut:(KickOutNode *)data];
        }
        else if([data isKindOfClass:[KickBySysNode class]])
        {
            [self onKickedOutBySys];
        }
        else
        {
            [JEDISystem log:@"CSTSProxy.dealWithJsonData, Error --> " withObject:data];
        }
    }
    JEDI_SYS_EndTry
}

- (void)  dealWithInfoData:(InfoFather *) data
{
    if(mDataListener != nil && [mDataListener respondsToSelector:@selector(onInforRec:)])
    {
        [NSThread detachNewThreadSelector:@selector(onInforRec:) toTarget:mDataListener withObject:data];
    }
}

- (void)  dispatchQuote
{
#ifdef CSTS_PROXY_DEBUGGING
    [JEDISystem log:@"CSTSProxy.dispatchQuote, ------- Running"];
#endif
    
    NSMutableArray * quotes = nil;
    
    @synchronized(mQuoteDict)
    {
        if(mQuoteDict != nil && mQuoteDict.count > 0)
        {
            quotes = [[NSMutableArray alloc] init];
            
            NSEnumerator *enumerator = [mQuoteDict objectEnumerator];
            id value;
            
            while ((value = [enumerator nextObject]))
            {
                [quotes addObject:value];
            }
            
            [mQuoteDict removeAllObjects];
        }
    }
    
    if(quotes != nil && mDataListener != nil)
    {
        if([mDataListener respondsToSelector:@selector(onQuoteRec:)]){
            [mDataListener onQuoteRec:quotes];
        }
    }
}

- (void)  tradeReturned:(OPFather *) op
{
    CSTSTradeWaitObject * waitor = [mTradeDict valueForKey:[op getOperateId]];
    
    if(waitor != nil){
        [waitor tradeReturn:op];
    }else{
        [JEDISystem log:@"Unknow CSTS wait boject." withObject:op];
    }
}

- (void)  onKickedOut:(KickOutNode *) node
{
    if(mDataListener != nil){
        [mDataListener onKickedOut:node];
    }
    
    mDataListener = nil;
    
    [self destroy];
}

- (void)  onKickedOutBySys
{
    if(mDataListener != nil){
        [mDataListener onKickedOutBySys];
    }
    
    mDataListener = nil;
    
    [self destroy];
}

- (void)  setErrorToTradeWaitObject
{
    NSEnumerator *enumerator = [mTradeDict objectEnumerator];
    CSTSTradeWaitObject * waitor;
    
    while ((waitor = [enumerator nextObject])) {
        [waitor setError];
    }
}

@end





