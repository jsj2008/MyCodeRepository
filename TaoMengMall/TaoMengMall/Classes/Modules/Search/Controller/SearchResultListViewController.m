//
//  CategoryViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "SearchResultListViewController.h"
#import "WallItemListCell.h"
#import "SearchRequest.h"
#import "SearchTermLabel.h"

@interface SearchResultListViewController ()

@property (nonatomic, strong) NSMutableArray<WallItemModel> *items;
@property (nonatomic, strong) UIScrollView *searchScrollView;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) UIView *headerBgView;
@property (nonatomic, strong) UIButton    *cancelButton;

@end

@implementation SearchResultListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad{
    
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    self.hasHeader = NO;

    self.view.backgroundColor = Color_Gray245;

//    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, 44)];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton setTitleColor:Color_White forState:UIControlStateNormal];
//    [cancelButton addTarget:self action:@selector(handleCancelButton) forControlEvents:UIControlEventTouchUpInside];
//    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
//    self.navigationBar.rightBarButton = cancelButton;
//    self.navigationBar.leftBarButton= nil;

    //[self.navigationBar addSubview:self.searchScrollView];
    
    [self.view addSubview:self.headerBgView];
    [self.view addSubview: self.searchScrollView];
    [self.view addSubview:self.cancelButton];
    
    self.collectionView.top = NAVBAR_HEIGHT;
    self.collectionView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT;
    
    self.keys = [NSMutableArray arrayWithArray:[self.key componentsSeparatedByString:@" "]];
    [self reloadSearchScrollView];
    [self initData];
}


- (void)reloadSearchScrollView
{
    [self.searchScrollView removeAllSubviews];
    CGFloat y = 20;
    for (int i = 0; i < self.keys.count; i++) {
        SearchTermLabel *label = [[SearchTermLabel alloc]initWithFrame:CGRectZero];
        label.text = [self.keys safeObjectAtIndex:i];
        [self.searchScrollView addSubview:label];
        //[label resizeToFit];
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            [self.keys removeObjectAtIndex:i];
            [self reloadSearchScrollView];
            
            if (self.keys.count == 0) {
                
                [self clickback];
            }else{
                
                self.key = [self.keys componentsJoinedByString:@" "];
                [self hideEmptyTips];
                [self initData];
            }

        }];
        
        label.centerY = 15;
        label.left = y;
        y += label.width + 20;
    }
    
    self.searchScrollView.contentSize = CGSizeMake(y+60, 30);

    if (y > SCREEN_WIDTH-56) {
        CGPoint point = CGPointZero;
        point.x = y + 60 - (SCREEN_WIDTH-90);

        [self.searchScrollView setContentOffset:point];
    }
}

- (UIScrollView*)searchScrollView
{
    if (!_searchScrollView) {
        UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(16, 7+STATUSBAR_HEIGHT, SCREEN_WIDTH-90, 30)];
        scrollview.backgroundColor = Color_White;
        scrollview.layer.cornerRadius = 5.f;
        scrollview.layer.masksToBounds = YES;
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        _searchScrollView = scrollview;
        [_searchScrollView bk_whenTapped:^{
            //返回searchViewController
            //NSString *link = [NSString stringWithFormat:@"xiaoma://search?searchTerm=%@",self.searchTerm];
            //[[TTNavigationService sharedService] openUrl:link];
            [self clickback];
        }];
    }
    return _searchScrollView;
}

- (UIView*)headerBgView
{
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVBAR_HEIGHT)];
        _headerBgView.backgroundColor = Color_Red12;
    }
    return _headerBgView;
}

- (UIButton*)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-64, STATUSBAR_HEIGHT+6, 44, 32)];
        [_cancelButton setTitleColor:Color_White forState:UIControlStateNormal];;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
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
        
        [SearchRequest getSearchMoreDataWithParams:params success:^(SearchResultModel *resultModel) {
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                
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
        [params setSafeObject:self.key forKey:@"key"];
        [params setSafeObject:self.shopId forKey:@"shopId"];

        [SearchRequest getSearchDataWithParams:params success:^(SearchResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.items && [resultModel.items.list count]>0) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                
                self.wp = resultModel.items.wp;
                
                if ( resultModel.items.isEnd ) {
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
    [self.collectionView registerClass:[WallItemListCell class] forCellWithReuseIdentifier:[WallItemListCell cellIdentifier]];
    //    [self.collectionView registerClass:[SearchSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchSectionHeaderView identifier]];
}

- (NSInteger)cellCount
{
    return self.items.count;
}


- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    WallItemListCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[WallItemListCell cellIdentifier] forIndexPath:indexPath];
    
    cell.cellData = wallItem;
    
    [cell reloadData];
    
    return cell;
}


- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    return CGSizeMake(SCREEN_WIDTH, [WallItemListCell heightForCell:wallItem]);
}

#pragma mark - WallViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)layout numberOfColumnsInSection:(NSInteger)section
{
    
    return 1;
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

- (void) handleCancelButton {
    [self clickback];
}


@end
