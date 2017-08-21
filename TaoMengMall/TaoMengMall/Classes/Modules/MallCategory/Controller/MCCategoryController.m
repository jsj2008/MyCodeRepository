//
//  MCTopDressController.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/20.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MCCategoryController.h"
#import "MCCategoryModulesCell.h"
#import "MCCategorySelectCell.h"
#import "CategoryRequest.h"
#import "MCCategorySelectView.h"
#import "MallCategoryRequest.h"

@interface MCCategoryController ()<MCCategorySelectViewDeleget,MCCategorySelectCellDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *categorysItems;
@property (nonatomic,strong) MCCategorySelectView *selectView;
@property (nonatomic,assign) BOOL isReady;

@property (nonatomic,strong) NSString *selectIndex;

@property (nonatomic,assign) NSInteger temp;

@property (nonatomic,copy) NSString *keyName;
@property (nonatomic,copy) NSString *KeyValue;
@property (nonatomic,strong) NSArray *siftsArray;
@end

@implementation MCCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBar];

    self.view.backgroundColor = Color_Gray245;

    self.collectionView.showsInfiniteScrolling = NO;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.hasHeader = YES;
    self.isReady = NO;
    self.selectIndex = @"1";
    self.temp = 0;
    //[self render];
    [self initData];
}

- (void)render
{
    [self.view addSubview:self.selectView];
    
    self.selectView.cellData = self.siftsArray;
    self.selectView.index = self.selectIndex;
    self.selectView.temp = self.temp;
    [self.selectView render];
    
}

- (MCCategorySelectView *)selectView
{
    if (!_selectView) {
        MCCategorySelectView *view = [[MCCategorySelectView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 55)];
        view.delegate = self;
        view.hidden = YES;
        _selectView = view;
    }
    return _selectView;
}

- (void)initData
{
    self.items = [NSMutableArray array];
    self.categorysItems = [NSMutableArray array];
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ( kLoadMore == self.loadingType ) {
        
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [MallCategoryRequest getMCCategoryDataWithParams:params success:^(MCCategoryResultModel *resultModel) {
            
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
            [self showNotice:status.msg];
            [self finishLoadMore];
            [self reloadData];

        }];
        
    } else {
        
        params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
        [params setSafeObject:self.cateId forKey:@"cateId"];

        [params setSafeObject:self.KeyValue forKey:self.keyName];
        
        [MallCategoryRequest getMCCategoryDataWithParams:params success:^(MCCategoryResultModel *resultModel) {
            [self hideEmptyTips];
            [self.items removeAllObjects];
            [self.categorysItems removeAllObjects];
            
            if ( resultModel && resultModel.items ) {
                
                [self.items addObjectsFromSafeArray:resultModel.items.list];
                [self.categorysItems addObjectsFromSafeArray:resultModel.categories];
                
                self.wp = resultModel.items.wp;
                self.title = resultModel.title?resultModel.title:@"类目";
                
                self.siftsArray = resultModel.sifts;
                
                [self render];
                
                
                if ( resultModel.items.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
            } else {
               
                self.collectionView.showsInfiniteScrolling = NO;
            }
            if (resultModel.items.list.count == 0) {
                NSString *noticeStr = @"没有相关商品哦";
                [self showEmptyTips:noticeStr ownerView:self.collectionView];
            }
            self.isReady = YES;
            [self finishRefresh];
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            [self finishRefresh];
            [self showNotice:status.msg];
            [self reloadData];
        }];
    }
}

-(void)registCell
{
    [self.collectionView registerClass:[MCCategoryModulesCell class] forCellWithReuseIdentifier:[MCCategoryModulesCell cellIdentifier]];
    
    [self.collectionView registerClass:[MCCategorySelectCell class] forCellWithReuseIdentifier:[MCCategorySelectCell cellIdentifier]];
    
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier]];
    
    [self.collectionView registerClass:[WallItemCell class] forCellWithReuseIdentifier:[WallItemCell cellIdentifier]];
}

- (NSInteger)itemCount
{
   
    return self.items.count;
}

- (NSInteger)headerCount
{
    return 2;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.item == 1) {
            MCCategoryModulesCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[MCCategoryModulesCell cellIdentifier] forIndexPath:indexPath];
            cell.cellData = self.categorysItems;
            [cell reloadData];
            return cell;
        }
    }else if (indexPath.section == 1) {
        MCCategorySelectCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[MCCategorySelectCell cellIdentifier] forIndexPath:indexPath];
        cell.index = self.selectIndex;
        cell.delegate = self;
        cell.temp = self.temp;
        cell.cellData = self.siftsArray;
        [cell reloadData];
        return cell;
    }
    
    BaseCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell *cell;
    
    if (indexPath.section == 2) {
        WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
        
        WallItemCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[WallItemCell cellIdentifier] forIndexPath:indexPath];
        
        cell.cellData = wallItem;
        
        [cell reloadData];
        
        return cell;
    }
    
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    return CGSizeMake(CELL_WIDTH, [WallItemCell heightForCell:wallItem]);
}


- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 14;
    
    if(indexPath.section == 0 ){
        if (indexPath.item == 1) {
            height = [MCCategoryModulesCell heightForCell:self.categorysItems];
        }else if (indexPath.item == 0||indexPath.item == 2) {
            if (self.categorysItems.count == 0) {
                height = 0;
            }
        }
    }else if (indexPath.section == 1) {
        height = [MCCategorySelectCell heightForCell:@""];
    }
    return CGSizeMake(SCREEN_WIDTH, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ( self.hasHeader && [self headerCount] > section ) {
        if (section == 0) {
            return 3; //2
        }else if (section == 1) {
            return 1; //1
        }
        else {
            return 2;
        }
        return 0;
    }
    
    return [self itemCount];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WallItemModel *wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    [[TTNavigationService sharedService] openUrl:wallItem.link];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isReady) {
        CGFloat height = 0;
        UICollectionViewLayoutAttributes *siftAtt = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        height = siftAtt.frame.origin.y;
        if (scrollView.contentOffset.y > height) {
            self.selectView.hidden = NO;
        }else{
            self.selectView.hidden = YES;
        }
    }
}

#pragma mark - selectViewDeleget

- (void)cellChooseIndex:(NSInteger)index withPriceUpOrDown:(NSInteger)temp keyName:(NSString *)name keyValue:(NSString *)keyValue
{
    self.selectIndex = [NSString stringWithFormat:@"%zd",index];
    self.temp = temp;
    self.keyName = name;
    self.KeyValue = keyValue;
    // 刷新数据
    [self initData];
    
    // 更新selectView
    self.selectView.index = self.selectIndex;
    self.selectView.temp = self.temp;
    [self.selectView render];
}

- (void)viewChooseIndex:(NSInteger)index withPriceUpOrDown:(NSInteger)temp keyName:(NSString *)name keyValue:(NSString *)keyValue
{
    self.selectIndex = [NSString stringWithFormat:@"%zd",index];
    self.temp = temp;
    self.keyName = name;
    self.KeyValue = keyValue;
    // 刷新数据
    
    [self initData];
}

@end
