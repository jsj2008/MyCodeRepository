//
//  DSSettlementViewController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSSettlementViewController.h"
#import "RevenueRequest.h"
#import "TitleDetailCell.h"
#import "DSSTSettlementCell.h"
#import "DistributorHeader.h"

@interface DSSettlementViewController ()
@property (nonatomic, strong) NSString *totalBalance;
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation DSSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = [self.xxType isEqualToString:@"1"]?@"未结算收入":@"已结算收入";
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
        [RevenueRequest getSettlementDataWithParams:params success:^(DSSettlementResultModel *resultModel) {
            
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
        [RevenueRequest getSettlementDataWithParams:params success:^(DSSettlementResultModel *resultModel) {
            [self.list removeAllObjects];
            [self hideEmptyTips];
            if (resultModel) {
                self.totalBalance = resultModel.totalBalance;
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            if (resultModel.list.count == 0) {
                [self showEmptyTips:@"当前没有相关记录哦" ownerView:self.tableView];
            }
            [self finishRefresh];
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
        }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return self.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (row == 1) {
            TitleDetailCell *cell = [TitleDetailCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":[self.xxType isEqualToString:@"1"]?@"未结算收入":@"已结算收入",@"desc":self.totalBalance?self.totalBalance:@""};
            cell.titleLabel.font = FONT(16);
            cell.descLabel.font = FONT(16);
            cell.descLabel.textColor = Theme_Color;
            [cell reloadData];
            return cell;
        }
    }else if (section == 1) {
        DSSTSettlementCell *cell = [DSSTSettlementCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:row];
        cell.status = [self.xxType isEqualToString:@"1"]?@"未结算":@"已结算";
        [cell reloadData];
        return cell;
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
            height = self.list.count>0?48:0;
        }else if (row == 2) {
            height = 14;
        }
    }else if (section == 1) {
        height = [DSSTSettlementCell heightForCell:[self.list safeObjectAtIndex:row]];
    }
    
    return height;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
//    if (section == 1) {
//        DSSettlementIncomeModel *model = [self.list safeObjectAtIndex:row];
//        [[TTNavigationService sharedService]]
//    }
//}
@end
