//
//  HomeViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckDrawHomeViewController.h"
#import "LuckDrawHomeItemCell.h"
#import "LuckDrawHomeSiftCell.h"
#import "LuckDrawHomeAdvertCell.h"
#import "LuckDrawHomeItemModel.h"
#import "LuckDrawHomeRequest.h"

@interface LuckDrawHomeViewController ()<LuckDrawHomeSiftCellDelegate>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) LuckDrawHomeResultModel *resultModel;
@property (nonatomic, strong) LuckDrawHomeAdvertModel *advertModel;
@end

@implementation LuckDrawHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"主页" titleColor:Color_Gray146 selectedTitleColor:Color_Red12 icon:[UIImage imageNamed:@"icon_tabbar_mine_normal"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_mine_selected"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.collectionView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT;
    self.collectionView.showsInfiniteScrolling = NO;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.hasHeader = YES;
    
    self.title = @"一元夺宝";
    [self initData];
}

#pragma mark - Private Methods


- (void)initData
{
    self.type = @"0";
    self.items = [NSMutableArray array];
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.type forKey:@"type"];
    
    if ( kLoadMore == self.loadingType ) {
        
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [LuckDrawHomeRequest getHomeDataWithParams:params success:^(LuckDrawHomeResultModel *resultModel) {
            
            if ( resultModel && resultModel.items ) {
                [self.items addObjectsFromSafeArray:resultModel.items];
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
            [self reloadData];
        }];
        
    } else {
        
        [LuckDrawHomeRequest getHomeDataWithParams:params success:^(LuckDrawHomeResultModel *resultModel) {
            
            [self.items removeAllObjects];
            
            if ( resultModel) {
                self.resultModel = resultModel;
                self.advertModel = resultModel.advert;
                [self.items addObjectsFromSafeArray:resultModel.items];
                self.wp = resultModel.wp;
                
                if ( resultModel.isEnd ) {
                    self.collectionView.showsInfiniteScrolling = NO;
                } else {
                    self.collectionView.showsInfiniteScrolling = YES;
                }
                
            } else {
                self.collectionView.showsInfiniteScrolling = NO;
            }
            
            [self finishRefresh];
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
        }];
    }
}

#pragma mark -
- (void)registCell
{
    
    [self.collectionView registerClass:[LuckDrawHomeAdvertCell class] forCellWithReuseIdentifier:[LuckDrawHomeAdvertCell cellIdentifier]];
    
    [self.collectionView registerClass:[LuckDrawHomeItemCell class] forCellWithReuseIdentifier:[LuckDrawHomeItemCell cellIdentifier]];
    
    [self.collectionView registerClass:[LuckDrawHomeSiftCell class] forCellWithReuseIdentifier:[LuckDrawHomeSiftCell cellIdentifier]];
    
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier]];
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
    if(indexPath.section == 0){
        
        if (indexPath.item == 0) {
            LuckDrawHomeAdvertCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[LuckDrawHomeAdvertCell cellIdentifier] forIndexPath:indexPath];
            cell.cellData = self.advertModel;
            [cell reloadData];
            return cell;
        }
        
    }else if(indexPath.section == 1){
        if (indexPath.item == 1) {
            LuckDrawHomeSiftCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[LuckDrawHomeSiftCell cellIdentifier] forIndexPath:indexPath];
            cell.cellData = self.type;
            cell.delegate = self;
            [cell reloadData];
            return cell;
        }
        
    }
    BaseCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
}


- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell *cell;
    
    id wallItem = [self.items safeObjectAtIndex:indexPath.item];
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[LuckDrawHomeItemCell cellIdentifier] forIndexPath:indexPath];
    cell.cellData = wallItem;
    [cell reloadData];
    return cell;
}


- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 14;
    
    if(indexPath.section == 0){
        if (indexPath.item == 0) {
            height = [LuckDrawHomeAdvertCell heightForCell:self.advertModel];
        }
        
    }else if(indexPath.section == 1){
        if (indexPath.item == 0) {
            height = self.items.count>0?14:0;
        }else if (indexPath.item == 1) {
            height = [LuckDrawHomeSiftCell heightForCell:@""];
        }
    }
    return CGSizeMake(SCREEN_WIDTH, height);
}


- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
   
    id wallItem = [self.items safeObjectAtIndex:indexPath.item ];
    height = [LuckDrawHomeItemCell heightForCell:wallItem];
    
    return CGSizeMake(CELL_WIDTH, height);
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    id wallItem = [self.items safeObjectAtIndex:indexPath.item];
    if ([wallItem isKindOfClass:[LuckDrawHomeItemModel class]]) {
            LuckDrawHomeItemModel *model = (LuckDrawHomeItemModel *)wallItem;
            [[TTNavigationService sharedService] openUrl:model.link];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ( self.hasHeader && [self headerCount] > section ) {
        if (section == 0 ) {
            return 1;
        }else if (section == 1) {
            return 2;
        }
        return 0;
    }
    
    return [self itemCount];
}

#pragma mark - HomeSiftCellDelegate
- (void)siftTypeChange:(NSString *)type{
    self.type = type;
    self.loadingType = kInit;
    [self loadData];
}
    

 
@end
