//
//  SearchModuleEntrance.m
//  LianWei
//
//  Created by marco on 8/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "SearchModuleEntrance.h"

#import "SearchViewController.h"
#import "SearchTabController.h"

#import "SearchResultListViewController.h"
#import "SearchResultWallViewController.h"

@implementation SearchModuleEntrance

+ (id)sharedEntrance
{
    static dispatch_once_t onceToken;
    static SearchModuleEntrance *moduleEntrance = nil;
    dispatch_once(&onceToken, ^{
        moduleEntrance = [[SearchModuleEntrance alloc] init];
    });
    return moduleEntrance;
}

+ (void)load
{
    // 搜索界面
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"search"];
    
    // 搜索结果Wall
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"searchWall"];
    
    // 搜索结果List
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"searchList"];
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    
    if ([url.scheme isEqualToString:APP_SCHEME]) {
        
        
        if ([url.host isEqualToString:@"search"]) {
            
            NSArray *childViewControllers = navigationController.childViewControllers;
            SearchTabController *searchVC = nil;
            for (UIViewController *vc  in childViewControllers) {
                if ([vc isKindOfClass:[SearchTabController class]]) {
                    searchVC = (SearchTabController*)vc;
                }
            }
            if (!searchVC) {
                searchVC = [[SearchTabController alloc]init];
                searchVC.key = urlParams[@"key"];
                [urlParams removeObjectForKey:@"key"];
                searchVC.shopId = urlParams[@"shopId"];
                [urlParams removeObjectForKey:@"shopId"];
                searchVC.cateId = urlParams[@"cateId"];
                searchVC.searchType = urlParams[@"type"];
                [navigationController pushViewController:searchVC animated:YES];
                
            }else{
                searchVC.key = urlParams[@"key"];
                [urlParams removeObjectForKey:@"key"];
                searchVC.shopId = urlParams[@"shopId"];
                [urlParams removeObjectForKey:@"shopId"];
                searchVC.cateId = urlParams[@"cateId"];
                searchVC.searchType = urlParams[@"type"];
                [navigationController popToViewController:searchVC animated:YES];
            }
            //SearchViewController *vc = [[SearchViewController alloc] init];
            //searchVC.type = [urlParams[@"type"] integerValue];
            //[urlParams removeObjectForKey:@"type"];
            //searchVC.tabTitle = urlParams[@"tabTitle"];
            //[urlParams removeObjectForKey:@"tabTitle"];
            //searchVC.placeHolder = urlParams[@"placeHolder"];
            //[urlParams removeObjectForKey:@"placeHolder"];
            
        }else if ([url.host isEqualToString:@"searchWall"]) {
            
            SearchResultWallViewController *vc = [[SearchResultWallViewController alloc] init];
            vc.key = urlParams[@"key"];
            [urlParams removeObjectForKey:@"key"];
            vc.shopId = urlParams[@"shopId"];
            [urlParams removeObjectForKey:@"shopId"];
            [navigationController pushViewController:vc animated:YES];
            
        }else if ([url.host isEqualToString:@"searchList"]) {
            
            SearchResultListViewController *vc = [[SearchResultListViewController alloc] init];
            vc.key = urlParams[@"key"];
            [urlParams removeObjectForKey:@"key"];
            vc.shopId = urlParams[@"shopId"];
            [urlParams removeObjectForKey:@"shopId"];
            [navigationController pushViewController:vc animated:YES];
            
        }
    }
}
@end
