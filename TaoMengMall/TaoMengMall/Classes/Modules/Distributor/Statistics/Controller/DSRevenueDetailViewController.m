//
//  DSRevenueDetailViewController.m
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSRevenueDetailViewController.h"
#import "DistributorRequest.h"
#import "DSRevenueDetailTotalCell.h"
#import "DSRevenueDetailDistributionCell.h"

@interface DSRevenueDetailViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSString *sum;
@property (nonatomic, strong) NSString *profit;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UILabel *profitLabel;
@end

@implementation DSRevenueDetailViewController

//- (void)dealloc
//{
//    NSLog(@"-----%@ dealloc----",self.class);
//}

- (void)viewDidLoad {
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    self.tableView.height = SCREEN_HEIGHT - TabsViewHeight - NAVBAR_HEIGHT - 44;
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.loadingType = kInit;
    self.list = [NSMutableArray array];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.xxType forKey:@"xxType"];
    if (self.loadingType == kLoadMore) {
        [params setSafeObject:self.wp forKey:@"wp"];
        [DistributorRequest getRevenueDetailDataWithParams:params success:^(DSRevenueDetailResultModel *resultModel) {

            if (resultModel) {
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            
            [self finishLoadMore];
            [self reloadData];
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishLoadMore];
            [self reloadData];
        }];
        
    }else{
        [DistributorRequest getRevenueDetailDataWithParams:params success:^(DSRevenueDetailResultModel *resultModel) {
            [self.list removeAllObjects];
            [self hideEmptyTips];
            if (resultModel) {
                self.profit = resultModel.profit;
                self.sum = resultModel.salesVolume;
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            if (resultModel.list.count == 0) {
                [self showEmptyTips:@"当前没有相关明细哦" ownerView:self.tableView];
            }
            [self finishRefresh];
            [self reloadData];
            [self render];
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
        }];
    }
}

- (void)render
{
    [self.view addSubview:self.line];
    [self.view addSubview:self.sumLabel];
    [self.view addSubview:self.profitLabel];
    
    self.profitLabel.text = self.profit;
    [self.profitLabel sizeToFit];
    self.profitLabel.right = SCREEN_WIDTH - 12;
    self.profitLabel.centerY = self.line.bottom + 22;
    
    self.sumLabel.text = self.sum;
    [self.sumLabel sizeToFit];
    self.sumLabel.right = self.profit?self.profitLabel.left - 4:SCREEN_WIDTH-12;
    self.sumLabel.centerY = self.line.bottom + 22;
}

#pragma mark -Suviews
- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray233;
        view.top = SCREEN_HEIGHT - NAVBAR_HEIGHT -TabsViewHeight - 44;
        _line = view;
    }
    return _line;
}

- (UILabel*)sumLabel
{
    if (!_sumLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _sumLabel = label;
    }
    return _sumLabel;
}

- (UILabel*)profitLabel
{
    if (!_profitLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _profitLabel = label;
    }
    return _profitLabel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if ([self.xxType isEqualToString:@"1"]) {
            DSRevenueDetailTotalCell *cell = [DSRevenueDetailTotalCell dequeueReusableCellForTableView:tableView];
            cell.cellData = [self.list safeObjectAtIndex:row];
            [cell reloadData];
            return cell;
        }else if ([self.xxType isEqualToString:@"2"]) {
            DSRevenueDetailDistributionCell *cell = [DSRevenueDetailDistributionCell dequeueReusableCellForTableView:tableView];
            cell.cellData = [self.list safeObjectAtIndex:row];
            [cell reloadData];
            return cell;
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
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if ([self.xxType isEqualToString:@"1"]) {
            height = [DSRevenueDetailTotalCell heightForCell:[self.list safeObjectAtIndex:row]];
        }else if ([self.xxType isEqualToString:@"2"]) {
            height = [DSRevenueDetailDistributionCell heightForCell:[self.list safeObjectAtIndex:row]];
        }
    }
    return height;
}
@end
