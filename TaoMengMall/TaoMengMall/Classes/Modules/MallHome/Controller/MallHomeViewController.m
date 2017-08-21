//
//  MallHomeViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MallHomeViewController.h"

#import "MallHomeRequest.h"
#import "VersionCheckService.h"
#import "LaunchGuideView.h"

#import "MHModule01Cell.h"
#import "MHModule02Cell.h"
#import "MHModule03Cell.h"
#import "MHModule04Cell.h"
#import "MHModule05Cell.h"
#import "MHModule06Cell.h"
#import "MHModule07Cell.h"
#import "MHModule08Cell.h"
#import "MHModule09Cell.h"
#import "MHModule10Cell.h"
#import "MHModule11Cell.h"
#import "MHModule12Cell.h"
#import "MHModule13Cell.h"
#import "MHModule14Cell.h"
#import "MHModule15Cell.h"
#import "MHModule16Cell.h"
#import "MHModule17Cell.h"
#import "MHModule18Cell.h"
#import "MHModule19Cell.h"
#import "MHModule20Cell.h"

#import "XMShareView.h"

@interface MallHomeViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) MHResultModel *resultModel;
@property (nonatomic, strong) UIButton *cartButton;
@property (nonatomic, assign) BOOL lastRefresh;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) ShareInfoModel *shareInfo;
@property (nonatomic, strong) XMShareView *shareView;
@end

@implementation MallHomeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"淘梦商城" titleColor:Color_Gray153 selectedTitleColor:Theme_Color icon:[UIImage imageNamed:@"icon_tabbar_home_normal"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_home_select"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 40, 20);
    [shareButton setImage:[UIImage imageNamed:@"mall_item_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
    shareButton.right = SCREEN_WIDTH - 12;
    shareButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:shareButton];
    shareButton.hidden = NO;
    self.shareButton = shareButton;
    

    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 40, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    infoButton.right = SCREEN_WIDTH - 12;
    infoButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:infoButton];
    self.cartButton = infoButton;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(handleSearchButton) forControlEvents:UIControlEventTouchUpInside];
    leftButton.left = 8;
    leftButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
    [self.navigationBar addSubview:leftButton];
    
    self.collectionView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT;
    self.collectionView.showsInfiniteScrolling = NO;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.hasHeader = YES;
    
    self.title = @"淘梦商城";
    [self initData];
    [[VersionCheckService sharedService] check];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchViewWillRemove:) name:LaunchViewWillRemoveNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cartButton.selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cartHasItems"] isEqualToString:@"1"];
}

- (void)didReceiveMemoryWarning
{
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)launchViewWillRemove:(NSNotification*)noti
{
    if (!self.lastRefresh) {
        [self initData];
    }
}

#pragma mark - Private Methods


- (void)initData
{
    self.items = [NSMutableArray array];
    self.loadingType = kInit;
    [self loadData];
}


- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [MallHomeRequest getHomeDataWithParams:params success:^(MHResultModel *resultModel) {
        //[self hideErrorTips];

        [self.items removeAllObjects];
        self.resultModel = resultModel;
        [self.items addObjectsFromSafeArray:resultModel.list];
        self.shareInfo = resultModel.share;
        self.collectionView.showsInfiniteScrolling = NO;
        [self finishRefresh];
        [self reloadData];
        self.lastRefresh = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_REMOVE object:nil];
        if (self.shareInfo) {
            self.shareButton.hidden = NO;
            self.shareButton.right = SCREEN_WIDTH - 12;
            self.shareButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
            
            self.cartButton.right = self.shareButton.left ;
            self.cartButton.centerY = self.shareButton.centerY;
        }else{
            self.shareButton.hidden = YES;
            
            self.cartButton.right = SCREEN_WIDTH - 12;
            self.cartButton.centerY = (STATUSBAR_HEIGHT + self.navigationBar.height)/2;
        }


    } failure:^(StatusModel *status) {
        [self hideErrorTips];
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
        [self showErrorTips];
        self.lastRefresh = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_REMOVE object:nil];
    }];
}

- (void) handleShowCartButton {

    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"mallCart")];
    //[[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"luckDraw")];

}

- (void)handleSearchButton {
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"search")];
}

