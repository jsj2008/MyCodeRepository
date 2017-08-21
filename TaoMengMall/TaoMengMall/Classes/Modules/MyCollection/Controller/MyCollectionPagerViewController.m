//
//  MyCollectionPagerViewController.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MyCollectionPagerViewController.h"
#import "MyCollectionViewController.h"
#import "MyCollectionShopViewController.h"

NSString *const kNOTIFY_COLLECTION_EDIT_CHANGE = @"kNOTIFY_COLLECTION_EDIT_CHANGE";

@interface MyCollectionPagerViewController ()

@property (nonatomic, strong) NSArray *tabNames;
@property (nonatomic, strong) NSArray *status;
@property (nonatomic,assign) BOOL isEditing;
@property (nonatomic, strong) UIButton *editButton;

@end

@implementation MyCollectionPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationBar];
    
    self.choosedColor = Theme_Color;
    self.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.noScroll = YES;
    self.noSelectBold = YES;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 32);
    rightButton.titleLabel.font = FONT(18);
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(handleRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.editButton = rightButton;
    self.navigationBar.rightBarButton = rightButton;
    
    self.title = @"我的收藏";
    [self initData];

}
- (void)handleRightButton
{
    self.isEditing = !self.isEditing;
    self.editButton.selected = self.isEditing;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_COLLECTION_EDIT_CHANGE object:[NSString stringWithFormat:@"%d",self.isEditing]];
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
    
    self.tabNames = @[@"宝贝", @"店铺"];
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
    if (index == 0) {
        MyCollectionViewController *contentVC = [[MyCollectionViewController alloc] init];
        contentVC.collectionType = [self.status safeObjectAtIndex:index];
        return contentVC;
    }else {
        MyCollectionShopViewController *contentVC = [[MyCollectionShopViewController alloc] init];
        contentVC.collectionType = [self.status safeObjectAtIndex:index];
        return contentVC;
    }
    
}

- (void)viewPager:(TTViewPagerController *)viewPager didSelectTabAtIndex:(NSInteger)index
{
    self.editButton.hidden = (index != 0);
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self loadData];
}

@end
