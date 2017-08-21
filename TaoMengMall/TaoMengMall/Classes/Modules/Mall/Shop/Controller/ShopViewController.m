//
//  ShopViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopRequest.h"
#import "ItemRequest.h"
//#import "WallItemCell.h"
#import "ShopHeaderCell.h"
#import "ShopSiftCell.h"
#import "ShopCategoriesCell.h"
#import "ShopWallItemCell.h"
#import "ShopListItemCell.h"
#import "ShopBannerItemCell.h"
#import "ShopTopicItemCell.h"
#import "ShopItemHeaderCell.h"
#import "ShopRestrictionTipCell.h"
#import "XMShareView.h"

@interface ShopViewController () <ShopHeaderDelegate,ShopSiftCellDelegate,ShopCategoriesCellDelegate,ShopItemCellDelegate>

@property (nonatomic, strong) ShopInfoModel *shopInfo;
//@property (nonatomic, strong) NSMutableArray<WallItemModel> *items;
@property (nonatomic, strong) NSMutableArray<ShopItemModel> *items;
@property (nonatomic, strong) NSMutableArray *groups;

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) NSString *itemTemplate;
@property (nonatomic, strong) ShopTabModel *currentTab;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *cartButton;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) ShareInfoModel *shareInfo;
@property (nonatomic, strong) XMShareView *shareView;

@end

@implementation ShopViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
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
    
    [self.navigationBar addSubview:self.searchTextField];
    
    self.collectionView.showsPullToRefresh = YES;
    self.collectionView.showsInfiniteScrolling = NO;
    self.collectionView.alwaysBounceVertical = YES;
    
    //self.title = @"店铺";
    
    [self initData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cartButton.selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cartHasItems"] isEqualToString:@"1"];
}

#pragma mark - Private Methods

- (void)initData
{
    self.items = [NSMutableArray<ShopItemModel> array];
    self.groups = [NSMutableArray array];
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ( kLoadMore == self.loadingType ) {
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [ShopRequest getShopMoreDataWithParams:params success:^(ShopResultModel *resultModel) {
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                [self generateGroupsFromItems:self.items];

                self.wp = resultModel.items.wp;
                
                if ( resultModel.items.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
            }
            
            [self finishLoadMore];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            [self finishLoadMore];
            
        }];
        
    } else {
        
        params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        
        [params setSafeObject:self.shopId forKey:@"shopId"];
        //[params setSafeObject:@"4" forKey:@"template"];
        [params setSafeObject:self.type forKey:@"type"];
        [params setSafeObject:self.categoryId forKey:@"categoryId"];
        
        [ShopRequest getShopDataWithParams:params success:^(ShopResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                [self generateGroupsFromItems:self.items];
                
                //resultModel.items.template = @"2";
                self.itemTemplate = resultModel.items.template;
                self.tabs = resultModel.tab;
                
                if ([self.itemTemplate isEqualToString:@"1"]|| [self.itemTemplate isEqualToString:@"3"]) {
                    self.view.backgroundColor = Color_White;
                }else{
                    self.view.backgroundColor = Color_Gray245;
                }
                
                for (ShopTabModel *tab in self.tabs) {
                    if (tab.isSelected) {
                        self.currentTab = tab;
                        self.type = tab.type;
                        for (ShopTabCateModel *cate in tab.list) {
                            if (cate.isSelected) {
                                self.categoryId = cate.value;
                            }
                        }
                    }
                }
                
                self.wp = resultModel.items.wp;
                
                if ( resultModel.items.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
                self.shopInfo = resultModel.shopInfo;
                self.shareInfo = resultModel.share;
                if (self.shareInfo) {
                    self.shareButton.hidden = NO;
                    self.shareButton.right = SCREEN_WIDTH - 12;
                    self.shareButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
                    
                    self.cartButton.right = self.shareButton.left ;
                    self.cartButton.centerY = self.shareButton.centerY;
                    self.searchTextField.width =  SCREEN_WIDTH - 40 - 56-40;
                }else{
                    self.shareButton.hidden = YES;
                    
                    self.cartButton.right = SCREEN_WIDTH - 12;
                    self.cartButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
                    self.searchTextField.width =  SCREEN_WIDTH - 40 - 56;
                }
                if ( IsEmptyString(self.shopInfo.shopId) ) {
                    self.shopInfo.shopId = self.shopId;
                }
            }
            
            [self finishRefresh];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
            self.collectionView.showsInfiniteScrolling = NO;
            
        }];
        
    }
    
}

- (void)generateGroupsFromItems:(NSArray*)items
{
    [self.groups removeAllObjects];
    
    NSMutableArray *array = [NSMutableArray array];
    for (ShopItemModel *shop in items) {
        if (shop.head) {
            if (array.count > 0) {
                [self.groups addObject:array];
            }
            
            array = [NSMutableArray array];
            [array addObject:shop];
            [self.groups addObject:array];
            
            array = [NSMutableArray array];
        }else{
            [array addObject:shop];
        }
    }
    if (array.count>0) {
        [self.groups addSafeObject:array];
    }
}


