//
//  ThirdLoginService.h
//  BabyDaily
//
//  Created by marco on 8/23/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ThirdPlatformType) {
    ThirdPlatformTypeQQ       =  1,
    ThirdPlatformTypeWeibo    =  2,
    ThirdPlatformTypeWechat   =  3,
};

typedef NS_ENUM(NSInteger, ThirdLoginResultCode)
{
    ThirdLoginResultCodeSuccess               =  0,//成功
    ThirdLoginResultCodeUserCancel            = -1,//用户取消发送
    ThirdLoginResultCodeSentFail              = -2,//发送失败
    ThirdLoginResultCodeAuthDeny              = -3,//授权失败
    ThirdLoginResultCodeUnregistered          = -4,//config未注册
    ThirdLoginResultCodeUnlogined             = -5,//未登录
    ThirdLoginResultCodeNetWork               = -6,//网络错误
    ThirdLoginResultCodeError                 = -9,//其他错误
};

@interface ThirdBaseConfig : NSObject
@property (nonatomic, assign) ThirdPlatformType thirdPlatform;
@end

@interface WeiboAuthorizeCofig : ThirdBaseConfig
@property (nonatomic,strong) NSString *redirectURI;

@end

@interface WechatAuthorizeCofig : ThirdBaseConfig
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *appSecret;
@end

@interface QQAuthorizeCofig : ThirdBaseConfig

@end

@interface ThirdUserInfo : NSObject
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *gender;// 1:男，0：女
@property (nonatomic, strong) NSString *avatarurl;
@end

@interface ThirdLoginInfo : NSObject
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *refresh_token;
@end


typedef void(^LoginSuccessBlock)(ThirdLoginInfo *loginInfo);
typedef void(^LoginFailedBlock)(ThirdLoginResultCode errCode);
typedef void(^GetUserProfileSuccessBlock)(ThirdUserInfo *userInfo);
typedef void(^GetUserProfileFailedBlock)(ThirdLoginResultCode errCode);




@interface ThirdLoginService : NSObject

+ (instancetype)sharedService;

- (void)initService;
//- (BOOL)registerConfig:(ThirdBaseConfig*)config;

//确保在使用页面调用该方法重新注册delegate
- (void)reregisterDelegate;

//取消注册delegate
- (void)unregisterDelegate;

//微博授权登录
- (void)weiboLoginSuccess:(LoginSuccessBlock)success
           failure:(LoginFailedBlock)failure;

//微信授权登录
- (void)weixinLoginSuccess:(LoginSuccessBlock)success
            failure:(LoginFailedBlock)failure;

//QQ授权登录
- (void)tencentLoginSuccess:(LoginSuccessBlock)success
             failure:(LoginFailedBlock)failure;


//获取用户资料需要先登录
//获取微博用户资料
- (void)getWBUserSuccess:(GetUserProfileSuccessBlock)success
               failure:(GetUserProfileFailedBlock)failure;

//获取微信用户资料
- (void)getWXUserSuccess:(GetUserProfileSuccessBlock)success
                 failure:(GetUserProfileFailedBlock)failure;

//获取QQ用户资料
- (void)getQQUserSuccess:(GetUserProfileSuccessBlock)success
                 failure:(GetUserProfileFailedBlock)failure;
@end
