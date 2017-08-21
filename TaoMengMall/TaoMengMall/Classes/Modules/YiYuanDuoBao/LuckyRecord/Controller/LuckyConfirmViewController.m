
//
//  LotteryConfirmViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckyConfirmViewController.h"
#import "LCBackGroundCell.h"
#import "LCTopBannerCell.h"
#import "LCItemCell.h"
#import "LCAdressCell.h"
#import "LCSingleButtonCell.h"
#import "LuckyRecordRequest.h"

@interface LuckyConfirmViewController ()
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) LuckyConfirmResultModel *resultModel;
@end

@implementation LuckyConfirmViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.width = SCREEN_WIDTH;
    self.confirmButton.height = 45;
    self.confirmButton.backgroundColor = RGB(249, 218, 109);
    self.confirmButton.bottom = SCREEN_HEIGHT;
    [self.confirmButton setTitleColor:Color_Black forState:UIControlStateNormal];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(handleConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"中奖确认";
    [self initData];
}

- (void)initData{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"activityId"] = self.activityId;
    [LuckyRecordRequest getConfirmInfoDataWithParams:parmas success:^(LuckyConfirmResultModel *resultModel) {
        self.resultModel = resultModel;
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
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
        return 3;
    }else if (section == 2){
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LCBackGroundCell *cell = [LCBackGroundCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel;
            [cell reloadData];
            return cell;
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            LCTopBannerCell *cell = [LCTopBannerCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @"商品信息";
            [cell reloadData];
            return cell;
        }else if (indexPath.row == 1){
            LCItemCell *cell = [LCItemCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel;
            [cell reloadData];
            return cell;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            LCTopBannerCell *cell = [LCTopBannerCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @"收货地址";
            [cell reloadData];
            return cell;
        }else if (indexPath.row == 1){
            LCAdressCell *cell = [LCAdressCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.consignee;
            [cell reloadData];
            return cell;
        }else if (indexPath.row == 2){
            LCSingleButtonCell *cell = [LCSingleButtonCell dequeueReusableCellForTableView:tableView];
            cell.type = LCSingleButtonCellStyleAlter;
            cell.cellData = self.resultModel.consignee;
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
            height = [LCBackGroundCell heightForCell:self.resultModel];
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            height = [LCTopBannerCell heightForCell:self.resultModel];
        }else if (indexPath.row == 1){
            height = [LCItemCell heightForCell:self.resultModel];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            height = [LCTopBannerCell heightForCell:self.resultModel];
        }else if (indexPath.row == 1){
            height = [LCAdressCell heightForCell:self.resultModel.consignee];
        }else if (indexPath.row == 2){
            height = [LCSingleButtonCell heightForCell:self.resultModel.consignee];
        }
    }
    return height;

}

#pragma mark - methods

- (void)handleConfirmButton{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"consigneeId"] = self.resultModel.consignee.consigneeId;
    params[@"prizeId"] = self.resultModel.activity.prizeId;
     [LuckyRecordRequest confirmWithParams:params success:^{
         [self.navigationController popViewControllerAnimated:YES];
     } failure:^(StatusModel *status) {
         [self showNotice:status.msg];
     }];
}

@end

