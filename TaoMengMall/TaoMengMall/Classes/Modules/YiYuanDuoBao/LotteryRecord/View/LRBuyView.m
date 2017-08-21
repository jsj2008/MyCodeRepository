//
//  ItemBuyView.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRBuyView.h"

@interface LRBuyView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *numberField;
@property (nonatomic, strong) UIButton *reduceButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) NSArray *buttonDatas;

@end

@implementation LRBuyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self render];
    }
    return self;
}

- (instancetype)init{
    if (self == [super init]) {
        [self render];
    }
    return self;
}


- (void)render{
    self.buttonDatas = @[@"5",@"10",@"15",@"20"];
    self.backgroundColor = Color_White;
    self.width = SCREEN_WIDTH;
    [self addSubview:self.topBar];
    [self.topBar addSubview:self.closeButton];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.reduceButton];
    [self.bgView addSubview:self.addButton];
    [self.bgView addSubview:self.numberField];
    for (int index = 0; index < 4; index ++) {
        UIButton *btn = [self.buttons safeObjectAtIndex:index];
        [self.bgView addSubview:btn];
    }
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.priceLabel];
    [self.bgView addSubview:self.line1];
    [self.bgView addSubview:self.line2];
    [self addSubview:self.buyButton];
    [self adaptive];
}

- (void)adaptive{
    if (self.type == ItemBuyViewTypeNone) {
        self.height = 44;
        self.bottom = SCREEN_HEIGHT;
        self.bgView.hidden = YES;
        self.topBar.hidden = YES;
        self.buyButton.left = self.buyButton.top = 0;
        [self.buyButton bringSubviewToFront:self];

    }else{
        self.height = 300;
        self.bottom = SCREEN_HEIGHT;
        self.topBar.hidden = NO;
        self.bgView.hidden = NO;
        
        self.buyButton.bottom = 300;
        self.buyButton.left = 0;
        
        self.topBar.top = self.topBar.left = 0;
        
        self.bgView.width = SCREEN_WIDTH;
        self.bgView.height = 300 - self.topBar.height - self.buyButton.height;
        self.bgView.top = self.topBar.bottom;
        self.bgView.left = 0;
        
        self.closeButton.centerY = self.topBar.height / 2.0f;
        self.closeButton.right = SCREEN_WIDTH - 8;
        
        self.titleLabel.top = 16;
        self.titleLabel.centerX = SCREEN_WIDTH / 2.0f;
        
        self.numberField.width = 218;
        self.numberField.height = 40;
        self.numberField.top = self.titleLabel.bottom + 15;
        self.numberField.centerX = SCREEN_WIDTH / 2.0f;
        
        self.reduceButton.right = self.numberField.left;
        self.reduceButton.centerY = self.numberField.centerY;
        
        self.addButton.left = self.numberField.right;
        self.addButton.centerY = self.numberField.centerY;
        
        self.line1.top = self.reduceButton.top;
        self.line1.width = self.addButton.left - self.reduceButton.right;
        self.line1.left = self.reduceButton.right;
        
        self.line2.bottom = self.reduceButton.bottom;
        self.line2.width = self.addButton.left - self.reduceButton.right;
        self.line2.left = self.reduceButton.right;
        
        CGFloat width = self.numberField.width + self.addButton.width + self.reduceButton.width;
        CGFloat margin = (width - 60 * 4)/3.0f;
        CGFloat bottom = self.addButton.bottom;;
        for (int index = 0; index < 4; index++) {
            UIButton *btn = [self.buttons safeObjectAtIndex:index];
            btn.left = self.reduceButton.left + index * (btn.width + margin);
            btn.top = bottom + 20;
        }
        
        self.line.top = bottom + 20 + 30 + 16;
        
        self.priceLabel.width = SCREEN_WIDTH;
        self.priceLabel.height = 25;
        self.priceLabel.top = self.line.bottom + 12;
        self.priceLabel.centerX = SCREEN_WIDTH / 2.0f;
    }
}

- (UIView *)coverView{
    if (!_coverView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Color_Black;
        view.alpha = 0.3;
        view.top = view.right = 0;
        view.width = SCREEN_WIDTH;
        view.height = SCREEN_HEIGHT - 300;
        _coverView = view;
    }
    return _coverView;
}

- (UIButton *)buyButton
{
	if (!_buyButton) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
		[button setTitleColor:Color_Black forState:UIControlStateNormal];
        button.backgroundColor = RGB(249, 218, 109);
		button.titleLabel.font = FONT(16);
		[button setTitle:@"立即购买" forState:UIControlStateNormal];
		[button addTarget:self action:@selector(handleBuyButton:) forControlEvents:UIControlEventTouchUpInside];
		_buyButton = button;
	}
	return _buyButton;
}

- (UIView *)bgView
{
	if (!_bgView) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
		view.backgroundColor = Color_White;
		_bgView = view;
	}
	return _bgView;
}

- (UIView *)topBar
{
	if (!_topBar) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
		view.backgroundColor = Color_Gray224;
		_topBar = view;
	}
	return _topBar;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [button setImage:[UIImage imageNamed:@"item_close_icon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleCloseButton) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = button;
    }
    return _closeButton;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
		label.text = @"参与人次";
		[label sizeToFit];
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UITextField *)numberField
{
	if (!_numberField) {
		UITextField *label = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
        label.text = @"1";
        label.textAlignment = NSTextAlignmentCenter;
        label.keyboardType = UIKeyboardTypeNumberPad;
        label.delegate = self;
		_numberField = label;
	}
	return _numberField;
}

