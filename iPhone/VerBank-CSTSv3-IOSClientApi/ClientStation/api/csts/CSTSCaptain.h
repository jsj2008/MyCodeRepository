//
//  CSTSCaptain.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataListener.h"
//#import "QuoteData.h"
#import "OPFather.h"
#import "IPFather.h"
#import "InfoCaptain.h"

#import "NetInfoNode.h"
#import "ClientAPI.h"
#import "MTP4CommDataInterface.h"

#import "CSTSProxy.h"


@interface CSTSCaptain : NSObject<DataListener>
{
@private
    BOOL          _isInited;
    
    NSString    * _attrName_ID;
//    NSString    * _attrName_CMD;
//    NSString    * _attrQuerySystem;
    
    CSTSProxy   * _proxy;
}

//------------------------------------------------------------------------------------
#pragma mark Singleton
//------------------------------------------------------------------------------------
+ (CSTSCaptain *)   getInstance;

//------------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------------
- (id)          init;

- (BOOL)        initWithAddressCaptain:(AddressCaptain *) captain  addressNode:(AddressNode *) node;
- (BOOL)        isNetOK;

- (void)        doDispachQuote:(QuoteData *)quoteData;

- (OPFather *)  trade:(IPFather *)ip;
- (void)        sendObject:(AbstractJsonData *)obj;

- (void)        destroy;

//------------------------------------------------------------------------------------
#pragma mark DataListener
//------------------------------------------------------------------------------------

- (void) onQuoteRec:(NSMutableArray *)quote;

- (void) onVolumnRec:(NSMutableArray *)quoteSize;

- (void) onInforRec:(InfoFather *) info;

- (void) onNetLost;

- (void) onPing:(long)ping avePing:(long)avePing lostPerc:(long)lostPerc;

- (void) onKickedOut:(KickOutNode *)kicknode;

- (void) onKickedOutBySys;

- (void) onPingTimeOut;

@end
