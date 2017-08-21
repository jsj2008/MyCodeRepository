//
//  OrderViewPagerController.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "OrderViewPagerController.h"
#import "OrderListViewController.h"

@interface OrderViewPagerController ()<TTViewPagerDelegate>

@property (nonatomic, strong) NSArray *tabNames;
@property (nonatomic, strong) NSArray *status;

@end

@implementation OrderViewPagerController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationBar];

    // Do any additional setup after loading the view.
    self.choosedColor = Theme_Color;
    self.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.noScroll = YES;
    self.noSelectBold = YES;
    self.choosedColor = Theme_Color;
    
    self.title = @"订单列表";
    
    [self initData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!IsEmptyString(self.selectedIndex)) {
        [self selectTabAtIndex:[self.selectedIndex integerValue]];
        self.selectedIndex = nil;
    }
}

#pragma mark - Private Methods

- (void)initData {
    
    [self loadData];
    
}

- (void)loadData
{
    
    self.tabNames = @[@"全部", @"待付款",@"待发货", @"待收货", @"待评价"];
    self.status = @[@"0", @"1", @"2", @"3",@"4"];
    
    [self reloadData];
//    
//    [StyleListRequest getStyleTagBarDataSuccess:^(StyleTagBarResultsModel *resultsModel) {
//        if (resultsModel) {
//            self.titleArr = resultsModel.tagBar;
//            [self reloadData];
//        }
//        
//        [self hideErrorTips];
//    } failure:^(StatusModel *status) {
//        [self showErrorTips];
//    }];
//    
    
}

#pragma mark - TTViewPagerDelegate

- (NSUInteger)numberOfTabsForViewPager:(TTViewPagerController *)viewPager
{
    return self.tabNames.count;
}

- (UILabel *)viewPager:(TTViewPagerController *)viewPager tabForTabAtIndex:(NSUInteger)index
{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = Color_Gray153;
    titleLabel.font = FONT(14);
    titleLabel.text = [self.tabNames safeObjectAtIndex:index];
    [titleLabel sizeToFit];
    return titleLabel;
    
}

- (UIViewController *)viewPager:(TTViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    
    
    
    OrderListViewController *contentVC = [[OrderListViewController alloc] init];
    contentVC.type = self.type;
    contentVC.status = [self.status safeObjectAtIndex:index];
    
    return contentVC;
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self loadData];
}

@end
