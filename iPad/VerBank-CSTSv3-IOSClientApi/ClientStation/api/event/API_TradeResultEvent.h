//
//  API_TradeResultEvent.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "API_IDEvent.h"
#import "OPFather.h"
#import "IPFather.h"

@interface API_TradeResultEvent : API_IDEvent
{
    NSString *tradeID;
    Boolean tradeResult;
    NSString *errCode;
    
    OPFather *opFather;
    IPFather *ipFather;
}

-(id)init:(IPFather *)ipfahter opfather:(OPFather *)opfather;

-(NSString *)   getTradeID;

-(Boolean)      isTradeResult;

-(NSString *)   getErrorCode;

-(OPFather *)   getOpFather;

-(IPFather *)   getIpFather;

@end
