//
//  APIReConnectInfoNode.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "APIReConnectInfoNode.h"

@implementation APIReConnectInfoNode

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

-(long)getTime{
    return time;
}

-(void)setTime:(long)_time{
    time=_time;
}

-(Boolean)isSucceed{
    return succeed;
}

-(void)setSucceed:(Boolean)_isSucceed{
    succeed=_isSucceed;
}

-(int)getResult{
    return result;
}

-(void)setResult:(int)_result{
    result=_result;
}

-(long)getLoginUsedTime{
    return loginUsedTime;
}

-(void)setLoginUsedTime:(long)_loginUsedTime{
    loginUsedTime=_loginUsedTime;
}
@end
