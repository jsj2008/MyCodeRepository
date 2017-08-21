//
//  RFProgressViewController.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RFHistoryViewController.h"

#import "RFStepCell.h"
#import "RFLastStatusCell.h"
#import "RFStatusHeadCell.h"
#import "RFStatusCell.h"

#import "RefundInfoModel.h"

#import "RefundRequest.h"

@interface RFHistoryViewController ()<RFLastStatusCell>
@property (nonatomic, strong) NSArray *refundInfos;
@property (nonatomic, strong) NSString *expireTime;
@property (nonatomic, strong) NSString *status;

//@property (nonatomic, strong) RFProofBarView *bottomBarView;
@end

@implementation RFHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray242;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    self.tableView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT; //- 80;

    self.title = @"退款";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];

}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    //self.orderId = @"909";
    [params setSafeObject:self.orderId forKey:@"orderId"];
    
    [RefundRequest getRefundHistoryWithParams:params success:^(RFHistoryResultModel *resultModel) {
        
        if (resultModel && resultModel.refundInfos) {

            self.refundInfos = [[NSArray<RefundInfoModel> alloc] initWithArray:resultModel.refundInfos];
            self.expireTime = resultModel.expireTime;
            self.status = resultModel.status;
            RefundInfoModel *lastRefund = [self.refundInfos firstObject];
            self.title = lastRefund.title;
            [self reloadData];
            
            //[self initBottomBarView];
        }
        
        if (!resultModel || !resultModel.refundInfos || resultModel.refundInfos.count <= 0) {
            NSString *noticeStr = @"没有待退款的商品哦";
            [self showEmptyTips:noticeStr ownerView:self.tableView];
        }
        
    } failure:^(StatusModel *status) {
        
        DBG(@"%@", status);
        [self showNotice:status.msg];
        [self reloadData];;
        
    }];
    
}

//- (void) initBottomBarView {
//    
//    self.bottomBarView = [[RFProofBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, TOTAL_BAR_VIEW_HEIGHT)];
//    self.bottomBarView.bottom = self.view.height;
//    self.bottomBarView.delegate = self;
//    [self.view addSubview:self.bottomBarView];
//}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 0;
    
    if ( self.refundInfos ) {
        numberOfSections = 3 + self.refundInfos.count + 1;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( self.refundInfos ) {
        
        if (section == 0) {
            
            return 1;
        }else if (section == 1) {
            
            return 2;
            
        }else if (section == 2) {
            return 1;
        }else if( [self.refundInfos safeObjectAtIndex:section-3] ) {
            
            return 1;
            
        } else {
            
            return 1;
            
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if ( self.refundInfos ) {
        
        if (section == 0) {
            
//            RFStepCell *cell = [RFStepCell dequeueReusableCellForTableView:tableView];
//            cell.cellData = self.status;
//            [cell reloadData];
//            return cell;
            
        }else if (section == 1) {
            
            if (row == 0) {
                
                RefundInfoModel *refundInfo = (RefundInfoModel *)[self.refundInfos safeObjectAtIndex:section-1];
                RFLastStatusCell *cell = [RFLastStatusCell dequeueReusableCellForTableView:tableView];
                cell.status = self.status;
                cell.expireTime = self.expireTime;
                cell.cellData = refundInfo;
                cell.delegate = self;
                [cell reloadData];
                return cell;
            }

        }else if (section == 2) {
            RFStatusHeadCell *cell = [RFStatusHeadCell dequeueReusableCellForTableView:tableView];
            return cell;
            
        }else if( [self.refundInfos safeObjectAtIndex:section-3] ) {
            
            if (row == 0) {
                RefundInfoModel *refundInfo = (RefundInfoModel *)[self.refundInfos safeObjectAtIndex:section-3];
                RFStatusCell *cell = [RFStatusCell dequeueReusableCellForTableView:tableView];
                cell.cellData = refundInfo;
                [cell reloadData];
                return cell;
            }
            
        }
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
    
    if ( self.refundInfos ) {
        
        if (section == 0) {
            
            height = 14;//[RFStepCell heightForCell:self.status];
            
        }else if (section == 1) {
            if (row == 0) {
                RefundInfoModel *refundInfo = (RefundInfoModel *)[self.refundInfos safeObjectAtIndex:0];
                height = [RFLastStatusCell heightForCell:refundInfo];
            }else{
                height = 14;
            }
        }else if (section == 2) {
            
            height = [RFStatusHeadCell heightForCell:self.refundInfos.count>1?@"":nil];
            
        }else if( [self.refundInfos safeObjectAtIndex:section-3] ) {
            if (row == 0) {
                RefundInfoModel *refundInfo = (RefundInfoModel *)[self.refundInfos safeObjectAtIndex:section-3];
                height = [RFStatusCell heightForCell:refundInfo];
            }else{
                height = 14;
            }
        }else{
            height = TOTAL_BAR_VIEW_HEIGHT;
        }
    }
    return height;
}


#pragma mark - RFLastStatusCell Delegate
- (void)cancelButtonTapped
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.orderId forKey:@"orderId"];
    weakify(self);
    [RefundRequest cancelRefundWithParams:params success:^(RFHistoryResultModel *resultModel) {
        strongify(self);
        [self showNoticeOnWindow:@"退款申请已取消" duration:1.f];
        [self clickback];
    } failure:^(StatusModel *status) {
        strongify(self);
        [self showNotice:@"退款申请取消失败"];
    }];
}

- (void)applyButtonTapped
{
    NSString *link = [NSString stringWithFormat:@"xiaoma://mallRefundApply?orderId=%@",self.orderId];
    [[TTNavigationService sharedService] openUrl:link];
}

- (void)recordButtonTapped
{
    NSString *link = [NSString stringWithFormat:@"xiaoma://mallRefundDetail?orderId=%@",self.orderId];
    [[TTNavigationService sharedService] openUrl:link];
}
@end
