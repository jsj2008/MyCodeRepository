//
//  ThirdPartLoginView.m
//  BabyDaily
//
//  Created by marco on 8/18/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "ThirdPartLoginView.h"
#import "WXApi.h"

#define BUTTON_WIDTH (SCREEN_WIDTH/7)

@interface ThirdPartLoginView ()
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *rightLine;

@property (nonatomic, strong) UIButton *weiboButton;
@property (nonatomic, strong) UILabel *weiboLabel;

@property (nonatomic, strong) UIButton *wechatButton;
@property (nonatomic, strong) UILabel *wechatLabel;

@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UILabel *qqLabel;

@end

@implementation ThirdPartLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithDelegate:(id <ThirdPartLoginViewDelegate>)delegate;
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, BUTTON_WIDTH + (IS_IPHONE4?70:82));
        _delegate = delegate;
        [self render];
    }
    return self;
}

- (void)render
{
    [self addSubview:self.leftLine];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightLine];
    
    [self addSubview:self.weiboButton];
    [self addSubview:self.weiboLabel];
    [self addSubview:self.wechatButton];
    [self addSubview:self.wechatLabel];
    [self addSubview:self.qqButton];
    [self addSubview:self.qqLabel];
    
    if ([WXApi isWXAppInstalled]) {
        self.wechatButton.hidden = NO;
        self.wechatLabel.hidden = NO;
        
        self.qqButton.centerX = SCREEN_WIDTH/6.f;
        self.qqLabel.centerX = self.qqButton.centerX;
        
        self.wechatButton.centerX = SCREEN_WIDTH/2.f;
        self.wechatLabel.centerX = self.wechatButton.centerX;
        
        self.weiboButton.centerX = SCREEN_WIDTH*5/6.f;
        self.weiboLabel.centerX = self.weiboButton.centerX;
        
    }else{
        self.wechatButton.hidden = YES;
        self.wechatLabel.hidden = YES;
        
        self.qqButton.centerX = SCREEN_WIDTH/4.f;
        self.qqLabel.centerX = self.qqButton.centerX;
        
        self.weiboButton.centerX = SCREEN_WIDTH*3/4.f;
        self.weiboLabel.centerX = self.weiboButton.centerX;
    }
}

- (void)setHideName:(BOOL)hideName
{
    _hideName = hideName;
    self.wechatLabel.hidden = _hideName;
    self.weiboLabel.hidden = _hideName;
    self.qqLabel.hidden = _hideName;
}

#pragma mark -Subviews

- (UIView*)leftLine
{
    if (!_leftLine) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 0, 80, LINE_WIDTH)];
        view.backgroundColor =  Color_Gray125;
        view.centerY = self.titleLabel.centerY;
        view.centerX = SCREEN_WIDTH/6;
        _leftLine = view;
    }
    return _leftLine;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray125;
        label.text = @"第三方快捷登录";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2;
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UIView*)rightLine
{
    if (!_rightLine) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, LINE_WIDTH)];
        view.backgroundColor =  Color_Gray125;
        view.centerY = self.titleLabel.centerY;
        view.centerX = SCREEN_WIDTH*5/6;
        _rightLine = view;
    }
    return _rightLine;
}

- (UIButton*)weiboButton
{
    if (!_weiboButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
        [button setImage:[UIImage imageNamed:@"login_weibo"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(weiboButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.centerX = self.leftLine.centerX;
        button.bottom = self.height - 30;
        _weiboButton = button;
    }
    return _weiboButton;
}

- (UILabel*)weiboLabel
{
    if (!_weiboLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"微博";
        [label sizeToFit];
        label.top = self.weiboButton.bottom + 4;
        _weiboLabel = label;
    }
    return _weiboLabel;
}


- (UIButton*)wechatButton
{
    if (!_wechatButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
        [button setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(wechatButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.centerX = SCREEN_WIDTH/2;
        button.bottom = self.weiboButton.bottom;
        _wechatButton = button;
    }
    return _wechatButton;
}

- (UILabel*)wechatLabel
{
    if (!_wechatLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"微信";
        [label sizeToFit];
        label.top = self.weiboButton.bottom + 4;
        _wechatLabel = label;
    }
    return _wechatLabel;
}

- (UIButton*)qqButton
{
    if (!_qqButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
        [button setImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(qqButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.centerX = self.rightLine.centerX;
        button.bottom = self.weiboButton.bottom;
        _qqButton = button;
    }
    return _qqButton;
}

- (UILabel*)qqLabel
{
    if (!_qqLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"QQ";
        [label sizeToFit];
        label.top = self.weiboButton.bottom + 4;
        _qqLabel = label;
    }
    return _qqLabel;
}

#pragma mark - Button Actions
- (void)weiboButtonTapped
{
    if (_delegate && [_delegate respondsToSelector:@selector(weiboAuthorizeLogin)]) {
        [self.delegate weiboAuthorizeLogin];
    }
}

- (void)wechatButtonTapped
{
    if (_delegate && [_delegate respondsToSelector:@selector(wechatAuthorizeLogin)]) {
        [self.delegate wechatAuthorizeLogin];
    }
}

- (void)qqButtonTapped
{
    if (_delegate && [_delegate respondsToSelector:@selector(tencentAuthorizeLogin)]) {
        [self.delegate tencentAuthorizeLogin];
    }
}

@end
