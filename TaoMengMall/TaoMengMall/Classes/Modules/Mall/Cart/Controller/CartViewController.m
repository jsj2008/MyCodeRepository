//
//  CartViewController.m
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CartViewController.h"
#import "CartSubmitViewController.h"

#import "CartRequest.h"
#import "ItemRequest.h"

#import "ItemResultModel.h"
#import "CartInfoModel.h"

#import "CTShopInfoCell.h"
#import "CTSkuInfoCell.h"
#import "CTClearInvalidCell.h"

#import "CTTotalBarView.h"
#import "ITSKUSelectView.h"

#define CART_ROW_EMPTY 0
#define CART_ROW_SHOP 1

@interface CartViewController() <CTTotalBarDelegate,CTShopInfoCellDelegate,ITSKUSelectDelegate,CTSkuInfoCellDelegate>

@property (nonatomic, strong) NSMutableArray<CartInfoModel> *cartInfo;
@property (nonatomic, strong) NSArray *invalidCartItems;
@property (nonatomic, strong) CTTotalBarView *totalBarView;
@property (nonatomic, strong) NSMutableDictionary *selectInfo;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) MBProgressHUD *loadingProgressHUD;

@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) NSMutableDictionary *editingShops;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) ITSKUSelectView *skuSelectView;
@property (nonatomic, strong) ItemInfoModel *itemInfo;
@property (nonatomic, strong) CTSkuInfoModel *currentCartItem;
@end

@implementation CartViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray240;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 32);
    rightButton.titleLabel.font = FONT(18);
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(handleRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButton = rightButton;
    self.editButton = rightButton;
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;

    self.title = @"购物车";
    
    [self initTotalBarView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectChanged:) name:kNOTIFY_CART_SELECT_CHANGE object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self hideLoading];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];
}

#pragma mark - Private Methods

- (void)initData
{
    self.selectInfo = [NSMutableDictionary dictionary];
    self.editingShops = [NSMutableDictionary dictionary];
    self.cartInfo = [NSMutableArray<CartInfoModel> array];
    
    self.totalPrice = @"0";
    self.totalBarView.selected = NO;
    [self.totalBarView reloadData:@{@"totalPrice":@"￥0.00",
                                    @"savePrice":@"￥0.00",
                                    @"skuCount":@"0"
                                    }];

    self.loadingType = kInit;
    //[self initTotalBarView];
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    
    [CartRequest getCartDataWithParams:params success:^(CartResultModel *resultModel) {
        [self hideEmptyTips];
        
        [self.cartInfo removeAllObjects];
        
        if (resultModel.cartInfo.count > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cartHasItems"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cartHasItems"];
        }
        
        [self.cartInfo addObjectsFromSafeArray:resultModel.cartInfo];
        
        self.invalidCartItems = resultModel.invalidSkus;
        
        if (resultModel.cartInfo.count <= 0 && resultModel.invalidSkus.count<=0) {
            NSString *noticeStr = @"您的购物车中还没有商品哦";
            [self showEmptyTips:noticeStr ownerView:self.tableView];
        }
        
        [self finishRefresh];
        [self reloadData];
        [self checkTotalBar];
        [self requestTotalPrice];
        
    } failure:^(StatusModel *status) {
        DBG(@"%@", status);
        [self showNotice:status.msg];
        [self reloadData];
        [self finishRefresh];
    }];
    
}

- (void) initTotalBarView {
    if (!self.totalBarView) {
        self.totalBarView = [[CTTotalBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, TOTAL_BAR_VIEW_HEIGHT)];
        self.totalBarView.bottom = self.view.height;
        
        self.totalBarView.delegate = self;
        
        [self.view addSubview:self.totalBarView];
    }
}

- (ITSKUSelectView *)createSkuSelectView
{
    if (self.itemInfo) {
        ITSKUSelectView *skuSelectView = [[ITSKUSelectView alloc] initWithSkuInfo:self.itemInfo.skuInfo itemTitle:self.itemInfo.title];
        skuSelectView.delegate = self;
        return skuSelectView;
    }
    return nil;
}

