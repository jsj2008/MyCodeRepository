//
//  IosConfig.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
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
