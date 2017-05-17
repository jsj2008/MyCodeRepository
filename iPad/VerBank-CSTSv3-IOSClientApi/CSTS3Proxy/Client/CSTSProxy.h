//
//  CSTSProxy.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/16/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PingDealerableDelegate.h"
#import "OPFather.h"
#import "IPfather.h"

@interface CSTSProxy : NSObject <PingDealerableDelegate>


//----------------------------------------------------------------------
#pragma mark Init

- (id)      init;
- (id)      initWithHost:(NSString *) ip  port:(NSInteger) port  listener:(id)listener;

- (BOOL)    waitInitFinished;

- (BOOL)    isDestroy;
- (BOOL)    isNetInit;
- (BOOL)    isLogined;

- (void)    destroy;

//----------------------------------------------------------------------
#pragma mark Trade

- (OPFather *)  doTrade:(IPFather *) ip;
- (void)        sendObject:(AbstractJsonData *) obj;

//----------------------------------------------------------------------
#pragma mark PingDealerableDelegate

- (BOOL)    sendPing:(CSTSPing *)ping;
- (void)    onPingResult:(PingResult *) pingResult;

@end
