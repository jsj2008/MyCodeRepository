//
//  CSTSTradeWaitObject.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IPFather.h"
#import "OPFather.h"

#ifndef JEDI_CSTS_TRADE_WAIT_GAP
#define JEDI_CSTS_TRADE_WAIT_GAP 3*60*1000
#endif


@interface CSTSTradeWaitObject : NSObject
{
@private
    NSString * mHashCode;
    IPFather * mIp;
    OPFather * mOp;
    
    NSLock   * mWaitLock;
}


- (id)          init;
- (id)          initWithIp:(IPFather *) ip;

- (OPFather *)  waitTradeForTime:(long) waitTime;
- (OPFather *)  waitTrade;

- (void)        tradeReturn:(OPFather *)op;
- (void)        setError;

- (NSString *)  getHashCode;

@end
