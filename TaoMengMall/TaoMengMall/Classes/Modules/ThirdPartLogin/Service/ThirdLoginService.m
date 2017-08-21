//
//  ThirdAuthorizeLoginService.m
//  BabyDaily
//
//  Created by marco on 8/23/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "ThirdLoginService.h"
#import "WeiboUser.h"

#import "WXApiManager.h"
#import "TencentOAuthManager.h"
#import "WeiboApiManager.h"

@interface ThirdBaseConfig ()
@property (nonatomic, strong) NSString *refresh_token;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *openId;
@end
@implementation ThirdBaseConfig

@end


@interface WeiboAuthorizeCofig ()
@end
@implementation WeiboAuthorizeCofig
@end

@interface WechatAuthorizeCofig ()
@end
@implementation WechatAuthorizeCofig
@end


@implementation QQAuthorizeCofig
@end

@implementation ThirdUserInfo
@end
@implementation ThirdLoginInfo
@end

@interface ThirdLoginService ()<WBHttpRequestDelegate,WeiboApiManagerDelegate,TencentOAuthManagerDelegate,WXApiManagerDelegate>
@property (nonatomic, strong) NSMutableArray *configs;

@property (nonatomic, copy) LoginSuccessBlock loginSuccessBlock;
@property (nonatomic, copy) LoginFailedBlock loginFailedBlock;
@property (nonatomic, copy) GetUserProfileSuccessBlock getUserProfileSuccessBlock;
@property (nonatomic, copy) GetUserProfileFailedBlock getUserProfileFailedBlock;

@end

@implementation ThirdLoginService

+ (instancetype)sharedService
{
    static dispatch_once_t onceToken;
    static ThirdLoginService *service;
    dispatch_once(&onceToken, ^{
        service = [[ThirdLoginService alloc] init];
    });
    return service;
}

