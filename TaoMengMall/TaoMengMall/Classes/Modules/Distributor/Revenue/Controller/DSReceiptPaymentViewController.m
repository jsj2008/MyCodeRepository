//
//  DSReceiptPaymentDetailViewController.m
//  CarKeeper
//
//  Created by marco on 3/3/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSReceiptPaymentViewController.h"
#import "RevenueRequest.h"
#import "DSReceiptPaymentListCell.h"

@interface DSReceiptPaymentViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation DSReceiptPaymentViewController

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
        [RevenueRequest getReceiptPaymentDataWithParams:params success:^(DSReceiptPaymentResultModel *resultModel) {
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
        [RevenueRequest getReceiptPaymentDataWithParams:params success:^(DSReceiptPaymentResultModel *resultModel) {
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
                [self showEmptyTips:@"当前没有相关明细哦"];
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
        DSReceiptPaymentListCell *cell = [DSReceiptPaymentListCell dequeueReusableCellForTableView:tableView];
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
        height = [DSReceiptPaymentListCell heightForCell:[self.list safeObjectAtIndex:row]];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        DSReceiptPaymentModel *model = [self.list safeObjectAtIndex:row];
        [[TTNavigationService sharedService] openUrl:model.link];
    }
}
@end
