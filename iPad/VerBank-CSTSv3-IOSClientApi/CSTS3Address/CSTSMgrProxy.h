//
//  CSTSMgrProxy.h
//  IOSClientStation
//
//  Created by felix on 9/4/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JEDINetwork.h"
#import "AddressNode.h"

#define CMP_NetMsgHeadSize      8
#define CMP_NMTRequest010       0x00010001
#define CMP_NMTResponse010      0x00020001


@protocol CSTSMgrProxyDelegate
@optional
- (void)    didQueryFromServer:(NSMutableArray *) nodeArray cstsProxy:(id)proxy;
@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface CSTSMgrProxy : NSObject <JEDINetworkDelegate>

- (id)      initWithNode:(AddressNode *)node userName:(NSString *)userName andDelegate:(id <CSTSMgrProxyDelegate>)delegate;

- (void)    startQuery;
- (void)    stopQuery;

- (BOOL)    isNetworkOk;

@end