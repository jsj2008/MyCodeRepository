//
//  NetInfoNode.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "NetInfoNode.h"

@implementation NetInfoNode
 

-(NSString *)getIpAddress{
    return ipAddress;
}

-(void)setIpAddress:(NSString *)_ipAddress{
    ipAddress=_ipAddress;
}

-(int)getPort{
    return port;
}

-(void)setPort:(int)_port{
    port=_port;
}

-(long long)getTime{
    return time;
}

-(void)setTime:(long long)_time{
    time=_time;
}

-(int)getType{
    return type;
}

-(void)setType:(int)_type{
    type=_type;
}

-(long)getLoginUserTime{
    return loginUseTime;
}

-(void)setLoginUserTime:(long)_loginUserTime
{
    loginUseTime=_loginUserTime;
}

-(int)getReason{
    return reason;
}

-(void)setReason:(int) _reason{
    reason=_reason;
}

-(NSMutableArray *)getReconnectVec{
    return reconnectVec;
}

-(void)setReconnectVec:(NSMutableArray *)_reconnectVec{
    reconnectVec=_reconnectVec;
}
@end
