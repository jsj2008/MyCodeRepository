//
//  MallModuleEntrance.m
//  LianWei
//
//  Created by Ivan on 16/6/19.
//  Copyright © 2016年 marco. All rights reserved.
//

#import "MallModuleEntrance.h"

#import "TTNavigationService.h"
#import "TTNavigationController.h"

#import "ReviewsViewController.h"
#import "RFApplyViewController.h"
#import "RFHistoryViewController.h"
#import "RFDetailViewController.h"
#import "CommentListViewController.h"

#import "OrderViewController.h"
#import "OrderViewPagerController.h"

#import "ItemViewController.h"
#import "CartViewController.h"

#import "ConsigneeEditViewController.h"
#import "ConsigneeSelectViewController.h"

#import "CashierViewController.h"

#import "ShopViewController.h"

#import "MallItemSearchViewController.h"
#import "PMCategoryViewController.h"
#import "PMProductListViewController.h"
#import "PMPointDetailViewController.h"

#import "ODReturnPointViewController.h"

@implementation MallModuleEntrance

+ (id)sharedEntrance
{
    static dispatch_once_t onceToken;
    static MallModuleEntrance *moduleEntrance = nil;
    dispatch_once(&onceToken, ^{
        moduleEntrance = [[MallModuleEntrance alloc] init];
    });
    return moduleEntrance;
}

+ (void)load
{
    // 积分商城
    //积分商城首页
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointMallWall"];
    // 积分商城-商品详情
//    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointMallItem"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointMallCategory"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointMallSearch"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointTabSearch"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointMallOrderList"];
    //积分商城-商品评价
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointMallComment"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointMallCommentList"];
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"pointDetail"];
    //积分商城-收银台
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"cashierPoint"];
    // 已返淘米
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallCashback"];
    

    
    // 商品评价
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallComment"];
    // 商品退款申请
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallRefundApply"];
    // 商品退款历史
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallRefundHistory"];
    // 商品退款详情
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallRefundDetail"];
    // 商品评论列表
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallCommentList"];
    
    // 订单列表
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallOrderList"];
    // 订单
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallOrder"];
    
    // 商品
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallItem"];
    
    // 购物车
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallCart"];
    
    // 联系人列表
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"consigneeSelect"];
    // 联系人编辑
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"consigneeEdit"];
    
    // 收银台
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"cashier"];
    
    // 店铺
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"mallShop"];
    
    
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    
    if ([url.scheme isEqualToString:APP_SCHEME]) {
        
        
        if ([url.host isEqualToString:@"mallComment"]) {
            
            ReviewsViewController *vc = [[ReviewsViewController alloc] init];
            vc.orderId = urlParams[@"orderId"];
            [urlParams removeObjectForKey:@"orderId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallRefundApply"]) {
            
            RFApplyViewController *vc = [[RFApplyViewController alloc]init];
            vc.orderId = urlParams[@"orderId"];
            [urlParams removeObjectForKey:@"orderId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallRefundHistory"]) {
            
            RFHistoryViewController *vc = [[RFHistoryViewController alloc]init];
            vc.orderId = urlParams[@"orderId"];
            [urlParams removeObjectForKey:@"orderId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallRefundDetail"]) {
            
            RFDetailViewController *vc = [[RFDetailViewController alloc]init];
            vc.orderId = urlParams[@"orderId"];
            [urlParams removeObjectForKey:@"orderId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallCommentList"]) {
            
            CommentListViewController *vc = [[CommentListViewController alloc]init];
            vc.itemId = urlParams[@"itemId"];
            [urlParams removeObjectForKey:@"itemId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallOrderList"]) {
     
            
            OrderViewPagerController *vc = [[OrderViewPagerController alloc] init];
            vc.type = urlParams[@"type"];
            
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallOrder"]) {
            
            OrderViewController *vc = [[OrderViewController alloc] init];
            vc.orderId = urlParams[@"orderId"];
            [urlParams removeObjectForKey:@"orderId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallItem"]) {
            
            ItemViewController *vc = [[ItemViewController alloc] init];
            vc.itemId = urlParams[@"itemId"];
            [urlParams removeObjectForKey:@"itemId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallCart"]) {
            
            CartViewController *vc = [[CartViewController alloc] init];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"consigneeEdit"]) {
            
            ConsigneeEditViewController *vc = [[ConsigneeEditViewController alloc] init];
            vc.consigneeId = urlParams[@"consigneeId"];
            [urlParams removeObjectForKey:@"consigneeId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"consigneeSelect"]) {
            
            ConsigneeSelectViewController *vc = [[ConsigneeSelectViewController alloc] init];
            vc.consigneeId = urlParams[@"consigneeId"];
            [urlParams removeObjectForKey:@"consigneeId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"cashier"]) {
            
            CashierViewController *vc = [[CashierViewController alloc] init];
            vc.vipPay = urlParams[@"vipPay"];
            [urlParams removeObjectForKey:@"vipPay"];
            vc.totalPrice = urlParams[@"totalPrice"];
            [urlParams removeObjectForKey:@"totalPrice"];
            vc.payId = urlParams[@"payId"];
            [urlParams removeObjectForKey:@"payId"];
            vc.orders = urlParams[@"orders"];
            [urlParams removeObjectForKey:@"orders"];
            vc.from = urlParams[@"from"];
            [urlParams removeObjectForKey:@"from"];
            vc.type = urlParams[@"type"];
            [urlParams removeObjectForKey:@"type"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        } else if ([url.host isEqualToString:@"mallShop"]) {
            
            ShopViewController *vc = [[ShopViewController alloc] init];
            vc.shopId = urlParams[@"shopId"];
            [urlParams removeObjectForKey:@"shopId"];
            vc.extraParams = urlParams;
            [navigationController pushViewController:vc animated:YES];
            
        }else if ([url.host isEqualToString:@"pointMallCategory"]) {
            PMCategoryViewController *vc = [[PMCategoryViewController alloc] init];
            vc.categoryId = urlParams[@"categoryId"];
            [navigationController pushViewController:vc animated:YES];
            
        }
        else if ([url.host isEqualToString:@"pointMallSearch"]) {
            MallItemSearchViewController *vc = [[MallItemSearchViewController alloc] init];
            vc.key = urlParams[@"key"];
            vc.cateId = urlParams[@"cateId"];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"pointDetail"]) {
            // 积分明细
            PMPointDetailViewController *vc = [[PMPointDetailViewController alloc] init];
            [navigationController pushViewController:vc animated:YES];
        }else if ([url.host isEqualToString:@"mallCashback"]) {
            ODReturnPointViewController *vc = [[ODReturnPointViewController alloc] init];
            vc.planId = urlParams[@"planId"];
            [navigationController pushViewController:vc animated:YES];
        }
    }
    
}

@end
