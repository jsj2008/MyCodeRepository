//
//  LotteryRecordViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckyHistoryRecordViewController.h"
#import "LuckyRecordCell.h"
#import "LuckyRecordRequest.h"

@interface LuckyHistoryRecordViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation LuckyHistoryRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"往期揭晓";
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
    params[@"activityId"] = self.activityId;
    [LuckyRecordRequest getHistoryRecordListWithParams:params success:^(LuckyHistoryResultModel *resultModel) {
        [self.list removeAllObjects];
        [self.list addObjectsFromArray:resultModel.list];
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LuckyRecordCell *cell = [LuckyRecordCell dequeueReusableCellForTableView:tableView];
    cell.cellData = [self.list safeObjectAtIndex:indexPath.row];
    [cell reloadData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    height = [LuckyRecordCell heightForCell:[self.list safeObjectAtIndex:indexPath.row]];
    return height;
}




@end
