//
//  ItemViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemInfoModel.h"
#import "ITShopInfoModel.h"
#import "ITCommentInfoModel.h"
#import "ItemRequest.h"

#import "ITImageCell.h"
#import "ITItemInfoCell.h"
#import "ITSkuSelectedCell.h"
#import "ITCommentHeadCell.h"
#import "ITCommentCell.h"
#import "ITCommentFootCell.h"
#import "ITShopInfoCell.h"
#import "ITImagesHeadCell.h"
#import "ITCoverImageCell.h"
#import "ITContentHeadCell.h"
#import "ITTextCell.h"
#import "ITRecommendTitleCell.h"
#import "ITRecommendCell.h"
#import "ITRebateRuleCell.h"
#import "ItemTipCell.h"

#import "ITToolbarView.h"
#import "ITSKUSelectView.h"
#import "ITPhotoBrowserPanel.h"
#import "XMShareView.h"


#import "CartRequest.h"
#import "ShopRequest.h"
#import "PMToolbarView.h"

#import "CartSubmitViewController.h"

#define ITEM_DETAIL_SECTION_ITEM 0
#define ITEM_DETAIL_SECTION_SKU 1
#define ITEM_DETAIL_SECTION_COMMENT 2
#define ITEM_DETAIL_SECTION_SHOP 3
#define ITEM_DETAIL_SECTION_IMAGES 4
#define ITEM_DETAIL_SECTION_RECOMMEND 5
#define ITEM_DETAIL_SECTION_EMPTY 6

#define ITEM_DETAIL_ITEM_ROW_IMAGE 0
#define ITEM_DETAIL_ITEM_ROW_INFO 1
#define ITEM_DETAIL_ITEM_ROW_RULE 2
#define ITEM_DETAIL_ITEM_ROW_TIP 4

#define ITEM_DETAIL_SKU_ROW_INFO 0

#define ITEM_DETAIL_COMMENT_ROW_HEAD 0

#define ITEM_DETAIL_SHOP_ROW_INFO 0

#define ITEM_DETAIL_CONTENT_ROW_HEAD 0

//#define HONGBAO_DETAIL_ROW_BASE 0
//#define HONGBAO_DETAIL_ROW_USERS 1
//#define HONGBAO_DETAIL_ROW_INTRO 3
//#define HONGBAO_DETAIL_ROW_RULE 5

#define BUY_TYPE_1 @"1" // 立即购买
#define BUY_TYPE_2 @"2" // 加购物车

@interface ItemViewController () <ITToolbarDelegate, ITSKUSelectDelegate,ITShopInfoCellDelegate,UIActionSheetDelegate,TTAlertViewDelegate,ITCoverImageCellDelegate,ITItemInfoCellDelegate,ITPhotoBrowserPanelDelegate>

@property (nonatomic, strong) ItemInfoModel *itemInfo;
@property (nonatomic, strong) ITShopInfoModel *shopInfo;
@property (nonatomic, strong) ITCommentInfoModel *commentInfo;
@property (nonatomic, strong) ShareInfoModel *shareInfo;
@property (nonatomic, strong) ITRecommendsModel *recommend;
@property (nonatomic, strong) NSArray *selectedSkus;

@property (nonatomic, strong) ITToolbarView *toolbarView;
@property (nonatomic,strong)  PMToolbarView *pointToolBarView;
@property (nonatomic, strong) ITSKUSelectView *skuSelectView;
@property (nonatomic, strong) ITPhotoBrowserPanel *coverBrowserView;
@property (nonatomic, strong) XMShareView *shareView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *cartButton;
@property (nonatomic, strong) NSString *supportContact;
@property (nonatomic,copy) NSString *servicePrice;
@property (nonatomic,copy) NSString *cashback;
@property (nonatomic,copy) NSString *quotaDesc;
@end

