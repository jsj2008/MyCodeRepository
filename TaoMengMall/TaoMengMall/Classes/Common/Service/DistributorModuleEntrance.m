//
//  DistributorModuleEntrance.m
//  CarKeeper
//
//  Created by marco on 3/11/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DistributorModuleEntrance.h"

#import "DSHomeViewController.h"
#import "DSDistributorApplyViewController.h"
#import "DSDistributorPromoteViewController.h"
#import "DSCustomerPromoteViewController.h"
#import "DSDistributorListViewController.h"
#import "DSCustomerListViewController.h"
#import "DSRevenueViewController.h"
#import "DSUnavailableSumViewController.h"
#import "DSSettlementViewController.h"
#import "DSReceiptPaymentPagerController.h"
#import "DSWithdrawHistoryViewController.h"
#import "DSWithdrawDetailViewController.h"
#import "DSStatisticsPagerController.h"
#import "DSRevenueDetailPagerController.h"
#import "DSWithdrawViewController.h"
#import "DSAccountEditViewController.h"

@implementation DistributorModuleEntrance

+ (id)sharedEntrance
{
    static dispatch_once_t onceToken;
    static DistributorModuleEntrance *moduleEntrance = nil;
    dispatch_once(&onceToken, ^{
        moduleEntrance = [[DistributorModuleEntrance alloc] init];
    });
    return moduleEntrance;
}

+ (void)load
{
    //分销商
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"distribution"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"distributorManage"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"distributorStatistics"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"customerManage"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"distributorPromote"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"customerPromote"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"distributorRevenue"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"distributorApply"];
    //不可用金额
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"dsUnavailableSum"];
    //结算
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"dsSettlement"];
    //收支明细
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"dsReceiptPayment"];
    //提现记录
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"dsWithdrawHistory"];
    //提现明细
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"withdraw"];
    
    //营收明细
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"dsRevenueDetail"];
    //提现
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"dsWithdraw"];
    //提现账户编辑
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"dsAccountEdit"];
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    
    if ([url.scheme isEqualToString:APP_SCHEME]||[url.scheme isEqualToString:APP_EXTERN_SCHEME]) {

        if ([url.host isEqualToString:@"distribution"]) {
            DSHomeViewController *vc = [[DSHomeViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"distributorManage"]) {
            DSDistributorListViewController *vc = [[DSDistributorListViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"distributorStatistics"]) {
            DSStatisticsPagerController *vc = [[DSStatisticsPagerController alloc]init];
            vc.xxType = urlParams[@"xxType"];
            [urlParams removeObjectForKey:@"xxType"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"customerManage"]) {
            DSCustomerListViewController *vc = [[DSCustomerListViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"distributorPromote"]) {
            DSDistributorPromoteViewController *vc = [[DSDistributorPromoteViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"customerPromote"]) {
            DSCustomerPromoteViewController *vc = [[DSCustomerPromoteViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"distributorRevenue"]) {
            DSRevenueViewController *vc = [[DSRevenueViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"distributorApply"]) {
            DSDistributorApplyViewController *vc = [[DSDistributorApplyViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"dsUnavailableSum"] ) {
            DSUnavailableSumViewController *vc = [[DSUnavailableSumViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"dsSettlement"]) {
            DSSettlementViewController *vc = [[DSSettlementViewController alloc]init];
            vc.xxType = urlParams[@"xxType"];
            [urlParams removeObjectForKey:@"xxType"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"dsReceiptPayment"]) {
            DSReceiptPaymentPagerController *vc = [[DSReceiptPaymentPagerController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"dsWithdrawHistory"]) {
            DSWithdrawHistoryViewController *vc = [[DSWithdrawHistoryViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"withdraw"]) {
            DSWithdrawDetailViewController *vc = [[DSWithdrawDetailViewController alloc]init];
            vc.id = urlParams[@"id"];
            [urlParams removeObjectForKey:@"id"];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"dsRevenueDetail"]) {
            DSRevenueDetailPagerController *vc = [[DSRevenueDetailPagerController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"dsAccountEdit"]) {
            DSAccountEditViewController *vc = [[DSAccountEditViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"dsWithdraw"]) {
            DSWithdrawViewController *vc = [[DSWithdrawViewController alloc]init];
            [navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
