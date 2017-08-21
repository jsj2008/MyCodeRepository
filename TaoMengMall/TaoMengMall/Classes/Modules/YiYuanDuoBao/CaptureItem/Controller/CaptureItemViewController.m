//
//  CIViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CaptureItemViewController.h"

#import "CIItemRequest.h"
#import "CIItemRequest.h"

#import "ShareInfoModel.h"

#import "CIAdvertCell.h"
#import "CINoJoinContentCell.h"
#import "CIJoinContentCell.h"
#import "CIActivityEndContentCell.h"
#import "CIMenuItemCell.h"
#import "CIRecordCell.h"
#import "CIBuyView.h"
#import "CIActivityCompleteCell.h"
#import "CIActivityExpireCell.h"

#import "XMShareView.h"
#import "CIBottomView.h"

typedef enum JoinType{
    JoinTypeNone,
    JoinTypeJoin,
    JoinTypeEnd,
    JoinTypeCompleted,
    JoinTypeExpire
}JoinType;

@interface CaptureItemViewController ()<CIBuyViewDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) JoinType joinType;
@property (nonatomic, strong) NSMutableArray *records;
@property (nonatomic, strong) CIItemResultModel *resultModel;
@property (nonatomic, strong) ShareInfoModel *shareInfo;
@property (nonatomic, assign) int amount;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) CIBuyView *buyView;
@property (nonatomic, strong) CIBottomView *bottomView;
@property (nonatomic, strong) XMShareView *shareView;
@end

@implementation CaptureItemViewController

- (void)viewDidLoad{
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    //self.tableView.height = SCREEN_HEIGHT  - self.buyView.height;
    
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.shareButton];
    
    [self.view addSubview:self.buyView];
    [self.view addSubview:self.bottomView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self initData];
}

#pragma mark - Private Methods

- (void)initData
{
    self.records  = [NSMutableArray array];
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"activityId"] = self.activityId;
    
    // 1-未参与，2-已参与，3-已揭晓，4-已完成，5-已过期
    [CIItemRequest getItemDataWithParams:params success:^(CIItemResultModel *resultModel) {
        self.resultModel = resultModel;
        self.shareInfo = resultModel.share;
        self.shareButton.hidden = !self.shareInfo;
        
        self.buyView.price = resultModel.singlePrice;
        
        self.bottomView.model = resultModel.button;

        [self.records addObjectsFromArray:resultModel.record.list];
        
        self.buyView.hidden = YES;

        //resultModel.type = @"4";
        //resultModel.activity.winners = nil;
        
        if ([resultModel.type isEqualToString:@"1"]) {
            self.joinType = JoinTypeNone;
            self.buyView.hidden = NO;

        }else if([resultModel.type isEqualToString:@"2"]){
            self.joinType = JoinTypeJoin;
            self.buyView.hidden = NO;

        }else if([resultModel.type isEqualToString:@"3"] ){
            self.joinType = JoinTypeEnd;

        }else if ([resultModel.type isEqualToString:@"4"]){
            if (resultModel.activity.winners) {
                self.joinType = JoinTypeEnd;
            }else{
                self.joinType = JoinTypeCompleted;
            }

        }else if ([resultModel.type isEqualToString:@"5"]){
            self.joinType = JoinTypeExpire;

        }
        
        if (resultModel.showBuy) {
            self.buyView.hidden = NO;
            self.bottomView.hidden = YES;
        }
        
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self reloadData];
    }];
}

- (CIBuyView *)buyView{
    if (!_buyView) {
        _buyView = [[CIBuyView alloc] init];
        _buyView.bottom = SCREEN_HEIGHT;
        _buyView.delegate = self;
        _buyView.hidden = YES;
    }
    return _buyView;
}

- (CIBottomView *)bottomView{
    if (!_bottomView) {
        CIBottomView *bottomView = [[CIBottomView alloc] init];
        _bottomView = bottomView;
        _bottomView.hidden = YES;
    }
    return _bottomView;
}

- (UIButton *)backButton{
    if (!_backButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(12, 25, 33, 33)];
        [button setImage:[UIImage imageNamed:@"lucky_back_btn"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
        _backButton = button;
    }
    return _backButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 33, 25, 33, 33)];
        [button setImage:[UIImage imageNamed:@"lucky_share_btn"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        _shareButton = button;
    }
    return _shareButton;
}

- (XMShareView*)shareView
{
    if (!_shareView) {
        _shareView = [[XMShareView alloc]init];
    }
    return _shareView;
}

