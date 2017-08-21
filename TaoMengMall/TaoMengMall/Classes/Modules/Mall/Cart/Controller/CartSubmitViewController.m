//
//  OrderSubmitViewController.m
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CartSubmitViewController.h"
#import "ConsigneeSelectViewController.h"
#import "CashierViewController.h"

#import "CartRequest.h"
#import "OrderRequest.h"

#import "CSItemInfoModel.h"
#import "CSConsigneeInfoModel.h"
#import "CartSubmitResultModel.h"
#import "ConsigneeModel.h"
#import "CSAdditionInfoModel.h"

#import "CSConsigneeInfoCell.h"
#import "CSShopInfoCell.h"
#import "CSSkuInfoCell.h"
#import "CSShippingListCell.h"
#import "CSTotalPriceCell.h"
#import "CSShippingFeeCell.h"
#import "CSTotalBarView.h"
#import "CSPointUsageCell.h"
#import "CSTimelessPointCell.h"
//#import "CSPlatformCouponCell.h"
#import "CSShopCouponCell.h"
#import "CSRemarkCell.h"

#import "CSCouponSelectView.h"
#import "CSShippingSelectView.h"

#define SECTION_CONSIGNEE 0

#define ROW_EMPTY 0
#define ROW_SHOP 1

@interface CartSubmitViewController()<CSTotalBarDelegate,CSCouponSelectViewDelegate,CSShippingSelectViewDelegate>

@property (nonatomic, strong) NSArray<CSItemInfoModel> *orderInfo;
@property (nonatomic, strong) NSArray *invalids;
@property (nonatomic, strong) CTDiscountInfoModel *discountInfo;
@property (nonatomic, strong) CSConsigneeInfoModel *consigneeInfo;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *platformPromotionId;

@property (nonatomic, strong) CSTotalBarView *totalBarView;
@property (nonatomic, strong) CSCouponSelectView *couponSelectView;
@property (nonatomic, strong) CSShippingSelectView *shippingSelectView;

//@property (nonatomic, strong) CSAdditionInfoModel *additionModel;
@property (nonatomic, strong) NSArray *points;
@property (nonatomic, strong) NSMutableDictionary *remarks;

@property (nonatomic, strong) NSMutableArray<CSPlatformCouponModel> *coupons;
@end

@implementation CartSubmitViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    [self initData];
    
    self.title = @"确认订单";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(consigneeSelected:) name:kNOTIFY_CART_CONSIGNEE_SELECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:CSOrderConfirmUsePointChanged object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:CSOrderConfirmUseTimelessPointChanged object:nil];
    
}

#pragma mark - Private Methods

