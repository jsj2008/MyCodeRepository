//
//  SDSignatureAlertView.m
//  SD
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDSignatureAlertView.h"
#import "SDSignatureCheckView.h"
#import "SDLoginButton.h"
#import "SDSSQStatus.h"

static SDSignatureAlertView *_instance;

@interface SDSignatureAlertView()

@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) SDSignatureCheckView *checkView;

@property (nonatomic, weak) SDLoginButton *okButton;

@property (nonatomic, assign) SSQSatusCode ssqStatusCode;

@end

@implementation SDSignatureAlertView

+ (instancetype)sharedSignatureAlertView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = 578 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 446 * SCALE;
        CGFloat y = (SCREENHEIGHT - height)/2;
        _instance = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
    });
    
    return _instance;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initContent];
    }
    return self;
}

- (void)initContent {
    
    self.layer.cornerRadius = 8 * SCALE;
    self.clipsToBounds = YES;
    self.backgroundColor = SDWhiteColor;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"提示";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = FDColor(34, 34, 34);
    titleLabel.font = [UIFont systemFontOfSize:36 * SCALE];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"为保障您的合法权益，需要您的电子签名。";
    contentLabel.textColor = FDColor(102, 102, 102);
    contentLabel.font = [UIFont systemFontOfSize:28 * SCALE];
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    [self addSubview:contentLabel];
    
    SDSignatureCheckView *checkView = [[SDSignatureCheckView alloc] init];
    checkView.checkLabel.text = @"授权自动签署闪贷侠借款协议";
    checkView.checkLabel.textColor = FDColor(153, 153, 153);
    [checkView.checkBox addTarget:self
                           action:@selector(checkBoxClicked)
                 forControlEvents:UIControlEventTouchUpInside];
    self.checkView = checkView;
    [self addSubview:checkView];
    
    SDLoginButton *okButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(0, 0, 380 * SCALE, 80 * SCALE)];
    [okButton setTitle:@"知道了" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont systemFontOfSize:30 * SCALE];
    [okButton addTarget:self
                 action:@selector(buttonClick)
       forControlEvents:UIControlEventTouchUpInside];
    self.okButton = okButton;
    [self addSubview:okButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = CGRectGetWidth(self.frame);
//    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    // title Label
    CGFloat titleTop = 52 * SCALE;
    CGFloat titleWidth = CGRectGetWidth(self.frame);
    CGFloat titleHeight = 36 * SCALE;
    
    CGSize titleSize = CGSizeMake(titleWidth, titleHeight);
    CGPoint titleCenter = CGPointMake(titleWidth / 2, titleTop + (titleHeight / 2));
    _titleLabel.size = titleSize;
    _titleLabel.center = titleCenter;
    
    // content Label
    CGFloat contentEdge = 40 * SCALE;
    CGFloat contentTop = titleTop + titleHeight + 30 * SCALE;
    CGFloat contentWidth = CGRectGetWidth(self.frame) - contentEdge * 2;
    CGFloat contentHeight = 68 * SCALE;
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    CGPoint contentCenter = CGPointMake(selfWidth / 2, contentTop + (contentHeight / 2));
    _contentLabel.size = contentSize;
    _contentLabel.center = contentCenter;
    [_contentLabel sizeToFit];
    
    // checkView
    CGFloat checkViewEdge = 40 * SCALE;
    CGFloat checkViewTop = contentTop + contentHeight + 30 * SCALE;
    CGFloat checkViewWidth = CGRectGetWidth(self.frame) - checkViewEdge * 2;
    CGFloat checkViewHeight = 68 * SCALE;
    
    CGSize checkViewSize = CGSizeMake(checkViewWidth, checkViewHeight);
    CGPoint checkViewCenter = CGPointMake(selfWidth / 2, checkViewTop + checkViewHeight / 2);
    _checkView.size = checkViewSize;
    _checkView.center = checkViewCenter;
    
    // okButton
    CGFloat okButtonTop = checkViewTop + checkViewHeight + 44 * SCALE;
    CGFloat okButtonHeight = 80 * SCALE;
    CGPoint okButtonCenter = CGPointMake(selfWidth / 2, okButtonTop + okButtonHeight / 2);
    _okButton.center = okButtonCenter;
}

+ (void)showSelected:(Boolean)isSelect {
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    
    SDSignatureAlertView *alert = [self sharedSignatureAlertView];
    alert.shadowButton = shadowButton;
    
    [alert.checkView setIsSelect:isSelect];
    alert.ssqStatusCode = SSQSatusCodeAuto;
    [alert updateSSQStatus];
    
    
    if (isSelect) {
        alert.ssqStatusCode = SSQSatusCodeAuto;
    } else {
        alert.ssqStatusCode = SSQSatusCodeManual;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
}

- (void)updateSSQStatus {
    SDSignatureAlertView *alert = [SDSignatureAlertView sharedSignatureAlertView];
    [SDNotificationCenter postNotificationName:SDSSQUpdateStatus object:[NSNumber numberWithInteger:alert.ssqStatusCode]];
}

- (void)checkBoxClicked {
    if (self.ssqStatusCode == SSQSatusCodeAuto) {
        [self.checkView setIsSelect:false];
        self.ssqStatusCode = SSQSatusCodeManual;
    } else {
        [self.checkView setIsSelect:true];
        self.ssqStatusCode = SSQSatusCodeAuto;
    }
    [self updateSSQStatus];
}


+ (void)dismiss {
    SDSignatureAlertView *alert = [self sharedSignatureAlertView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];

}

- (void)buttonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(okButtonClick:)]) {
        [self.delegate okButtonClick:self.ssqStatusCode];
    }
    [SDSignatureAlertView dismiss];
}


@end
