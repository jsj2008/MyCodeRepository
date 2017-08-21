//
//  AfterSaleListViewController.m
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "AfterSaleListViewController.h"
#import "OrderRequest.h"

#import "ODLStatusCell.h"
#import "ODLShopCell.h"
#import "ODLSkuCell.h"
#import "ODLTotalCell.h"
#import "ODLOperateCell.h"

#define ORDERLIST_ROW_EMPTY    0
#define ORDERLIST_ROW_STATUS   1
#define ORDERLIST_ROW_SHOP     2

#define CELL_TYPE_EMPTY     @"0"
#define CELL_TYPE_STATUS    @"1"
#define CELL_TYPE_SHOP      @"2"
#define CELL_TYPE_SKU       @"3"
#define CELL_TYPE_TOTAL     @"4"
#define CELL_TYPE_OPERATE   @"5"

@interface AfterSaleListViewController () <ODLOperateCellDelegate>

@property (nonatomic, strong) NSMutableArray<ODLFeedModel> *orders;
@property (nonatomic, strong) NSMutableDictionary *cellsType;
@property (nonatomic, strong) NSMutableDictionary *tempData;

@end

@implementation AfterSaleListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    //self.hideNavigationBar = YES;
    
    [super viewDidLoad];

    self.view.backgroundColor = Color_Gray245;
    self.title = @"售后";
    //self.tableView.top = 0;
    //self.tableView.height = SCREEN_HEIGHT - TabsViewHeight - NAVBAR_HEIGHT;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self initData];
    
}

#pragma mark - Private Methods

