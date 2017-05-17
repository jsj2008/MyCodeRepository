//
//  NetInfoNode.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIReConnectInfoNode.h"

const static int NetInfoNode_TYPE_LOST      =1;
const static int NetInfoNode_TYPE_CONNECT   =2;

const static int NetInfoNode_REASON_NETLOST =1;
const static int NetInfoNode_REASON_TIMEOUT =2;

@interface NetInfoNode : NSObject
{
@private
    int type;
    
    NSString *ipAddress;
    int port;
    
    long long time;
    long loginUseTime;
    int reason;
    
    //APIReConnectInfoNode *reconnectVec;
    NSMutableArray *reconnectVec;
}
 

-(NSString *)   getIpAddress;
-(void)         setIpAddress:(NSString *)_ipAddress;

-(int)          getPort;
-(void)         setPort:(int)_port;

-(long long)    getTime;
-(void)         setTime:(long long)_time;

-(int)          getType;
-(void)         setType:(int)_type;

-(long)         getLoginUserTime;
-(void)         setLoginUserTime:(long)_loginUserTime;

-(int)          getReason;
-(void)         setReason:(int) _reason;

-(NSMutableArray *) getReconnectVec;
-(void) setReconnectVec:(NSMutableArray *)_reconnectVec;

@end
