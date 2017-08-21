//
//  TencentOAuthManager.m
//  BabyDaily
//
//  Created by marco on 8/24/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "TencentOAuthManager.h"

NSString *const TencentOAuthManagerLoginSuccessed = @"TencentOAuthManagerLoginSuccessed";
NSString *const TencentOAuthManagerLoginFailed = @"TencentOAuthManagerLoginFailed";
NSString *const TencentOAuthManagerLoginCancelled = @"TencentOAuthManagerLoginCancelled";
NSString *const TencentOAuthManagerDidLogout = @"TencentOAuthManagerDidLogout";
NSString *const TencentOAuthManagerUpdateSuccessed = @"TencentOAuthManagerUpdateSuccessed";
NSString *const TencentOAuthManagerUpdateFailed = @"TencentOAuthManagerUpdateFailed";


@interface TencentOAuthManager () <TencentSessionDelegate>
@property (nonatomic, strong) TencentOAuth *tencentOAuth;
@end

@implementation TencentOAuthManager

+ (void)registerApp:(NSString*)appid
{
    TencentOAuth *oauth = [[TencentOAuth alloc]initWithAppId:appid andDelegate:nil];
    TencentOAuthManager *manager = [TencentOAuthManager sharedManager];
    manager.tencentOAuth = oauth;
    oauth.sessionDelegate = manager;
}

+ (BOOL)isQQInstalled
{
    return [TencentOAuth iphoneQQInstalled];
}

+ (BOOL)isZoneInstalled
{
    return [TencentOAuth iphoneQZoneInstalled];
}


+ (instancetype)sharedManager
{
    static TencentOAuthManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TencentOAuthManager alloc] init];
    });
    return instance;
}

- (void)delegateDealloc {
    self.delegate = nil;
}


#pragma mark -当前封装的精简接口
- (BOOL)authorize:(NSArray *)permissions
{
    return [self.tencentOAuth authorize:permissions inSafari:NO];
}

- (void)logout
{
    [self.tencentOAuth logout:self];
}

- (BOOL)getUserInfo
{
    return [self.tencentOAuth getUserInfo];
}

- (BOOL)addShareWithParams:(NSMutableDictionary *)params
{
    return [self.tencentOAuth addShareWithParams:params];
}

- (BOOL)addTopicWithParams:(NSMutableDictionary *)params
{
    return [self.tencentOAuth addTopicWithParams:params];
}

- (NSString *)getUserOpenID
{
    return [self.tencentOAuth getUserOpenID];
}


#pragma mark - TencentLoginDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TencentOAuthManagerLoginSuccessed object:self.tencentOAuth];

    if (_delegate && [_delegate respondsToSelector:@selector(managerDidLogin)]) {
        [_delegate managerDidLogin];
    }
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TencentOAuthManagerLoginCancelled object:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(managerDidNotLogin:)]) {
        [_delegate managerDidNotLogin:cancelled];
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TencentOAuthManagerLoginFailed object:nil];

    if (_delegate && [_delegate respondsToSelector:@selector(managerDidNotNetWork)]) {
        [_delegate managerDidNotNetWork];
    }
}


#pragma mark -TencentSessionDelegate
- (void)tencentDidLogout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TencentOAuthManagerDidLogout object:nil];

    if (_delegate && [_delegate respondsToSelector:@selector(managerDidLogout)]) {
        [_delegate managerDidLogout];
    }
}

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    if (_delegate && [_delegate respondsToSelector:@selector(managerNeedPerformIncrAuth:withPermissions:)]) {
        return [_delegate managerNeedPerformIncrAuth:tencentOAuth withPermissions:permissions];
    }
    return YES;
}

- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    if (_delegate && [_delegate respondsToSelector:@selector(managerNeedPerformReAuth:)]) {
        return [_delegate managerNeedPerformReAuth:tencentOAuth];
    }
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TencentOAuthManagerUpdateSuccessed object:tencentOAuth];

    if (_delegate && [_delegate respondsToSelector:@selector(managerDidUpdate:)]) {
        [_delegate managerDidUpdate:tencentOAuth];
    }
}

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
- (void)tencentFailedUpdate:(UpdateFailType)reason
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TencentOAuthManagerUpdateFailed object:@(reason)];

    if (_delegate && [_delegate respondsToSelector:@selector(managerFailedUpdate:)]) {
        [_delegate managerFailedUpdate:reason];
    }
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response
{
    if (_delegate && [_delegate respondsToSelector:@selector(managerGetUserInfoResponse:)]) {
        [_delegate managerGetUserInfoResponse:response];
    }
}


/**
 * 分享到QZone回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/addShareResponse.exp success
 *          错误返回示例: \snippet example/addShareResponse.exp fail
 */
- (void)addShareResponse:(APIResponse*)response
{
    if (_delegate && [_delegate respondsToSelector:@selector(managerAddShareResponse:)]) {
        [_delegate managerAddShareResponse:response];
    }
}



/**
 * 在QZone中发表一条说说回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/addTopicResponse.exp success
 *          错误返回示例: \snippet example/addTopicResponse.exp fail
 */
- (void)addTopicResponse:(APIResponse*) response
{
    if (_delegate && [_delegate respondsToSelector:@selector(managerAddTopicResponse:)]) {
        [_delegate managerAddTopicResponse:response];
    }
}





@end
