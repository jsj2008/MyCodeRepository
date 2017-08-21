//
//  DSStatisticsViewController.m
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSStatisticsViewController.h"
#import "DistributorRequest.h"
#import "DSStatisticsChartCell.h"
#import "DSStatisticsOrderCell.h"
#import "DSStatisticsOrderLegendCell.h"
#import "DSStatisticsRevenueLegendCell.h"
#import "TitleDetailCell.h"

@interface DSStatisticsViewController ()
@property (nonatomic, strong) DSStatisticsResultModel *resultModel;
@property (nonatomic, strong) NSArray *list;
@end

@implementation DSStatisticsViewController

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
    self.tableView.height = SCREEN_HEIGHT - TabsViewHeight - NAVBAR_HEIGHT;
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self initData];
//}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.xxType forKey:@"xxType"];
    [params setSafeObject:self.duration forKey:@"duration"];
    [DistributorRequest getDistributorStatisticsDataWithParams:params success:^(DSStatisticsResultModel *resultModel) {
        self.resultModel = resultModel;
        self.list = resultModel.list;
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.xxType isEqualToString:@"1"]?(1+self.list.count):2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section >= 1) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (row == 0) {
            DSStatisticsChartCell *cell = [DSStatisticsChartCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.chart;
            [cell reloadData];
            return cell;
        }else if (row == 1) {
            if ([self.xxType isEqualToString:@"1"]) {
                DSStatisticsOrderLegendCell *cell = [DSStatisticsOrderLegendCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel.orderMetric;
                [cell reloadData];
                return cell;
            }else if ([self.xxType isEqualToString:@"2"]) {
                DSStatisticsRevenueLegendCell *cell = [DSStatisticsRevenueLegendCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel.earningMetric;
                [cell reloadData];
                return cell;
            }
        }

    }else if (section >= 1) {
        if ([self.xxType isEqualToString:@"1"]) {
            if (row  == 0) {
                DSStatisticsOrderCell *cell = [DSStatisticsOrderCell dequeueReusableCellForTableView:tableView];
                cell.cellData = [self.list safeObjectAtIndex:section-1];
                [cell reloadData];
                return cell;
            }
        }else if ([self.xxType isEqualToString:@"2"]) {
            if (row == 0) {
                TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
                cell.cellData = @{@"title":@"营收明细",@"desc":@"",@"link":LOCALSCHEMA(@"dsRevenueDetail")};
                cell.showLine = YES;
                cell.showMore = YES;
                [cell reloadData];
                return cell;
            }else if (row == 1) {
                TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
                cell.cellData = @{@"title":@"营收提现",@"desc":@"",@"link":LOCALSCHEMA(@"distributorRevenue")};
                cell.showLine = NO;
                cell.showMore = YES;
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
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (row == 0) {
            height = [DSStatisticsChartCell heightForCell:self.resultModel.chart];

        }else if (row == 1) {
            if ([self.xxType isEqualToString:@"1"]) {
                height = [DSStatisticsOrderLegendCell heightForCell:self.resultModel.orderMetric];
            }else if ([self.xxType isEqualToString:@"2"]) {
                height = [DSStatisticsRevenueLegendCell heightForCell:self.resultModel.earningMetric];
            }
        }else if (row == 2) {
            height = 14;
        }
        
    }else if (section >= 1) {
        if ([self.xxType isEqualToString:@"1"]) {
            if (row  == 0) {
                height = [DSStatisticsOrderCell heightForCell:[self.list safeObjectAtIndex:section-1]];
            }else if (row == 1) {
                height = 14;
            }
        }else if ([self.xxType isEqualToString:@"2"]) {
            if (row == 0) {
                height = 46;
            }else if (row == 1) {
                height = 46;
            }
        }
    }
    return height;
}
@end
