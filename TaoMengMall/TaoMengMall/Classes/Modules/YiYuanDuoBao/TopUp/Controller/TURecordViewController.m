//
//  TURecordViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "TURecordViewController.h"
#import "TURTopBannerCell.h"
#import "TURContentCell.h"
#import "TopUpRequest.h"


@interface TURecordViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation TURecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
   
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"充值记录";
    [self initData];
}

- (void)initData
{
    self.loadingType = kInit;
    self.list = [NSMutableArray array];
    [self loadData];
}

- (void)loadData
{
    [TopUpRequest getTopUpRecordListWithParams:nil success:^(TopUpRecordResultModel *resultModel) {
        [self hideEmptyTips];
        [self.list removeAllObjects];
        [self.list addObjectsFromArray:resultModel.list];
        if (resultModel.list.count == 0) {
            [self showEmptyTips:@"暂无相关记录哦"];
        }
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopUpRecordItemModel *model = [self.list safeObjectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        TURTopBannerCell *cell = [TURTopBannerCell dequeueReusableCellForTableView:tableView];
        cell.cellData = model.head.month;
        [cell reloadData];
        return cell;
    }else if (indexPath.row == 1){
        TURContentCell *cell = [TURContentCell dequeueReusableCellForTableView:tableView];
        cell.cellData = model.content;
        [cell reloadData];
        return cell;
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopUpRecordItemModel *model = [self.list safeObjectAtIndex:indexPath.section];
    CGFloat height = 14;
    if (indexPath.row == 0) {
        height = [TURTopBannerCell heightForCell:model.head];
    }else{
        height = [TURContentCell heightForCell:model.content];
    }
    return height;
}
@end
