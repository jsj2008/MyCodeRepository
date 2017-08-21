//
//  CategoryViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CategoryViewController.h"
#import "WallItemCell.h"
#import "CategoryRequest.h"
#import "CategoryHeaderCell.h"

@interface CategoryViewController ()

@property (nonatomic, strong) NSArray<CategoryModel> *categories;
@property (nonatomic, strong) NSMutableArray<WallItemModel> *items;

@end

@implementation CategoryViewController

#pragma mark - Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;

    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 50, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.rightBarButton = infoButton;
    
    self.collectionView.showsPullToRefresh = YES;
    self.collectionView.showsInfiniteScrolling = YES;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.title = @"类目";
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((UIButton*)self.navigationBar.rightBarButton).selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cartHasItems"] isEqualToString:@"1"];
}

#pragma mark - Private Methods

- (void)initData
{
    self.items = [NSMutableArray<WallItemModel> array];
    
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ( kLoadMore == self.loadingType ) {
        
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [CategoryRequest getCategoryMoreDataWithParams:params success:^(CategoryResultModel *resultModel) {
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                
                self.wp = resultModel.items.wp;
                
                if ( resultModel.items.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
                self.categories = resultModel.categories;
            }
            
            [self finishLoadMore];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            [self finishLoadMore];
            
        }];
        
    } else {
        
        params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        [params setSafeObject:self.cateId forKey:@"cateId"];
        [params setSafeObject:self.type forKey:@"type"];

        [CategoryRequest getCategoryDataWithParams:params success:^(CategoryResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                
                self.wp = resultModel.items.wp;
                self.title = resultModel.title?resultModel.title:@"类目";
                
                if ( resultModel.items.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
                self.categories = resultModel.categories;
            } else {
                NSString *noticeStr = @"没有找到相关商品哦";
                [self showEmptyTips:noticeStr ownerView:self.collectionView];
                self.collectionView.showsInfiniteScrolling = NO;
            }
            
//            [self hideErrorTips];
            [self finishRefresh];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
//            [self showErrorTips];
            [self finishRefresh];
            [self showNotice:status.msg];
            
        }];
    }
    
    
    
}

- (void)registCell
{
    [self.collectionView registerClass:[WallItemCell class] forCellWithReuseIdentifier:[WallItemCell cellIdentifier]];
    [self.collectionView registerClass:[CategoryHeaderCell class] forCellWithReuseIdentifier:[CategoryHeaderCell cellIdentifier]];
    //    [self.collectionView registerClass:[SearchSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchSectionHeaderView identifier]];
}

- (NSInteger)cellCount
{
    return self.items.count;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryHeaderCell *headerCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[CategoryHeaderCell cellIdentifier] forIndexPath:indexPath];
    
    headerCell.cellData = self.categories;
    
    [headerCell reloadData];
    
    return headerCell;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    WallItemCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[WallItemCell cellIdentifier] forIndexPath:indexPath];
    
    cell.cellData = wallItem;
    
    [cell reloadData];
    
    return cell;
}

- (CGSize)sizeForHeader
{
    return CGSizeMake(SCREEN_WIDTH, [CategoryHeaderCell heightForCell:self.categories]);
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    return CGSizeMake(CELL_WIDTH, [WallItemCell heightForCell:wallItem]);
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    [[TTNavigationService sharedService] openUrl:wallItem.link];
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - Event Response

- (void) handleShowCartButton {
    [[TTNavigationService sharedService] openUrl:@"xiaoma://mallCart"];
}


@end
