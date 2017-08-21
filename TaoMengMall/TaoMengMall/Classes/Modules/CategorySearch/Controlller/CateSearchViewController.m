//
//  CateSearchViewController.m
//  HongBao
//
//  Created by marco on 5/10/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "CateSearchViewController.h"
#import "WallItemCell.h"
#import "WallItemSmallCell.h"
#import "CategoryRequest.h"
#import "CategoryHeaderCell.h"


@interface CateSearchViewController ()

@property (nonatomic, strong) UIButton *searchBar;

@property (nonatomic, strong) NSArray<CategoryModel> *categories;
@property (nonatomic, strong) NSMutableArray<WallItemModel> *items;
@property (nonatomic, assign) CSDisplayMode displayMode;
@property (nonatomic, assign) SortKind sortKind;
@property (nonatomic, strong) SortPanelView *panelView;

@end

@implementation CateSearchViewController

#pragma mark - Life Cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    self.displayMode = CSDisplayModeBig;
    self.sortKind = SortKindComprehensive;
    
    [self.view addSubview:self.panelView];
    self.panelView.top = NAVBAR_HEIGHT;
    
    self.hasHeader = NO;
    self.collectionView.top = NAVBAR_HEIGHT + self.panelView.height;
    self.collectionView.height = SCREEN_HEIGHT - self.collectionView.top;
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 50, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.rightBarButton = infoButton;
    [self addSearchBar];
    
    //self.title = @"类目";
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((UIButton*)self.navigationBar.rightBarButton).selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cartHasItems"] isEqualToString:@"1"];
}

- (void)addSearchBar
{
    if (!_searchBar) {
        _searchBar = [[UIButton alloc]initWithFrame:CGRectMake(52, 6, SCREEN_WIDTH - 104, 32)];
        _searchBar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_searchBar setImageEdgeInsets:UIEdgeInsetsMake(5, 8, 5, SCREEN_WIDTH - 104 -38)];
        [_searchBar setTitleEdgeInsets:UIEdgeInsetsMake(0, -34, 0, 0)];
        _searchBar.titleLabel.font = [UIFont systemFontOfSize:13];
        _searchBar.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_searchBar setTitle:@"来挑选一双释放双脚的凉鞋吧" forState:UIControlStateNormal] ;
        [_searchBar setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_searchBar setBackgroundColor:[UIColor lightGrayColor]];
        _searchBar.layer.cornerRadius = 4.f;
        [_searchBar  setImage:[UIImage imageNamed:@"icon_file_trans_normal"] forState:UIControlStateNormal];
        [_searchBar  setImage:[UIImage imageNamed:@"icon_file_trans_normal"] forState:UIControlStateHighlighted];
        [_searchBar  setImage:[UIImage imageNamed:@"icon_file_trans_normal"] forState:UIControlStateSelected];

        [_searchBar addTarget:self action:@selector(handleShowSearchButton) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navigationBar.containerView addSubview:_searchBar];
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
        
        [CategoryRequest getCategoryDataWithParams:params success:^(CategoryResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                
                self.wp = resultModel.items.wp;
                
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
    [self.collectionView registerClass:[WallItemSmallCell class] forCellWithReuseIdentifier:[WallItemSmallCell cellIdentifier]];
    [self.collectionView registerClass:[CategoryHeaderCell class] forCellWithReuseIdentifier:[CategoryHeaderCell cellIdentifier]];

}

- (NSInteger)cellCount
{
    return self.items.count;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    BaseCollectionViewCell *cell;
    if (self.displayMode == CSDisplayModeBig) {
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[WallItemCell cellIdentifier] forIndexPath:indexPath];
    }else{
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[WallItemSmallCell cellIdentifier] forIndexPath:indexPath];
    }
    
    cell.cellData = wallItem;
    
    [cell reloadData];
    
    return cell;
}


- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    if (self.displayMode == CSDisplayModeBig) {
        
        return CGSizeMake(CELL_WIDTH, [WallItemCell heightForCell:wallItem]);
 
    }else{
        
        return CGSizeMake(SCREEN_WIDTH, [WallItemSmallCell heightForCell:wallItem]);
    }
}

#pragma mark -SubViews

- (SortPanelView*)panelView
{
    if (!_panelView) {
        _panelView = [[SortPanelView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _panelView.delegate = self;
    }
    return _panelView;
}


#pragma mark - WallViewDelegateFlowLayout
    
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(WallViewLayout *)layout numberOfColumnsInSection:(NSInteger)section
{
    
    return self.displayMode == CSDisplayModeBig ? 2:1;
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    [[TTNavigationService sharedService] openUrl:wallItem.link];
}


#pragma mark -SortPanelView delegate
- (void)sortPanelView:(SortPanelView *)panelView sortKindChanged:(SortKind)kind
{
    self.sortKind = kind;
    [self startRefresh];
    [self loadData];
}

- (void)sortPanelView:(SortPanelView *)panelView dispalyModeChanged:(CSDisplayMode)mode
{
    self.displayMode = mode;
    
    NSIndexPath *lastVisableIndexPath = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
    [self reloadData];
    [self.collectionView scrollToItemAtIndexPath:lastVisableIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - Event Response

- (void) handleShowCartButton {
    [[TTNavigationService sharedService] openUrl:@"jump://bmall_cart"];
}

- (void)handleShowSearchButton
{
    [[TTNavigationService sharedService] openUrl:@"jump://search"];
}

@end

