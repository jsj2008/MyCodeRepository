//
//  TencentOAuthManager.h
//  BabyDaily
//
//  Created by marco on 8/24/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

extern NSString *const TencentOAuthManagerLoginSuccessed;
extern NSString *const TencentOAuthManagerLoginFailed;
extern NSString *const TencentOAuthManagerLoginCancelled;
extern NSString *const TencentOAuthManagerDidLogout;
extern NSString *const TencentOAuthManagerUpdateSuccessed;
extern NSString *const TencentOAuthManagerUpdateFailed;


@protocol TencentOAuthManagerDelegate <NSObject>

@optional

- (void)managerDidLogin;
- (void)managerDidNotLogin:(BOOL)cancelled;
- (void)managerDidNotNetWork;
- (void)managerDidLogout;
- (BOOL)managerNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions;
- (BOOL)managerNeedPerformReAuth:(TencentOAuth *)tencentOAuth;
- (void)managerDidUpdate:(TencentOAuth *)tencentOAuth;
- (void)managerFailedUpdate:(UpdateFailType)reason;
- (void)managerGetUserInfoResponse:(APIResponse*) response;
- (void)managerAddShareResponse:(APIResponse*)response;
- (void)managerAddTopicResponse:(APIResponse*) response;

@end



@interface TencentOAuthManager : NSObject

@property (nonatomic, strong, readonly) TencentOAuth *tencentOAuth;

@property (nonatomic, weak) id<TencentOAuthManagerDelegate> delegate;

+ (void)registerApp:(NSString*)appid;

+ (instancetype)sharedManager;

+ (BOOL)isQQInstalled;
+ (BOOL)isZoneInstalled;

// 简化的OAuth接口
- (BOOL)authorize:(NSArray *)permissions;
- (void)logout;

- (BOOL)getUserInfo;
- (BOOL)addShareWithParams:(NSMutableDictionary *)params;
- (BOOL)addTopicWithParams:(NSMutableDictionary *)params;
- (NSString *)getUserOpenID;

@end
