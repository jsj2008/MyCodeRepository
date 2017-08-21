//
//  DSRevenueDetailPagerController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSRevenueDetailPagerController.h"
#import "DSRevenueDetailViewController.h"
#import "DistributorHeader.h"

@interface DSRevenueDetailPagerController ()
@property (nonatomic, strong) NSArray *tabNames;
@property (nonatomic, strong) NSArray *status;
@end

@implementation DSRevenueDetailPagerController

//- (void)dealloc
//{
//    NSLog(@"-----%@ dealloc----",self.class);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBar];
    
    self.choosedColor = Theme_Color;
    self.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.noScroll = YES;
    self.noSelectBold = YES;
    
    self.title = @"营收明细";
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.tabNames = @[@"总销售额", @"分销商品"];
    self.status = @[@"1", @"2"];
    
    [self reloadData];
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
    DSRevenueDetailViewController *contentVC = [[DSRevenueDetailViewController alloc] init];
    contentVC.xxType = [self.status safeObjectAtIndex:index];
    return contentVC;
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self loadData];
}
@end
