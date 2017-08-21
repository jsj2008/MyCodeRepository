//
//  DSWithdrawHistoryViewController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSWithdrawHistoryViewController.h"
#import "WithdrawRequest.h"
#import "DSWithdrawHistoryCell.h"

@interface DSWithdrawHistoryViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation DSWithdrawHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"提现记录";
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
    if (self.loadingType == kLoadMore) {
        [params setSafeObject:self.wp forKey:@"wp"];
        [WithdrawRequest getWithdrawHistoryWithParams:params success:^(DSWithdrawHistoryResultModel *resultModel) {
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
    }else {
        [WithdrawRequest getWithdrawHistoryWithParams:params success:^(DSWithdrawHistoryResultModel *resultModel) {
            [self.list removeAllObjects];
            [self hideEmptyTips];
            if (resultModel) {
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            if (resultModel.list.count == 0) {
                [self showEmptyTips:@"当前没有相关记录哦"];
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
        DSWithdrawHistoryCell *cell = [DSWithdrawHistoryCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:row];
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
        height = [DSWithdrawHistoryCell heightForCell:[self.list safeObjectAtIndex:row]];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        DSWithdrawHistoryModel *model = [self.list safeObjectAtIndex:row];
        [[TTNavigationService sharedService] openUrl:model.link];
    }
}
@end