- (void) handleShowCartButton {
    
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"mallCart")];
}

- (void)handleSearchButton {

    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"search?shopId=%@",self.shopId)];
}

- (UITextField*)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, STATUSBAR_HEIGHT+7, SCREEN_WIDTH - 40 - 56-40, 30)];
        _searchTextField.font = FONT(14);
        _searchTextField.placeholder = @"搜索商品、品牌";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.backgroundColor = Color_Gray240;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.layer.cornerRadius = 2.;
        _searchTextField.layer.masksToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        imageView.image = [UIImage imageNamed:@"search_icon_search"];
        imageView.centerY = 15;
        imageView.centerX = 15;
        UIView *bkg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [bkg addSubview:imageView];
        _searchTextField.leftView = bkg;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *mask = [[UIView alloc]initWithFrame:_searchTextField.bounds];
        [_searchTextField addSubview:mask];
        [mask bk_whenTapped:^{
            [self handleSearchButton];
        }];
    }
    return _searchTextField;
}

#pragma mark -
- (void)registCell
{
    //[self.collectionView registerClass:[WallItemCell class] forCellWithReuseIdentifier:[WallItemCell cellIdentifier]];
    [self.collectionView registerClass:[ShopHeaderCell class] forCellWithReuseIdentifier:[ShopHeaderCell cellIdentifier]];
    [self.collectionView registerClass:[ShopSiftCell class] forCellWithReuseIdentifier:[ShopSiftCell cellIdentifier]];
    [self.collectionView registerClass:[ShopCategoriesCell class] forCellWithReuseIdentifier:[ShopCategoriesCell cellIdentifier]];
    [self.collectionView registerClass:[ShopWallItemCell class] forCellWithReuseIdentifier:[ShopWallItemCell cellIdentifier]];
    [self.collectionView registerClass:[ShopListItemCell class] forCellWithReuseIdentifier:[ShopListItemCell cellIdentifier]];
    [self.collectionView registerClass:[ShopBannerItemCell class] forCellWithReuseIdentifier:[ShopBannerItemCell cellIdentifier]];
    [self.collectionView registerClass:[ShopTopicItemCell class] forCellWithReuseIdentifier:[ShopTopicItemCell cellIdentifier]];
    [self.collectionView registerClass:[ShopItemHeaderCell class] forCellWithReuseIdentifier:[ShopItemHeaderCell cellIdentifier]];
    [self.collectionView registerClass:[ShopRestrictionTipCell class] forCellWithReuseIdentifier:[ShopRestrictionTipCell cellIdentifier]];
}

- (NSInteger)itemSectionCount
{
    return self.groups.count;
}

- (NSInteger)itemCountForSection:(NSInteger)section
{
    NSArray *items = [self.groups safeObjectAtIndex:section];
    return items.count;
}

- (NSInteger)headerCount
{
    return 1;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ShopHeaderCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopHeaderCell cellIdentifier] forIndexPath:indexPath];
        cell.cellData = self.shopInfo;
        cell.delegate = self;
        [cell reloadData];
        return cell;
    }else if (indexPath.row == 1) {
        ShopRestrictionTipCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopRestrictionTipCell cellIdentifier] forIndexPath:indexPath];
        cell.cellData = self.shopInfo.quota;
        [cell reloadData];
        return cell;
        
    }else if (indexPath.row == 2) {
        ShopSiftCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopSiftCell cellIdentifier] forIndexPath:indexPath];
        cell.cellData = self.tabs;
        cell.delegate = self;
        [cell reloadData];
        return cell;
    }else if (indexPath.row == 3) {
        ShopCategoriesCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopCategoriesCell cellIdentifier] forIndexPath:indexPath];
        cell.cellData = self.currentTab.list;
        cell.delegate = self;
        [cell reloadData];
        return cell;
    }
    return nil;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.groups safeObjectAtIndex:(indexPath.section-[self headerCount])];

    ShopItemModel *wallItem = [items safeObjectAtIndex:indexPath.item];
    if (wallItem.content) {
        ShopItemCell *cell = nil;
        if ([self.itemTemplate isEqualToString:@"1"]) {
            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopListItemCell cellIdentifier] forIndexPath:indexPath];

        }else if ([self.itemTemplate isEqualToString:@"2"]||[self.itemTemplate isEqualToString:@"5"]) {
            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopWallItemCell cellIdentifier] forIndexPath:indexPath];

        }else if ([self.itemTemplate isEqualToString:@"3"]) {
            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopTopicItemCell cellIdentifier] forIndexPath:indexPath];

        }else if ([self.itemTemplate isEqualToString:@"4"]) {
            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopBannerItemCell cellIdentifier] forIndexPath:indexPath];
        }
        cell.cellData = wallItem.content;
        cell.delegate = self;
        [cell reloadData];
        return cell;
    }else{
        ShopItemHeaderCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[ShopItemHeaderCell cellIdentifier] forIndexPath:indexPath];
        cell.cellData = wallItem.head;
        [cell reloadData];
        return cell;
    }
}

- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(SCREEN_WIDTH, [ShopHeaderCell heightForCell:self.shopInfo]);
    }else if (indexPath.row == 1) {
        return CGSizeMake(SCREEN_WIDTH, [ShopRestrictionTipCell heightForCell:self.shopInfo.quota]);
    }
    else if (indexPath.row == 2){
        return CGSizeMake(SCREEN_WIDTH, [ShopSiftCell heightForCell:self.tabs]);
    }else{
        return CGSizeMake(SCREEN_WIDTH, [ShopCategoriesCell heightForCell:self.currentTab.list]);
    }
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.groups safeObjectAtIndex:(indexPath.section-[self headerCount])];

    ShopItemModel *wallItem = [items safeObjectAtIndex:indexPath.item];
    CGFloat height = 0;
    CGFloat width = CELL_WIDTH;
    
    if (wallItem.content) {
        if ([self.itemTemplate isEqualToString:@"1"]) {
            height = [ShopListItemCell heightForCell:wallItem.content];
            width = SCREEN_WIDTH;
        }else if ([self.itemTemplate isEqualToString:@"2"]||[self.itemTemplate isEqualToString:@"5"]) {
            height = [ShopWallItemCell heightForCell:wallItem.content];

        }else if ([self.itemTemplate isEqualToString:@"3"]) {
            height = [ShopTopicItemCell heightForCell:wallItem.content];
            width = SCREEN_WIDTH;
        }else if ([self.itemTemplate isEqualToString:@"4"]) {
            height = [ShopBannerItemCell heightForCell:wallItem.content];
            width = BANNER_WIDTH;
        }

    }else{
        height = [ShopItemHeaderCell heightForCell:wallItem.head];
        width = SCREEN_WIDTH;
    }
    return CGSizeMake(width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)layout numberOfColumnsInSection:(NSInteger)section{
    
    if ( self.hasHeader && [self headerCount] > section ) {
        return 1;
    }
    NSArray *items = [self.groups safeObjectAtIndex:(section-[self headerCount])];
    ShopItemModel *wallItem = [items safeObjectAtIndex:0];
    if (wallItem.head) {
        return 1;
    }else{
        if ([self.itemTemplate isEqualToString:@"2"]||[self.itemTemplate isEqualToString:@"5"]) {
            return 2;
        }
        return 1;
    }
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.groups safeObjectAtIndex:(indexPath.section-[self headerCount])];
    ShopItemModel *wallItem = [items safeObjectAtIndex:indexPath.item];
    if (wallItem.content) {
        ShopItemCell *cell = (ShopItemCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        if (cell.showMask) {
            [cell hideMaskAnimated];
        }else{
            [[TTNavigationService sharedService] openUrl:wallItem.content.link];
        }
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.hasHeader) {
        return [self headerCount]+ [self itemSectionCount];
    }
    
    return [self itemSectionCount];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ( self.hasHeader && [self headerCount] > section ) {
        if (section == 0 ) {
            return 4;
        }
        return 0;
    }
    
    return [self itemCountForSection:(section-[self headerCount])];
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
    [params setSafeObject:self.shopId forKey:@"shopId"];
    
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
    [params setSafeObject:self.shopId forKey:@"shopId"];
    
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

#pragma mark - ShopSiftCellDelegate
- (void)cellTapSift:(id)model
{
    ShopTabModel *tab = (ShopTabModel*)model;
    self.type = tab.type;
    self.categoryId = nil;
    [self initData];
}

#pragma mark - ShopCategoriesCellDelegate
- (void)cellTapCate:(id)model
{
    ShopTabCateModel *cate = (ShopTabCateModel*)model;
    self.categoryId = cate.value;
    [self initData];
}

#pragma mark - ShopItemCellDelegate
- (void)cell:(ShopItemCell*)cell tapFavButton:(id)item
{
    ShopItemContentModel *itemInfo = (ShopItemContentModel*)item;
    if ( itemInfo.isFav ) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        [params setSafeObject:itemInfo.itemId forKey:@"itemId"];
        
        [ItemRequest unfollowWithParams:params success:^{
            [self showNotice:@"已取消收藏"];
            itemInfo.isFav = NO;
            cell.favButton.selected = NO;
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
        
    } else {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        [params setSafeObject:itemInfo.itemId forKey:@"itemId"];
        
        [ItemRequest followWithParams:params success:^{
            [self showNotice:@"已收藏"];
            itemInfo.isFav = YES;
            cell.favButton.selected = YES;
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
    }
}

- (void)cell:(ShopItemCell*)cell tapMoreButton:(id)item
{
    [self hideCellMask];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideCellMask];
}

#pragma mark - Prvate
- (void)hideCellMask
{
    NSArray *visibleCells = self.collectionView.visibleCells;
    for (BaseCollectionViewCell *cell in visibleCells) {
        if ([cell isKindOfClass:[ShopItemCell class]]) {
            ShopItemCell *itemCell = (ShopItemCell*)cell;
            if (itemCell.showMask) {
                [itemCell hideMaskAnimated];
            }
        }
    }
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

- (XMShareView*)shareView
{
    if (!_shareView) {
        _shareView = [[XMShareView alloc]init];
    }
    return _shareView;
}
@end
