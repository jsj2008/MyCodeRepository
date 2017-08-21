//
//  DSWithdrawViewController.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSWithdrawViewController.h"
#import "DSAccountListViewController.h"
#import "DSAccountEditViewController.h"
#import "WithdrawRequest.h"
#import "DistributorHeader.h"


@interface DSWithdrawViewController ()

@property (nonatomic, strong) DSWithdrawHomeResultModel *resultModel;
@property (nonatomic, strong) DSWithdrawAccountModel *account;

@property (nonatomic, strong) UIView *amountBackgroundView;
@property (nonatomic, strong) UILabel *availableLabel;
@property (nonatomic, strong) UILabel *availableValueLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *withdrawLabel;
@property (nonatomic, strong) UITextField *withdrawTextField;

@property (nonatomic, strong) UIView *accountBackgroundView;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *moreImageView;

@property (nonatomic, strong) UIButton *withdrawButton;
@end

@implementation DSWithdrawViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.title = @"提现";
    //[self initData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectAccount:) name:DistributorDidSelectWithdrawAccount object:nil];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [WithdrawRequest getWithdrawHomeDataWithParams:params success:^(DSWithdrawHomeResultModel *resultModel) {
        self.resultModel = resultModel;
        [self render];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}

- (void)render
{
    [self.view addSubview:self.amountBackgroundView];
    [self.amountBackgroundView addSubview:self.availableLabel];
    [self.amountBackgroundView addSubview:self.availableValueLabel];
    [self.amountBackgroundView addSubview:self.line];
    [self.amountBackgroundView addSubview:self.withdrawLabel];
    [self.amountBackgroundView addSubview:self.withdrawTextField];
    
    [self.view addSubview:self.accountBackgroundView];
    [self.accountBackgroundView addSubview:self.accountLabel];
    [self.accountBackgroundView addSubview:self.descLabel];
    [self.accountBackgroundView addSubview:self.moreImageView];
    
    [self.view addSubview:self.withdrawButton];
    
    self.availableValueLabel.text = self.resultModel.balance;
    [self.availableValueLabel sizeToFit];
    self.availableValueLabel.centerY = self.availableLabel.centerY;
    weakify(self);
    if (self.resultModel.accounts.count == 0) {
        self.descLabel.text = @"请创建提现账户";
        [self showNotice:@"当前没可创建账户"];
//        [self.accountBackgroundView bk_whenTapped:^{
//            strongify(self);
//            DSAccountEditViewController *vc = [[DSAccountEditViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }];
    }else if (self.resultModel.accounts.count == 1){
        DSWithdrawAccountModel *model = [self.resultModel.accounts safeObjectAtIndex:0];
        if (IsEmptyString(model.account)) {
            self.descLabel.text = @"请创建提现账户";
        }else{
            self.account = model;
            self.descLabel.text = model.name;
        }
        [self.accountBackgroundView bk_whenTapped:^{
            strongify(self);
            DSAccountEditViewController *vc = [[DSAccountEditViewController alloc]init];
            vc.account = model;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        if (self.account) {
            self.descLabel.text = self.account.name;
        }else{
            self.descLabel.text = @"请选择提现账户";
        }
        [self.accountBackgroundView bk_whenTapped:^{
            strongify(self);
            DSAccountListViewController *vc = [[DSAccountListViewController alloc]init];
            vc.accounts = self.resultModel.accounts;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    
    [self.descLabel sizeToFit];
    self.descLabel.right = self.moreImageView.left - 4;
    self.descLabel.centerY = 22.5;
}

- (void)didSelectAccount:(NSNotification*)noti
{
    DSWithdrawAccountModel *model = noti.object;
    self.account = model;
    [self render];
}

- (UIView*)amountBackgroundView
{
    if (!_amountBackgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 14, SCREEN_WIDTH, 90)];
        view.backgroundColor = Color_White;
        _amountBackgroundView = view;
    }
    return _amountBackgroundView;
}

- (UILabel*)availableLabel
{
    if (!_availableLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.text = @"可提现金额";
        [label sizeToFit];
        label.centerY = 22.5;
        _availableLabel = label;
    }
    return _availableLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.centerY = 45;
        _line = view;
    }
    return _line;
}

- (UILabel*)availableValueLabel
{
    if (!_availableValueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 0, 0)];
        label.font = FONT(16);
        _availableValueLabel = label;
    }
    return _availableValueLabel;
}

- (UILabel*)withdrawLabel
{
    if (!_withdrawLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.text = @"本次提现";
        [label sizeToFit];
        label.centerY = 45 + 22.5;
        _withdrawLabel = label;
    }
    return _withdrawLabel;
}

- (UITextField*)withdrawTextField
{
    if (!_withdrawTextField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(120, 45 + 6., SCREEN_WIDTH-120-12, 33)];
        textField.font = FONT(16);
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.placeholder = @"单笔最高2万";
        _withdrawTextField = textField;
    }
    return _withdrawTextField;
}

- (UIView*)accountBackgroundView
{
    if (!_accountBackgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+14+90+14, SCREEN_WIDTH, 45)];
        view.backgroundColor = Color_White;
        view.userInteractionEnabled = YES;

        _accountBackgroundView = view;
    }
    return _accountBackgroundView;
}

- (UILabel*)accountLabel
{
    if (!_accountLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.text = @"提现账户";
        [label sizeToFit];
        label.centerY = 22.5;
        _accountLabel = label;
    }
    return _accountLabel;
}

- (UILabel*)descLabel
{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"选择提现账户";
        [label sizeToFit];
        label.centerY = 22.5;
        label.right = self.moreImageView.left - 4;
        _descLabel = label;
    }
    return _descLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.right = SCREEN_WIDTH -12;
        _moreImageView.centerY = 22.5;
    }
    
    return _moreImageView;
}

- (UIButton*)withdrawButton
{
    if (!_withdrawButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, self.accountBackgroundView.bottom+60, SCREEN_WIDTH-40, 44)];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        button.backgroundColor = Theme_Color;
        button.layer.cornerRadius = 4.;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(handleWithdrawButton) forControlEvents:UIControlEventTouchUpInside];
        _withdrawButton = button;
    }
    return _withdrawButton;
}

- (void)handleWithdrawButton
{
    if ([self.withdrawTextField.text floatValue] == 0.) {
        [self showNotice:@"请输入提现金额"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:[self.withdrawTextField.text trim] forKey:@"amount"];
    [params setSafeObject:self.account.method forKey:@"method"];
    [WithdrawRequest applyWithdrawWithParams:params success:^{
        [self showNotice:@"提现成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clickback];
        });
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}
@end
