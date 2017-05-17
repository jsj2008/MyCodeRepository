//
//  PingDealerableDelegate.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/16/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTSPing.h"
#import "PingResult.h"

@protocol PingDealerableDelegate
@required

- (BOOL)    sendPing:(CSTSPing *)ping;
- (void)    onPingResult:(PingResult *) pingResult;

@end
