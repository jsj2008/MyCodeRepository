//
//  LCRecordsViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LotteryRecordsViewController.h"
#import "LRRecordCell.h"
#import "LRStatusCell.h"
#import "LotteryRecordRequest.h"
#import "LRBuyView.h"

@interface LotteryRecordsViewController ()<LRStatusCellDelegate,LRBuyViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) LRBuyView *buyView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, assign) int amount;
@property (nonatomic, strong) LotteryRecordsItemModel *recordModel;
@end

@implementation LotteryRecordsViewController

- (void)viewDidLoad {
    self.hideNavigationBar = YES;
    [super viewDidLoad];

    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    self.tableView.backgroundColor = Color_Gray245;
    self.tableView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT - TabsViewHeight;
    
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
    [params setSafeObject:self.status forKey:@"type"];
    if (self.loadingType == kLoadMore) {
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [LotteryRecordRequest getRecordsDataWithParams:params success:^(LotteryRecordsResultModel *resultModel) {
            
            if (resultModel) {
                self.wp = resultModel.wp;
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                [self.list addObjectsFromSafeArray:resultModel.list];
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
        [LotteryRecordRequest getRecordsDataWithParams:params success:^(LotteryRecordsResultModel *resultModel) {
            
            [self.list removeAllObjects];
            [self hideEmptyTips];
            
            if (resultModel) {
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.wp = resultModel.wp;
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
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



- (LRBuyView *)buyView{
    if (!_buyView) {
        _buyView = [[LRBuyView alloc] init];
        _buyView.bottom = SCREEN_HEIGHT;
        _buyView.type = ItemBuyViewTypeProcess;
        _buyView.delegate = self;
    }
    return _buyView;
}

- (UIView *)coverView{
    if (!_coverView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.backgroundColor = Color_Black;
        view.alpha = 0.3;
        _coverView = view;
    }
    return _coverView;
}
#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LRRecordCell *cell = [LRRecordCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:indexPath.section];
        [cell reloadData];
        return cell;
    }else if (indexPath.row == 1){
        LRStatusCell *cell = [LRStatusCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:indexPath.section];
        cell.delegate = self;
        [cell reloadData];
        return cell;
    }
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    LotteryRecordsItemModel *model = [self.list safeObjectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        height = [LRRecordCell heightForCell:[self.list safeObjectAtIndex:indexPath.section]];
    }else if (indexPath.row == 1){
        height = [LRStatusCell heightForCell: (model.buttons&&model.buttons.count>0) || model.refund||model.winner? [self.list safeObjectAtIndex:indexPath.section]:nil];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LotteryRecordsItemModel *model = [self.list safeObjectAtIndex:indexPath.section];
        [[TTNavigationService sharedService] openUrl:model.link];
    }
}
#pragma mark - LRStatusCellDelegate
- (void)handleBuyButttonWithModel:(id)model{
    self.recordModel = model;
    LotteryRecordsItemModel *record = model;
    [self.buyView removeFromSuperview];
    self.buyView.type = ItemBuyViewTypeProcess;
    self.buyView.bottom = self.view.height;
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.buyView];
    self.buyView.price = [record.singlePrice intValue];
}
#pragma mark - LRBuyViewDelegate

- (void)handleBuyButtonWithAmount:(int)amount{
    self.amount = amount;
    NSString *tip = [NSString stringWithFormat:@"您确定要购买%d人次吗，总共%g元",amount,amount * [self.recordModel.singlePrice floatValue]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];

}
- (void)hanleCloseButton{
    [self.coverView removeFromSuperview];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"amount"] = [NSString stringWithFormat:@"%d",self.amount];
        params[@"activityId"] = self.recordModel.activityId;
        [LotteryRecordRequest buyItemWithParams:params success:^(NSDictionary *result) {
            [self loadData];
            [self showNotice:@"购买成功"];
            if(result[@"link"]){
                [[TTNavigationService sharedService] openUrl:result[@"link"]];
            }
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
    }
}
@end
