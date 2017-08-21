//
//  AppModuleEntrance.m
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "AppModuleEntrance.h"

#import "TTNavigationService.h"
#import "TTNavigationController.h"
#import "LoginViewController.h"
//#import "RegisterStepOneViewController.h"
#import "SettingViewController.h"
//#import "ResetPasswordStepOneViewController.h"
#import "STChangeNameViewController.h"


#import "CategoryViewController.h"
#import "MCCategoryController.h"
#import "SearchTabController.h"
#import "BecomeMemberViewController.h"

#import "MyCollectionPagerViewController.h"

//#define APP_EXTERN_SCHEME @"xmxiaopa"

@implementation AppModuleEntrance

+ (id)sharedEntrance
{
    static dispatch_once_t onceToken;
    static AppModuleEntrance *moduleEntrance = nil;
    dispatch_once(&onceToken, ^{
        moduleEntrance = [[AppModuleEntrance alloc] init];
    });
    return moduleEntrance;
}

+ (void)load
{
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"myCollection"];
    
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"becomeMember"];

    //[[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"tabSearch"];

    // 分类 上装
    //[[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"topDress"];
    // 分类 下装
    //[[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"downDress"];
    
    // 登录
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"login"];
    
    // 首页
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"index"];

    // 注册
    //[[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"register"];
    
   
    
    // 设置
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"setting"];
    
    // 重置密码
   // [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"reset"];
    
    // 我的
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mine"];
    // 修改用户名
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"changeName"];
    // 修改性别
    //[[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"changeGender"];
    // 类目
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"cateWall"];
   
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    if ([url.host isEqualToString:@"login"]){
        [[UserService sharedService] clearLoginInfo];
        [[ApplicationEntrance shareEntrance].tabbarController selectAtIndex:0];

        UIViewController *topVC = navigationController.topViewController;
        if ([topVC isKindOfClass:[LoginViewController class]]) {
            return;
        }
        if( [navigationController.childViewControllers count] > 1 ){
            [navigationController popToRootViewControllerAnimated:NO onCompletion:^{
                LoginViewController *vc = [[LoginViewController alloc] init];
                [navigationController pushViewController:vc animated:YES];
            }];
        } else {
            LoginViewController *vc = [[LoginViewController alloc] init];
            [navigationController pushViewController:vc animated:YES];
        }
    }
    else if([url.host isEqualToString:@"index"]) {
        
        [[ApplicationEntrance shareEntrance].tabbarController selectAtIndex:0];
        
        if( [navigationController.childViewControllers count] > 1 ){
            [navigationController popToRootViewControllerAnimated:NO onCompletion:^{
            }];
        } else {
            //[[ApplicationEntrance shareEntrance].tabbarController selectAtIndex:0];
        }
        
    }else if ([url.host isEqualToString:@"setting"]){
        SettingViewController *vc = [[SettingViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([url.host isEqualToString:@"changeName"]) {
        
        STChangeNameViewController *vc = [[STChangeNameViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
        
    }else if ([url.host isEqualToString:@"cateWall"]) {
        
//        CategoryViewController *vc = [[CategoryViewController alloc] init];
//        vc.cateId = urlParams[@"cateId"];
//        [urlParams removeObjectForKey:@"cateId"];
//        [navigationController pushViewController:vc animated:YES];
        
        MCCategoryController *vc = [[MCCategoryController alloc] init];
        vc.cateId = urlParams[@"cateId"];
        [urlParams removeObjectForKey:@"cateId"];
        [navigationController pushViewController:vc animated:YES];
        
    }
#pragma mark -
    
    else if ([url.host isEqualToString:@"myCollection"]) {
        MyCollectionPagerViewController *vc = [[MyCollectionPagerViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"becomeMember"]){
        BecomeMemberViewController *vc = [[BecomeMemberViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
//    else if ([url.host isEqualToString:@"topDress"]) {
//        MCCategoryController *vc = [[MCCategoryController alloc] init];
//        [navigationController pushViewController: vc animated:YES];
//    }
    
}

@end
