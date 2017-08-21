//
//  OrderViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "OrderViewController.h"

#import "OrderRequest.h"

#import "ODItemInfoModel.h"
#import "ODConsigneeInfoModel.h"

#import "ODTotalBarView.h"
#import "ODStatusCell.h"
#import "ODExpressCell.h"
#import "ODConsigneeInfoCell.h"
#import "ODBuyerAdditionCell.h"
#import "ODShopInfoCell.h"
#import "ODTotalInfoCell.h"
#import "ODSkuInfoCell.h"
#import "ODPayMethodCell.h"
#import "ODCashBackCell.h"
#import "OrderInfoCell.h"
#import "ODOrderInfoCell.h"


#define SECTION_HEADER 0
#define ROW_STATUS     0
#define ROW_EXPRESS    1
#define ROW_CONSIGNEE  2
#define ROW_REMARK     3


#define ROW_EMPTY 0
#define ROW_SHOP 1

@interface OrderViewController() <ODTotalBarDelegate>
@property (nonatomic, strong) OrderResultModel *resultModel;
@property (nonatomic, strong) NSArray<ODItemInfoModel> *itemInfos;
@property (nonatomic, strong) ODConsigneeInfoModel *consigneeInfo;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *orders;
@property (nonatomic, strong) NSString *payLink;
@property (nonatomic, strong) NSString *refundLink;

@property (nonatomic, strong) ODTotalBarView *totalBarView;
@property (nonatomic, strong) NSDictionary *buttons;
@end

@implementation OrderViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"订单详情";
    
    //[self initData];
    
}

//确保退款申请返回后，刷新页面
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];
}

#pragma mark - Private Methods

- (void)initData
{

    
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    
    [params setSafeObject:self.orderId forKey:@"orderId"];
    
    weakify(self);
    
    [OrderRequest getOrderDataWithParams:params success:^(OrderResultModel *resultModel) {
        
        strongify(self);
        
        if (resultModel) {
            self.resultModel = resultModel;
            self.consigneeInfo = resultModel.consigneeInfo;
            self.itemInfos = resultModel.orderInfos;
            self.totalPrice = resultModel.totalPrice;
            self.status = resultModel.status;
            //self.orderId = resultModel.orderId;
            self.payLink = resultModel.payLink;
            self.orders = resultModel.orders;
            self.buttons = resultModel.buttons;
            
//            if ( [@"1" isEqualToString:self.status] ) {
//            
//                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                addButton.frame = CGRectMake(0, 0, 100, 20);
//                [addButton setTitle:@"取消订单" forState:UIControlStateNormal];
//                [addButton setTitleColor:Color_Gray66 forState:UIControlStateNormal];
//                addButton.titleLabel.font = FONT(14);
//                [addButton addTarget:self action:@selector(handleCancelButton) forControlEvents:UIControlEventTouchUpInside];
//                
//                self.navigationBar.rightBarButton = addButton;
//                
//            }
            
            [self hideErrorTips];
            
            [self reloadData];
            
            [self initTotalBarView];
            
        }
        
    } failure:^(StatusModel *status) {
        
        DBG(@"%@", status);
        
        strongify(self);
        
        if( status ) {
            [self showNotice:status.msg];
        } else {
            [self showNotice:@"获取订单信息失败"];
        }
        
    }];
    
}

