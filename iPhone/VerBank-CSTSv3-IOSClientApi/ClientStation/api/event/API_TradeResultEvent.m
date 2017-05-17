//
//  API_TradeResultEvent.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "API_TradeResultEvent.h"

@implementation API_TradeResultEvent

-(id)init:(IPFather *)ipfahter opfather:(OPFather *)opfather
{
    if (self=[super init]) {
        ipFather=ipfahter;
        opFather=opfather;
        tradeID=[ipfahter getID];
        tradeResult=[opfather isSuccessed];
        errCode=[opfather getErrCode];
    }
    return self;
}

-(NSString *)getTradeID{
    return tradeID;
}

-(Boolean)isTradeResult{
    return tradeResult;
}

-(NSString *)getErrorCode{
    return errCode;
}

-(OPFather *)getOpFather{
    return opFather;
}

-(IPFather *)getIpFather{
    return ipFather;
}
@end
