//
//  DSHomeViewController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSHomeViewController.h"
#import "DistributorRequest.h"
#import "DSHomeTotalCell.h"
#import "DSHomeManageCell.h"
#import "DSHomePromoteCell.h"
#import "DistributorHeader.h"

@interface DSHomeViewController ()
@property (nonatomic, strong) DSHomeResultModel *resultModel;

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIButton *applyButton;
@end

@implementation DSHomeViewController

- (void)dealloc
{
    NSLog(@"-----%@ dealloc----",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0, 0, 50, 32);
//    rightButton.titleLabel.font = FONT(18);
//    [rightButton setTitle:@"统计" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(handleRightButton) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationBar.rightBarButton = rightButton;
//    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"代理商";
    //[self initData];
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [DistributorRequest getHomeDataWithParams:params success:^(DSHomeResultModel *resultModel) {
        self.resultModel = resultModel;
        [self hideEmptyTips];
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        self.resultModel = nil;
        //8010未申请,8011审核中
        if (status.code == 8010) {
            [self showEmptyTipsType:0];
        }else if (status.code == 8011) {
            [self showEmptyTipsType:1];
        }else{
            [self hideEmptyTips];
            [self showNotice:status.msg];
        }
        [self finishRefresh];
        [self reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (row == 0) {
            DSHomeTotalCell *cell = [DSHomeTotalCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel;
            [cell reloadData];
            return cell;
        }
    }else if (section == 1) {
        if (row == 0) {
            DSHomeManageCell *cell = [DSHomeManageCell dequeueReusableCellForTableView:tableView];
            [cell reloadData];
            return cell;
        }
    }else if (section == 2) {
        if (row == 0) {
            DSHomePromoteCell *cell = [DSHomePromoteCell dequeueReusableCellForTableView:tableView];
            [cell reloadData];
            return cell;
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
    if (section == 0) {
        if (row == 0) {
            height = [DSHomeTotalCell heightForCell:self.resultModel];
        }else if (row == 1) {
            height = 14;
        }
    }else if (section == 1) {
        if (row == 0) {
            height = [DSHomeManageCell heightForCell:self.resultModel];
        }else if (row == 1) {
            height = 14;
        }
    }else if (section == 2) {
        if (row == 0) {
            height = [DSHomePromoteCell heightForCell:self.resultModel];
        }else if (row == 1) {
            height = 60;
        }
    }
    return height;
}

#pragma mark - Subviews
#pragma mark - Empty Subviews
- (void)showEmptyTipsType:(NSInteger)type
{
    if (type == 0) {
        self.title = @"申请为分销商";
        self.logoImageView.image = [UIImage imageNamed:@"icon_distributor_apply"];
        
        self.titleLabel.text = @"你还不是分销商，完善身份信息";
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = SCREEN_WIDTH/2;
        
        self.tipsLabel.text = @"请填写真实信息";
        [self.tipsLabel sizeToFit];
        self.tipsLabel.centerX = SCREEN_WIDTH/2;
        
        self.applyButton.hidden = NO;
    }else if (type == 1) {
        self.title = @"审核中";
        self.logoImageView.image = [UIImage imageNamed:@"icon_distributor_auditing"];

        self.titleLabel.text = @"您的资料正在审核中…";
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = SCREEN_WIDTH/2;
        
        self.tipsLabel.text = @"请耐心等待，预计1-7个工作日";
        [self.tipsLabel sizeToFit];
        self.tipsLabel.centerX = SCREEN_WIDTH/2;
        
        self.applyButton.hidden = YES;
    }
    [self.view insertSubview:self.titleLabel aboveSubview:self.tableView];
    [self.view insertSubview:self.tipsLabel aboveSubview:self.tableView];
    [self.view insertSubview:self.logoImageView aboveSubview:self.tableView];
    [self.view insertSubview:self.applyButton aboveSubview:self.tableView];
}

- (void)hideEmptyTips
{
    self.view.backgroundColor = Color_Gray245;
    [self.titleLabel removeFromSuperview];
    [self.logoImageView removeFromSuperview];
    [self.tipsLabel removeFromSuperview];
    [self.applyButton removeFromSuperview];
}

- (UIImageView*)logoImageView
{
    if (!_logoImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
        imageView.centerX = SCREEN_WIDTH/2;
        imageView.centerY = SCREEN_HEIGHT*2/5;
        _logoImageView = imageView;
    }
    return _logoImageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = BOLD_FONT(17);
        label.top = self.logoImageView.bottom + 60;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel*)tipsLabel
{
    if (!_tipsLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(15);
        label.textColor = Color_Gray100;
        label.top = self.logoImageView.bottom + 100;
        _tipsLabel = label;
    }
    return _tipsLabel;
}

- (UIButton*)applyButton
{
    if (!_applyButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 44)];
        [button setTitle:@"申请为分销商" forState:UIControlStateNormal];
        button.backgroundColor = Theme_Color;
        button.layer.cornerRadius = 4.;
        button.layer.masksToBounds = YES;
        button.top = self.logoImageView.bottom + (IS_IPHONE4?140:180);
        button.centerX = SCREEN_WIDTH/2;
        [button addTarget:self action:@selector(handleApplyButton) forControlEvents:UIControlEventTouchUpInside];
        _applyButton = button;
    }
    return _applyButton;
}

#pragma mark - Button actions
-(void)handleApplyButton
{
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"distributorApply")];
}
@end