- (void) initTotalBarView {
    
    if (!self.totalBarView) {
        self.totalBarView = [[ODTotalBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, TOTAL_BAR_VIEW_HEIGHT)];
        self.totalBarView.bottom = self.view.height;
        self.totalBarView.delegate = self;
        //self.totalBarView.status = self.status;
        [self.view addSubview:self.totalBarView];
    }
    self.totalBarView.totalPrice = self.totalPrice;
    self.totalBarView.viewData = self.buttons;
    [self.totalBarView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 0;
    
    if ( self.itemInfos ) {
        numberOfSections = 1 + self.itemInfos.count + 1 + 1 +1;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( self.itemInfos ) {
        
        if ( SECTION_HEADER == section ) {
            return 4;
        } else if( [self.itemInfos safeObjectAtIndex:section - 1] ) {
            
            return 1 + ((ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:section - 1]).skuInfo.count + 3;
            
        } else if (section == self.itemInfos.count + 1){
            
            return self.resultModel.payMethod?2:0;
            
        }else if (section == self.itemInfos.count + 2){
            
            return [self.itemInfos safeObjectAtIndex:0]?3:0;
        }else{
            return 1;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if ( self.itemInfos ) {
        
        if ( SECTION_HEADER == section ) {
            if (row == ROW_STATUS) {
                ODStatusCell *cell = [ODStatusCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel.statusDesc;
                [cell reloadData];
                return cell;

            }else if (row == ROW_EXPRESS) {
                ODExpressCell *cell = [ODExpressCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel.express;
                [cell reloadData];
                return cell;

            }else if (row == ROW_CONSIGNEE) {
                ODConsigneeInfoCell *cell = [ODConsigneeInfoCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.consigneeInfo;
                [cell reloadData];
                return cell;
            }else if (row == ROW_REMARK) {
                ODBuyerAdditionCell *cell = [ODBuyerAdditionCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel.buyerRemark;
                [cell reloadData];
                return cell;
            }
            
        } else if( [self.itemInfos safeObjectAtIndex:section - 1] ) {
            
            ODItemInfoModel *itemInfo = (ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:section - 1];
            
            if ( ROW_SHOP == row) {
                
                ODShopInfoCell *cell = [ODShopInfoCell dequeueReusableCellForTableView:tableView];
                cell.cellData = itemInfo.shopInfo;
                [cell reloadData];
                return cell;
                
            } else if ( row == itemInfo.skuInfo.count + 3 ) {
                
                ODTotalInfoCell *cell = [ODTotalInfoCell dequeueReusableCellForTableView:tableView];
                
                ODSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:0];

                cell.cellData = @{@"totalPrice":itemInfo.totalPrice, @"shippingFee":itemInfo.shippingFee, @"servicePrice":skuInfo.serviceCharge?skuInfo.serviceCharge:@""};
                [cell reloadData];
                return cell;
                
            } else if ( row == itemInfo.skuInfo.count + 2 ) {
//                ODItemInfoModel *itemInfo = (ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:0];
//                ODSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:0];
//                
//                ODCashBackCell *cell = [ODCashBackCell dequeueReusableCellForTableView:tableView];
//                cell.cellData = skuInfo.cashback;
//                [cell reloadData];
//                return  cell;
                
            }else if ( row != ROW_EMPTY ) {
                
                ODSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:row - 2];
                
                ODSkuInfoCell *cell = [ODSkuInfoCell dequeueReusableCellForTableView:tableView];
                cell.cellData = skuInfo;
                [cell reloadData];
                return cell;
            }
            
        } else if (self.itemInfos.count+1 == section) {
            if (row == 1) {
                ODPayMethodCell *cell = [ODPayMethodCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel.payMethod;
                [cell reloadData];
                return cell;
            }
        }else if (self.itemInfos.count+2 == section) {
            if (row == 1) {
                ODItemInfoModel *itemInfo = (ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:0];
                
                ODOrderInfoCell *cell = [ODOrderInfoCell dequeueReusableCellForTableView:tableView];
                cell.cellData = @{@"orderTime":itemInfo.orderTime?itemInfo.orderTime:@"", @"orderId":self.orderId?self.orderId:@"",@"points":itemInfo.point?itemInfo.point:@[],@"payTime":self.resultModel.payTime?self.resultModel.payTime:@""};
                [cell reloadData];
                return cell;
            }
        }
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if ( self.itemInfos ) {
        
        if ( SECTION_HEADER == section ) {
            if (ROW_STATUS == row) {
                height = [ODStatusCell heightForCell:self.resultModel.statusDesc];
            }else if (ROW_EXPRESS == row) {
                height = [ODExpressCell heightForCell:self.resultModel.express];
            }else if (ROW_CONSIGNEE == row) {
                height = [ODConsigneeInfoCell heightForCell:self.consigneeInfo];
            }else if (ROW_REMARK == row) {
                height = [ODBuyerAdditionCell heightForCell:self.resultModel.buyerRemark];
            }
            
        } else if( [self.itemInfos safeObjectAtIndex:section - 1] ) {
            
            ODItemInfoModel *itemInfo = (ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:section - 1];
            
            if ( ROW_EMPTY == row) {
                
                height = 14;
                
            } else if ( ROW_SHOP == row) {
                
                height = [ODShopInfoCell heightForCell:itemInfo.shopInfo];
                
            } else if ( row == itemInfo.skuInfo.count + 3 ) {
                ODSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:0];
                height = [ODTotalInfoCell heightForCell:@{@"totalPrice":itemInfo.totalPrice, @"shippingFee":itemInfo.shippingFee,@"servicePrice":skuInfo.serviceCharge?skuInfo.serviceCharge:@""}];
                
            }else if ( row == itemInfo.skuInfo.count + 2 ) {
                //ODItemInfoModel *itemInfo = (ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:0];
//                ODSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:0];
//                height = [ODCashBackCell heightForCell:skuInfo.cashback];
                height = 0;
                
            }else  {
                
                ODSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:row - 2];
                
                height = [ODSkuInfoCell heightForCell:skuInfo];
                
            }
        } else if (section == self.itemInfos.count+1){
            if (row == 1) {
                height = [ODPayMethodCell heightForCell:self.resultModel.payMethod];
            }else{
                height = 14;
            }
        }else if (section == self.itemInfos.count+2) {
             ODItemInfoModel *itemInfo = (ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:0];
            if (row == 1) {
                height = [ODOrderInfoCell heightForCell:@{@"orderTime":itemInfo.orderTime?itemInfo.orderTime:@"", @"orderId":self.orderId?self.orderId:@"",@"points":itemInfo.point?itemInfo.point:@[],@"payTime":self.resultModel.payTime?self.resultModel.payTime:@""}];
            }else{
                height = 14;
            }
        }
        else {
            height = TOTAL_BAR_VIEW_HEIGHT;
        }
    }
    
    return height;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
//    if ( self.itemInfos ) {
//        
//        if ( SECTION_HEADER == section ) {
//            
//            
//        } else if( [self.itemInfos safeObjectAtIndex:section - 1] ) {
//            
//            ODItemInfoModel *itemInfo = (ODItemInfoModel *)[self.itemInfos safeObjectAtIndex:section - 1];
//            
//            if ( ROW_EMPTY == row) {
//                
//                
//            } else if ( ROW_SHOP == row) {
//                
//                
//            } else if ( row == itemInfo.skuInfo.count + 2 ) {
//                
//                
//            } else {
//                
//                ODSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:row - 2];
//                if (IsEmptyString(skuInfo.refundLink)) {
//                    return;
//                }
//                [[TTNavigationService sharedService] openUrl:skuInfo.refundLink];
//                
//            }
//        }
//    }
//
//}

#pragma mark - TTErrorTipsViewDelegate

- (void)errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - ODTotalBarDelegate

- (void) payButtonDidTappedWithPayLink:(NSString *)payLink {
    
    if ( IsEmptyString(payLink) ) {
        return;
    }
    
    [[TTNavigationService sharedService] openUrl:payLink];
    
}

- (void) receiptButtonDidTapped {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要收货？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10001;
    [alertView show];
    
}

- (void) rateButtonDidTappedWithRateLink:(NSString *)rateLink {
    
    if ( IsEmptyString(rateLink)) {
        return;
    }
    [[TTNavigationService sharedService] openUrl:rateLink];
}

- (void) deleteButtonDidTapped{
    

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要删除订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10003;
    [alertView show];
    
}

- (void) cancelButtonDidTapped {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要取消订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10004;
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    DBG(@"%ld", (long)buttonIndex); //0
    
    if ( alertView.tag == 10001) { // 收货
        
        if ( 1 == buttonIndex ) {
            
            NSString *orderId = self.orderId;
            NSDictionary *param = @{@"orderId":orderId};
            
            weakify(self);
            
            [OrderRequest receiptOrderWithParams:param success:^{
                
                strongify(self);
                
                [self initData];

//                for (ODLFeedModel *order in self.orders) {
//                    
//                    if ( [order.orderId isEqualToString:orderId] ) {
//                        order.status = @"3";
//                    }
//                    
//                }
//                
//                [self reloadData];
                
            } failure:^(StatusModel *status) {
                
                strongify(self);
                DBG(@"%@", status);
                if( status ) {
                    
                    [self showNotice:status.msg];
                } else {
                    [self showNotice:@"收货发生异常"];
                }
                
            }];
        }
    } else if ( alertView.tag == 10003) { // 删除
        
        if ( 1 == buttonIndex ) {
            
            NSString *orderId = self.orderId;
            
            NSDictionary *param = @{@"orderId":orderId};
            
            weakify(self);
            
            [OrderRequest deleteOrderWithParams:param success:^{
                strongify(self);
                //[self showNotice:@"订单删除成功"];
                [self clickback];
                
            } failure:^(StatusModel *status) {
                
                strongify(self);
                DBG(@"%@", status);
                if( status ) {
                    [self showNotice:status.msg];
                } else {
                    [self showNotice:@"删除订单发生异常"];
                }
                
            }];
        }
    } else if ( alertView.tag == 10004) { // 取消
        
        if ( 1 == buttonIndex ) {
            
            NSString *orderId = self.orderId;
            
            NSDictionary *param = @{@"orderId":orderId};
            
            weakify(self);
            
            [OrderRequest cancelOrderWithParams:param success:^{
                
                strongify(self);
                
                [self initData];
                
            } failure:^(StatusModel *status) {
                
                strongify(self);
                DBG(@"%@", status);
                if( status ) {
                    
                    [self showNotice:status.msg];
                } else {
                    [self showNotice:@"取消订单发生异常"];
                }
                
            }];
        }
    }
    
}






//- (void) payButtonDidTapped {
//    
//    DBG(@"付款");
//    
//    if ( IsEmptyString(self.payLink)) {
//        return;
//    }
//    [[TTNavigationService sharedService] openUrl:self.payLink];
//    
//}
//
//- (void) receiptButtonDidTapped {
//    
//    DBG(@"收货");
//    
//    NSDictionary *param = @{@"orderId":self.orderId};
//    
//    weakify(self);
//    
//    [OrderRequest receiptOrderWithParams:param success:^{
//        
//        strongify(self);
//        
//        //self.status = @"3";
//        
//        //self.totalBarView.status = self.status;
//        [self initData];
//        
//    } failure:^(StatusModel *status) {
//        
//        strongify(self);
//        
//        if( status ) {
//            
//            [self showNotice:status.msg];
//        } else {
//            [self showNotice:@"收货发生异常"];
//        }
//        
//    }];
//    
//}
//
//- (void) rateButtonDidTapped {
//    
//    DBG(@"评价");
//    
//}
//
//#pragma mark - Event Response
//
//- (void) handleCancelButton {
//    
//    DBG(@"取消订单");
//    
//    NSDictionary *param = @{@"orderId":self.orderId};
//    
//    weakify(self);
//    
//    [OrderRequest cancelOrderWithParams:param success:^{
//        
//        strongify(self);
//        
//        [self showNotice:@"取消订单成功"];
//        
//        [self clickback];
//        
//    } failure:^(StatusModel *status) {
//        
//        strongify(self);
//        
//        if( status ) {
//            
//            [self showNotice:status.msg];
//        } else {
//            [self showNotice:@"取消订单发生异常"];
//        }
//        
//    }];
//    
//}

@end
