//
//  LotteryDetailSecondViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LotteryDetailSecondViewController.h"
#import "LDInfoCell.h"
#import "LDDescCell.h"
#import "LDRecordTitleCell.h"
#import "LRNumberDetailRecordCell.h"
#import "LRDetailResultModel.h"
#import "LotteryRecordRequest.h"

@interface LotteryDetailSecondViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) LRDetailResultModel *resultModel;
@end

@implementation LotteryDetailSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_White;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"夺宝详情";
    [self initData];
}

- (void)initData
{
    self.loadingType = kInit;
    self.list = [NSMutableArray array];
    [self loadData];
}
- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"participantId"] = self.participantId;
    [LotteryRecordRequest getRecordDetailNunmberDataWithParams:params success:^(LRDetailResultModel *resultModel) {
        [self.list removeAllObjects];
        self.resultModel = resultModel;
        NSArray *numbers = [resultModel.numbers componentsSeparatedByString:@" "];
        [self.list addObjectsFromArray:numbers];
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}
#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return self.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LDInfoCell *cell = [LDInfoCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.resultModel;
        [cell reloadData];
        return cell;
    }else if (indexPath.section == 1){
        LDDescCell *cell = [LDDescCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.resultModel.myAmount;
        [cell reloadData];
        return cell;
    }else if (indexPath.section == 2){
        LDRecordTitleCell *cell = [LDRecordTitleCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.resultModel;
        [cell reloadData];
        return cell;
    }else if (indexPath.section == 3){
        LRNumberDetailRecordCell *cell = [LRNumberDetailRecordCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:indexPath.row];
        [cell reloadData];
        return cell;
    }
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 15;
    if (indexPath.section == 0) {
        height = [LDInfoCell heightForCell:self.resultModel];
    }else if (indexPath.section == 1){
        height = [LDDescCell heightForCell:self.resultModel];
    }else if (indexPath.section == 2){
        height = [LDRecordTitleCell heightForCell:nil];
    }else if (indexPath.section == 3){
        height = [LRNumberDetailRecordCell heightForCell:[self.list safeObjectAtIndex:indexPath.row]];
    }
    return height;
}

@end
