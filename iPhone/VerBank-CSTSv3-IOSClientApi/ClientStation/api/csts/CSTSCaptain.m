//
//  CSTSCaptain.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "CSTSCaptain.h"
#import "QuoteSizeData.h"
#import "JEDISystem.h"
#import "JEDIDateTime.h"

#import "ClientAPI.h"
#import "PingCaptain.h"

#import "API_IDEventCaptain.h"
#import "API_IDEvent_NameInterface.h"
#import "APIDoc.h"
#import "QuoteDataStore.h"

CSTSCaptain * gs_CSTSCaptain_Instance = nil;



@implementation CSTSCaptain

//------------------------------------------------------------------------------------
#pragma mark Singleton
//------------------------------------------------------------------------------------
+ (CSTSCaptain *)   getInstance
{
    if(gs_CSTSCaptain_Instance == nil){
        gs_CSTSCaptain_Instance = [[CSTSCaptain alloc] init];
    }
    
    return gs_CSTSCaptain_Instance;
}

//------------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------------
- (id)          init {
    
    if(self = [super init]) {
        //        _attrName_CMD = @"ATTRNAME_CAD";
        //        _attrQuerySystem = @"ATTRNAME_QUERYSYSTEM";
        //        _attrName_ID = @"ATTRNAME_ID";
        _isInited = false;
    }
    
    return self;
}

//------------------------------------------------------------------------------------
- (void)        dealloc {
    [self destroy];
}

//------------------------------------------------------------------------------------
- (BOOL)        initWithAddressCaptain:(AddressCaptain *) captain addressNode:(AddressNode *) node
{
    _isInited = false;
    
    if(_proxy != nil){
        [_proxy destroy];
        _proxy = nil;
    }
    
    _proxy = [[CSTSProxy alloc] initWithHost:node.strIp port:node.nPort listener:self];
    _isInited = [_proxy waitInitFinished];
    
    return _isInited;
}

//------------------------------------------------------------------------------------
- (BOOL)        isNetOK
{
    return (_proxy != nil) && [_proxy isLogined];
}

//------------------------------------------------------------------------------------
- (void)        doDispachQuote:(QuoteData *)quoteData{
    
    if (quoteData != nil) {
        [[APIDoc getSystemDocCaptain] setQuote:quoteData];
        [self doFixTradeAnOrder:quoteData];
        long long accountID = [[ClientAPI getInstance] getAccount];
        if (accountID > 0) {
            JEDI_SYS_Try{
                InstrumentUtil *instrumentUtil = [APIDoc getInstrumentUtil:[quoteData getInstrument]];
                if (instrumentUtil != nil) {
                    JEDI_SYS_Try{
                        CDS_PriceSnapShot *pss = [instrumentUtil getPriceSnapShotWithAccountID:accountID];
                        //                    }JEDI_SYS_EndTry
                        //                    [API_IDEventCaptain fireEventChanged:DATA_ON_NewQuote eventData:pss];
                        // quote data store
                        
                        //                    JEDI_SYS_Try{
                        if ([QuoteDataStore getInited]) {
                            [[QuoteDataStore getInstance] recQuoteData:pss];
                            //                            NSLog(@"%@, %lld", [pss instrumentName], [pss snapshotTime]);
                        }
                    }JEDI_SYS_EndTry
                    
                }
            }JEDI_SYS_EndTry
        }
    }
    
}

//------------------------------------------------------------------------------------
- (OPFather *)  trade:(IPFather *)ip
{
    if (!_isInited || _proxy == nil) {
        OPFather *opFather = [[OPFather alloc] initWithIp:ip];
        [opFather setSuccess:false];
        [opFather setErrCode:@"NetLost"];
        [opFather setErrMessage:@"proxy lost net connection"];
        return opFather;
    }
    OPFather *opFather = [_proxy doTrade:ip];
    return opFather;
}

//------------------------------------------------------------------------------------
- (void)        sendObject:(AbstractJsonData *)obj{
    if(_proxy != nil && [_proxy isNetInit]){
        [_proxy sendObject:obj];
    }
}