#pragma mark - Selection & editing
- (BOOL) shopSelected:(NSString *)shopId {
    
    return [[self.selectInfo objectForKey:[NSString stringWithFormat:@"shopId_%@", shopId]] boolValue];
    
}

- (void) setShopSelected:(BOOL)selected shopId:(NSString *)shopId{
    
    [self.selectInfo setObject:selected ? @YES : @NO forKey:[NSString stringWithFormat:@"shopId_%@", shopId]];
    
}

- (void) removeShopSelectedWithShopId:(NSString *)shopId{
    
    [self.selectInfo removeObjectForKey:[NSString stringWithFormat:@"shopId_%@", shopId]];
    
}

- (BOOL) shopEditing:(NSString *)shopId {
    
    return [[self.editingShops objectForKey:[NSString stringWithFormat:@"shopId_%@", shopId]] boolValue];
    
}

- (void) setShopEditing:(BOOL)editing shopId:(NSString *)shopId{
    
    [self.editingShops setObject:editing ? @YES : @NO forKey:[NSString stringWithFormat:@"shopId_%@", shopId]];
    
}

- (void) removeShopEditingWithShopId:(NSString *)shopId{
    
    [self.editingShops removeObjectForKey:[NSString stringWithFormat:@"shopId_%@", shopId]];
    
}


//- (BOOL) skuSelected:(NSString *)skuId {
//    
//    return [[self.selectInfo objectForKey:[NSString stringWithFormat:@"skuId_%@", skuId]] boolValue];
//    
//}
//
//- (void) setSkuSelected:(BOOL)selected skuId:(NSString *)skuId{
//    
//    [self.selectInfo setObject:selected ? @YES : @NO forKey:[NSString stringWithFormat:@"skuId_%@", skuId]];
//    
//}
//
//- (void) removeSkuSelectedWithSkuId:(NSString *)skuId{
//    
//    [self.selectInfo removeObjectForKey:[NSString stringWithFormat:@"skuId_%@", skuId]];
//    
//}
//
//- (NSArray *) selectdSkus {
//    
//    NSMutableArray *selectdSkus = [NSMutableArray array];
//    
//    for ( CartInfoModel *cart in self.cartInfo) {
//        
//        for ( CTSkuInfoModel *sku in cart.skuInfo ) {
//            
//            if ( [self skuSelected:sku.skuId] && ( [@"0" isEqualToString:sku.status] || [@"3" isEqualToString:sku.status] ) ) {
//                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"skuId":sku.skuId, @"amount":sku.amount, @"cartId":sku.cartId}];
//                [selectdSkus addObject:dict];
//            }
//        }
//    }
//    
//    return selectdSkus;
//}

- (BOOL) cartItemSelected:(NSString *)cartId {
    
    return [[self.selectInfo objectForKey:[NSString stringWithFormat:@"cartId_%@", cartId]] boolValue];
    
}

- (void) setCartItemSelected:(BOOL)selected cartId:(NSString *)cartId{
    
    [self.selectInfo setObject:selected ? @YES : @NO forKey:[NSString stringWithFormat:@"cartId_%@", cartId]];
    
}

- (void) removeCartItemSelectedWithCartItem:(NSString *)cartId{
    
    [self.selectInfo removeObjectForKey:[NSString stringWithFormat:@"cartId_%@", cartId]];
    
}

- (NSArray *) selectdCartItems {
    
    NSMutableArray *selectdSkus = [NSMutableArray array];
    if (self.selectInfo.count > 0) {
        for ( CartInfoModel *cart in self.cartInfo) {
            
            for ( CTSkuInfoModel *sku in cart.skuInfo ) {
                
                if ( [self cartItemSelected:sku.cartId] && IsEmptyString(sku.error) ) {
                    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"skuId":sku.skuId, @"amount":sku.amount, @"cartId":sku.cartId}];
                    [selectdSkus addObject:dict];
                }
            }
        }
    }
    return selectdSkus;
}