#pragma mark -
- (void)registCell
{
    
    [self.collectionView registerClass:[MHModule01Cell class] forCellWithReuseIdentifier:[MHModule01Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule02Cell class] forCellWithReuseIdentifier:[MHModule02Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule03Cell class] forCellWithReuseIdentifier:[MHModule03Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule04Cell class] forCellWithReuseIdentifier:[MHModule04Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule05Cell class] forCellWithReuseIdentifier:[MHModule05Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule06Cell class] forCellWithReuseIdentifier:[MHModule06Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule07Cell class] forCellWithReuseIdentifier:[MHModule07Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule08Cell class] forCellWithReuseIdentifier:[MHModule08Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule09Cell class] forCellWithReuseIdentifier:[MHModule09Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule10Cell class] forCellWithReuseIdentifier:[MHModule10Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule11Cell class] forCellWithReuseIdentifier:[MHModule11Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule12Cell class] forCellWithReuseIdentifier:[MHModule12Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule13Cell class] forCellWithReuseIdentifier:[MHModule13Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule14Cell class] forCellWithReuseIdentifier:[MHModule14Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule15Cell class] forCellWithReuseIdentifier:[MHModule15Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule16Cell class] forCellWithReuseIdentifier:[MHModule16Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule17Cell class] forCellWithReuseIdentifier:[MHModule17Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule18Cell class] forCellWithReuseIdentifier:[MHModule18Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule19Cell class] forCellWithReuseIdentifier:[MHModule19Cell cellIdentifier]];
    [self.collectionView registerClass:[MHModule20Cell class] forCellWithReuseIdentifier:[MHModule20Cell cellIdentifier]];
    
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier]];
}

- (NSInteger)itemCount
{
    return 0;
}

- (NSInteger)headerCount
{

    return self.items.count;
}

- (UICollectionViewCell *)cellForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    MHModuleModel *model = [self.items safeObjectAtIndex:indexPath.section];
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
    
    id wallItem = [self.items safeObjectAtIndex:indexPath.item];
    
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[BaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell reloadData];
    return cell;
    
}


- (CGSize)sizeForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 14;
    MHModuleModel *model = [self.items safeObjectAtIndex:indexPath.section];
    if(model.type!=20 && indexPath.item == 0){
        
        if (model.type == 1) {
            height = [MHModule01Cell heightForCell:model];
        }else if (model.type == 2){
            height = [MHModule02Cell heightForCell:model];
        }else if (model.type == 3){
            height = [MHModule03Cell heightForCell:model];
        }else if (model.type == 4){
            height = [MHModule04Cell heightForCell:model];
        }else if (model.type == 5){
            height = [MHModule05Cell heightForCell:model];
        }else if (model.type == 6){
            height = [MHModule06Cell heightForCell:model];
        }else if (model.type == 7){
            height = [MHModule07Cell heightForCell:model];
        }else if (model.type == 8){
            height = [MHModule08Cell heightForCell:model];
        }else if (model.type == 9){
            height = [MHModule09Cell heightForCell:model];
        }else if (model.type == 10){
            height = [MHModule10Cell heightForCell:model];
        }else if (model.type == 11){
            height = [MHModule11Cell heightForCell:model];
        }else if (model.type == 12){
            height = [MHModule12Cell heightForCell:model];
        }else if (model.type == 13){
            height = [MHModule13Cell heightForCell:model];
        }else if (model.type == 14){
            height = [MHModule14Cell heightForCell:model];
        }else if (model.type == 15){
            height = [MHModule15Cell heightForCell:model];
        }else if (model.type == 16){
            height = [MHModule16Cell heightForCell:model];
        }else if (model.type == 17){
            height = [MHModule17Cell heightForCell:model];
        }else if (model.type == 18){
            height = [MHModule18Cell heightForCell:model];
        }else if (model.type == 19){
            height = [MHModule19Cell heightForCell:model];
        }
        
    }else if (model.type == 20) {
        NSMutableDictionary *items = [NSMutableDictionary dictionary];
        [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2] forKey:@"leftItem"];
        [items setSafeObject:[model.items safeObjectAtIndex:indexPath.row*2 + 1] forKey:@"rightItem"];
        height = [MHModule20Cell heightForCell:items];
    }
    return CGSizeMake(SCREEN_WIDTH, height);
}


- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    id wallItem = [self.items safeObjectAtIndex:indexPath.item ];
    
    height = [BaseCollectionViewCell heightForCell:wallItem];
    return CGSizeMake(CELL_WIDTH, height);
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    MHModuleModel *model = [self.items safeObjectAtIndex:section];
    if ( self.hasHeader && [self headerCount] > section ) {
        if (section == 0 ) {
            return 1;
        }
        else {
            if (model.type == 20) {
                return ceil(model.items.count/2.0f);
            }
            return 2;
        }
        return 0;
    }
    
    return [self itemCount];
}

#pragma mark
- (void)errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}


- (void)handleShareButton
{
    if (!self.shareInfo) {
        [self showNotice:@"分享信息获取失败，请稍后再试"];
        return;
    }
    self.shareView.shareInfo = self.shareInfo;
    [self.shareView show];
}

- (XMShareView*)shareView
{
    if (!_shareView) {
        _shareView = [[XMShareView alloc]init];
    }
    return _shareView;
}
@end
