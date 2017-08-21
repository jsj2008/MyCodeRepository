//
//  MineViewController.m
//  HongBao
//
//  Created by Ivan on 16/2/8.
//  Copyright © 2016年 ivan. All rights reserved.
//


#import "MineViewController.h"

#import "MIOrderCell.h"
#import "MIMenuItemCell.h"
#import "MIHeadCell.h"

#import "MineRequest.h"
#import "UserService.h"

#define SECTION_USER 0
#define SECTION_MENU 1

@interface MineViewController ()

@property (nonatomic, strong) NSMutableArray *menu;

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) MineResultModel *resultModel;

@end

@implementation MineViewController

#pragma mark - Life Cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:@"我的" titleColor:Color_Gray153 selectedTitleColor:Theme_Color icon:[UIImage imageNamed:@"icon_tabbar_mine_normal"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_mine_selected"]];
    }
    return self;
}

- (void)viewDidLoad{
    
    //self.hideNavigationBar = YES;
    [super viewDidLoad];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 32);
    rightButton.titleLabel.font = FONT(18);
    [rightButton setImage:[UIImage imageNamed:@"mine_setting_icon"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(handleRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButton = rightButton;
    
    self.view.backgroundColor = Color_Gray245;
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"我的";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:kNOTIFY_USER_LOGOUT_COMPLETED object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:kNOTIFY_USER_LOGIN_COMPLETED object:nil];

}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}


#pragma mark - Private Methods

