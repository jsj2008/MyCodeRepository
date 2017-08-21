//
//  LotteryRefundViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/30.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LotteryRefundViewController.h"
#import "LotteryRecordRequest.h"
#import "LRBackgroundCell.h"
#import "LRTopBannerCell.h"
#import "LRItemCell.h"

@interface LotteryRefundViewController ()
@property (nonatomic, strong) LotteryRefundResultModel *resultModel;
@end

@implementation LotteryRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];

    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"退款";
    [self initData];
}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"participantId"] =self.participantId;
    [LotteryRecordRequest getRefundDetailNunmberDataWithParams:params success:^(LotteryRefundResultModel *resultModel) {
        self.resultModel = resultModel;
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self reloadData];
    }];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LRBackgroundCell *cell = [LRBackgroundCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.resultModel;
        [cell reloadData];
        return cell;
    }else if (indexPath.row == 2){
        LRTopBannerCell *cell = [LRTopBannerCell dequeueReusableCellForTableView:tableView];
        cell.cellData = @"商品信息";
        [cell reloadData];
        return cell;
    }else if (indexPath.row == 3){
        LRItemCell *cell = [LRItemCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.resultModel;
        [cell reloadData];
        return cell;
    }
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 14;
    if (indexPath.row == 0) {
        height = [LRBackgroundCell heightForCell:self.resultModel];
    }else if (indexPath.row == 2){
        height = [LRTopBannerCell heightForCell:self.resultModel];
    }else if (indexPath.row == 3){
        height = [LRItemCell heightForCell:self.resultModel];
    }
    return height;
}

@end
