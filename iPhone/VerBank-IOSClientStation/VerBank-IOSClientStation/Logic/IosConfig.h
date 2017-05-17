//
//  IosConfig.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IosConfig : NSObject

+ (IosConfig *) getInstance;
- (id)   init;

#pragma loadData
+ (Boolean) loadAddressInfoForLogin;
+ (Boolean) loadClientConfig;
- (Boolean) loadClientConfig:(NSString *) fileName;

#pragma property
- (NSString *)      getAppName;
- (NSString *)      getAppId;
- (NSString *)      getVersion;
- (NSString *)      getType;

#pragma ClientConfigKeyArray
- (NSMutableArray *) getClientConfigKeyArray;
- (NSString *)       getClientConfigKeyBy:(NSString *)key;

@end
