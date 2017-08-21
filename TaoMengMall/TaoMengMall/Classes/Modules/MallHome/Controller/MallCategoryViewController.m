//
//  MallCategoryViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/24.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MallCategoryViewController.h"
#import "MallHomeRequest.h"
#import "MHModule21Cell.h"
#import "MHModule22Cell.h"
#import "MHModule23Cell.h"
#import "MHModule24Cell.h"
#import "MHModule25Cell.h"
#import "MHModule20Cell.h"

@interface MallCategoryViewController ()
@property (nonatomic, strong) NSMutableArray *lists;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) MHResultModel *resultModel;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *cartButton;
@end

@implementation MallCategoryViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"分类" titleColor:Color_Gray153 selectedTitleColor:Theme_Color icon:[UIImage imageNamed:@"icon_tabbar_category_normal"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_category_select"]];
    }
    return self;
}

- (void)viewDidLoad {
    //self.hideNavigationBar = YES;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
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
    
    self.collectionView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT;
    self.collectionView.showsInfiniteScrolling = NO;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.hasHeader = YES;
    
    //self.title = @"全部分类";
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
    self.lists = [NSMutableArray array];
    self.loadingType = kInit;
    
    [self loadData];
}


- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [MallHomeRequest getCategoryDataWithParams:params success:^(MHResultModel *resultModel) {
        
        [self.lists removeAllObjects];
        
        if ( resultModel) {
            self.resultModel = resultModel;
            [self.lists addObjectsFromSafeArray:resultModel.list];
        }
        
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        
        [self finishRefresh];
        [self showNotice:status.msg];
        [self reloadData];
    }];
}

- (void) handleShowCartButton {
    
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"mallCart")];
}

- (void)handleSearchButton {
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"search")];
}

- (UITextField*)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(12, STATUSBAR_HEIGHT+7, SCREEN_WIDTH - 12 - 56, 30)];
        _searchTextField.font = FONT(14);
        _searchTextField.placeholder = @"搜索商品";
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
    [self.collectionView registerClass:[MHModule20Cell class] forCellWithReuseIdentifier:[MHModule20Cell cellIdentifier]];
    
    [self.collectionView registerClass:[MHModule21Cell class] forCellWithReuseIdentifier:[MHModule21Cell cellIdentifier]];
    
    [self.collectionView registerClass:[MHModule22Cell class] forCellWithReuseIdentifier:[MHModule22Cell cellIdentifier]];
    
    [self.collectionView registerClass:[MHModule23Cell class] forCellWithReuseIdentifier:[MHModule23Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule24Cell class] forCellWithReuseIdentifier:[MHModule24Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule25Cell class] forCellWithReuseIdentifier:[MHModule25Cell cellIdentifier]];
    
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier]];
}

- (NSInteger)itemCount
{
    return 0;
}

- (NSInteger)headerCount
{
    return self.lists.count;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    MHModuleModel *model = [self.lists safeObjectAtIndex:indexPath.section];
    if (model.type != 20) {
        if (indexPath.item == 0) {
            
            
            NSString *classStr = [NSString stringWithFormat:@"MHModule%02dCell",model.type];
            Class class = NSClassFromString(classStr);
            BaseCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[class cellIdentifier] forIndexPath:indexPath];
            cell.cellData = model;
            [cell reloadData];
            return cell;
            
        }
    }else if(model.type == 20) {
        
        MHModule20Cell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[MHModule20Cell cellIdentifier] forIndexPath:indexPath];
        
        NSMutableDictionary *items = [NSMutableDictionary dictionary];
        [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2] forKey:@"leftItem"];
        [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2 + 1] forKey:@"rightItem"];
        cell.cellData = items;
        [cell reloadData];
        return cell;

    }
    
    
    BaseCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;

}


- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSRunLoop *currentThreadRunLoop = [NSRunLoop currentRunLoop];
    //    NSRunLoopMode mode = currentThreadRunLoop.currentMode;
    //    NSLog(@"-----------current mode:%@-----------",mode);
    
    BaseCollectionViewCell *cell;
    
   
    //id wallItem = [self.lists safeObjectAtIndex:indexPath.item];
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
    
}


- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 14;
    MHModuleModel *model = [self.lists safeObjectAtIndex:indexPath.section];
    if(model.type !=20 && indexPath.item == 0){
        
        if ( model.type == 21) {
            height = [MHModule21Cell heightForCell:model];
        }else if (model.type == 22){
            height = [MHModule22Cell heightForCell:model];
        }else if (model.type == 23){
            height = [MHModule23Cell heightForCell:model];
        }else if (model.type == 24){
            height = [MHModule24Cell heightForCell:model];
        }else if (model.type == 25){
            height = [MHModule25Cell heightForCell:model];
        }
    }else{
        if (model.type == 25) {
            height = 0;
        }else if (model.type == 20) {
            NSMutableDictionary *items = [NSMutableDictionary dictionary];
            [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2] forKey:@"leftItem"];
            [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2 + 1] forKey:@"rightItem"];
            height = [MHModule20Cell heightForCell:items];
        }
    }
    return CGSizeMake(SCREEN_WIDTH, height);
}


- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    
    
        height = [BaseCollectionViewCell heightForCell:nil];
    
    
    return CGSizeMake(SCREEN_WIDTH, height);
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MHModuleModel *model = [self.lists safeObjectAtIndex:section];
    if ( self.hasHeader && [self headerCount] > section ) {
        
        if (section == 0 ) {
            return 1;
        }else {
            if (model.type==20) {
                return ceil(model.items.count / 2.0f);
            }
            return 2;
        }
        return 0;
    }
    
    return 0;
}
@end
