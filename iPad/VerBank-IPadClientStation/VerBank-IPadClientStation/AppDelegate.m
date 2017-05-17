//
//  AppDelegate.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AppDelegate.h"
#import "IosLogic.h"
#import "PhonePinChecker.h"
#import "IosLogic.h"
#import "LoginViewController.h"
#import "IosScreen.h"
#import "UserDefaultsSettingKey.h"
#import "ClientAPI.h"
#import "IosLogic.h"
#import "PushViewShow.h"
#import "LayoutCenter.h"
#import <Bugtags/Bugtags.h>

static NSDate *enterBackgroundTime;

@interface AppDelegate () {
    Boolean isNeedShowMessage;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Bugtags startWithAppKey:@"fdd38fab51e93a44def58bee0fb60a6a" invocationEvent:BTGInvocationEventBubble];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[IosLogic getInstance] setUiWindow:self.window];
    [IosScreen setIsInRotation:false];
    if(![[IosLogic getInstance] gotoLoginViewController]){
        return NO;
    }
    
    isNeedShowMessage = true;
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]){
        //IOS8
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        
    } else { // ios7
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
    [application registerForRemoteNotifications];
    
    [self.window makeKeyAndVisible];
    
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
    
    enterBackgroundTime = [NSDate new];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    isNeedShowMessage = true;
    if (![[[[IosLogic getInstance] uiWindow] rootViewController] isKindOfClass:[LoginViewController class]]) {
        NSTimeInterval time = [[NSDate new] timeIntervalSinceDate:enterBackgroundTime];
        long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
        [[PhonePinChecker getInstance] resetByTime:dTime];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings {
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
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
//            [[IosLogic getInstance] gotoMessageViewController];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_Message];
        }
    }
}




@end
