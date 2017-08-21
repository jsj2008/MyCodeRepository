//
//  CategoryViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "PMProductListViewController.h"
#import "PMCatrogryCell.h"
#import "PointMallRequest.h"
#import "PMModuleCell.h"
#import "PMModuleView.h"
#import "PMTitleHeaderCell.h"

@interface PMProductListViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray<WallItemModel> *items;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic,strong) NSArray *categoryArray;

@property (nonatomic,copy) NSString *key;
@end

@implementation PMProductListViewController

#pragma mark - Life Cycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"淘米商城" titleColor:Color_Gray(153) selectedTitleColor: Theme_Color icon:[UIImage imageNamed:@"icon_tabbar_point_normal"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_point_select"]];
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
//    self.navigationBar.backgroundColor = Color_Orange3;
//    self.navigationBar.tintColor = Color_White;
    self.hasHeader = YES;
    [self.navigationBar addSubview:self.searchTextField];

    self.collectionView.showsInfiniteScrolling = NO;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT;
    //self.title = @"积分商城";
    
    [self initData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
        
        [PointMallRequest getProductMoreDataWithParams:params success:^(ProductListResultModel *resultModel) {
            
            if ( resultModel && resultModel.list ) {
                
                [self.items addObjectsFromSafeArray:resultModel.list];
                
                self.wp = resultModel.wp;
//                
//                if ( resultModel.isEnd ) {
//                    self.collectionView.showsInfiniteScrolling = NO;
//                } else {
//                    self.collectionView.showsInfiniteScrolling = YES;
//                }
                
            }
            
            [self finishLoadMore];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            [self finishLoadMore];
            
        }];
        
    } else {
        
        params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        [params setSafeObject:self.cateId forKey:@"cateId"];
        
        [PointMallRequest getProductListDataWithParams:params success:^(ProductListResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel && resultModel.list ) {
                
                [self.items addObjectsFromSafeArray:resultModel.list];
                
                self.categoryArray =resultModel.cates;
                
                self.wp = resultModel.wp;
                
//                if ( resultModel.isEnd ) {
//                    self.collectionView.showsInfiniteScrolling = NO;
//                } else {
//                    self.collectionView.showsInfiniteScrolling = YES;
//                }
                
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
    [self.collectionView registerClass:[PMModuleCell class] forCellWithReuseIdentifier:[PMModuleCell cellIdentifier]];
    [self.collectionView registerClass:[PMCatrogryCell class] forCellWithReuseIdentifier:[PMCatrogryCell cellIdentifier]];

    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier]];
    [self.collectionView registerClass:[PMTitleHeaderCell class] forCellWithReuseIdentifier:[PMTitleHeaderCell cellIdentifier]];
}

- (NSInteger)itemCount
{
    return 0;
}

- (NSInteger)headerCount
{
    return 1+self.items.count;
}


- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        
        PMCatrogryCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[PMCatrogryCell cellIdentifier] forIndexPath:indexPath];
        cell.cellData = self.categoryArray;
        [cell reloadData];
        return cell;
    }
    
    if (indexPath.section >0) {
        PMListItemMOdel *list = [self.items safeObjectAtIndex:indexPath.section-1];
        if (indexPath.item == 0) {
            PMTitleHeaderCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[PMTitleHeaderCell cellIdentifier] forIndexPath:indexPath];
            cell.cellData = list.title;
            [cell reloadData];
            return cell;
            
        }else {
            
            
            PMModuleCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[PMModuleCell cellIdentifier] forIndexPath:indexPath];
            
            NSMutableDictionary *items = [NSMutableDictionary dictionary];
            [items setSafeObject:[list.items safeObjectAtIndex:(indexPath.row-1)*2] forKey:@"leftItem"];
            [items setSafeObject:[list.items safeObjectAtIndex:(indexPath.row-1)*2 + 1] forKey:@"rightItem"];
            cell.cellData = items;
            [cell reloadData];
            return cell;
 
        }
        
    }
    
    BaseCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
}

- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = [PMCatrogryCell heightForCell:self.categoryArray];
    }
    if (indexPath.section > 0) {
        if (indexPath.item ==0) {
            PMListItemMOdel *list = [self.items safeObjectAtIndex:indexPath.section-1];
            height = [PMTitleHeaderCell heightForCell:list.title];
        }else {
            PMListItemMOdel *list = [self.items safeObjectAtIndex:indexPath.section-1];
            
            NSMutableDictionary *items = [NSMutableDictionary dictionary];
            [items setSafeObject:[list.items safeObjectAtIndex:(indexPath.row-1)*2] forKey:@"leftItem"];
            [items setSafeObject:[list.items safeObjectAtIndex:(indexPath.row-1)*2 + 1] forKey:@"rightItem"];
            height = [PMModuleCell heightForCell:items];
        }
        
        
    }
    return CGSizeMake(SCREEN_WIDTH, height);
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    BaseCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
}


- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(CELL_WIDTH, 0);
}

#pragma mark - WallViewDelegateFlowLayout


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ( self.hasHeader && [self headerCount] > section ) {
        
        if (section == 0 ) {
            return 1;
        }else {
            PMListItemMOdel *list = [self.items safeObjectAtIndex:section-1];
            return ceil(list.items.count/2.0f) + 1;
        }
        return 0;
    }
    
    return [self itemCount];
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}


- (void)handleSearchButton {
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"search?cateId=%@&type=pointSearch",self.cateId)];
}

- (UITextField*)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, STATUSBAR_HEIGHT+7, SCREEN_WIDTH - 40, 30)];
        _searchTextField.font = FONT(14);
        _searchTextField.placeholder = @"搜索商品";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.backgroundColor = Color_Gray240;
        _searchTextField.tintColor = Color_Gray140;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.layer.cornerRadius = 2.;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.delegate = self;
        _searchTextField.centerX =SCREEN_WIDTH/2;
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



@end
