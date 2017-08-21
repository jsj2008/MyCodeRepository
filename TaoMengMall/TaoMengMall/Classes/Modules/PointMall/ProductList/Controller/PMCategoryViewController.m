//
//  PMCategoryViewController.m
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import "PMCategoryViewController.h"
#import "PointMallRequest.h"
#import "PMItemModel.h"
#import "PMListCell.h"
@interface PMCategoryViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic,copy) NSString *key;
@end

@implementation PMCategoryViewController


#pragma mark - Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self addNavigationBar];
    self.view.backgroundColor = Color_Gray245;
    

    self.hasHeader = NO;
    self.collectionView.showsPullToRefresh = YES;
    self.collectionView.showsInfiniteScrolling = YES;
    self.collectionView.alwaysBounceVertical = YES;
//    [self.navigationBar addSubview:self.searchTextField];

    //self.title = @"类目";
    
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
        
        [PointMallRequest getPointMallCategoryWithParams:params success:^(PMCategoryResultModel *resultModel) {
            
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
        [params setSafeObject:self.categoryId forKey:@"categoryId"];
        
        [PointMallRequest getPointMallCategoryWithParams:params success:^(PMCategoryResultModel *resultModel) {
            [self hideEmptyTips];
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.list ) {
                
                [self.items addObjectsFromSafeArray:resultModel.list];
                self.title = resultModel.title;
                self.wp = resultModel.wp;
                
                if ( resultModel.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
            } else {
                
                self.collectionView.showsInfiniteScrolling = NO;
            }
            if (resultModel.list.count == 0) {
                NSString *noticeStr = @"没有相关商品哦";
                [self showEmptyTips:noticeStr ownerView:self.collectionView];
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
    [self.collectionView registerClass:[PMListCell class] forCellWithReuseIdentifier:[PMListCell cellIdentifier]];
    //    [self.collectionView registerClass:[SearchSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchSectionHeaderView identifier]];
}

- (NSInteger)cellCount
{
    return self.items.count;
}


- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    PMListCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[PMListCell cellIdentifier] forIndexPath:indexPath];
    
    cell.cellData = wallItem;
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    [cell reloadData];
    
    return cell;
}



- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    return CGSizeMake(CELL_WIDTH, [PMListCell heightForCell:wallItem]);
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    [[TTNavigationService sharedService] openUrl:wallItem.link];
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}



- (UITextField*)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(12, STATUSBAR_HEIGHT+7, SCREEN_WIDTH - 52, 30)];
        _searchTextField.font = FONT(14);
        _searchTextField.placeholder = @"搜索商品";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.backgroundColor = Color_Gray240;
        _searchTextField.tintColor = Color_Gray140;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.layer.cornerRadius = 2.;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.delegate = self;
        _searchTextField.centerX =SCREEN_WIDTH/2+15;
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



- (void)handleSearchButton
{
//    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"pointTabSearch")];
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"search?cateId=%@&type=pointSearch",self.categoryId)];

}

@end
