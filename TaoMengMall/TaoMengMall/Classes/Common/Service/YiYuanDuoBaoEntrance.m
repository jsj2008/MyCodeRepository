//
//  YiYuanDuoBaoEntrance.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/24.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "YiYuanDuoBaoEntrance.h"

#import "CaptureItemViewController.h"
#import "CaptureItemDetailViewController.h"

#import "TopUpViewController.h"

#import "LotteryRecordsViewPageController.h"
#import "LotteryDetailViewController.h"
#import "LotteryDetailSecondViewController.h"
#import "LotteryRefundViewController.h"

#import "LuckyRecordViewController.h"
#import "LuckyConfirmViewController.h"

#import "LuckyHistoryRecordViewController.h"
#import "LRDetailViewController.h"

#import "CIPayResultViewController.h"

#import "TopUpViewController.h"
#import "TURecordViewController.h"

#import "LuckDrawHomeViewController.h"


//#define APP_EXTERN_SCHEME @"xmxiaopa"
@implementation YiYuanDuoBaoEntrance

+ (id)sharedEntrance
{
    static dispatch_once_t onceToken;
    static YiYuanDuoBaoEntrance *moduleEntrance = nil;
    dispatch_once(&onceToken, ^{
        moduleEntrance = [[YiYuanDuoBaoEntrance alloc] init];
    });
    return moduleEntrance;
}

+ (void)load
{
    
    //一元夺宝主页
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"luckDraw"];
    // 商品详情
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"activityDetail"];
    // 商品图文详情
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"prizeDetail"];

    
    
    //充值
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"topUp"];
    
    //夺宝记录
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"lotteryRecords"];
    //夺宝详情
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"participantActivity"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"participantDetail"];
    //夺宝退款详情
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"overdueActivity"];
    
    // 幸运记录
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"luckRecord"];
    // 幸运确认
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"activityConfirmPending"];
    
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"activityAward"];
    
    // 往期揭晓
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"previousWinners"];
    
    // 支付结果
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"participantSuccess"];
    //充值记录
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"chargeRecords"];
    // 充值
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"charge"];
    
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    if ([url.host isEqualToString:@"luckDraw"]) {
        LuckDrawHomeViewController *vc = [[LuckDrawHomeViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if([url.host isEqualToString:@"activityDetail"]){
        CaptureItemViewController *vc = [[CaptureItemViewController alloc] init];
        vc.activityId = urlParams[@"activityId"];
        [navigationController pushViewController:vc animated:YES];
    }else if([url.host isEqualToString:@"prizeDetail"]){
        CaptureItemDetailViewController *vc = [[CaptureItemDetailViewController alloc] init];
        vc.activityId = urlParams[@"activityId"];
        [navigationController pushViewController:vc animated:YES];
    }
    
    else if ([url.host isEqualToString:@"topUp"]){
        TopUpViewController *vc = [[TopUpViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"lotteryRecords"]){
        LotteryRecordsViewPageController *vc = [[LotteryRecordsViewPageController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if([url.host isEqualToString:@"participantActivity"]){
        LotteryDetailViewController *vc = [[LotteryDetailViewController alloc] init];
        vc.activityId = urlParams[@"activityId"];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"participantDetail"]){
        LotteryDetailSecondViewController *vc = [[LotteryDetailSecondViewController alloc] init];
        vc.participantId = urlParams[@"participantId"];
        [navigationController pushViewController:vc animated:YES];
    }else if([url.host isEqualToString:@"overdueActivity"]){
        LotteryRefundViewController *vc = [[LotteryRefundViewController alloc] init];
        vc.participantId = urlParams[@"participantId"];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"luckRecord"]){
        LuckyRecordViewController *vc = [[LuckyRecordViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"activityAward"]){
        LRDetailViewController *vc = [[LRDetailViewController alloc] init];
        vc.activityId = urlParams[@"activityId"];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"previousWinners"]){
        LuckyHistoryRecordViewController *vc = [[LuckyHistoryRecordViewController alloc] init];
        vc.activityId = urlParams[@"activityId"];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"activityConfirmPending"]){
        LuckyConfirmViewController *vc = [[LuckyConfirmViewController alloc] init];
        vc.activityId = urlParams[@"activityId"];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"participantSuccess"]){
        CIPayResultViewController *vc = [[CIPayResultViewController alloc] init];
        vc.participantId = urlParams[@"participantId"];
        [navigationController pushViewController:vc animated:YES];
    }else if([url.host isEqualToString:@"chargeRecords"]){
        TURecordViewController *vc = [TURecordViewController alloc];
        [navigationController pushViewController:vc animated:YES];
    }else if ([url.host isEqualToString:@"charge"]){
        TopUpViewController *vc = [[TopUpViewController alloc] init];
        [navigationController pushViewController:vc animated:YES];
    }
}


@end