- (void)initData
{
    self.points = @"0";
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    self.menu = @[
                  @{@"type":@"empty",},
                  @{@"type":@"item", @"icon":@"icon_mine_cart", @"title":@"购物车", @"link":@"xiaoma://mallCart", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_collection", @"title":@"我的收藏", @"link":@"xiaoma://myCollection", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_point", @"title":@"淘米余额", @"link":@"xiaoma://pointDetail", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_pointorder", @"title":@"淘米商城订单", @"link":@"xiaoma://pointMallOrderList", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"empty",},
                  @{@"type":@"item", @"icon":@"icon_mine_ member", @"title":@"成为会员", @"link":@"", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"item", @"icon":@"icon_mine_ invite", @"title":@"邀请有礼", @"link":@"", @"line":@YES, @"arrow":@YES,@"value":@""},
                  @{@"type":@"empty",},
                  //@{@"type":@"item", @"icon":@"icon_mine_lottery", @"title":@"全部夺宝记录", @"link":@"xiaoma://lotteryRecords", @"line":@YES, @"arrow":@YES},
                  //@{@"type":@"item", @"icon":@"icon_mine_lucky", @"title":@"幸运记录", @"link":@"xiaoma://luckRecord", @"line":@YES, @"arrow":@YES},
                  //@{@"type":@"item", @"icon":@"icon_mine_topUp", @"title":@"充值记录", @"link":@"xiaoma://chargeRecords", @"line":@YES, @"arrow":@YES},
                  ];
    
    [MineRequest getMineDataWithParams:nil success:^(MineResultModel *resultModel) {
        
        
        if ( resultModel ) {
            
            //self.points = resultModel.points;
            self.resultModel = resultModel;
            [UserService sharedService].gender = resultModel.gender;
            [UserService sharedService].name = resultModel.nickName;
            [UserService sharedService].avatar = resultModel.avatar;
            
            //[[UserService sharedService] updateInfo:resultModel.gender for:@"gender"];
            
            if (!IsEmptyString(resultModel.aboutLink)) {
                [[NSUserDefaults standardUserDefaults] setObject:resultModel.aboutLink forKey:@"aboutLink"];
            }
            if (!IsEmptyString(resultModel.supportLink)) {
                [[NSUserDefaults standardUserDefaults] setObject:resultModel.supportLink forKey:@"supportLink"];
            }
            if (!IsEmptyString(resultModel.protocolLink)) {
                [[NSUserDefaults standardUserDefaults] setObject:resultModel.protocolLink forKey:@"protocolLink"];
            }
            
            self.menu = [NSMutableArray arrayWithArray:@[
                                                         @{@"type":@"empty",},
                                                         @{@"type":@"item", @"icon":@"icon_mine_location", @"title":@"居住地", @"link":@"", @"line":@YES, @"arrow":@NO,@"value":resultModel.address},
                                                         @{@"type":@"item", @"icon":@"icon_mine_cart", @"title":@"购物车", @"link":@"xiaoma://mallCart", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                         @{@"type":@"item", @"icon":@"icon_mine_collection", @"title":@"我的收藏", @"link":@"xiaoma://myCollection", @"line":@YES, @"arrow":@YES,@"value":@""},@{@"type":@"empty",},
                                                         @{@"type":@"item", @"icon":@"icon_mine_point", @"title":@"淘米余额", @"link":@"xiaoma://pointDetail", @"line":@YES, @"arrow":@YES,@"value":resultModel.points},
                                                         @{@"type":@"item", @"icon":@"icon_mine_pointorder", @"title":@"淘米商城订单", @"link":@"xiaoma://mallOrderList?type=1", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                         @{@"type":@"empty",},
                                                         @{@"type":@"item", @"icon":@"icon_mine_ member", @"title":@"成为会员", @"link":LOCALSCHEMA(@"becomeMember"), @"line":@YES, @"arrow":@YES,@"value":@""},
                                                         @{@"type":@"item", @"icon":@"icon_mine_ invite", @"title":@"邀请有礼", @"link":resultModel.representLink, @"line":@YES, @"arrow":@YES,@"value":@""},
                                                         @{@"type":@"empty",},]];
            if (resultModel.showLuck) {
                [self.menu addObjectsFromArray:@[
                                                @{@"type":@"item", @"icon":@"icon_mine_lottery", @"title":@"全部夺宝记录", @"link":@"xiaoma://lotteryRecords", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                @{@"type":@"item", @"icon":@"icon_mine_lucky", @"title":@"幸运记录", @"link":@"xiaoma://luckRecord", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                @{@"type":@"item", @"icon":@"icon_mine_topUp", @"title":@"充值记录", @"link":@"xiaoma://chargeRecords", @"line":@YES, @"arrow":@YES,@"value":@""},
                                                @{@"type":@"empty"}]];
            }
        }
        
        [self hideErrorTips];
        [self finishRefresh];

        [self reloadData];
        
    } failure:^(StatusModel *status) {
        
        DBG(@"%@", status);
        
        [self finishRefresh];
        [self reloadData];

    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == SECTION_USER ) {
        return 4;
    } else if ( section == SECTION_MENU ) {
        return self.menu.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( indexPath.section == SECTION_USER ) {
        
        if ( 0 == indexPath.row ){
            MIHeadCell *cell = [MIHeadCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel;
            [cell reloadData];
            return cell;
        }else if (2 == indexPath.row ) {
            MIOrderCell *cell = [MIOrderCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.orderPendingCount;
            [cell reloadData];
            return cell;
        }

        
    }  else if ( indexPath.section == SECTION_MENU) {
        
        if ( indexPath.row < self.menu.count ) {
            
            NSDictionary *itemData = [self.menu safeObjectAtIndex:indexPath.row];
            
            if ( ![@"empty" isEqualToString:itemData[@"type"]]) {
                
                MIMenuItemCell *cell = [MIMenuItemCell dequeueReusableCellForTableView:tableView];
                cell.cellData = itemData;
                [cell reloadData];
                return cell;
                
            }
            
            
        }
        
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat height = 0;
    
    if ( indexPath.section == SECTION_USER ) {
        
        if ( 0 == indexPath.row ){
            
            height = [MIHeadCell heightForCell:nil];

        } else if ( 2 == indexPath.row) {
            
            height = [MIOrderCell heightForCell:nil];
            
        } else {
            
            height = 14;
            
        }
        
    }  else if ( indexPath.section == SECTION_MENU) {
        
        if ( indexPath.row < self.menu.count ) {
            
            height = [MIMenuItemCell heightForCell:[self.menu safeObjectAtIndex:indexPath.row]];
            
        }
        
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( indexPath.section == SECTION_MENU) {
        
        if ( indexPath.row < self.menu.count ) {
            
            NSDictionary *itemData = [self.menu safeObjectAtIndex:indexPath.row];
            
            if ( [@"item" isEqualToString:itemData[@"type"]]) {
                [[TTNavigationService sharedService] openUrl:itemData[@"link"]];
            }
            
        }
    }
    
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - methods
- (void)handleRightButton{
    [[TTNavigationService sharedService] openUrl:@"xiaoma://setting"];
}

@end
