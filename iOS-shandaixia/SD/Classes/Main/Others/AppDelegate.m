//
//  AppDelegate.m

/// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId           @"itwu6cLrCsApJTrjtOfcv6"
#define kGtAppKey          @"IG56yJf4mT9IE56GBUyuf7"
#define kGtAppSecret       @"UJh6GI0QyPATfMqQGtvKW"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define isEnvDev @"YES"


#ifdef DEBUG

#else

#define isEnvDev @"NO"

#endif



#import "AppDelegate.h"
#import "YPSideController.h"
#import "YPLeftMenuController.h"
#import "YPReusableControllerConst.h"
#import "ViewController.h"
#import "YPBaseNavigationController.h"
#import "FMDeviceManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AliyunOSSiOS.h"
#import "GeTuiSdk.h"  // GetuiSdk头文件应用
#import "BqsDeviceFingerPrinting.h"
#import "YAXGuideCollectionViewController.h"
#import "UMMobClick/MobClick.h"
#import "SDAccount.h"
#import <UMSocialCore/UMSocialCore.h>


#define UMRedirectURL @""

#define UMAppID @"58c0ff48c895766b8b001c77" // 正式版
//#define UMAppID @"590fd3a35312dd1302002e62" // 专业版


@interface AppDelegate () <YPSideControllerDelegate,UINavigationControllerDelegate,UIApplicationDelegate,UNUserNotificationCenterDelegate,GeTuiSdkDelegate,BqsDeviceFingerPrintingDelegate, BqsDeviceFingerPrintingContactsDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //    友盟
    [self configUM];
    
    
    //白骑士
    [self initBqsDFSDK];
    
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
    
    
    
    //    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    //    [NSURLCache setSharedURLCache:URLCache];
    //
    //    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //
    
    NSArray *channelTitleArray = [YPCacheTool channelTitleArray];
    
    if (!channelTitleArray) {
        //        NSArray *titleArray = @[@"要闻",@"体育",@"辽宁",@"娱乐",@"北京",@"社会",@"视频",@"教育",@"游戏",@"理财",@"股票",@"家居",@"财经"];
        
        NSArray *titleArray = @[@"闪贷侠"];
        
        [YPCacheTool saveChannelTitleArray:titleArray];
    }
    
    NSArray *titleArray = @[@"闪贷侠"];
    
    [YPCacheTool saveChannelTitleArray:titleArray];
    
    self.window = [[UIWindow alloc] initWithFrame:YPScreenBounds];
    [self.window makeKeyAndVisible];
    
    if ([NSString isNewVersion]) {
        
        YAXGuideCollectionViewController *guideController = [[YAXGuideCollectionViewController alloc] init];
        
        guideController.dismiss = NO;
        
        self.window.rootViewController = guideController;
        
    }else{
        
        YPBaseNavigationController *navVc = [[YPBaseNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        YPLeftMenuController *leftVc = [[YPLeftMenuController alloc] init];
        YPSideController *sideVc = [[YPSideController alloc] initWithContentViewController:navVc leftMenuViewController:leftVc];
        //    sideVc.backgroundImage = [UIImage imageNamed:@"mine_sidebar_background"];
        
        
        sideVc.myDelegate = self;
        self.window.rootViewController = sideVc;
    }
    
    
    
    
    //同盾
    // 获取设备管理器实例
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    
    // 准备SDK初始化参数
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    // SDK具有防调试功能，当使用xcode运行时，请取消此行注释，开启调试模式
    // 否则使用xcode运行会闪退，(但直接在设备上点APP图标可以正常运行)
    // 上线Appstore的版本，请记得删除此行，否则将失去防调试防护功能！
    [options setValue:@"allowd" forKey:@"allowd"];  // TODO
    
    // 指定对接同盾的测试环境，正式上线时，请删除或者注释掉此行代码，切换到同盾生产环境
    [options setValue:@"sandbox" forKey:@"env"]; // TODO
    
    // 指定合作方标识
    [options setValue:@"zxkj" forKey:@"partner"];
    
    // 使用上述参数进行SDK初始化
    manager->initWithOptions(options);
    
    [self networkListener];
    
    [self clearBadge];
    
//    [NSThread sleepForTimeInterval:3.0];
    
    return YES;
}

- (void)networkListener {
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
}

- (void)networkChanged:(NSNotification *)notification {
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    NSLog(@"currentStatus:%@",@(status));
    switch (status) {
        case RealStatusNotReachable:
            [@"网络无连接" showNotice];
            break;
            
        case RealStatusViaWiFi:
        case RealStatusViaWWAN:
            [SDNotificationCenter postNotificationName:SDNetworkReconnectNotification object:nil];
            
        default:
            break;
    }
}

- (void)sideVc:(YPSideController *)sideVc willShowMenuViewController:(UIViewController *)menuViewController
{
    [UIView animateWithDuration:0.35f animations:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

- (void)sideVc:(YPSideController *)sideVc willHideMenuViewController:(UIViewController *)menuViewController
{
    [UIView animateWithDuration:0.35f animations:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }];
    
}

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    
    [SDAccount registGeTui:clientId];
    
}

/**
 初始化白骑士设备指纹sdk
 */
-(void)initBqsDFSDK{
    
    [[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] setBqsDeviceFingerPrintingDelegate:self];
    [[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] setBqsDeviceFingerPrintingContactsDelegate:self];
    
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"yrsd" forKey:@"partnerId"];
    [params setValue:@"YES" forKey:@"isGatherContacts"];
    [params setValue:@"YES" forKey:@"isGatherGps"];
//    [params setValue:isEnvDev forKey:@"isEnvDev"];
    
    
    [[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] initBqsDFSdkWithParams:params];
    
    NSLog(@"getTokenKey=%@",[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] getTokenKey]);
    
}