- (void)initData
{
    self.loadingType = kInit;
    self.coupons = [NSMutableArray<CSPlatformCouponModel> array];
    //self.additionModel = [[CSAdditionInfoModel alloc]init];
    self.points = nil;
    self.remarks = [NSMutableDictionary dictionary];
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    [params setSafeObject:self.consigneeInfo.consigneeId forKey:@"consigneeId"];
    [params setSafeObject:[self buildShippingInfoJson] forKey:@"shippingTemplates"];
    
    for (CSPointShowModel *point in self.points) {
        if (point.unfold) {
            [params setSafeObject:point.inputValue forKey:point.key];
        }
    }
//    if (self.additionModel.point > 0) {
//        [params setSafeObject:[NSString stringWithFormat:@"%ld",(long)self.additionModel.point] forKey:@"point"];
//    }
//    
//    if (self.additionModel.tPoint > 0 ) {
//        [params setSafeObject:[NSString stringWithFormat:@"%ld",(long)self.additionModel.tPoint] forKey:@"timelessPoint"];
//    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.cartSubmitData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    [params setObject:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] forKey:@"skus"];
    
    DBG(@"%@", params);
    
    [CartRequest getCartSubmitDataWithParams:params success:^(CartSubmitResultModel *resultModel) {
        
        if (resultModel) {
            [self.coupons removeAllObjects];
            
            self.consigneeInfo = resultModel.consigneeInfo;
            self.orderInfo = resultModel.orderInfo;
            self.invalids = resultModel.invalids;
            self.totalPrice = resultModel.totalPrice;
            self.discountInfo = resultModel.discountInfo;
            self.platformPromotionId = resultModel.platformPromotionId;
            if (!self.points) {
                self.points = resultModel.points;
            }
//            CSPlatformCouponModel *coupon1 = [[CSPlatformCouponModel alloc]init];
//            coupon1.title = @"全场优惠1";
//            coupon1.platformCouponId = @"1";
//            coupon1.selected = YES;
//            CSPlatformCouponModel *coupon2 = [[CSPlatformCouponModel alloc]init];
//            coupon2.title = @"全场优惠2";
//            coupon2.platformCouponId = @"2";
//            resultModel.platformCoupons = @[coupon1,coupon2];
            
            //[self.coupons addObjectsFromSafeArray:resultModel.platformCoupons];
//            [self hideErrorTips];
            

            //model.platformPromotionId = resultModel.platformPromotionId;
            
//            self.additionModel.pointAmountBalance = resultModel.pointAmountBalance;
//            self.additionModel.canUsePoint = resultModel.canUsePoint;
//            self.additionModel.pointAmountMax = resultModel.pointAmountMax;
//            
//            self.additionModel.timelessPoint = resultModel.timelessPoint;
//            self.additionModel.canUseTimelessPoint = resultModel.canUseTimelessPoint;
//            self.additionModel.timelessPointAmountMax = resultModel.timelessPointAmountMax;
            
            [self reloadData];
            [self initTotalBarView];
        }
        
    } failure:^(StatusModel *status) {
        
        DBG(@"%@", status);
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
    
}

- (void) initTotalBarView {
    
    self.totalBarView = [[CSTotalBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, TOTAL_BAR_VIEW_HEIGHT) totalPrice:self.totalPrice];
    self.totalBarView.bottom = self.view.height;
    self.totalBarView.delegate = self;
    [self.view addSubview:self.totalBarView];
    
}

- (CSCouponSelectView*)couponSelectView
{
    if (!_couponSelectView) {
        _couponSelectView = [[CSCouponSelectView alloc]initWithCoupons:self.coupons];
        _couponSelectView.delegate = self;
    }
    return _couponSelectView;
}

- (CSShippingSelectView*)shippingSelectView
{
    if (!_shippingSelectView) {
        _shippingSelectView = [[CSShippingSelectView alloc]init];
        _shippingSelectView.delegate = self;
    }
    return _shippingSelectView;
}

- (void) consigneeSelected:(NSNotification *)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    
    ConsigneeModel *consignee = [userInfo objectForKey:@"consignee"];
    
    if ( !self.consigneeInfo ) {
        self.consigneeInfo = [[CSConsigneeInfoModel alloc] init];
    }
    if (consignee) {
        self.consigneeInfo.consigneeId = consignee.consigneeId;
        self.consigneeInfo.name = consignee.name;
        self.consigneeInfo.phone = consignee.phone;
        self.consigneeInfo.address = [NSString stringWithFormat:@"%@ %@ %@ %@", consignee.province, consignee.city,consignee.district?consignee.district:@"",consignee.address];
    }

    [self loadData];
    
    DBG(@"%@", userInfo);
}

- (NSString *) bulidItemInfosJson {
    
    NSMutableArray *itemInfos = [NSMutableArray array];
    
    for (CSItemInfoModel *itemInfo in self.orderInfo) {
        
        NSMutableDictionary *itemInfoData = [NSMutableDictionary dictionary];
        
        [itemInfoData setSafeObject:itemInfo.shopInfo.shopId forKey:@"shopId"];
        
        NSString *remarkId = [NSString stringWithFormat:@"%@_%@",itemInfo.shopInfo.shopId,itemInfo.shippingTemplateId];
        [itemInfoData setSafeObject:[self.remarks objectForKey:remarkId] forKey:@"remark"];
        
        NSMutableArray *skuInfos = [NSMutableArray array];
        
        for (CTSkuInfoModel *sku in itemInfo.skuInfo) {
            
            NSMutableDictionary *skuData = [NSMutableDictionary dictionary];
            
            [skuData setSafeObject:sku.skuId forKey:@"skuId"];
            [skuData setSafeObject:sku.amount forKey:@"amount"];
            [skuData setSafeObject:sku.cartId forKey:@"cartId"];
            [skuInfos addSafeObject:skuData];
        }
        
        NSString *shipppingId = nil;
        for (CSShippingModel *model in itemInfo.shippingList) {
            if (model.selected) {
                shipppingId = model.shippingId;
            }
        }
        [itemInfoData setSafeObject:shipppingId forKey:@"shippingId"];
        [itemInfoData setObject:skuInfos forKey:@"skus"];
        [itemInfos addSafeObject:itemInfoData];
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:itemInfos
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString*)buildShippingInfoJson
{
    NSMutableArray *itemInfos = [NSMutableArray array];
    
    for (CSItemInfoModel *itemInfo in self.orderInfo) {
        NSMutableDictionary *itemInfoData = [NSMutableDictionary dictionary];

        NSString *shipppingId = nil;
        for (CSShippingModel *model in itemInfo.shippingList) {
            if (model.selected) {
                shipppingId = model.shippingId;
            }
        }
        [itemInfoData setSafeObject:shipppingId forKey:@"shippingId"];
        [itemInfoData setSafeObject:itemInfo.shippingTemplateId forKey:@"templateId"];
        [itemInfos addObject:itemInfoData];
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:itemInfos
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - UITableViewDataSource
//consignee, orders,point, empty
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 0;
    //consignee,shops,invalids,points,bottom
    numberOfSections = 1 + self.orderInfo.count + 1 + 1 + 1;
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ( SECTION_CONSIGNEE == section ) {
        return 1;
    } else if( [self.orderInfo safeObjectAtIndex:section - 1] ) {
        
        return 1 + 1 + 1*((CSItemInfoModel *)[self.orderInfo safeObjectAtIndex:section - 1]).skuInfo.count + 4;
        
    } else if( section == self.orderInfo.count + 1 ){
        
        return self.invalids.count?self.invalids.count+2:0;
        
    } else if (section == self.orderInfo.count + 2){
        
        return 1 + self.points.count;
        
    }else if (section == self.orderInfo.count + 3) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    if ( SECTION_CONSIGNEE == section ) {
        
        CSConsigneeInfoCell *cell = [CSConsigneeInfoCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.consigneeInfo;
        [cell reloadData];
        return cell;
        
    } else if( [self.orderInfo safeObjectAtIndex:section - 1] ) {
        
        CSItemInfoModel *itemInfo = (CSItemInfoModel *)[self.orderInfo safeObjectAtIndex:section - 1];
        
        if ( ROW_SHOP == row) {
            
            CSShopInfoCell *cell = [CSShopInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = itemInfo.shopInfo;
            [cell reloadData];
            return cell;

        } else if ( row == 1*itemInfo.skuInfo.count + 2 ) {
            
            CSShippingListCell *cell = [CSShippingListCell dequeueReusableCellForTableView:tableView];
            cell.cellData = itemInfo.shippingList;
            [cell reloadData];
            return cell;

        } else if (row == 1*itemInfo.skuInfo.count + 3) {
            CSShopCouponCell *cell = [CSShopCouponCell dequeueReusableCellForTableView:tableView];
            cell.cellData = nil;//self.additionModel.coupon;
            [cell reloadData];
            return cell;
        }else if ( row == 1*itemInfo.skuInfo.count + 4 ) {
            
            CSTotalPriceCell *cell = [CSTotalPriceCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"totalPrice":itemInfo.totalPrice};
            [cell reloadData];
            return cell;
            
        }else if ( row == 1*itemInfo.skuInfo.count + 5 ) {
            
            CSRemarkCell *cell = [CSRemarkCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.remarks;
            cell.remarkId = [NSString stringWithFormat:@"%@_%@",itemInfo.shopInfo.shopId,itemInfo.shippingTemplateId];
            [cell reloadData];
            return cell;
            
        }else if ( row != ROW_EMPTY ) {
            
            CTSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:row-2];
            CSSkuInfoCell *cell = [CSSkuInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = skuInfo;
            [cell reloadData];
            return cell;
        }
        
    }else if (section == self.orderInfo.count + 1){
        if (row == 1) {
            CTShopInfoModel *shop = [[CTShopInfoModel alloc]init];
            shop.shopName = @"失效商品";
            CSShopInfoCell *cell = [CSShopInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = shop;
            [cell reloadData];
            return cell;
        }else if (row >= 2){
            CTSkuInfoModel *skuInfo = [self.invalids safeObjectAtIndex:row-2];
            CSSkuInfoCell *cell = [CSSkuInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = skuInfo;
            [cell reloadData];
            return cell;
        }
        
    }else if (section == self.orderInfo.count + 2) {
        if (row >= 1) {
            CSPointUsageCell *cell = [CSPointUsageCell dequeueReusableCellForTableView:tableView];
            cell.cellData = [self.points safeObjectAtIndex:row - 1];
            [cell reloadData];
            return cell;
        }
//            else if (row == 2) {
//                CSTimelessPointCell *cell = [CSTimelessPointCell dequeueReusableCellForTableView:tableView];
//                cell.cellData = self.additionModel;
//                [cell reloadData];
//                return cell;
//            }

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
    
    
    if ( SECTION_CONSIGNEE == section ) {
        
        height = [CSConsigneeInfoCell heightForCell:self.consigneeInfo];
        
    } else if( [self.orderInfo safeObjectAtIndex:section - 1] ) {
        
        CSItemInfoModel *itemInfo = (CSItemInfoModel *)[self.orderInfo safeObjectAtIndex:section - 1];
        
        if ( ROW_EMPTY == row) {
            
            height = 14;
            
        } else if ( ROW_SHOP == row) {
            
            height = [CSShopInfoCell heightForCell:itemInfo.shopInfo];
            
        } else if ( row == 1*itemInfo.skuInfo.count + 2 ) {
            
            //height = [CSShippingFeeCell heightForCell:nil];
            height = [CSShippingListCell heightForCell:itemInfo.shippingList];

        }else if ( row == 1*itemInfo.skuInfo.count + 3 ) {
            
            height = [CSShopCouponCell heightForCell:self.coupons.count>0?@"":nil];
            
        }else if ( row == 1*itemInfo.skuInfo.count + 4 ) {
            
            height = [CSTotalPriceCell heightForCell:@{@"totalPrice":itemInfo.totalPrice}];
            
        }else if ( row == 1*itemInfo.skuInfo.count + 5 ) {
            
            height = [CSRemarkCell heightForCell:itemInfo.shopInfo];
            
        }else {
            CTSkuInfoModel *skuInfo = [itemInfo.skuInfo safeObjectAtIndex:row -2];
            height = [CSSkuInfoCell heightForCell:skuInfo];
        }
    }else if (section == self.orderInfo.count + 1) {
        if (row == 1) {
            height = [CSShopInfoCell heightForCell:self.invalids];
        }else if (row >= 2){
            CTSkuInfoModel *skuInfo = [self.invalids safeObjectAtIndex:row -2];
            height = [CSSkuInfoCell heightForCell:skuInfo];
        }else{
            height = 14;
        }
    }else if (section == self.orderInfo.count + 2){
        if (row >= 1) {
            height = [CSPointUsageCell heightForCell:[self.points safeObjectAtIndex:row-1]];
        }
//            else if (row == 2) {
//                height = [CSTimelessPointCell heightForCell:self.additionModel];
//            }
        else {
            height = 14;
        }
    }else {
        height = TOTAL_BAR_VIEW_HEIGHT;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if ( SECTION_CONSIGNEE == section ) {
        
        [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"consigneeSelect")];
        
    }else if ([self.orderInfo safeObjectAtIndex:section - 1]) {
        
        CSItemInfoModel *itemInfo = (CSItemInfoModel *)[self.orderInfo safeObjectAtIndex:section - 1];

        if (row == 1*itemInfo.skuInfo.count + 3) {
            // show coupon select view
            [self.couponSelectView show];
        }
        
        if (row == 1*itemInfo.skuInfo.count + 2) {
            [self.shippingSelectView showShippingList:itemInfo.shippingList];
        }
    }
}

#pragma mark - 
- (void)didFinishSelectingCoupon
{
//    self.additionModel.coupon = nil;
//    for (CSPlatformCouponModel *coupon in self.coupons) {
//        if (coupon.selected) {
//            self.additionModel.coupon = coupon;
//        }
//    }
//    [self reloadData];
}

- (void)didFinishSelectingShipping
{
    [self loadData];
}

#pragma mark - CSTotalBarDelegate

- (void)orderButtonDidClick {
    
    if ( !self.consigneeInfo ) {
        [self showNotice:@"请选择联系人"];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定付款吗？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 100;
    [alert show];
}

- (void)payAction
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *itemInfosJson = [self bulidItemInfosJson];
    
    [params setSafeObject:itemInfosJson forKey:@"orderInfos"];
    [params setSafeObject:self.consigneeInfo.consigneeId forKey:@"consigneeId"];
    [params setSafeObject:self.platformPromotionId forKey:@"platformPromotionId"];
    
    int success = 0;
    for (CSPointShowModel *point in self.points) {
        if (point.unfold) {
            
            if ([point.inputValue floatValue] > [point.usable floatValue]||
                [point.inputValue floatValue] > [point.total floatValue]) {
                [self showNotice:[NSString stringWithFormat:@"%@超出可用范围",point.name]];
                break;
            }
            if ([point.inputValue floatValue] > 0.) {
                [params setSafeObject:point.inputValue forKey:point.key];
            }
        }
    }
    if (success == - 1) {
        return;
    }
    
    weakify(self);
    
    [OrderRequest orderGenerateWithParams:params success:^(OrderGenerateResultModel *resultModel) {
        
        if (resultModel) {
            
            [[[ApplicationEntrance shareEntrance] currentNavigationController] popViewControllerAnimated:NO onCompletion:^{
                [[TTNavigationService sharedService] openUrl:resultModel.payLink];
            }];
        }
        
    } failure:^(StatusModel *status) {
        
        strongify(self);
        
        if( status ) {
            if (status.code == 1130) {
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"您还不是会员！\n成为会员才能购物哦~" delegate:self cancelButtonTitle:@"成为会员" otherButtonTitles:@"再等等", nil];
                alertView.tag = 101;
                [alertView show];
                
            }else{
                [self showNotice:status.msg];
            }
        } else {
            [self showNotice:@"生成订单异常"];
        }
        
    }];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [self payAction];
        }
    }else if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            [[TTNavigationService sharedService] openUrl:LOCALSCHEME(@"becomeMember")];
        }
    }
}

#pragma mark - TTErrorTipsViewDelegate

- (void)errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

@end