- (UIButton *)reduceButton
{
	if (!_reduceButton) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
		button.backgroundColor = Color_White;
        [button setImage:[UIImage imageNamed:@"item_redeuce_icon"] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(handleReduceButton:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 1;
        button.layer.borderColor = Color_Gray216.CGColor;
        
		_reduceButton = button;
	}
	return _reduceButton;
}

- (UIButton *)addButton
{
	if (!_addButton) {
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [button setImage:[UIImage imageNamed:@"item_add_icon"] forState:UIControlStateNormal];
		button.backgroundColor = Color_White;
		[button addTarget:self action:@selector(handleAddButton:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 1;
        button.layer.borderColor = Color_Gray216.CGColor;
		_addButton = button;
	}
	return _addButton;
}

- (NSMutableArray *)buttons
{
	if (!_buttons) {
		NSMutableArray *buttons = [[NSMutableArray alloc] init];
        for (int index = 0; index < 4; index++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[self.buttonDatas safeObjectAtIndex:index] forState:UIControlStateNormal];
            [btn setTitleColor:Color_Gray216 forState:UIControlStateNormal];
            btn.width = 60;
            btn.height = 30;
            btn.layer.cornerRadius = 3;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = Color_Gray216.CGColor;
            btn.layer.masksToBounds = YES;
            btn.tag = index;
            [btn addTarget:self action:@selector(handleMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
            [buttons addObject:btn];
        }
		_buttons = buttons;
	}
	return _buttons;
}

- (UIView *)line
{
	if (!_line) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
		_line = view;
	}
	return _line;
}

- (UIView *)line1{
    if (!_line1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Color_Gray216;
        view.height = 1;
        _line1 = view;
    }
    return _line1;
}

- (UIView *)line2{
    if (!_line2) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = Color_Gray216;
        view.height = 1;
        _line2 = view;
    }
    return _line2;
}
- (UILabel *)priceLabel
{
	if (!_priceLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
        label.textAlignment = NSTextAlignmentCenter;
		_priceLabel = label;
	}
	return _priceLabel;
}

- (void)setType:(LRBuyViewType)type{
    _type = type;
    [self adaptive];
}

- (void)handleBuyButton:(UIButton*)button
{
    if (self.type == ItemBuyViewTypeNone) {
        self.type = ItemBuyViewTypeProcess;
        [self adaptive];
        
    }else{
        if ([self.delegate respondsToSelector:@selector(handleBuyButtonWithAmount:)]) {
            
            [self.delegate handleBuyButtonWithAmount:[self.numberField.text intValue]];
        }
    }
    
}

- (void)handleReduceButton:(UIButton*)button
{
    int number = [self.numberField.text intValue];
    if (number != 1) {
        number --;
        self.numberField.text = [NSString stringWithFormat:@"%d",number];
        self.priceLabel.text = [NSString stringWithFormat:@"共  %g元",[self.numberField.text intValue] * self.price];
        for (UIButton *tempButton in self.buttons) {
            if ([tempButton.titleLabel.text intValue] == number) {
                tempButton.layer.borderColor = Color_Gray42.CGColor;
                [tempButton setTitleColor:Color_Gray42 forState:UIControlStateNormal];
            }else{
                tempButton.layer.borderColor = Color_Gray216.CGColor;
                [tempButton setTitleColor:Color_Gray216 forState:UIControlStateNormal];
            }
            
        }
        
    }
}

- (void)handleAddButton:(UIButton*)button
{   int number = [self.numberField.text intValue];
    number ++;
    self.numberField.text = [NSString stringWithFormat:@"%d",number];
    self.priceLabel.text = [NSString stringWithFormat:@"共  %g元",[self.numberField.text intValue] * self.price];
    for (UIButton *tempButton in self.buttons) {
        if ([tempButton.titleLabel.text intValue] == number) {
            tempButton.layer.borderColor = Color_Gray42.CGColor;
            [tempButton setTitleColor:Color_Gray42 forState:UIControlStateNormal];
        }else{
            tempButton.layer.borderColor = Color_Gray216.CGColor;
            [tempButton setTitleColor:Color_Gray216 forState:UIControlStateNormal];
        }
        
    }
}

- (void)handleMoneyButton:(UIButton *)button{
    for (UIButton *tempButton in self.buttons) {
        tempButton.layer.borderColor = Color_Gray216.CGColor;
        [tempButton setTitleColor:Color_Gray216 forState:UIControlStateNormal];
    }
    button.layer.borderColor = Color_Gray42.CGColor;
    [button setTitleColor:Color_Gray42 forState:UIControlStateNormal];
    int number = [[self.buttonDatas safeObjectAtIndex:button.tag] intValue];
    self.numberField.text = [NSString stringWithFormat:@"%d",number];
    self.priceLabel.text = [NSString stringWithFormat:@"共  %g元",[self.numberField.text intValue] * self.price];
}

- (void)handleCloseButton{
    self.type = ItemBuyViewTypeNone;
    [self.coverView removeFromSuperview];
    [self adaptive];
    if ([self.delegate respondsToSelector:@selector(hanleCloseButton)]) {
        [self.delegate hanleCloseButton];
    }
}


- (void)setPrice:(float)price{
    _price = price;
    
    self.priceLabel.text = [NSString stringWithFormat:@"共  %g元",[self.numberField.text intValue] * price];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    int number = [self.numberField.text intValue];
    for (UIButton *tempButton in self.buttons) {
        if ([tempButton.titleLabel.text intValue] == number) {
            tempButton.layer.borderColor = Color_Gray42.CGColor;
            [tempButton setTitleColor:Color_Gray42 forState:UIControlStateNormal];
        }else{
            tempButton.layer.borderColor = Color_Gray216.CGColor;
            [tempButton setTitleColor:Color_Gray216 forState:UIControlStateNormal];
        }
        
    }
    self.priceLabel.text = [NSString stringWithFormat:@"共  %g元",number * self.price];
}
@end