#pragma mark - Custom Methods
- (void)checkTotalBar
{
    NSInteger skuCount = [self selectdCartItems].count;
    if (skuCount > 0) {
        //检查totalBarView是否应该选中
        NSInteger selectableCount = 0;
        for ( CartInfoModel *cart in self.cartInfo) {
            
            for ( CTSkuInfoModel *sku in cart.skuInfo ) {
                
                if ( IsEmptyString(sku.error)){
                    selectableCount ++;
                }
            }
        }
        BOOL selected = selectableCount == skuCount;
        self.totalBarView.selected = selected;
    }else{
        self.totalBarView.selected = NO;
        
    }
}

- (void)clearInvalidSkus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [CartRequest clearInvalidItemWithParams:params success:^{
        [self loadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}
/*
- (void) calculateCart {
    
    if ( self.totalBarView ) {
        
        CGFloat totalPrice = 0;
        CGFloat savePrice = 0;
        NSInteger skuCount = 0;
        
        for ( CartInfoModel *cart in self.cartInfo) {
            
            for ( CTSkuInfoModel *sku in cart.skuInfo ) {
                
                if ( [self cartItemSelected:sku.cartId] ) {
                    
                    totalPrice += [sku.price floatValue] * [sku.amount integerValue];
                    
                    if ( !IsEmptyString(sku.oPrice)) {
                        savePrice += ( [sku.oPrice floatValue] - [sku.price floatValue] ) * [sku.amount integerValue];
                    }
                    
                    skuCount += [sku.amount integerValue];
                }
                
            }
            
        }
        
        [self.totalBarView reloadData:@{@"totalPrice":[NSString stringWithFormat:@"%.2f", totalPrice],
                                        @"savePrice":[NSString stringWithFormat:@"%.2f", savePrice],
                                        @"skuCount":[NSString stringWithFormat:@"%ld", (long)skuCount],
                                        }];
    }
    
}*/


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cartInfo.count + 1 + 1;

//    if ( self.cartInfo ) {
//        return self.cartInfo.count + 1 + 1;
//    } else {
//        return 0;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == self.cartInfo.count ) {
        
        return 3 + self.invalidCartItems.count;
        
    }else if (section == self.cartInfo.count + 1) {
        
        return 1;
        
    } else {
        if ( [self.cartInfo safeObjectAtIndex:section] ) {
            return ((CartInfoModel *)[self.cartInfo safeObjectAtIndex:section]).skuInfo.count + 2;
        } else {
            return 0;
        }
    }
//    if ( self.cartInfo ) {
//
//        if ( section == self.cartInfo.count ) {
//            
//            return 3 + self.invalidCartItems.count;
//
//        }else if (section == self.cartInfo.count + 1) {
//            
//            return 1;
//            
//        } else {
//            if ( [self.cartInfo safeObjectAtIndex:section] ) {
//                return ((CartInfoModel *)[self.cartInfo safeObjectAtIndex:section]).skuInfo.count + 2;
//            } else {
//                return 0;
//            }
//        }
//        
//    } else {
//        return 0;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    if ( section < self.cartInfo.count ) {
        
        if ( CART_ROW_EMPTY == row ) {
            
            BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
            [cell reloadData];
            return cell;
            
        } else if ( CART_ROW_SHOP == row ) {
            
            CTShopInfoModel *shopInfo = ((CartInfoModel *)[self.cartInfo safeObjectAtIndex:section]).shopInfo;
            
            CTShopInfoCell *cell = [CTShopInfoCell dequeueReusableCellForTableView:tableView];
            
            cell.cellData = shopInfo;
            cell.selected = [self shopSelected:shopInfo.shopId];
            cell.xxEditing = self.isEditing;
            cell.isShopEditing = [self shopEditing:shopInfo.shopId];
            
            cell.delegate = self;
            [cell reloadData];
            return cell;
            
        } else {
            
            CartInfoModel *cartInfo = [self.cartInfo safeObjectAtIndex:section];

            CTSkuInfoModel *skuInfo = [cartInfo.skuInfo safeObjectAtIndex:row - 2];
            
            CTSkuInfoCell *cell = [CTSkuInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = skuInfo;
            
            if ( row - 2 == [((CartInfoModel *)[self.cartInfo safeObjectAtIndex:section]).skuInfo count] - 1) {
                cell.isLast = YES;
            } else {
                cell.isLast = NO;
            }
            
            cell.selected = [self cartItemSelected:skuInfo.cartId];
            cell.xxEditing = self.isEditing;
            cell.isShopEditing = [self shopEditing:cartInfo.shopInfo.shopId];
            cell.actionDelegate = self;
            [cell reloadData];
            return cell;
        }
        
    }else if (section == self.cartInfo.count){
        if (CART_ROW_EMPTY == row) {
            
        }else if (CART_ROW_SHOP == row) {
            CTShopInfoModel *shopInfo = [[CTShopInfoModel alloc]init];
            shopInfo.shopName = @"失效商品";
            CTShopInfoCell *cell = [CTShopInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = shopInfo;
            [cell reloadData];
            return cell;
        }else if (row <= self.invalidCartItems.count + 1){
            CTSkuInfoModel *skuInfo = [self.invalidCartItems safeObjectAtIndex:row - 2];
            CTSkuInfoCell *cell = [CTSkuInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = skuInfo;
            if ( row - 2 == [self.invalidCartItems count] - 1) {
                cell.isLast = YES;
            } else {
                cell.isLast = NO;
            }
            [cell reloadData];
            return cell;
        }else if (row == self.invalidCartItems.count + 2) {
            CTClearInvalidCell *cell = [CTClearInvalidCell dequeueReusableCellForTableView:tableView];
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
    CGFloat height = 0;
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if ( section < self.cartInfo.count ) {
        if (self.cartInfo) {
            if ( CART_ROW_EMPTY == row ) {
                
                return 14;
                
            } else if ( CART_ROW_SHOP == row ) {
                
                CTShopInfoModel *shopInfo = ((CartInfoModel *)[self.cartInfo safeObjectAtIndex:section]).shopInfo;
                
                return height = [CTShopInfoCell heightForCell:shopInfo];
                
            } else {
                
                CTSkuInfoModel *skuInfo = [((CartInfoModel *)[self.cartInfo safeObjectAtIndex:section]).skuInfo safeObjectAtIndex:row - 2];
                
                return height = [CTSkuInfoCell heightForCell:skuInfo];
            }
        }else{
            return 0;
        }
    } else if (section == self.cartInfo.count) {
        if (self.invalidCartItems.count) {
            if ( CART_ROW_EMPTY == row ) {
                
                return 14;
                
            } else if ( CART_ROW_SHOP == row ) {
                
                return height = [CTShopInfoCell heightForCell:@""];
                
            } else if(row <= self.invalidCartItems.count + 1) {
                
                CTSkuInfoModel *skuInfo = [self.invalidCartItems safeObjectAtIndex:row - 2];
                return height = [CTSkuInfoCell heightForCell:skuInfo];
                
            } else if (row == self.invalidCartItems.count + 2) {
                
                return height = [CTClearInvalidCell heightForCell:@""];
            }

        }else{
            return 0;
        }
    } else {
        return TOTAL_BAR_VIEW_HEIGHT+20;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == self.cartInfo.count && self.invalidCartItems.count>0) {
      if (row == self.invalidCartItems.count + 2) {
          [self clearInvalidSkus];
      }
    }
}

#pragma mark - UIAletView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.firstOtherButtonIndex == buttonIndex) {
        
    }
}

#pragma mark - CTShopInfoCellDelegate
- (void)editTappedWithModel:(id)model
{
    CTShopInfoModel *shopInfo = (CTShopInfoModel*)model;
    [self setShopEditing:![self shopEditing:shopInfo.shopId] shopId:shopInfo.shopId];
    [self reloadData];
}

#pragma mark - CTSkuInfoCellDelegate
- (void)dropdownButtonTappedWithModel:(id)model
{
    self.currentCartItem = model;
    
    CTSkuInfoModel *skuInfo = (CTSkuInfoModel*)model;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:skuInfo.itemId forKey:@"itemId"];
    [ItemRequest getItemDataWithParams:params success:^(ItemResultModel *resultModel) {
        
        self.itemInfo = resultModel.itemInfo;
        
        //设置预选中的property
        NSMutableArray *properties = [NSMutableArray array];
        for (NSString *proertyKey in skuInfo.properties) {
            ITPropertyKVModel *property = [[ITPropertyKVModel alloc]init];
            property.k = proertyKey;
            [properties addObject:property];
        }
        self.skuSelectView = [self createSkuSelectView];
        self.skuSelectView.selectedProperties = properties;
        self.skuSelectView.amount = [skuInfo.amount integerValue];
        [self.skuSelectView show];

    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

#pragma mark - ITSKUSelectDelegate
- (void)addWithSkuInfo:(ITStockInfoModel *)skuInfo amount:(NSInteger)amount type:(NSString *)type
{
    [self.skuSelectView dismiss];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.currentCartItem.cartId forKey:@"cartId"];
    [params setSafeObject:skuInfo.skuId forKey:@"skuId"];
    [params setSafeObject:[NSString stringWithFormat:@"%lu",amount] forKey:@"amount"];
    
    [CartRequest amountChangeWithParams:params success:^{
        
        [self loadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];

    }];
}

#pragma mark - CTTotalBarDelegate

- (void)okButtonDidClick
{
    if (self.totalBarView.xxEditing) {
        if ([self selectdCartItems].count == 0) {
            [self showNotice:@"请选择要删除的商品"];
            return;
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除选中的商品么？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    if ( !self.cartInfo || self.cartInfo.count == 0) {
        return;
    }
    if ([self selectdCartItems].count == 0) {
        [self showNotice:@"请选择要结算的商品"];
        return;
    }
    if ([self.totalPrice isEqualToString:@"0"]) {
        [self showNotice:@"请检查您选择的商品"];
        return;
    }

    
    TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
    
    CartSubmitViewController *vc = [[CartSubmitViewController alloc] init];
    vc.cartSubmitData = [self selectdCartItems];
    [navigationController pushViewController:vc animated:YES];
}

#pragma mark - action
- (void)handleRightButton
{
    self.isEditing = !self.isEditing;
    self.editButton.selected = self.isEditing;
    //self.tableView.showsPullToRefresh = !self.isEditing;
    //self.totalBarView.xxEditing = self.isEditing;
    [self reloadData];
}

#pragma mark - TTErrorTipsViewDelegate

- (void)errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - Loading

- (void)showLoading {
    
    if (!self.loadingProgressHUD) {
        //初始化进度框，置于当前的View当中
        self.loadingProgressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.loadingProgressHUD];
        
        //如果设置此属性则当前的view置于后台
        self.loadingProgressHUD.dimBackground = YES;
        
        //设置对话框文字
        self.loadingProgressHUD.labelText = @"请稍等";
        
        //显示对话框
        [self.loadingProgressHUD show:YES];
    }
}

- (void)hideLoading
{
    if (self.loadingProgressHUD) {
        [self.loadingProgressHUD hide:YES];
        [self.loadingProgressHUD removeFromSuperview];
        self.loadingProgressHUD = nil;
        
    }
}


#pragma mark - Observing Methods

- (void)selectChanged:(NSNotification *)notification {
    
    DBG(@"%@", notification);
 
    NSString *type = [notification.userInfo objectForKey:@"type"];
    
    if ( [@"shop" isEqualToString:type] ) {
    
        NSString *shopId = [notification.userInfo objectForKey:@"id"];
        
        for ( CartInfoModel *cart in self.cartInfo) {
            
            if ( [cart.shopInfo.shopId isEqualToString:shopId]) {
                
                [self setShopSelected:[[notification.userInfo objectForKey:@"selected"] boolValue] shopId:shopId];
                
                for ( CTSkuInfoModel *sku in cart.skuInfo ) {
                    if (IsEmptyString(sku.error))
                    {
                        [self setCartItemSelected:[[notification.userInfo objectForKey:@"selected"] boolValue] cartId:sku.cartId];
                    }

                    
                }
                
            }
            
        }
        weakify(self);
        dispatch_async(dispatch_get_main_queue(),^{
            strongify(self);
            [self reloadData];
            [self checkTotalBar];
            //重新计算购物车价格
            [self requestTotalPrice];
        });
        return;
        
    } else if ( [@"cart" isEqualToString:type] ) {
        
        NSString *cartId = [notification.userInfo objectForKey:@"id"];
        
        CTSkuInfoModel *selectSku = nil;
        CartInfoModel *selectCart = nil;
        
        for ( CartInfoModel *cart in self.cartInfo) {
            
            for ( CTSkuInfoModel *sku in cart.skuInfo ) {
                
                if ( [cartId isEqualToString:sku.cartId] ) {
                    
                    selectSku = sku;
                    
                    if ( !selectCart ) {
                        selectCart = cart;
                    }
                    
                }
                
            }
            
        }
        
        if ( selectSku ) {
            
//            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
//            
//            [params setSafeObject:selectSku.cartId forKey:@"cartId"];
//            [params setSafeObject:[notification.userInfo objectForKey:@"amount"] forKey:@"amount"];
//
//            [CartRequest amountChangeWithParams:params success:^{
//                
//            } failure:^(StatusModel *status) {
//                [self showNotice:status.msg];
//            }];
            
            [self setCartItemSelected:[[notification.userInfo objectForKey:@"selected"] boolValue] cartId:selectSku.cartId];

            //selectSku.amount = [notification.userInfo objectForKey:@"amount"];
            
            if ( [[notification.userInfo objectForKey:@"selected"] boolValue] ) {
            
                NSInteger skuSelectCount = 0;
                NSInteger skuSelectableCount = 0;
                
                for ( CTSkuInfoModel *sku in selectCart.skuInfo ) {

                    if ( IsEmptyString(sku.error))
                    {
                        skuSelectableCount++;
                    }
                    if ( [self cartItemSelected:sku.cartId] ) {
                        skuSelectCount++;
                    }

                }

                if (skuSelectCount>0 && skuSelectCount == skuSelectableCount ) {
                    [self setShopSelected:YES shopId:selectCart.shopInfo.shopId];
                }
                
            } else {
                [self setShopSelected:NO shopId:selectCart.shopInfo.shopId];
                
            }
            
            dispatch_async(dispatch_get_main_queue(),^{
                [self reloadData];
                [self checkTotalBar];
                //重新计算购物车价格
                [self requestTotalPrice];
            });
            return;

        }
        
    } else if ( [@"all" isEqualToString:type] ) {
        
        for ( CartInfoModel *cart in self.cartInfo) {
            
            [self setShopSelected:[[notification.userInfo objectForKey:@"selected"] boolValue] shopId:cart.shopInfo.shopId];
            
            for ( CTSkuInfoModel *sku in cart.skuInfo ) {
                if ( IsEmptyString(sku.error))
                {
                    [self setCartItemSelected:[[notification.userInfo objectForKey:@"selected"] boolValue] cartId:sku.cartId];
                }
            }
            
        }
        dispatch_async(dispatch_get_main_queue(),^{
            [self reloadData];
            [self checkTotalBar];
            //重新计算购物车价格
            [self requestTotalPrice];
        });
        return;

    
    } else if ( [@"skuDelete" isEqualToString:type] ) {
    
        NSString *cartId = [notification.userInfo objectForKey:@"id"];
        
        CTSkuInfoModel *selectSku = nil;
        CartInfoModel *selectCart = nil;
        
        for ( CartInfoModel *cart in self.cartInfo) {
            
            for ( CTSkuInfoModel *sku in cart.skuInfo ) {
                
                if ( [cartId isEqualToString:sku.cartId] ) {
                    
                    selectSku = sku;
                    
                    if ( !selectCart ) {
                        selectCart = cart;
                    }
                    
                }
                
            }
            
        }
        
        if ( selectSku ) {
            
            CTSkuInfoModel *sku = [[CTSkuInfoModel alloc]init];
            sku.cartId = selectSku.cartId;
            sku.skuId = selectSku.skuId;
            sku.amount = @"0";
            
            [self reportCartWithSku:sku success:^{
                
                [self removeCartItemSelectedWithCartItem:selectSku.cartId];
                
                [selectCart.skuInfo removeObject:selectSku];
                
                if ( !selectCart.skuInfo || 0 == selectCart.skuInfo.count ) {
                    
                    [self removeShopSelectedWithShopId:selectCart.shopInfo.shopId];
                    [self.cartInfo removeObject:selectCart];
                    if (self.cartInfo.count > 0) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cartHasItems"];
                    }else{
                        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cartHasItems"];
                    }
                    
                } else {
                    
                    NSInteger skuSelectCount = 0;
                    NSInteger skuSelectableCount = 0;
                    
                    for ( CTSkuInfoModel *sku in selectCart.skuInfo ) {
                        if ( IsEmptyString(sku.error))
                        {
                            skuSelectableCount++;
                        }
                        if ( [self cartItemSelected:sku.cartId] ) {
                            skuSelectCount++;
                        }
                        
                    }
                    
                    if (skuSelectCount>0 && skuSelectCount == skuSelectableCount ) {
                        [self setShopSelected:YES shopId:selectCart.shopInfo.shopId];
                    }
                }
                
                [self reloadData];
                [self checkTotalBar];
            } failure:^{
                
            }];
            return;
        }
        
    }else if ([@"amount" isEqualToString:type]) {
        NSString *cartId = [notification.userInfo objectForKey:@"id"];
        
        CTSkuInfoModel *selectSku = nil;
        CartInfoModel *selectCart = nil;
        
        for ( CartInfoModel *cart in self.cartInfo) {
            
            for (CTSkuInfoModel *sku in cart.skuInfo) {
                
                if ( [cartId isEqualToString:sku.cartId] ) {
                    
                    selectSku = sku;
                    
                    if ( !selectCart ) {
                        selectCart = cart;
                    }
                    
                }
            }
        }
        
        if ( selectSku ) {
            
            dispatch_async(dispatch_get_main_queue(),^{
                //[self reloadData];
                //报告购物车选择情况
                [self reportCartWithSku:selectSku success:nil failure:nil];
                
            });
            return;
        }
    }
    [self reloadData];
}

- (void)requestTotalPrice
{
    NSArray *selectSkus = [self selectdCartItems];
    __block NSString *totalPrice = @"￥0.00";
    __block NSString *savePrice = @"￥0.00";
    __block NSInteger skuCount = selectSkus.count;
    
    if (skuCount > 0) {
        
        //查询价格
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:selectSkus
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        [params setObject:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] forKey:@"skus"];
        
        [self showLoading];
        
        weakify(self);
        [CartRequest getTotalPriceWithParams:params success:^(CTTotalPriceResultModel *resultModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                strongify(self);
                
                totalPrice = resultModel.totalPrice;
                self.totalPrice = totalPrice;
                savePrice = resultModel.saved;
                skuCount =  selectSkus.count;
                [self.totalBarView reloadData:@{@"totalPrice":totalPrice,
                                                @"savePrice": savePrice,
                                                @"skuCount":[NSString stringWithFormat:@"%ld", (long)skuCount]
                                                }];
                
                [self hideLoading];
            });
            
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self hideLoading];
        }];
        
    }else{
        [self hideLoading];
        self.totalBarView.selected = NO;
        [self.totalBarView reloadData:@{@"totalPrice":totalPrice,
                                        @"savePrice":savePrice,
                                        @"skuCount":[NSString stringWithFormat:@"%ld", (long)skuCount]                                            }];
    }
}

- (void)reportCartWithSku:(CTSkuInfoModel*)sku success:(void(^)())success failure:(void(^)())failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    [params setObject:sku.cartId forKey:@"cartId"];
    [params setObject:sku.amount forKey:@"amount"];
    [params setObject:sku.skuId forKey:@"skuId"];
    
    BOOL needUpdatePrice = [self cartItemSelected:sku.cartId];
    
    [self showLoading];
    [CartRequest amountChangeWithParams:params success:^{
        if (success) {
            success();
        }
        if (needUpdatePrice) {
            [self requestTotalPrice];
        }else{
            [self hideLoading];
        }
    } failure:^(StatusModel *status) {
        if (failure) {
            failure();
        }
        [self showNotice:status.msg];
        [self hideLoading];
    }];
}

@end
