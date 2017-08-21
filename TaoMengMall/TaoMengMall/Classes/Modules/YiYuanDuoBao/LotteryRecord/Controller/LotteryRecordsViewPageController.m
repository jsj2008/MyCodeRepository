//
//  OrderViewPagerController.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "LotteryRecordsViewPageController.h"
#import "LotteryRecordsViewController.h"

@interface LotteryRecordsViewPageController ()<TTViewPagerDelegate>

@property (nonatomic, strong) NSArray *tabNames;
@property (nonatomic, strong) NSArray *status;

@end

@implementation LotteryRecordsViewPageController

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
    
    self.title = @"夺宝记录";
    
    [self initData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self selectTabAtIndex:self.selectedIndex];
}

#pragma mark - Private Methods

- (void)initData {
    
    [self loadData];
    
}

- (void)loadData
{
    
    self.tabNames = @[@"全部", @"进行中",@"已结束",@"已过期"];
    self.status = @[@"0", @"1", @"2",@"3"];
    
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
    
    
    
    LotteryRecordsViewController *contentVC = [[LotteryRecordsViewController alloc] init];
    contentVC.status = [self.status safeObjectAtIndex:index];
    
    return contentVC;
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self loadData];
}

@end