@implementation ItemViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 40, 20);
    [shareButton setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
    shareButton.right = SCREEN_WIDTH - 12;
    shareButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:shareButton];
    shareButton.hidden = NO;
    self.shareButton = shareButton;
    
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 40, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    infoButton.right = SCREEN_WIDTH - 12;
    infoButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:infoButton];
    self.cartButton = infoButton;
    
    self.tableView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT;
    
    self.title = @"商品详情";
    
    [self initData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSkuPanelSelectChanged:) name:kNOTIFY_SKU_PANEL_SELECT_CHANGED object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cartButton.selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cartHasItems"] isEqualToString:@"1"];
}

#pragma mark - Private Methods

- (void)initData
{
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.loadingType = kInit;
    [self loadData];
    //[self getSupportContact];
}

#pragma mark - Event Response

- (void) handleShowCartButton {
    [[TTNavigationService sharedService] openUrl:@"xiaoma://mallCart"];
}

- (void)handleShareButton
{
    if (!self.shareInfo) {
        [self showNotice:@"分享信息获取失败，请稍后再试"];
        return;
    }
    self.shareView.shareInfo = self.shareInfo;
    [self.shareView show];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *tel = [NSString stringWithFormat:@"tel://%@",self.supportContact];
        [[TTNavigationService sharedService]openUrl:tel];
    }
}

#pragma mark - Custom Methods

- (void)getSupportContact
{
    [ItemRequest getSupportContactWithParams:nil success:^(ITSupportContactResultModel *resultModel) {
        self.supportContact = resultModel.phone;
    } failure:^(StatusModel *status) {
        
    }];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    //self.itemId = @"2558";
    //self.itemId = @"2561";
    [params setSafeObject:self.itemId forKey:@"itemId"];
    
    [ItemRequest getItemDataWithParams:params success:^(ItemResultModel *resultModel) {
        
        if (resultModel) {
            self.itemInfo = resultModel.itemInfo;
            self.shopInfo = resultModel.shopInfo;
            self.commentInfo = resultModel.commentInfo;
            self.shareInfo = resultModel.share;
            self.recommend = resultModel.recommend;
            self.cashback = resultModel.cashback;
            self.quotaDesc = resultModel.quotaDesc;
            self.itemInfo.servicePrice = resultModel.serviceCharge;
            NSMutableArray *skus = [NSMutableArray array];
            for (ITPropertyModel *property in self.itemInfo.skuInfo.properties) {
                [skus addObject:@{property.propertyName:@""}];
            }
            self.selectedSkus = skus;
            
            if (self.shareInfo) {
                self.shareButton.hidden = NO;
                self.shareButton.right = SCREEN_WIDTH - 12;
                self.shareButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
                
                self.cartButton.right = self.shareButton.left ;
                self.cartButton.centerY = self.shareButton.centerY;
            }else{
                self.shareButton.hidden = YES;
                
                self.cartButton.right = SCREEN_WIDTH - 12;
                self.cartButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
            }
        }
        
//        [self hideErrorTips];
        [self finishRefresh];
        
//        [self.view addSubview:self.toolbarView];
        if ([self.itemInfo.type isEqualToString:@"1"]) {
           [self.view addSubview:self.pointToolBarView];
        }else {
            [self.view addSubview:self.toolbarView];
        }
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
//        [self showErrorTips];
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
    
}

#pragma mark - Getters And Setters

- (ITToolbarView *)toolbarView {
    
    if ( !_toolbarView ) {
        
        _toolbarView = [[ITToolbarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45)];
        _toolbarView.delegate = self;
        _toolbarView.isFav = self.itemInfo.isFav;
        _toolbarView.status = self.itemInfo.status;
        [_toolbarView render];
        
    }
    
    return _toolbarView;
    
}

- (PMToolbarView *)pointToolBarView {
    
    if ( !_pointToolBarView ) {
        
        _pointToolBarView = [[PMToolbarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45)];
        _pointToolBarView.delegate = self;
        
    }
    
    return _pointToolBarView;
    
}

- (ITSKUSelectView *)skuSelectView {
    
    if ( !_skuSelectView ) {
        
        _skuSelectView = [[ITSKUSelectView alloc] initWithSkuInfo:self.itemInfo.skuInfo itemTitle:self.itemInfo.title];
        _skuSelectView.delegate = self;
    }
    
    return _skuSelectView;
    
}

- (ITPhotoBrowserPanel*)coverBrowserView
{
    if (!_coverBrowserView) {
        _coverBrowserView = [[ITPhotoBrowserPanel alloc]initWithPhotos:self.itemInfo.coverImage.src];
        _coverBrowserView.delegate = self;
    }
    return _coverBrowserView;
}

- (XMShareView*)shareView
{
    if (!_shareView) {
        _shareView = [[XMShareView alloc]init];
    }
    return _shareView;
}

#pragma mark - ITToolbarDelegate

//- (void) chatButtonDidClick {
//    if (self.supportContact) {
//        TTAlertView *alert = [[TTAlertView alloc]initWithTitle:@"提示" message:@"是否拨打客服电话？" containerView:nil delegate:self confirmButtonTitle:@"是" otherButtonTitles:@[@"否"]];
//        [alert show];
//    }else{
//        [self showNotice:@"当前客服联系方式不可用，请尝试刷新页面"];
//    }
//}

- (void) likeButtonDidClick {
    DBG(@"喜欢");
    
    if ( self.itemInfo.isFav ) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        [params setSafeObject:self.itemId forKey:@"itemId"];
        
        [ItemRequest unfollowWithParams:params success:^{
            
            self.itemInfo.isFav = NO;
            self.toolbarView.isFav = self.itemInfo.isFav;
            [self.toolbarView render];
            
        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            
        }];
        
    } else {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        [params setSafeObject:self.itemId forKey:@"itemId"];
        
        [ItemRequest followWithParams:params success:^{
            
            self.itemInfo.isFav = YES;
            self.toolbarView.isFav = self.itemInfo.isFav;
            [self.toolbarView render];
            
        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            
        }];
        
    }
    
}

- (void) shopButtonDidClick {
    
    [[TTNavigationService sharedService] openUrl:self.shopInfo.link];
    
}

- (void) addToCartButtonDidClick {
    DBG(@"addToCartButtonDidClick");
    
    self.skuSelectView.type = BUY_TYPE_2;
    [self.skuSelectView show];
    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m32 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.9, 0.9, 1);
    //t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view.layer setTransform:t1];
    } completion:^(BOOL finished) {
        
    }];

}

