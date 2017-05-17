//
//  APIReConnectInfoNode.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIReConnectInfoNode : NSObject
{
    long time;
    NSString *ipAddress;
    int port;
    Boolean succeed;
    int result;
    long loginUsedTime;
}

-(NSString *)getIpAddress;

-(void)setIpAddress:(NSString *)_ipAddress;

-(int)getPort;

-(void)setPort:(int)_port;

-(long)getTime;

-(void)setTime:(long)_time;

-(Boolean)isSucceed;

-(void)setSucceed:(Boolean)_isSucceed;

-(int)getResult;

-(void)setResult:(int)_result;

-(long)getLoginUsedTime;

-(void)setLoginUsedTime:(long)_loginUsedTime;
@end
