//
//  SockProxyNode.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/24.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SockProxyNode : NSObject

@property (strong, nonatomic) NSString * nodeName;

@property (strong, nonatomic) NSString * userName;
@property (strong, nonatomic) NSString * userPassword;

@property (strong, nonatomic) NSString * hostIp;
@property (nonatomic)         NSInteger  hostPort;

@end
