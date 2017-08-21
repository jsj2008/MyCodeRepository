//
//  LotteryLuckyRecordViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckyRecordViewController.h"
#import "LuckyItemCell.h"
#import "LLStateCell.h"
#import "LuckyRecordRequest.h"

@interface LuckyRecordViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation LuckyRecordViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"幸运记录";
    [self initData];
    
}

- (void)initData
{
    self.loadingType = kInit;
    self.list = [NSMutableArray array];
    [self loadData];
}

- (void)loadData{
    
    [LuckyRecordRequest getRecordListWithParams:nil success:^(LuckyRecordResultModel *resultModel) {
        [self.list removeAllObjects];
        [self.list addObjectsFromArray:resultModel.list];
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LuckyItemCell *cell = [LuckyItemCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:indexPath.section];
        [cell reloadData];
        return cell;
    }else if (indexPath.row == 1){
        LLStateCell *cell = [LLStateCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:indexPath.section];
        [cell reloadData];
        return cell;
    }
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 15;
    if (indexPath.row == 0) {
        height = [LuckyItemCell heightForCell:[self.list safeObjectAtIndex:indexPath.section]];
    }else if (indexPath.row == 1){
        height = [LLStateCell heightForCell:[self.list safeObjectAtIndex:indexPath.section]];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LuckyRecordItemModel *model = [self.list safeObjectAtIndex:indexPath.section];
        [[TTNavigationService sharedService] openUrl:model.link];
    }
}

@end