- (instancetype)init
{
    if (self = [super init]) {
        _configs = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

- (void)initService
{
    [self.configs removeAllObjects];
    
    //三方登陆注册
    WeiboAuthorizeCofig *weibo = [[WeiboAuthorizeCofig alloc]init];
    weibo.thirdPlatform = ThirdPlatformTypeWeibo;
    weibo.redirectURI = [WeiboApiManager sharedManager].redirectURI;
    [self registerConfig:weibo];
    
    WechatAuthorizeCofig *wechat = [[WechatAuthorizeCofig alloc]init];
    wechat.thirdPlatform = ThirdPlatformTypeWechat;
    wechat.appId = [WXApiManager sharedManager].appId;
    wechat.appSecret = [WXApiManager sharedManager].appSecret;
    [self registerConfig:wechat];
    
    QQAuthorizeCofig *qq = [[QQAuthorizeCofig alloc]init];
    qq.thirdPlatform = ThirdPlatformTypeQQ;
    [self registerConfig:qq];
}


- (BOOL)registerConfig:(ThirdBaseConfig *)config
{
    
    ThirdPlatformType type = config.thirdPlatform;
    switch (type) {
        case ThirdPlatformTypeWeibo:
        {
            WeiboAuthorizeCofig *conf = (WeiboAuthorizeCofig*)config;
            if(IsEmptyString(conf.redirectURI)) conf.redirectURI = @"http://";
        }
            break;
        case ThirdPlatformTypeWechat:
        {
            WechatAuthorizeCofig *conf = (WechatAuthorizeCofig*)config;
            if (IsEmptyString(conf.appId)||IsEmptyString(conf.appSecret)) {
                NSLog(@"appid and appSecret in WechatAuthorizeCofig are should not be empty");
                return NO;
            }
        }
            break;
        case ThirdPlatformTypeQQ:
            break;
        default:
            break;
    }
    for (int i = 0;i < self.configs.count;i++) {
        ThirdBaseConfig *conf = [self.configs safeObjectAtIndex:i];
        if (config.thirdPlatform == conf.thirdPlatform) {
            [self.configs replaceObjectAtIndex:i withObject:config];
            return YES;
        }
    }
    [self.configs addSafeObject:config];
    return YES;
}

- (void)reregisterDelegate;
{
    [WXApiManager sharedManager].delegate = self;
    [WeiboApiManager sharedManager].delegate = self;
    [TencentOAuthManager sharedManager].delegate = self;
}

- (void)unregisterDelegate;
{
    [WXApiManager sharedManager].delegate = nil;
    [WeiboApiManager sharedManager].delegate = nil;
    [TencentOAuthManager sharedManager].delegate = nil;
}

- (ThirdBaseConfig*)getConfig:(ThirdPlatformType)type
{
    for (ThirdBaseConfig *conf in self.configs) {
        if (conf.thirdPlatform == type) {
            return conf;
        }
    }
    return nil;
}

#pragma mark Third Authorize Login
//微博授权登录
- (void)weiboLoginSuccess:(LoginSuccessBlock)success
                  failure:(LoginFailedBlock)failure
{
    self.loginSuccessBlock = success;
    self.loginFailedBlock = failure;
    
    WeiboAuthorizeCofig *weibo = (WeiboAuthorizeCofig*)[self getConfig:ThirdPlatformTypeWeibo];
    if (!weibo) {
        self.loginFailedBlock(ThirdLoginResultCodeUnregistered);
        return;
    }
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = weibo.redirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": NSStringFromClass([self class]),
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

//微信授权登录
- (void)weixinLoginSuccess:(LoginSuccessBlock)success
                   failure:(LoginFailedBlock)failure
{
    self.loginSuccessBlock = success;
    self.loginFailedBlock = failure;
    
    WechatAuthorizeCofig *wechat = (WechatAuthorizeCofig*)[self getConfig:ThirdPlatformTypeWechat];
    if (!wechat) {
        self.loginFailedBlock(ThirdLoginResultCodeUnregistered);
        return;
    }
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"0744";
    [WXApi sendReq:req];
}

//QQ授权登录
- (void)tencentLoginSuccess:(LoginSuccessBlock)success
                    failure:(LoginFailedBlock)failure
{
    self.loginSuccessBlock = success;
    self.loginFailedBlock = failure;
    
    QQAuthorizeCofig *qq = (QQAuthorizeCofig*)[self getConfig:ThirdPlatformTypeQQ];
    if (!qq) {
        self.loginFailedBlock(ThirdLoginResultCodeUnregistered);
        return;
    }
    
    NSArray*permissions =[[NSArray alloc]initWithObjects:@"get_user_info", @"get_simple_userinfo",@"add_t",nil];
    [[TencentOAuthManager sharedManager] authorize:permissions];
}

//获取微博用户资料
- (void)getWBUserSuccess:(GetUserProfileSuccessBlock)success
                 failure:(GetUserProfileFailedBlock)failure
{
    self.getUserProfileFailedBlock = failure;
    self.getUserProfileSuccessBlock = success;
    
    WeiboAuthorizeCofig *weibo = (WeiboAuthorizeCofig*)[self getConfig:ThirdPlatformTypeWeibo];
    if (IsEmptyString(weibo.openId)||IsEmptyString(weibo.access_token)) {
        self.getUserProfileFailedBlock(ThirdLoginResultCodeUnlogined);
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weibo.openId forKey:@"uid"];
    
    [WBHttpRequest requestWithAccessToken:weibo.access_token url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:params delegate:self withTag:nil];
}

//获取微信用户资料
- (void)getWXUserSuccess:(GetUserProfileSuccessBlock)success
                 failure:(GetUserProfileFailedBlock)failure
{
    self.getUserProfileFailedBlock = failure;
    self.getUserProfileSuccessBlock = success;
    
    WechatAuthorizeCofig *wechat = (WechatAuthorizeCofig*)[self getConfig:ThirdPlatformTypeWechat];
    if (IsEmptyString(wechat.access_token)) {
        self.getUserProfileFailedBlock(ThirdLoginResultCodeUnlogined);
        return;
    }
    [self getUserInfo];
    
}

//获取QQ用户资料
- (void)getQQUserSuccess:(GetUserProfileSuccessBlock)success
                 failure:(GetUserProfileFailedBlock)failure
{
    self.getUserProfileFailedBlock = failure;
    self.getUserProfileSuccessBlock = success;
    
    QQAuthorizeCofig *qq = (QQAuthorizeCofig*)[self getConfig:ThirdPlatformTypeQQ];
    if (IsEmptyString(qq.access_token)) {
        self.getUserProfileFailedBlock(ThirdLoginResultCodeUnlogined);
        return;
    }
    [[TencentOAuthManager sharedManager] getUserInfo];
}

#pragma mark - Third Authorize Login Callback
#pragma mark -WeiboApiManagerDelegate
- (void)managerDidRecvAuthorizeResponse:(WBAuthorizeResponse *)response
{
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        if (response != nil && response.userID.length > 0 && response.accessToken.length > 0) {
            
            WeiboAuthorizeCofig *weibo = (WeiboAuthorizeCofig*)[self getConfig:ThirdPlatformTypeWeibo];
            weibo.access_token = response.accessToken;
            weibo.refresh_token = response.refreshToken;
            weibo.openId = response.userID;
            
            ThirdLoginInfo *login = [[ThirdLoginInfo alloc]init];
            login.access_token = weibo.access_token;
            login.openId = weibo.openId;
            login.refresh_token = weibo.refresh_token;
            if (self.loginSuccessBlock) {
                self.loginSuccessBlock(login);
            }
        }
    }else if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
        if (self.loginFailedBlock) {
            self.loginFailedBlock(ThirdLoginResultCodeUserCancel);
        }
    }
}

#pragma mark -WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    WeiboUser* userInfo = [[WeiboUser alloc] initWithDictionary:dic];
    ThirdUserInfo *info = [[ThirdUserInfo alloc]init];
    info.openId = userInfo.userID;
    info.nickname = userInfo.name;
    info.gender = [userInfo.gender isEqualToString:@"m"]?@"1":@"0";
    info.avatarurl = userInfo.avatarHDUrl;
    if (self.getUserProfileSuccessBlock) {
        self.getUserProfileSuccessBlock(info);
    }
}

