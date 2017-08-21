//
//  PayResultViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIPayResultViewController.h"
#import "CIBackgroundCell.h"
#import "CITopBannerCell.h"
#import "CIOrderCell.h"
#import "CIItemRequest.h"

@interface CIPayResultViewController ()<CIBackgroundCellDelegate>
@property (nonatomic, strong) CIPayResultModel *resultModel;

@end

@implementation CIPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"支付结果";
    
    [self initData];
}

- (void)initData{
    [self loadData];
}

- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"participantId"] = self.participantId;
    [CIItemRequest getPayResultDataWithParams:params success:^(CIPayResultModel *resultModel) {
        self.resultModel = resultModel;
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self reloadData];
    }];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CIBackgroundCell *cell = [CIBackgroundCell dequeueReusableCellForTableView:tableView];
            cell.delegate = self;
            cell.cellData = self.resultModel;
            [cell reloadData];
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            CITopBannerCell *cell = [CITopBannerCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel;
            [cell reloadData];
            return cell;
        }
    }else if (indexPath.section == 2){
        CIOrderCell *cell = [CIOrderCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.resultModel;
        [cell reloadData];
        return cell;
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 14;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = [CIBackgroundCell heightForCell:self.resultModel];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            height = [CITopBannerCell heightForCell:self.resultModel];
        }
    }else if (indexPath.section == 2){
       height = [CIOrderCell heightForCell:self.resultModel];
    }
    return height;
}

#pragma mark - CPBackgroundCellDelegate

- (void)handleContinueButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleRecordButton{
    [[TTNavigationService sharedService] openUrl:@"xiaoma://lotteryRecords"];
}

@end