#pragma mark - 
- (void)handleShareButton
{
    if (!self.shareInfo) {
        [self showNotice:@"分享信息获取失败，请稍后再试"];
        return;
    }
    self.shareView.shareInfo = self.shareInfo;
    [self.shareView show];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return self.records.count + 1;
    }else if (section == 3){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CIAdvertCell *cell = [CIAdvertCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.item;
            [cell reloadData];
            return cell;
        }else if (indexPath.row == 1){
            if (self.joinType == JoinTypeNone) {
                CINoJoinContentCell *cell = [CINoJoinContentCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel;
                [cell reloadData];
                return cell;
            }else if (self.joinType == JoinTypeJoin){
                CIJoinContentCell *cell = [CIJoinContentCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel;
                [cell reloadData];
                return cell;
            }else if (self.joinType == JoinTypeEnd){
                CIActivityEndContentCell *cell = [CIActivityEndContentCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel;
                [cell reloadData];
                return cell;
            }else if (self.joinType == JoinTypeCompleted){
                CIActivityCompleteCell *cell = [CIActivityCompleteCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel;
                [cell reloadData];
                return cell;
            }else if (self.joinType == JoinTypeExpire){
                CIActivityExpireCell *cell = [CIActivityExpireCell dequeueReusableCellForTableView:tableView];
                cell.cellData = self.resultModel;
                [cell reloadData];
                return cell;
            }
            
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            CIMenuItemCell *cell = [CIMenuItemCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":@"图文详情",@"value":@"建议在wifi下查看",@"line":@YES,@"arrow":@YES};
            [cell reloadData];
            return cell;
        }else if (indexPath.row == 1){
            CIMenuItemCell *cell = [CIMenuItemCell dequeueReusableCellForTableView:tableView];
            cell.cellData = @{@"title":@"往期揭晓",@"line":@YES,@"arrow":@YES};
            [cell reloadData];
            return cell;
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            CIMenuItemCell *cell = [CIMenuItemCell dequeueReusableCellForTableView:tableView];
            NSString *value;
            if (self.resultModel.record.beginTime) {
                value = [NSString stringWithFormat:@"（%@开始）",self.resultModel.record.beginTime];
            }
            
            cell.cellData = @{@"title":@"所有参与记录",@"line":@YES,@"arrow":@NO,@"value":value?value:@""};
            [cell reloadData];
            return cell;
        }else{
            CIRecordCell *cell = [CIRecordCell dequeueReusableCellForTableView:tableView];
            cell.cellData = [self.records safeObjectAtIndex:indexPath.row - 1];
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
            height = [CIAdvertCell heightForCell:self.resultModel.item];
        }else if (indexPath.row == 1){
            if (self.joinType == JoinTypeNone) {
                 height = [CINoJoinContentCell heightForCell:self.resultModel];
            }else if (self.joinType == JoinTypeJoin){
                 height = [CIJoinContentCell heightForCell:self.resultModel];
            }else if (self.joinType == JoinTypeEnd){
                 height = [CIActivityEndContentCell heightForCell:self.resultModel];
            }else if (self.joinType == JoinTypeCompleted){
                height = [CIActivityCompleteCell heightForCell:self.resultModel];
            }else if (self.joinType == JoinTypeExpire){
                height = [CIActivityExpireCell heightForCell:self.resultModel];
            }
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            height = [CIMenuItemCell heightForCell:self.resultModel.prizeDetailLink];

        }else if (indexPath.row == 1) {
            height = [CIMenuItemCell heightForCell:self.resultModel.activity.previousWinnersLink];

        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            height = [CIMenuItemCell heightForCell:self.resultModel];
        }else{
            height = [CIRecordCell heightForCell:[self.records safeObjectAtIndex:indexPath.row - 1]];
        }
    }else{
        height = 50;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 1) {
        if (row == 0) {
            [[TTNavigationService sharedService] openUrl:self.resultModel.prizeDetailLink];

        }else if (row == 1){
            [[TTNavigationService sharedService] openUrl:self.resultModel.activity.previousWinnersLink];
        }
    }
}

#pragma mark - CIBuyViewDelegate
- (void)handleBuyButtonWithAmount:(int)amount{
    
    self.amount = amount;
    NSString *tip = [NSString stringWithFormat:@"您确定要购买%d人次吗，总共%g元",amount,amount * self.resultModel.singlePrice];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"amount"] = [NSString stringWithFormat:@"%d",self.amount];
        params[@"activityId"] = self.activityId;
        [CIItemRequest buyItemWithParams:params success:^(NSDictionary *result) {
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