//------------------------------------------------------------------------------------
- (void)        destroy
{
    _isInited = false;
    
    [JEDISystem log:@"destroy -----> CSTSCaptain."];
    
    if(_proxy != nil){
        [_proxy destroy];
    }
    
    _proxy = nil;
    
    //    _attrName_CMD = nil;
    //    _attrQuerySystem = nil;
    _attrName_ID = nil;
}

//------------------------------------------------------------------------------------
#pragma mark DataListener
//------------------------------------------------------------------------------------

- (void) onQuoteRec:(NSMutableArray *)quote{
    for (int i=0; i<[quote count]; i++){
        QuoteData *quoteData= [quote objectAtIndex:i];
        [self doDispachQuote:quoteData];
    }
}

//------------------------------------------------------------------------------------
- (void) onVolumnRec:(NSMutableArray *)quoteSize{
    //    if(quoteSize) [quoteSize removeAllObjects];
}

//------------------------------------------------------------------------------------
- (void) onInforRec:(InfoFather *) info{
    [[InfoCaptain getInstance] onInfo:info];
}

//------------------------------------------------------------------------------------
- (void) onNetLost{
    if(_isInited){
        NetInfoNode * info = [[NetInfoNode alloc] init];
        [info setIpAddress:[[ClientAPI getInstance] getCurrentAddress].strIp];
        [info setPort:[[ClientAPI getInstance] getCurrentAddress].nPort];
        [info setTime:[JEDIDateTime currentMillis]];
        [info setType:NetInfoNode_TYPE_LOST];
        [info setReason:NetInfoNode_REASON_NETLOST];
        
        [self destroy];
        
        if([ClientAPI getInstance] != nil){
            [API_IDEventCaptain fireEventChanged:NAME_NAME_ON_NET_LOST eventData:info];
            [API_IDEventCaptain fireEventChanged:NAME_ON_DO_RECONNECT eventData:nil];
        }
    }
}

//------------------------------------------------------------------------------------
- (void) onPing:(long)ping avePing:(long)avePing lostPerc:(long)lostPerc
{
    [API_IDEventCaptain fireEventChanged:OTHER_ON_PING eventData:nil];
}

//------------------------------------------------------------------------------------
- (void) onKickedOut:(KickOutNode *)kicknode{
    //    if (_isInited){
    [API_IDEventCaptain fireEventChanged:OTHER_ON_KICKOUT eventData:kicknode];
    //    }
}

//------------------------------------------------------------------------------------
- (void) onKickedOutBySys{
    //    if (_isInited){
    [API_IDEventCaptain fireEventChanged:OTHER_ON_KICK_BY_SYS eventData:nil];
    //    }
}

//------------------------------------------------------------------------------------
- (void) onPingTimeOut
{
    [[PingCaptain getInstance] clearTimeoutRecords];
    [JEDISystem log:@"-------->CSTSCaptain, handle ping time out."];
    [self onNetLost];
}

#pragma private function
- (void)doFixTradeAnOrder:(QuoteData *)quoteData{
    JEDI_SYS_Try{
        long long accountID = [[ClientAPI getInstance] getAccount];
        if (accountID <= 0) {
            return;
        }
        GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:accountID];
        if (groupDoc == nil) {
            return;
        }
        
        NSArray *tradeArray = [[groupDoc getTradeDoc] getTTradeByInstrumentList:[quoteData getInstrument]];
        if (tradeArray != nil) {
//            for (TTrade *trade in tradeArray) {
            for (int i = 0; i < [tradeArray count]; i++) {
                [[APIDoc getFixUtil] fixTrade:[tradeArray objectAtIndex:i]];
            }
        }
        NSArray *orderArray = [[groupDoc getOrderDoc] getTOrderByInstrumentList:[quoteData getInstrument]];
        if (orderArray != nil) {
//            for (TOrder *order in orderArray) {
            for (int i = 0; i < [orderArray count]; i++) {
                [[APIDoc getFixUtil] fixOrder:[orderArray objectAtIndex:i]];
            }
        }
    }JEDI_SYS_EndTry
}

@end