/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    //NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    //FDLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    [SDNotificationCenter postNotificationName:SDReceivedPushingNotification object:nil];
    
}

- (void)configUM{
    
    
    
    UMConfigInstance.appKey = UMAppID;
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppID];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxfd22bbdb9c7c7ee8" appSecret:@"5c6888f9595bdc5e3b1e039103f32d37" redirectURL:UMRedirectURL];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106047478"/*设置QQ平台的appID*/  appSecret:@"DCaXuJyAlr9xocJD" redirectURL:UMRedirectURL];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"418939720"  appSecret:@"900cf8282c9cd8ebf42af007f4759a4f" redirectURL:UMRedirectURL];
    
    
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
        FDLog(@"回调 ------------ ");
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


/** 远程通知注册成功委托 */

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    FDLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    
    
    // 向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [SDNotificationCenter postNotificationName:SDUpdateNewVersion object:nil];
}



- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    
    [self clearBadge];
    
    [self initBqsDFSDK];
    
}



- (void)clearBadge{
    
    [GeTuiSdk resetBadge]; //重置角标计数
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // APP 清空角标
}



#pragma mark - BqsDeviceFingerPrintingDelegate
-(void)onBqsDFInitSuccess:(NSString *)tokenKey{
    NSLog(@"初始化成功 tokenKey=%@", tokenKey);
}

-(void)onBqsDFInitFailure:(NSString *)resultCode withDesc:(NSString *)resultDesc{
    NSLog(@"SDK初始化失败 resultCode=%@, resultDesc=%@", resultCode, resultDesc);
}

#pragma mark - BqsDeviceFingerPrintingContactsDelegate
-(void)onBqsDFContactsUploadSuccess:(NSString *)tokenKey{
    NSLog(@"联系人上传成功 tokenKey=%@", tokenKey);
}

-(void)onBqsDFContactsUploadFailure:(NSString *)resultCode withDesc:(NSString *)resultDesc{
    NSLog(@"联系人上传失败 resultCode=%@, resultDesc=%@", resultCode, resultDesc);
}


@end






