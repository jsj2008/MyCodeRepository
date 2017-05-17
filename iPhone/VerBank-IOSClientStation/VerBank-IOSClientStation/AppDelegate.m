//
//  AppDelegate.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AppDelegate.h"
#import "IosLogic.h"
#import "UserDefaultsSettingKey.h"

#import "PushViewShow.h"

#import "CertificateUtil.h"
#import "APIDoc.h"
#import "ClientAPI.h"

#import <Bugtags/Bugtags.h>

@interface AppDelegate () {
    Boolean isNeedShowMessage;
    //    NSTimer *runTime;
    //    UIBackgroundTaskIdentifier identifier;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Bugtags startWithAppKey:@"3299143b3f4d101f84ac738102b3932a" invocationEvent:BTGInvocationEventBubble];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[IosLogic getInstance] setWindow:self.window];
    // 初始化 配置信息
    
    if(![[IosLogic getInstance] gotoLoginViewController]){
        return NO;
    }
    
    isNeedShowMessage = true;
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        //        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        
        //        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        
    } else{ // ios7
//        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
    [application registerForRemoteNotifications];
    
    [self.window makeKeyAndVisible];
//    [application setApplicationIconBadgeNumber:0];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    isNeedShowMessage = false;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [CertificateUtil setOriDate:[NSDate date]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //    if (identifier != UIBackgroundTaskInvalid){
    //        [self endBackgroundTask];
    //    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    isNeedShowMessage = true;
    [CertificateUtil resetTimeTickIsEnterBackground:true];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings {
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:pushToken forKey:kDeviceTokenKey];
    NSLog(@"%@", pushToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (isNeedShowMessage) {
        //在此处理接收到的消息。
        NSLog(@"Receive remote notification : %@", userInfo);
        NSDictionary *dic = [userInfo objectForKey:@"aps"];
        [PushViewShow showPushViewAtSuperView:self.window.rootViewController.view alert:[dic objectForKey:@"alert"]];
    } else {
        if ([[ClientAPI getInstance] docInited]) {
//        if ([[ClientAPI getInstance] is]) {
            [[IosLogic getInstance] gotoMessageViewController];
        }
    }
}


@end
