//
//  DSRevenueViewController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSRevenueViewController.h"
#import "RevenueRequest.h"
#import "DSRVTotalCell.h"
#import "TitleDetailCell.h"

@interface DSRevenueViewController ()
@property (nonatomic, strong) DSRevenueHomeResultModel *resultModel;
@end

@implementation DSRevenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"营收";
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RevenueRequest getRevenueHomeDataWithParams:params success:^(DSRevenueHomeResultModel *resultModel) {
        self.resultModel = resultModel;
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
    return  3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (row == 1) {
            DSRVTotalCell *cell = [DSRVTotalCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.withdrawAmount;
            [cell reloadData];
            return cell;
        }else if (row == 2) {
            TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":@"不可用金额",@"desc":self.resultModel.disableAmount?self.resultModel.disableAmount:@"",@"link":LOCALSCHEMA(@"dsUnavailableSum")};
            cell.showLine = NO;
            cell.showMore = YES;
            [cell reloadData];
            return cell;
        }
    }else if (section == 1) {
        if (row == 1) {
            TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":@"已结算收入",@"desc":self.resultModel.settledAmount?self.resultModel.settledAmount:@"",@"link":LOCALSCHEMA(@"dsSettlement?xxType=2")};
            cell.showLine = YES;
            cell.showMore = YES;
            [cell reloadData];
            return cell;
        }else if (row == 2) {
            TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":@"未结算收入",@"desc":self.resultModel.unsettledAmount?self.resultModel.unsettledAmount:@"",@"link":LOCALSCHEMA(@"dsSettlement?xxType=1")};
            cell.showLine = NO;
            cell.showMore = YES;
            [cell reloadData];
            return cell;
        }
    }else if (section == 2) {
        if (row == 1) {
            TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":@"收支明细",@"desc":@"",@"link":LOCALSCHEMA(@"dsReceiptPayment")};
            cell.showLine = YES;
            cell.showMore = YES;
            [cell reloadData];
            return cell;
        }else if (row == 2) {
            TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":@"提现记录",@"desc":@"",@"link":LOCALSCHEMA(@"dsWithdrawHistory")};
            cell.showLine = NO;
            cell.showMore = YES;
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
        if (row == 0) {
            height = 14;
        }else if (row == 1) {
            height = [DSRVTotalCell heightForCell:@""];
        }else if (row == 2) {
            height = 46;
        }
    }else if (section == 1) {
        if (row == 0) {
            height = 14;
        }else if (row == 1) {
            height = 46;
        }else if (row == 2) {
            height = 46;
        }
    }else if (section == 2) {
        if (row == 0) {
            height = 14;
        }else if (row == 1) {
            height = 46;
        }else if (row == 2) {
            height = 46;
        }
    }
    return height;
}
@end