- (void) buyButtonDidClick {
    DBG(@"buyButtonDidClick");
    
    self.skuSelectView.type = BUY_TYPE_1;
    [self.skuSelectView show];
    
     CATransform3D t1 = CATransform3DIdentity;
     t1.m32 = 1.0/-900;
     t1 = CATransform3DScale(t1, 0.9, 0.9, 1);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         [self.view.layer setTransform:t1];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)willHideSKUSelectView
{
    CATransform3D t1 = CATransform3DIdentity;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view.layer setTransform:t1];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Notification'
- (void)didSkuPanelSelectChanged:(NSNotification*)noti
{
    NSArray *selectedSkus = noti.object;
    self.selectedSkus = selectedSkus;
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( ITEM_DETAIL_SECTION_ITEM == section ) {
        return 6;
    } else if ( ITEM_DETAIL_SECTION_SKU == section ) {
        return 2;
    }else if ( ITEM_DETAIL_SECTION_COMMENT == section ) {
        return 2 + self.commentInfo.comments.count+1;
    } else if ( ITEM_DETAIL_SECTION_SHOP == section ) {
        return self.shopInfo?2:0;
    } else if ( ITEM_DETAIL_SECTION_IMAGES == section ) {
        
        if ( self.itemInfo ) {
            return self.itemInfo.detailContent.count + 1;
        } else {
            return 1;
        }
    }else if (ITEM_DETAIL_SECTION_RECOMMEND == section) {
        
        return 1 + ceil(self.recommend.list.count/2.);
        
    } else if ( ITEM_DETAIL_SECTION_EMPTY == section ) {
        
        return 1;
        
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if ( ITEM_DETAIL_SECTION_ITEM == section ) {
        
        if ( ITEM_DETAIL_ITEM_ROW_IMAGE == row ) {
            
            ITCoverImageCell *cell = [ITCoverImageCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.itemInfo.coverImage;
            cell.delegate = self;
            [cell reloadData];
            return cell;
            
        } else if ( ITEM_DETAIL_ITEM_ROW_INFO == row ) {
            
            ITItemInfoCell *cell = [ITItemInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.itemInfo;
            cell.delegate = self;
            cell.showShare = NO;
            [cell reloadData];
            return cell;
            
        }else if (ITEM_DETAIL_ITEM_ROW_RULE == row) {
            ITRebateRuleCell *cell = [ITRebateRuleCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.cashback;
            [cell reloadData];
            return cell;
            
        }else if (ITEM_DETAIL_ITEM_ROW_TIP == row) {
            ItemTipCell *cell = [ItemTipCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.quotaDesc;
            [cell reloadData];
            return cell;
            
        }
    } else if ( ITEM_DETAIL_SECTION_SKU == section) {
        
        if (ITEM_DETAIL_SKU_ROW_INFO == row) {
            ITSkuSelectedCell *cell = [ITSkuSelectedCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.selectedSkus;
            [cell reloadData];
            return cell;
        }
    } else if ( ITEM_DETAIL_SECTION_COMMENT == section ) {
        
        if ( ITEM_DETAIL_COMMENT_ROW_HEAD == row ) {
            
            ITCommentHeadCell *cell = [ITCommentHeadCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.commentInfo;
            [cell reloadData];
            return cell;
            
        } else if (row <= self.commentInfo.comments.count){
            
            ITCommentCell *cell = [ITCommentCell dequeueReusableCellForTableView:tableView];
            cell.cellData = [self.commentInfo.comments safeObjectAtIndex:row -1 ];
            [cell reloadData];
            return cell;
            
        } else if(row <= self.commentInfo.comments.count+1){
            ITCommentFootCell *cell = [ITCommentFootCell dequeueReusableCellForTableView:tableView];
            return cell;
        }
        
    } else if ( ITEM_DETAIL_SECTION_SHOP == section ) {
        
        if ( ITEM_DETAIL_SHOP_ROW_INFO == row ) {
            
            ITShopInfoCell *cell = [ITShopInfoCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.shopInfo;
            cell.delegate = self;
            [cell reloadData];
            return cell;
            
        }
        
        
    } else if ( ITEM_DETAIL_SECTION_IMAGES == section ) {
        
        if ( ITEM_DETAIL_CONTENT_ROW_HEAD == row ) {
            
            ITContentHeadCell *cell = [ITContentHeadCell dequeueReusableCellForTableView:tableView];
            [cell reloadData];
            return cell;
            
        } else {
            
            ITDetailContentModel *itemContent = [self.itemInfo.detailContent safeObjectAtIndex:row - 1];
            
            if ( itemContent ) {
                
                if ( [@"image" isEqualToString:itemContent.type] ) {
                    
                    ITImageCell *cell = [ITImageCell dequeueReusableCellForTableView:tableView];
                    cell.cellData = itemContent;
                    [cell reloadData];
                    return cell;
                    
                } else if ( [@"text" isEqualToString:itemContent.type] ) {
                    ITTextCell *cell = [ITTextCell dequeueReusableCellForTableView:tableView];
                    cell.cellData = itemContent.text;
                    [cell reloadData];
                    return cell;
                }
                
            }
            
            
        }
        
    }else if (ITEM_DETAIL_SECTION_RECOMMEND == section) {
        if (row == 0) {
            ITRecommendTitleCell *cell = [ITRecommendTitleCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.recommend.title;
            [cell reloadData];
            return cell;
        }else{
            NSMutableDictionary *items = [NSMutableDictionary dictionary];
            [items setSafeObject:[self.recommend.list safeObjectAtIndex:(row - 1)*2] forKey:@"leftItem"];
            [items setSafeObject:[self.recommend.list safeObjectAtIndex:(row - 1)*2 + 1] forKey:@"rightItem"];

            ITRecommendCell *cell = [ITRecommendCell dequeueReusableCellForTableView:tableView];
            cell.cellData = items;
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
    CGFloat height = 0;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if ( ITEM_DETAIL_SECTION_ITEM == section ) {
        
        if ( ITEM_DETAIL_ITEM_ROW_IMAGE == row ) {
            
            height = [ITCoverImageCell heightForCell:self.itemInfo.coverImage];
            
        } else if ( ITEM_DETAIL_ITEM_ROW_INFO == row ) {
            
            height = [ITItemInfoCell heightForCell:self.itemInfo];
            
        }else if (ITEM_DETAIL_ITEM_ROW_RULE == row){
            
            height = [ITRebateRuleCell heightForCell:self.cashback];
            
        }else if (ITEM_DETAIL_ITEM_ROW_TIP == row) {
            
            height = [ItemTipCell heightForCell:self.quotaDesc];
        }else {
            if (self.quotaDesc) {
                height = 14;
            }else {
                height = 0;
            }
            
            
        }
    } else if ( ITEM_DETAIL_SECTION_SKU == section) {
        if (![self.itemInfo.status isEqualToString:@"0"]) {
            return 0;
        }else{
            if (ITEM_DETAIL_SKU_ROW_INFO == row) {
                
                height = [ITSkuSelectedCell heightForCell:@""];
                
            }else{
                height = 14;
            }
        }
    } else if ( ITEM_DETAIL_SECTION_COMMENT == section ) {
        
        if ( ITEM_DETAIL_COMMENT_ROW_HEAD == row ) {
            
            height = [ITCommentHeadCell heightForCell:self.commentInfo];
        
        } else if (row <= self.commentInfo.comments.count) {

            height = [ITCommentCell heightForCell:[self.commentInfo.comments safeObjectAtIndex:row -1 ]];
        
        }else if(row == self.commentInfo.comments.count+1){
            height = [ITCommentFootCell heightForCell:self.commentInfo.comments.count>0?@"":nil];
        }else {
            if (self.commentInfo.comments.count>0) {
                height=14;
            }else {
                height = 0;
            }
        }
        
    } else if ( ITEM_DETAIL_SECTION_SHOP == section ) {
        
        if ( ITEM_DETAIL_SHOP_ROW_INFO != row ) {
            
            height = 14;
            
        } else {
            
            height = [ITShopInfoCell heightForCell:self.shopInfo];
            
        }
        
    } else if ( ITEM_DETAIL_SECTION_IMAGES == section ) {
        
        if ( ITEM_DETAIL_CONTENT_ROW_HEAD == row ) {
            
            height = [ITContentHeadCell heightForCell:nil];
            
        } else {
            
            ITDetailContentModel *itemContent = [self.itemInfo.detailContent safeObjectAtIndex:row - 1];
            
            if ( itemContent ) {
                
                if ( [@"image" isEqualToString:itemContent.type]) {
                    
                    height = [ITImageCell heightForCell:itemContent];
                    
                } else if ( [@"text" isEqualToString:itemContent.type] ) {
                    
                    height = [ITTextCell heightForCell:itemContent.text];
                    
                }
                
            }
            
        }
    }else if (ITEM_DETAIL_SECTION_RECOMMEND == section) {
        if (row == 0) {
            height = [ITRecommendTitleCell heightForCell:self.recommend.title];
        }else{
            height = [ITRecommendCell heightForCell:[self.recommend.list safeObjectAtIndex:(row - 1)*2]];
        }
    } else if ( ITEM_DETAIL_SECTION_EMPTY == section ) {
        
        height = 45+20+44;
        
    }
    
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (ITEM_DETAIL_SECTION_SKU == section) {
        if (ITEM_DETAIL_SKU_ROW_INFO == row) {
            [self addToCartButtonDidClick];
        }
    }else if (ITEM_DETAIL_SECTION_COMMENT == section) {
        if (ITEM_DETAIL_COMMENT_ROW_HEAD == row||(row == self.commentInfo.comments.count+1)) {
            [[TTNavigationService sharedService] openUrl:self.commentInfo.link];
        }
    }
}

#pragma mark - ITSKUSelectDelegate

- (void) addWithSkuId:(NSString *)skuId amount:(NSInteger)amount type:(NSString *)type{
    
    [self.skuSelectView dismiss];
    
    if ( [BUY_TYPE_2 isEqualToString:type] ) {
        
        NSDictionary *params = @{@"skuId":skuId, @"amount":[NSString stringWithFormat:@"%ld", amount]};
        
        weakify(self);
        
        [CartRequest addToCartWithParams:params success:^{
            
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cartHasItems"];
            self.cartButton.selected = YES;
            
            strongify(self);
            if ([self.itemInfo.type isEqualToString:@"0"]) {
                [self showNotice:@"加入购物车成功"];
            }
            
            
        } failure:^(StatusModel *status) {
            
            strongify(self);
            [self showNotice:status.msg];
            
        }];
        
    } else {
        
        //[self.skuSelectView dismiss];
        
        TTNavigationController *navigationController = [[ApplicationEntrance shareEntrance] currentNavigationController];
        
        CartSubmitViewController *vc = [[CartSubmitViewController alloc] init];
        
        NSMutableArray *selectdSkus = [NSMutableArray array];
        
        [selectdSkus addObject:@{@"skuId":skuId, @"amount":[NSString stringWithFormat:@"%ld", amount]}];

        vc.cartSubmitData = selectdSkus;
        
        [navigationController pushViewController:vc animated:YES];
        
    }
    
}

#pragma mark -ITCoverImageCellDelegate
- (void)didTapCoverAtIndex:(NSInteger)index
{
    self.coverBrowserView.currentIndex = index;
    [self.coverBrowserView show];
}

#pragma mark -ITPhotoBrowserPanelDelegate
- (void) willHidePhotoBrowsePanel:(ITPhotoBrowserPanel*)panel
{
    NSIndexPath *coverPath = [NSIndexPath indexPathForRow:ITEM_DETAIL_ITEM_ROW_IMAGE inSection:ITEM_DETAIL_SECTION_ITEM];
    ITCoverImageCell *cell = [self.tableView cellForRowAtIndexPath:coverPath];
    [cell scrollToCoverAtIndex:panel.currentIndex];
}

#pragma mark - ITItemInfoCellDelegate
- (void)cell:(ITItemInfoCell *)cell shareButtonTapped:(id)model
{
    [self handleShareButton];
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - ShopHeaderDelegate

- (void) addFavButtonDidTapped:(UIButton*)sender {
    
    sender.enabled = NO;

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    [params setSafeObject:self.shopInfo.shopId forKey:@"shopId"];
    
    [ShopRequest followWithParams:params success:^(ShopFollowResultModel *resultModel) {
        
        sender.enabled = YES;

        [self showNotice:@"收藏成功"];
        self.shopInfo.isFav = YES;
        self.shopInfo.favCount = resultModel.favCount;
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
        sender.enabled = YES;
        [self showNotice:status.msg];
        
    }];
    
}

- (void) cancelFavButtonDidTapped:(UIButton*)sender {
    
    sender.enabled = NO;

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    [params setSafeObject:self.shopInfo.shopId forKey:@"shopId"];
    
    [ShopRequest unfollowWithParams:params success:^(ShopFollowResultModel *resultModel) {
        
        sender.enabled = YES;

        [self showNotice:@"取消收藏成功"];
        self.shopInfo.isFav = NO;
        self.shopInfo.favCount = resultModel.favCount;
        
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        sender.enabled = YES;
        [self showNotice:status.msg];
        
    }];
    
}
@end
