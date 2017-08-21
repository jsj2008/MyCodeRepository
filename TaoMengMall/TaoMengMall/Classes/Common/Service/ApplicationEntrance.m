//
//  ApplicationEntrance.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import "ApplicationEntrance.h"

#import "TTApplicationEntrance.h"
#import "XMAppThemeHelper.h"
#import "TTNetworkManager.h"
#import "TTAppLaunchView.h"

#import "WXApi.h"
#import "WXApiManager.h"

#import "WeiboSDK.h"
#import "WeiboApiManager.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "QQApiManager.h"
#import "TencentOAuthManager.h"

#import "ThirdLoginService.h"

//#import "AMUserLocationManager.h"
#import <AMapFoundationKit/AMapServices.h>

#import "UMessage.h"
#import <UMMobClick/MobClick.h>

#import "MallHomeViewController.h"
#import "MallCategoryViewController.h"
#import "MineViewController.h"
#import "PMProductListViewController.h"

#import "AlipayManager.h"

#import "LaunchGuideView.h"
#import "UserRequest.h"

@implementation ApplicationEntrance

+ (ApplicationEntrance*)shareEntrance
{
    static ApplicationEntrance *entrance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entrance = [[ApplicationEntrance alloc] init];
    });
    return entrance;
}

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions
{
    
    self.window = mainWindow;
    
    //配置主题
    [self configTheme];
    
    //注册应用请求Host
    TTNetworkConfig *config = [[TTNetworkConfig alloc]init];

    config.baseURL = @"https://app.taomengzhe.cn";
//    config.baseURL = @"http://116.62.201.6:10200/";
    
    //config.timeoutInterval = 10.f;
    [TTNetworkManager startWithConfigure:config];
    
    //主页面初始化
    [self initViewControllers];
    
    //应用初始化
    [self appInit];
    
    // 初始化微信,d80c8ef9792adc982522cf646d8563d8
    //[WXApi registerApp:@"wx5e05e6ca53062770" withDescription:@"com.xiaoma.flylantern"];
    [WXApiManager registerApp:@"wx5e05e6ca53062770" appSecret:@"de8b40b632a0fa09e267f1f548b6dda7" withDescription:@"com.xiaoma.taomengmall"];

    
    // 初始化微博,appsecret c410c0c1fc01c5590b0cb423dfc34cc9
    [WeiboApiManager registerApp:@"3122083106" redirectURI:@"https://api.weibo.com/oauth2/default.html"];

    
    // 初始化腾讯OAuth,app key:WaOdA9khQeDU1MuU
    [TencentOAuthManager registerApp:@"1106170620"];

    [[ThirdLoginService sharedService] initService];
       //高德地图
    [AMapServices sharedServices].apiKey = @"fa6413b873b36a7f8dba63ffd74b7791";

   
    // 初始化Alipay
    [AlipayManager registerScheme:@"tmMallXiaoMa" withDescription:@"com.xiaoma.taomengMall"];
   
    // 友盟
    [MobClick setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    //[MobClick startWithAppkey:@"" reportPolicy:BATCH channelId:@"default"];
    
    UMAnalyticsConfig *configU = [[UMAnalyticsConfig alloc]init];
    configU.appKey = @"591be76499f0c75d8d0005a1";
    configU.secret = @"pmg7lpxqej4stbpkxruizxqfymyuveca";
    [MobClick startWithConfigure:configU];
    
    //友盟推送
    //设置 AppKey 及 LaunchOptions
    //Adhoc
    [UMessage startWithAppkey:@"591be76499f0c75d8d0005a1" launchOptions:launchOptions];
    
    //AppStore
    //[UMessage startWithAppkey:@"" launchOptions:launchOptions];
    
    
    
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    
    //[UMessage registerForRemoteNotifications];
    
    //注册推送
    [self registerAPNs];
    [UMessage setLogEnabled:YES];
    [UMessage setBadgeClear:NO];
    [UMessage setAutoAlert:NO];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //当程序被推送调起，处理推送
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification) {
        [self didReceiveRemoteNotification:remoteNotification];
    }
    
}

- (void)applicationEnterForeground
{
    //TTAppLaunchView *launchView = [TTAppLaunchView sharedInstance];
    //[launchView showLaunchView];
    
    if ([UserService sharedService].isLogin) {
        NSMutableDictionary *p = [NSMutableDictionary dictionary];
        [p setSafeObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"deviceToken"];
        [UserRequest uploadPushTokenWithParams:p success:^{
            NSLog(@"success upload");
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lastUploadToken"];
        } failure:^(StatusModel *status) {
            NSLog(@"failed upload");
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lastUploadToken"];
        }];
    }
}

- (void)applicationActive
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationEnterBackground
{

}

- (void)handleOpenURL:(NSString *)aUrl
{
    [[TTNavigationService sharedService] openUrl:aUrl];
}

- (void)applicationRegisterDeviceToken:(NSData*)deviceToken
{
    //[UMessage registerDeviceToken:deviceToken];
    NSLog(@"token %@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                        stringByReplacingOccurrencesOfString: @">" withString: @""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""]);
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    

}

- (void)applicationFailToRegisterDeviceToken:(NSError*)error
{
    
}

- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo
{
    //[UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"receive:%@",userInfo);
    [self didReceiveRemoteNotification:userInfo];
}

- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    //后台点击调起应用
   
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"receive:%@",userInfo);
    //如果程序在前台，舍弃推送
    //if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [self didReceiveRemoteNotification:userInfo];
    //}
}

- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        
        [[AlipayManager sharedManager] processOrderWithPaymentResult:url standbyCallback:nil];
    } else if ([@"wx5e05e6ca53062770" isEqualToString:[url scheme]]) {
        
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        
    } else if ([@"wb3122083106" isEqualToString:[url scheme]]) {
        
        return [WeiboSDK handleOpenURL:url delegate:[WeiboApiManager sharedManager]];
        
    }else if ([@"tencent1106170620" isEqualToString:[url scheme]]) {
        
        return [TencentOAuth HandleOpenURL:url];

    }else if ([@"QQ41EED2FC" isEqualToString:[url scheme]]) {
        //为了兼容旧版本的手机QQ，需要增加 URL Scheme，QQ + 十六进制新AppId，不足八位在首部补0。（如 appid=222222 则 scheme=QQ0003640E）
        return [QQApiInterface handleOpenURL:url delegate:[QQApiManager sharedManager]];
    }else{
        [[TTNavigationService sharedService]openUrl:url.absoluteString];
    }
    
    return NO;
}

- (BOOL)applicationHandleOpenURL:(NSURL *)url {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        
        [[AlipayManager sharedManager] processOrderWithPaymentResult:url standbyCallback:nil];
    } else if ([@"wx5e05e6ca53062770" isEqualToString:[url scheme]]) {
        
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        
    } else if ([@"wb3122083106" isEqualToString:[url scheme]]) {
        
        return [WeiboSDK handleOpenURL:url delegate:[WeiboApiManager sharedManager]];
        
    }else if ([@"tencent1106170620" isEqualToString:[url scheme]]) {
        
        return [TencentOAuth HandleOpenURL:url];
        
    }else if ([@"QQ41EED2FC" isEqualToString:[url scheme]]) {

        return [QQApiInterface handleOpenURL:url delegate:[QQApiManager sharedManager]];
    }else{
        [[TTNavigationService sharedService]openUrl:url.absoluteString];
    }
    
    return NO;
    
}

- (void)didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSString *payloadMsg = userInfo[@"custom"];
    if (payloadMsg) {
        NSData *jsonData = [payloadMsg dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        
        if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
            if (dic[@"link"]) {
                [[TTNavigationService sharedService]openUrl:dic[@"link"]];
            }
        }
    }
}


- (void)configTheme
{
    XMAppThemeHelper *theme = [XMAppThemeHelper defaultTheme];
    theme.mainThemeColor = Theme_Color;
    theme.mainThemeContrastColor = Color_White;
    theme.navigationBarBackgroundColor = Color_White;
    theme.navigationBarTintColor = Color_Gray66;
    theme.navigationBarBackColor = Color_Gray66;
    theme.navigationBarButtonColor = Color_Gray66;
    theme.navigationBarBottomColor = Color_Gray230;
    theme.navigationBarTitleColor = Color_Gray66;
    
    theme.tabbarBackgroundColor = Color_White;
    theme.backButtonIconName = @"navigation_bar_back";
    
    //theme.checkButtonNormalIconName = @"checkbutton_normal";
    //theme.checkButtonSelectedIconName = @"checkbutton_selected";
    //theme.checkButtonDisableIconName = @"checkbutton_normal";
}


- (void)appInit
{
    
    TTAppLaunchView *launchView = [TTAppLaunchView sharedInstance];
    launchView.sliderView.currentPageColor = Color_White;
    launchView.sliderView.pageControl.pageIndicatorTintColor = Color_White;
    
    launchView.launchType = TTAppLaunchTypeGuide;
    launchView.dataSource = self;
    [launchView reloadPages];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_LOADING object:nil];
}




- (void)registerAPNs
{
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}

- (void)initViewControllers
{
    
    
    self.tabbarController = [[TTTabbarController alloc] initWithViewControllers:
                            @[
                             
                              [[MallHomeViewController alloc] init],
                            [[MallCategoryViewController alloc] init],
                               [[PMProductListViewController alloc] init],
                              [[MineViewController alloc] init]
                            ]];
    
     self.tabbarController.tabBarControllerDelegate = self;
     
     TTNavigationController *navigationController = [[TTNavigationController alloc] initWithRootViewController:self.tabbarController];
     self.window.rootViewController = navigationController;
     [self.window makeKeyAndVisible];
     
     self.currentNavController = navigationController;

}



- (TTNavigationController *)currentNavigationController
{
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (self.currentNavController) {
        return self.currentNavController;
    }
    
    TTNavigationController *nav;
    if ([rootController isKindOfClass:[TTNavigationController class]]) {
        nav = (TTNavigationController *)rootController;
        self.currentNavController = nav;
    } else if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)rootController;
        if ([tabbarController.selectedViewController isKindOfClass:[TTNavigationController class]]) {
            nav = (TTNavigationController *)tabbarController.selectedViewController;
            self.currentNavController = nav;
        }
    }
    return nav;
}

- (NSInteger)numberOfSliderPages
{
    return 3;
}

- (UIView *)viewForPageAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    LaunchGuideView *guide = [[LaunchGuideView alloc]init];
    guide.index = index;
    guide.showButton = index == 2;
    [guide render];
    return guide;
}


#pragma mark - TTTabBarDelegate
- (BOOL)tabBarController:(TTTabbarController *)tabBarController shouldSelectViewController:(BaseViewController *)viewController atIndex:(NSInteger)index
{
    //[UserService sharedService].isLogin = YES;
    if ( 0 != index && 1 != index && 2 != index&& ![UserService sharedService].isLogin ){
        [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"login")];
        return NO;
    }
    return YES;
}

- (void)tabBarController:(TTTabbarController *)tabBarController didSelectViewController:(BaseViewController *)viewController atIndex:(NSInteger)index
{
}
@end
