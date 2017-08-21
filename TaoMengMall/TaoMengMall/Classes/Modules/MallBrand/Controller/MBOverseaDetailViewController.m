//
//  MBOverseaDetailViewController.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/9.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MBOverseaDetailViewController.h"
#import "MallBrandRequest.h"
#import "MBOSDetailTitleModel.h"
#import "MBOverseaDetailHeaderCell.h"

@interface MBOverseaDetailViewController()

@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) MBOSDetailTitleModel *headerModel;
@end

@implementation MBOverseaDetailViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    

    
    self.collectionView.showsPullToRefresh = YES;
    self.collectionView.showsInfiniteScrolling = YES;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.title = @"类目";
    
    [self initData];
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
        
        [MallBrandRequest getOverseaDetailDataWithParams: params success:^(MBOSDetailResultModel *resultModel) {
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                
                self.wp = resultModel.items.wp;
                
                if ( resultModel.items.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
//                self.categories = resultModel.categories;
            }
            
            [self finishLoadMore];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            [self finishLoadMore];
            
        }];
        
    } else {
        
        
        [MallBrandRequest getOverseaDetailDataWithParams:params success:^(MBOSDetailResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                self.headerModel = resultModel.header;
                self.wp = resultModel.items.wp;
                self.title = resultModel.title?resultModel.title:@"海外品牌";
                
                if ( resultModel.items.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
//                self.categories = resultModel.categories;
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
    [self.collectionView registerClass:[MBOverseaDetailHeaderCell class] forCellWithReuseIdentifier:[MBOverseaDetailHeaderCell cellIdentifier]];
    //    [self.collectionView registerClass:[SearchSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchSectionHeaderView identifier]];
}

- (NSInteger)cellCount
{
    return self.items.count;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    MBOverseaDetailHeaderCell *headerCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[MBOverseaDetailHeaderCell cellIdentifier] forIndexPath:indexPath];
    
    headerCell.cellData = self.headerModel;
    
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
    return CGSizeMake(SCREEN_WIDTH, [MBOverseaDetailHeaderCell heightForCell:self.headerModel]);
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


@end
