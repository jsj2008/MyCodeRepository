//
//  CSTSProxyTest.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "AbstractJsonData.h"
#import "DataListener.h"

@interface CSTSProxyTest : NSObject <DataListener>

- (id) init;
- (id) initToTest;

#pragma mark Delegate of DataListener

- (void) onQuoteRec:(NSMutableArray *)quote;

- (void) onVolumnRec:(NSMutableArray *)quoteSize;

- (void) onInforRec:(InfoFather *) info;

- (void) onNetLost;

- (void) onPing:(long)ping avePing:(long)avePing lostPerc:(long)lostPerc;

- (void) onKickedOut:(KickOutNode *)kicknode;

- (void) onKickedOutBySys;

- (void) onPingTimeOut;

@end
