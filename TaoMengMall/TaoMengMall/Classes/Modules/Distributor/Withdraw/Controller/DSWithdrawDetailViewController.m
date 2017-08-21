//
//  DSWithdrawDetailViewController.m
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSWithdrawDetailViewController.h"
#import "WithdrawRequest.h"
#import "DSWithdrawDetailResultModel.h"

@interface DSWithdrawDetailViewController ()
@property (nonatomic, strong) DSWithdrawDetailResultModel *resultModel;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UILabel *sumValueLabel;
@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UILabel *methodLabel;
@property (nonatomic, strong) UILabel *methodValueLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nameValueLabel;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *statusValueLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *timeValueLabel;
@end

@implementation DSWithdrawDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.title = @"提现详情";
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.id forKey:@"id"];
    [WithdrawRequest getWithdrawDetailWithParams:params success:^(DSWithdrawDetailResultModel *resultModel) {
        self.resultModel = resultModel;
        [self render];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

- (void)render
{
    [self.view addSubview:self.backgroundView];
    
    [self.backgroundView addSubview:self.sumLabel];
    [self.backgroundView addSubview:self.sumValueLabel];
    [self.backgroundView addSubview:self.line1];
    
    [self.backgroundView addSubview:self.methodLabel];
    [self.backgroundView addSubview:self.methodValueLabel];
    [self.backgroundView addSubview:self.nameLabel];
    [self.backgroundView addSubview:self.nameValueLabel];
    [self.backgroundView addSubview:self.line2];
    
    [self.backgroundView addSubview:self.statusLabel];
    [self.backgroundView addSubview:self.statusValueLabel];
    [self.backgroundView addSubview:self.timeLabel];
    [self.backgroundView addSubview:self.timeValueLabel];
    
    DSWithdrawDetailResultModel *model = self.resultModel;
    self.sumValueLabel.text = model.amount;
    [self.sumValueLabel sizeToFit];
    self.sumValueLabel.right = SCREEN_WIDTH - 12;
    self.sumValueLabel.centerY = 25;
    
    self.methodValueLabel.text = model.method;
    [self.methodValueLabel sizeToFit];
    self.methodValueLabel.right = SCREEN_WIDTH - 12;
    self.methodValueLabel.centerY = self.methodLabel.centerY;
    
    self.nameValueLabel.text = model.account;
    [self.nameValueLabel sizeToFit];
    self.nameValueLabel.right = SCREEN_WIDTH - 12;
    self.nameValueLabel.centerY = self.nameLabel.centerY;
    
    self.statusValueLabel.text = model.status;
    [self.statusValueLabel sizeToFit];
    self.statusValueLabel.right = SCREEN_WIDTH - 12;
    self.statusValueLabel.centerY = self.statusLabel.centerY;
    
    self.timeValueLabel.text = model.time;
    [self.timeValueLabel sizeToFit];
    self.timeValueLabel.right = SCREEN_WIDTH - 12;
    self.timeValueLabel.centerY = self.timeLabel.centerY;
}

#pragma mark -SubViews
- (UIView*)backgroundView
{
    if (!_backgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 14, SCREEN_WIDTH, 150)];
        view.backgroundColor = Color_White;
        _backgroundView = view;
    }
    return _backgroundView;
}

- (UILabel*)sumLabel
{
    if (!_sumLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.text = @"提现金额";
        [label sizeToFit];
        label.centerY = 22.5;
        _sumLabel = label;
    }
    return _sumLabel;
}

- (UILabel*)sumValueLabel
{
    if (!_sumValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        _sumValueLabel = label;
    }
    return _sumValueLabel;
}

- (UIView*)line1
{
    if (!_line1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 50;
        _line1 = view;
    }
    return _line1;
}

- (UILabel*)methodLabel
{
    if (!_methodLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.text = @"提现方式";
        [label sizeToFit];
        label.centerY = 50 + 15;
        _methodLabel = label;
    }
    return _methodLabel;
}

- (UILabel*)methodValueLabel
{
    if (!_methodValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _methodValueLabel = label;
    }
    return _methodValueLabel;
}

- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.text = @"提现金额";
        [label sizeToFit];
        label.centerY = 50 + 35;
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel*)nameValueLabel
{
    if (!_nameValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _nameValueLabel = label;
    }
    return _nameValueLabel;
}

- (UIView*)line2
{
    if (!_line2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 100;
        _line2 = view;
    }
    return _line2;
}

- (UILabel*)statusLabel
{
    if (!_statusLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.text = @"当前状态";
        [label sizeToFit];
        label.centerY = 100+15;
        _statusLabel = label;
    }
    return _statusLabel;
}

- (UILabel*)statusValueLabel
{
    if (!_statusValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _statusValueLabel = label;
    }
    return _statusValueLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        label.text = @"申请时间";
        [label sizeToFit];
        label.centerY = 100 + 35;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel*)timeValueLabel
{
    if (!_timeValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _timeValueLabel = label;
    }
    return _timeValueLabel;
}
@end
