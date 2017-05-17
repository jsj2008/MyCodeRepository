//
//  DataListener.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuoteData.h" 
#import "InfoFather.h"
#import "KickOutNode.h"


@protocol DataListener <NSObject>
@required

- (void) onQuoteRec:(NSMutableArray *)quote;

- (void) onVolumnRec:(NSMutableArray *)quoteSize;

- (void) onInforRec:(InfoFather *) info;

- (void) onNetLost;

- (void) onPing:(long)ping avePing:(long)avePing lostPerc:(long)lostPerc;

- (void) onKickedOut:(KickOutNode *)kicknode;

- (void) onKickedOutBySys;

- (void) onPingTimeOut;

@end