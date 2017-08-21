//
//  ApplicationEntrance.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTabbarController.h"
#import "TTNavigationController.h"

extern NSString *const BaseURL;
extern NSString *const AppReceiveFamilyMessage;
extern NSString *const AppReceiveDashboardMessage;

@interface ApplicationEntrance : NSObject<TTTabbarControllerDelegate>

@property(nonatomic, strong) TTTabbarController *tabbarController;
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) TTNavigationController *currentNavController;


+ (ApplicationEntrance*)shareEntrance;

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions;
- (void)applicationEnterForeground;
- (void)applicationActive;
- (void)applicationEnterBackground;
- (void)handleOpenURL:(NSString *)aUrl;
- (void)applicationRegisterDeviceToken:(NSData*)deviceToken;
- (void)applicationFailToRegisterDeviceToken:(NSError*)error;
- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo;
- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)applicationHandleOpenURL:(NSURL *)url;
    
- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;
    
- (TTNavigationController *)currentNavigationController;

@end
