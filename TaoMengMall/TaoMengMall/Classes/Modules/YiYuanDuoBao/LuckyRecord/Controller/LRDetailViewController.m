//
//  LLRDetailViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRDetailViewController.h"
#import "LCTopBannerCell.h"
#import "LRFlowCell.h"
#import "LCAdressCell.h"
#import "LuckyItemCell.h"
#import "LuckyRecordRequest.h"

@interface LRDetailViewController ()<LRFlowCellDelegate>
@property (nonatomic, strong) LukcyRecordDetailResultModel *resultModel;
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation LRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"幸运详情";
    [self initData];
}

- (void)initData{
    self.list = [NSMutableArray array];
    [self loadData];
}
- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"activityId"] = self.activityId;
    [LuckyRecordRequest getRecordDetailWithParams:params success:^(LukcyRecordDetailResultModel *resultModel) {
        [self.list removeAllObjects];
        [self.list addObjectsFromArray:resultModel.express];
        self.resultModel = resultModel;
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

#pragma mark - tabelView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1 + self.list.count;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LCTopBannerCell *cell = [LCTopBannerCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @"物流物品";
            [cell reloadData];
            return cell;
        }else{
            LRFlowCell *cell = [LRFlowCell dequeueReusableCellForTableView:tableView];
            cell.cellData = [self.list safeObjectAtIndex:indexPath.row - 1];
            if (indexPath.row == 1) {
                cell.isBegin = YES;
            }else if (indexPath.row == self.list.count){
                cell.isEnd = YES;
            }
            cell.delegate = self;
            [cell reloadData];
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            LCTopBannerCell *cell = [LCTopBannerCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @"收货地址";
            [cell reloadData];
            return cell;
        }else if (indexPath.row == 1){
            LCAdressCell *cell = [LCAdressCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.address;
            [cell reloadData];
            return cell;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            LCTopBannerCell *cell = [LCTopBannerCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @"商品信息";
            [cell reloadData];
            return cell;
        }else if (indexPath.row == 1){
            LuckyItemCell *cell = [LuckyItemCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.award;
            [cell reloadData];
            return cell;
        }
    }

    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 15;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = [LCTopBannerCell heightForCell:self.resultModel];
        }else{
            height = [LRFlowCell heightForCell:[self.list safeObjectAtIndex:indexPath.row - 1]];
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            height = [LCTopBannerCell heightForCell:self.resultModel];
        }else if (indexPath.row == 1){
            height = [LCAdressCell heightForCell:self.resultModel.address];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            height = [LCTopBannerCell heightForCell:self.resultModel];
        }else if (indexPath.row == 1){
            height = [LuckyItemCell heightForCell:self.resultModel.award];
        }
    }
    return height;
}

#pragma mark - LRFlowCellDelegate
- (void)handleRecieveButton{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"activityId"] = self.activityId;
    [LuckyRecordRequest receiveWithParams:params success:^{
        [self showNotice:@"确认收货成功"];
        [self initData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

@end
