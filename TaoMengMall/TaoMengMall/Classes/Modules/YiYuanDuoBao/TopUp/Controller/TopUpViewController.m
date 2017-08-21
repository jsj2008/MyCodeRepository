//
//  TopUpViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "TopUpViewController.h"
#import "TopUpRequest.h"
#import "TURecordViewController.h"

@interface TopUpViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) NSString *amount;

@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 90, 32);
    rightButton.titleLabel.font = FONT(18);
    [rightButton setTitle:@"充值记录" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(handleRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButton = rightButton;
    
    self.title = @"充值";
    [self loadData];
}

- (void)loadData
{
    [TopUpRequest getTopUpDataWithParams:nil success:^(TopUpResultModel *resultModel) {
        self.lists = resultModel.options;
        [self render];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
    
}

- (void)render
{
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.line];
    for(int index = 0; index < self.buttons.count; index ++){
        UIView *view = self.buttons[index];
        [self.bgView addSubview:view];
    }
    [self.bgView addSubview:self.payButton];
    UIView *lastView = [self.buttons lastObject];
    self.payButton.top = lastView.bottom + 30;
    self.bgView.height = self.payButton.bottom + 35;
}

#pragma mark - tableView
- (UIView *)bgView
{
	if (!_bgView) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 14, SCREEN_WIDTH, 262)];
		view.backgroundColor = Color_White;
		_bgView = view;
	}
	return _bgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(14);
        label.text = @"请选择充值金额" ;
        [label sizeToFit];
        label.left = 12;
        label.centerY = 25;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)line
{
	if (!_line) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 50, SCREEN_WIDTH - 16, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
		_line = view;
	}
	return _line;
}

- (UIButton *)payButton
{
	if (!_payButton) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 256, 40)];
		button.layer.cornerRadius = 4;
		button.layer.masksToBounds = YES;
		button.backgroundColor = Theme_Color;
		[button setTitleColor:Color_White forState:UIControlStateNormal];
		button.titleLabel.font = FONT(16);
		[button setTitle:@"确认充值" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(handlePayButton:) forControlEvents:UIControlEventTouchUpInside];
        button.bottom = self.bgView.height - 35;
        button.centerX = SCREEN_WIDTH / 2.0f;
		_payButton = button;
	}
	return _payButton;
}

- (NSMutableArray *)buttons
{
	if (!_buttons) {
		NSMutableArray *buttons = [[NSMutableArray alloc] init];
        if (_lists) {
            CGFloat margin = 30;
            CGFloat rowMargin = 16;
            CGFloat columnMargin = 20;
            CGFloat width = (SCREEN_WIDTH - margin * 2 - rowMargin * 2) / 3.0f;
            CGFloat height = 30;
            for (int index = 0; index <= _lists.count; index ++){
                int row = index / 3;
                int column = index % 3;
                if (index == _lists.count) {
                    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, height)];
                    field.left = margin + column * (width + rowMargin);
                    field.top = self.line.bottom + 26 + row * (height + columnMargin);
                    field.layer.cornerRadius = 2;
                    field.layer.borderWidth = 1;
                    field.layer.borderColor = Color_Gray216.CGColor;
                    field.layer.masksToBounds = YES;
                    field.placeholder = @"其他金额";
                    field.textAlignment = NSTextAlignmentCenter;
                    field.font = FONT(14);
                    field.keyboardType = UIKeyboardTypeNumberPad;
                    field.tag = index;
                    field.delegate = self;
                    [field addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                    [buttons addObject:field];
                }else{
                    
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
                    button.left = margin + column * (width + rowMargin);
                    button.top = self.line.bottom + 26 + row * (height + columnMargin);
                    button.layer.cornerRadius = 2;
                    button.layer.borderWidth = 1;
                    button.layer.borderColor = Color_Gray216.CGColor;
                    button.layer.masksToBounds = YES;
                    TopUpItemModel *model = [_lists safeObjectAtIndex:index];
                    [button setTitle:model.amount forState:UIControlStateNormal];
                    [button setTitleColor:Color_Gray42 forState:UIControlStateNormal];
                    button.titleLabel.font = FONT(14);
                    button.tag = index;
                    [buttons addObject:button];
                    [button addTarget:self action:@selector(handleMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
                }
                
            }
        }
		_buttons = buttons;
	}
	return _buttons;
}

- (void)handlePayButton:(UIButton*)button
{

    if ([self.amount integerValue] == 0) {
        [self showNotice:@"请先选择金额"];
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"amount"] = self.amount;

    [TopUpRequest topUpWithParams:params success:^(NSDictionary *result) {
        [[TTNavigationService sharedService] openUrl:result[@"link"]];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
    
}

- (void)handleMoneyButton:(UIButton *)button{

    for (int index = 0; index < self.buttons.count - 1; index++) {
        UIButton *btn = self.buttons[index];
        btn.layer.borderColor = Color_Gray216.CGColor;
    }
    UITextField *textField = [self.buttons safeObjectAtIndex:self.buttons.count - 1];
    textField.layer.borderColor = Color_Gray216.CGColor;
    [textField resignFirstResponder];
    
    button.layer.borderColor = Color_Gray42.CGColor;
    self.amount = button.titleLabel.text;
}

- (void)handleRightButton
{
    TURecordViewController *vc = [[TURecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    for (int index = 0; index < self.buttons.count - 1; index++) {
        UIButton *btn = self.buttons[index];
        btn.layer.borderColor = Color_Gray216.CGColor;
    }
    textField.layer.borderColor = Color_Gray42.CGColor;
    self.amount = textField.text;
}

- (void)textFieldChanged:(UITextField*)textField
{
    self.amount = textField.text;
}
@end
