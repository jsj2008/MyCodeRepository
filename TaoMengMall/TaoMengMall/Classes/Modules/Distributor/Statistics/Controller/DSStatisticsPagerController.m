//
//  DSStatisticsPagerController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSStatisticsPagerController.h"
#import "DSStatisticsViewController.h"
#import "DistributorHeader.h"

@interface DSStatisticsPagerController ()
@property (nonatomic, strong)UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *tabNames;
@property (nonatomic, strong) NSArray *status;
@property (nonatomic, strong) NSMutableArray *lastSelection;
@property (nonatomic, strong) NSMutableArray *viewControllers;

@end

@implementation DSStatisticsPagerController

//- (void)dealloc
//{
//    NSLog(@"-----%@ dealloc----",self.class);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    [self.navigationBar addSubview:self.segmentedControl];

    self.choosedColor = Theme_Color;
    self.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.noScroll = YES;
    self.noSelectBold = YES;
    
    if (!self.xxType) {
        self.xxType = @"1";
    }else{
        if ([self.xxType isEqualToString:@"1"]) {
            self.segmentedControl.selectedSegmentIndex = 0;
        }else if ([self.xxType isEqualToString:@"2"]){
            self.segmentedControl.selectedSegmentIndex = 1;
        }
    }
    
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

- (void)initData
{
    self.lastSelection = [NSMutableArray arrayWithArray:@[@0,@0]];
    self.viewControllers = [NSMutableArray arrayWithArray:@[[NSNull null],[NSNull null],[NSNull null]]];
    [self loadData];
}

- (void)loadData
{
    self.tabNames = @[@"7天", @"30天",@"90天"];
    self.status = @[@"7", @"30",@"90"];
    [self reloadData];
}

- (UISegmentedControl*)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"订单",@"营收"]];
        _segmentedControl.tintColor = Theme_Color;
        _segmentedControl.height = 30;
        _segmentedControl.width = 200;
        _segmentedControl.centerX = SCREEN_WIDTH/2;
        _segmentedControl.top = 6+20;
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.layer.borderColor = Theme_Color.CGColor;
        _segmentedControl.layer.borderWidth = 1.;
        _segmentedControl.layer.cornerRadius = 4.f;
        _segmentedControl.layer.masksToBounds = YES;
        [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName: FONT(13),NSForegroundColorAttributeName:Color_Gray(23)} forState:UIControlStateNormal];
        [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName: FONT(13),NSForegroundColorAttributeName:Color_White} forState:UIControlStateSelected];
        [_segmentedControl addTarget:self action:@selector(handleSegmentChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void)handleSegmentChange:(UISegmentedControl*)segment
{
    NSInteger index = 0;
    if (segment.selectedSegmentIndex == 0) {
        self.xxType = @"1";
        index = [[self.lastSelection safeObjectAtIndex:0] integerValue];
    }else if (segment.selectedSegmentIndex == 1) {
        self.xxType = @"2";
        index = [[self.lastSelection safeObjectAtIndex:1] integerValue];
    }
    //重置xxType
    for (DSStatisticsViewController *vc  in self.viewControllers) {
        if ([vc isKindOfClass:[DSStatisticsViewController class]]) {
            vc.xxType = self.xxType;
        }
    }
    
    //刷新选中页面并选中
    DSStatisticsViewController *vc = [self.viewControllers safeObjectAtIndex:index];
    if ([vc isKindOfClass:[DSStatisticsViewController class]]) {
        [vc loadData];
        [self selectTabAtIndex:index];
    }
    //[self selectTabAtIndex:index];

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
    DSStatisticsViewController *contentVC = [self.viewControllers safeObjectAtIndex:index];
    if ([contentVC isKindOfClass:[NSNull class]] &&index<3) {
        contentVC = [[DSStatisticsViewController alloc] init];
        [self.viewControllers replaceObjectAtIndex:index withObject:contentVC];
    }
    contentVC.duration = [self.status safeObjectAtIndex:index];
    contentVC.xxType = self.xxType;
    return contentVC;
}

- (void)viewPager:(TTViewPagerController *)viewPager didSelectTabAtIndex:(NSInteger)index
{
    if ([self.xxType isEqualToString:@"1"]) {
        [self.lastSelection replaceObjectAtIndex:0 withObject:@(index)];
    }else if ([self.xxType isEqualToString:@"2"]) {
        [self.lastSelection replaceObjectAtIndex:1 withObject:@(index)];
    }
    DSStatisticsViewController *vc = [self.viewControllers safeObjectAtIndex:index];
    if ([vc isKindOfClass:[DSStatisticsViewController class]]) {
        [vc loadData];
    }
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self loadData];
}
@end