- (void)initData {
    
    self.orders = [NSMutableArray<ODLFeedModel> array];
    self.cellsType = [NSMutableDictionary dictionary];
    self.tempData = [NSMutableDictionary dictionary];
    
    self.loadingType = kInit;
    [self loadData];
    
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ( kLoadMore == self.loadingType ) {
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [OrderRequest getAfterSaleListMoreDataWithParams:params success:^(OrderListResultModel *resultModel) {
            
            
            if ( resultModel && resultModel.orders ) {
                
                [self.orders addObjectsFromSafeArray:resultModel.orders.list];
                
                if( resultModel.orders.isEnd ){
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
                
                self.wp = resultModel.orders.wp;
                
                [self calculateCellType];
                
            }
            
            [self finishLoadMore];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            DBG(@"%@", status);
            
            [self finishLoadMore];
            
        }];
        
    } else {
        
        //[params setSafeObject:@"5" forKey:@"status"];
        
        [OrderRequest getAfterSaleListDataWithParams:params success:^(OrderListResultModel *resultModel) {
            
            [self hideEmptyTips];
            [self.orders removeAllObjects];
            [self hideEmptyTips];
            
            if ( resultModel && resultModel.orders ) {
                
                [self.orders addObjectsFromSafeArray:resultModel.orders.list];
                
                if( resultModel.orders.isEnd ){
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
                
                self.wp = resultModel.orders.wp;
                
                [self calculateCellType];
                
            }
            
            if (resultModel.orders.list.count == 0) {
                NSString *noticeStr = @"您还没有相关订单哦";
                [self showEmptyTips:noticeStr ownerView:self.tableView];
                self.tableView.showsInfiniteScrolling = NO;
            }
            
            //            [self hideErrorTips];
            [self finishRefresh];
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            DBG(@"%@", status);
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
            
        }];
    }
    
    
}

- (void) calculateCellType {
    
    NSInteger section = 0;
    
    [self.cellsType removeAllObjects];
    
    for (ODLFeedModel *order in self.orders) {
        
        NSMutableArray *rowCellsType = [NSMutableArray array];
        
        [rowCellsType addObject:@{@"type":CELL_TYPE_EMPTY}];
        [rowCellsType addObject:@{@"type":CELL_TYPE_STATUS}];
        
        for (ODLSubOrderInfoModel *subOrder in order.orderInfos) {
            
            [rowCellsType addObject:@{@"type":CELL_TYPE_SHOP, @"shopName":subOrder.shopName,@"shopLink":subOrder.shopLink?subOrder.shopLink:@""}];
            
            for (ODLSkuInfoModel *sku in subOrder.skuInfo) {
                
                [rowCellsType addObject:@{@"type":CELL_TYPE_SKU, @"sku":sku}];
                
            }
        }
        
        [rowCellsType addObject:@{@"type":CELL_TYPE_TOTAL}];
        [rowCellsType addObject:@{@"type":CELL_TYPE_OPERATE}];
        
        [self.cellsType setObject:rowCellsType forKey:[NSString stringWithFormat:@"%ld", section++]];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( self.orders ) {
        
        NSInteger numberOfRows = 0;
        
        ODLFeedModel *orderFeed = [self.orders safeObjectAtIndex:section];
        
        for ( ODLSubOrderInfoModel *subOrder in orderFeed.orderInfos) {
            
            numberOfRows += 1 + subOrder.skuInfo.count;
            
        }
        
        numberOfRows += 4;
        
        return numberOfRows;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODLFeedModel *orderFeed = [self.orders safeObjectAtIndex:indexPath.section];
    
    if (orderFeed) {
        
        NSArray *rowCellsType = [self.cellsType objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section]];
        NSDictionary *cellTypeInfo = [rowCellsType safeObjectAtIndex:indexPath.row];
        NSString *cellType = cellTypeInfo[@"type"];
        
        if ( [CELL_TYPE_STATUS isEqualToString:cellType]) {
            
            ODLStatusCell *cell = [ODLStatusCell dequeueReusableCellForTableView:tableView];
            cell.cellData = orderFeed.statusForShow;
            [cell reloadData];
            return cell;
            
        } else if ( [CELL_TYPE_SHOP isEqualToString:cellType] ) {
            
            ODLShopCell *cell = [ODLShopCell dequeueReusableCellForTableView:tableView];
            cell.cellData = cellTypeInfo;//cellTypeInfo[@"shopName"];
            [cell reloadData];
            return cell;
            
        } else if ( [CELL_TYPE_SKU isEqualToString:cellType] ) {
            ODLSkuCell *cell = [ODLSkuCell dequeueReusableCellForTableView:tableView];
            cell.cellData = cellTypeInfo[@"sku"];
            [cell reloadData];
            return cell;
        } else if ( [CELL_TYPE_TOTAL isEqualToString:cellType] ) {
            ODLTotalCell *cell = [ODLTotalCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"totalPrice":orderFeed.totalPrice, @"shippingFee":orderFeed.shippingFee};
            [cell reloadData];
            return cell;
        } else if ( [CELL_TYPE_OPERATE isEqualToString:cellType] ) {
            ODLOperateCell *cell = [ODLOperateCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"buttons":orderFeed.buttons?orderFeed.buttons:@{},@"status":orderFeed.status, @"orderId":orderFeed.orderId, @"payLink":orderFeed.payLink ? orderFeed.payLink :(orderFeed.link?orderFeed.link: @""), @"orders":orderFeed.payId ? orderFeed.payId :(orderFeed.orderId?orderFeed.orderId :@"")};
            cell.delegate = self;
            [cell reloadData];
            return cell;
        }
        
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODLFeedModel *orderFeed = [self.orders safeObjectAtIndex:indexPath.section];
    
    CGFloat height = 0;
    
    if ( orderFeed ) {
        
        NSArray *rowCellsType = [self.cellsType objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section]];
        NSDictionary *cellTypeInfo = [rowCellsType safeObjectAtIndex:indexPath.row];
        NSString *cellType = cellTypeInfo[@"type"];
        
        if ([CELL_TYPE_EMPTY isEqualToString:cellType]) {
            
            height = 14;
            
        } else if ( [CELL_TYPE_STATUS isEqualToString:cellType] ) {
            
            height = [ODLStatusCell heightForCell:orderFeed.statusForShow];
            
        } else if ( [CELL_TYPE_SHOP isEqualToString:cellType] ) {
            
            height = [ODLShopCell heightForCell:cellTypeInfo[@"shopName"]];
            
        } else if ( [CELL_TYPE_SKU isEqualToString:cellType] ) {
            
            height = [ODLSkuCell heightForCell:cellTypeInfo[@"sku"]];
            
        } else if ( [CELL_TYPE_TOTAL isEqualToString:cellType] ) {
            
            height = [ODLTotalCell heightForCell:@{@"totalPrice":orderFeed.totalPrice, @"shippingFee":orderFeed.shippingFee}];
            
        } else if ( [CELL_TYPE_OPERATE isEqualToString:cellType] ) {
            height = [ODLOperateCell heightForCell:@{@"buttons":orderFeed.buttons?orderFeed.buttons:@{},@"status":orderFeed.status, @"orderId":orderFeed.orderId, @"payLink":orderFeed.payLink ? orderFeed.payLink :(orderFeed.link?orderFeed.link: @""), @"orders":orderFeed.payId ? orderFeed.payId :(orderFeed.orderId?orderFeed.orderId :@"")}];
            
        }
        
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ODLFeedModel *orderFeed = [self.orders safeObjectAtIndex:indexPath.section];
    
    if ( orderFeed ) {
        [[TTNavigationService sharedService] openUrl:orderFeed.link];
    }
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - ODLOperateCellDelegate

- (void) payButtonDidTappedWithPayLink:(NSString *)payLink {
    
    if ( IsEmptyString(payLink) ) {
        return;
    }
    
    [[TTNavigationService sharedService] openUrl:payLink];
    
}

- (void) receiptButtonDidTappedWithOrderId:(NSString *)orderId {
    
    if ( IsEmptyString(orderId)) {
        return;
    }
    
    [self.tempData setSafeObject:orderId forKey:@(10001)];
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

- (void) deleteButtonDidTappedWithOrderId:(NSString *)orderId {
    
    if ( IsEmptyString(orderId)) {
        return;
    }
    
    [self.tempData setSafeObject:orderId forKey:@(10003)];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要删除订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10003;
    [alertView show];
    
}

- (void) cancelButtonDidTappedWithOrderId:(NSString *)orderId {
    
    if ( IsEmptyString(orderId)) {
        return;
    }
    
    [self.tempData setSafeObject:orderId forKey:@(10004)];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要取消订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10004;
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    DBG(@"%ld", (long)buttonIndex); //0
    
    if ( alertView.tag == 10001) { // 收货
        
        if ( 1 == buttonIndex ) {
            
            NSString *orderId = [self.tempData objectForKey:@(10001)];
            
            NSDictionary *param = @{@"orderId":orderId};
            
            weakify(self);
            
            [OrderRequest receiptOrderWithParams:param success:^{
                
                strongify(self);
                
                for (ODLFeedModel *order in self.orders) {
                    
                    if ( [order.orderId isEqualToString:orderId] ) {
                        order.status = @"3";
                    }
                    
                }
                
                [self reloadData];
                
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
            
            NSString *orderId = [self.tempData objectForKey:@(10003)];
            
            NSDictionary *param = @{@"orderId":orderId};
            
            weakify(self);
            
            [OrderRequest deleteOrderWithParams:param success:^{
                
                for (ODLFeedModel *order in self.orders) {
                    
                    if ( [order.orderId isEqualToString:orderId] ) {
                        [self.orders removeObject:order];
                        break;
                    }
                    
                }
                
                [self reloadData];
                
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
            
            NSString *orderId = [self.tempData objectForKey:@(10004)];
            
            NSDictionary *param = @{@"orderId":orderId};
            
            weakify(self);
            
            [OrderRequest cancelOrderWithParams:param success:^{
                
                strongify(self);
                
                //                for (ODLFeedModel *order in self.orders) {
                //
                //                    if ( [order.orderId isEqualToString:orderId] ) {
                //                        order.status = @"31";
                //                    }
                //
                //                }
                //
                //                [self reloadData];
                
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


@end
