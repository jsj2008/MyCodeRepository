//
//  MallItemSearchViewController.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/16.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import "MallItemSearchViewController.h"
#import "SearchRequest.h"
#import "MallListCell.h"

@interface MallItemSearchViewController ()
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MallItemSearchViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self addNavigationBar];
    self.view.backgroundColor = Color_Gray245;
    
    
    self.hasHeader = NO;
    self.collectionView.showsPullToRefresh = YES;
    self.collectionView.showsInfiniteScrolling = YES;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.title = @"搜索";
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
        
        [SearchRequest getMallSearchDataWithParams:params success:^(MallResultModel *resultModel) {
            
            if ( resultModel && resultModel.list ) {
                
                [self.items addObjectsFromSafeArray:resultModel.list];
                
                self.wp = resultModel.wp;
                
                if ( resultModel.isEnd ) {
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
        [params setSafeObject:self.cateId forKey:@"cateId"];
        [params setSafeObject:self.key forKey:@"key"];
        [SearchRequest getMallSearchDataWithParams:params success:^(MallResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.list ) {
                
                [self.items addObjectsFromSafeArray:resultModel.list];
                
                self.wp = resultModel.wp;
                
                if ( resultModel.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
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
    [self.collectionView registerClass:[MallListCell class] forCellWithReuseIdentifier:[MallListCell cellIdentifier]];
    //    [self.collectionView registerClass:[SearchSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchSectionHeaderView identifier]];
}

- (NSInteger)cellCount
{
    return self.items.count;
}


- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    MallListCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[MallListCell cellIdentifier] forIndexPath:indexPath];
    
    cell.cellData = wallItem;
    
    [cell reloadData];
    
    return cell;
}



- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    return CGSizeMake(CELL_WIDTH, [MallListCell heightForCell:wallItem]);
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    [[TTNavigationService sharedService] openUrl:wallItem.link];
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}



@end