#pragma mark -WXApiManagerDelegate
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response
{
    if (response.errCode == WXSuccess) {
        WechatAuthorizeCofig *wechat = (WechatAuthorizeCofig*)[self getConfig:ThirdPlatformTypeWechat];
        
        NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",wechat.appId,wechat.appSecret,response.code];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *zoneUrl = [NSURL URLWithString:url];
            NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    wechat.access_token = dic[@"access_token"];
                    wechat.openId = dic[@"openid"];
                    wechat.refresh_token = dic[@"refresh_token"];
                    
                    ThirdLoginInfo *login = [[ThirdLoginInfo alloc]init];
                    login.access_token = wechat.access_token;
                    login.openId = wechat.openId;
                    login.refresh_token = wechat.refresh_token;
                    
                    if (self.loginSuccessBlock) {
                        self.loginSuccessBlock(login);
                    }
                }else{
                    if (self.loginFailedBlock) {
                        self.loginFailedBlock(ThirdLoginResultCodeError);
                    }
                }
            });
        });
        
    }else if (response.errCode == WXErrCodeUserCancel) {
        if (self.loginFailedBlock) {
            self.loginFailedBlock(ThirdLoginResultCodeUserCancel);
        }
    }
}

- (void)getUserInfo
{
    WechatAuthorizeCofig *wechat = (WechatAuthorizeCofig*)[self getConfig:ThirdPlatformTypeWechat];
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",wechat.access_token,wechat.openId];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                ThirdUserInfo *info = [[ThirdUserInfo alloc]init];
                info.openId = wechat.openId;
                info.nickname = dic[@"nickname"];
                info.gender = [NSString stringWithFormat:@"%@",dic[@"sex"]];
                info.avatarurl = dic[@"headimgurl"];
                if (self.getUserProfileSuccessBlock) {
                    self.getUserProfileSuccessBlock(info);
                }
            }else{
                if (self.getUserProfileFailedBlock) {
                    self.getUserProfileFailedBlock(ThirdLoginResultCodeError);
                }
            }
        });
    });
}


#pragma mark -TencentOAuthManagerDelegate
- (void)managerDidLogin
{
    ThirdLoginInfo *login = [[ThirdLoginInfo alloc]init];
    login.access_token = [TencentOAuthManager sharedManager].tencentOAuth.accessToken;
    login.openId = [TencentOAuthManager sharedManager].tencentOAuth.openId;
    
    QQAuthorizeCofig *qq = (QQAuthorizeCofig*)[self getConfig:ThirdPlatformTypeQQ];
    qq.access_token = [TencentOAuthManager sharedManager].tencentOAuth.accessToken;
    if (self.loginSuccessBlock) {
        self.loginSuccessBlock(login);
    }
}

- (void)managerDidNotLogin:(BOOL)cancelled
{
    if (cancelled&&self.loginFailedBlock) {
        self.loginFailedBlock(ThirdLoginResultCodeUserCancel);
    }else if (self.loginFailedBlock){
        self.loginFailedBlock(ThirdLoginResultCodeSentFail);
    }
}

- (void)managerGetUserInfoResponse:(APIResponse *)response
{
    if (response.detailRetCode == kOpenSDKErrorSuccess) {
        ThirdUserInfo *info = [[ThirdUserInfo alloc]init];
        info.openId = [TencentOAuthManager sharedManager].tencentOAuth.openId;
        info.nickname = response.jsonResponse[@"nickname"];
        info.gender = [response.jsonResponse[@"gender"] isEqualToString:@"男"]?@"1":@"0";
        info.avatarurl = response.jsonResponse[@"figureurl"];
        if (self.getUserProfileSuccessBlock) {
            self.getUserProfileSuccessBlock(info);
        }
    }else if (response.detailRetCode == kOpenSDKErrorOperationDeny){
        if (self.getUserProfileFailedBlock) {
            self.getUserProfileFailedBlock(ThirdLoginResultCodeAuthDeny);
        }
    }else if (response.detailRetCode == kOpenSDKErrorNetwork){
        if (self.getUserProfileFailedBlock) {
            self.getUserProfileFailedBlock(ThirdLoginResultCodeNetWork);
        }
    }else{
        if (self.getUserProfileFailedBlock) {
            self.getUserProfileFailedBlock(ThirdLoginResultCodeError);
        }
    }
}
@end
