//
//  SDForgotOperatorPasswordView.m
//  SD
//
//  Created by 余艾星 on 17/3/20.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDForgotOperatorPasswordView.h"

#import "SDLending.h"
#import "SDLoginButton.h"
#import "SDUserCenter.h"

#define AlipayAccount @""
#define FONT (26 * SCALE)

static SDForgotOperatorPasswordView *_instance;

@interface SDForgotOperatorPasswordView ()

@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UIImageView *noticeImageView;

@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *remarkLabel;
@property (nonatomic, weak) UIButton *copyingButton;

@property (nonatomic, strong) SDUserCenter *userCenter;

@end

@implementation SDForgotOperatorPasswordView


+ (instancetype)sharedForgotOperatorView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = SCREENWIDTH - 100 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 650 * SCALE;
        CGFloat y = (SCREENHEIGHT - height)/2;
        
        _instance = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        
        
    });
    
    return _instance;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat titleH = [@"运营商服务密码获取渠道" sizeOfMaxScreenSizeInFont:FONT].height;
        CGFloat titleY = 50 * SCALE;
        CGFloat titleX = 50 * SCALE;
        CGFloat buttonH = 100 * SCALE;
        titleH = titleH * 2;
        NSString *title = [NSString stringWithFormat:@"运营商服务密码获取渠道"];
        
        UILabel *titleLabel = [UILabel labelWithText:title textColor:FDColor(34, 34, 34) font:(FONT + 3) textAliment:1];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.frame = CGRectMake(0, titleY, self.width, titleH);
        
//        中国电信:尊敬的用户，您可以拨打10000，根据语音提示进行密码重置
        CGFloat priceY = CGRectGetMaxY(titleLabel.frame) + 47 * SCALE;
        UILabel *priceLabel = [UILabel labelWithText:@"中国电信: 尊敬的用户，您可以拨打10000，根据语音提示进行密码重置" textColor:SDBlackColor font:FONT textAliment:0];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        priceLabel.frame = CGRectMake(titleX, priceY, self.width - 2 * titleX, titleH);
        priceLabel.numberOfLines = 0;
        
        //中国联通:尊敬的用户，您可以拨打10010，根据语音提示进行密码重置
        CGFloat remarkY = CGRectGetMaxY(priceLabel.frame) + 47 * SCALE;
        UILabel *remarkLabel = [UILabel labelWithText:@"中国联通: 尊敬的用户，您可以拨打10010，根据语音提示进行密码重置" textColor:SDBlackColor font:FONT textAliment:0];
        [self addSubview:remarkLabel];
        self.remarkLabel = remarkLabel;
        remarkLabel.numberOfLines = 0;
        remarkLabel.frame = CGRectMake(titleX, remarkY, self.width - 2 * titleX, titleH);
        
        //中国移动:尊敬的用户，您可以拨打10086，根据语音提示进行密码重置
        CGFloat moblieY = CGRectGetMaxY(remarkLabel.frame) + 47 * SCALE;
        UILabel *mobileLabel = [UILabel labelWithText:@"中国移动: 尊敬的用户，您可以拨打10086，根据语音提示进行密码重置" textColor:SDBlackColor font:FONT textAliment:0];
        [self addSubview:mobileLabel];
        mobileLabel.numberOfLines = 0;
        
        mobileLabel.frame = CGRectMake(titleX, moblieY, self.width - 2 * titleX, titleH);
        self.layer.cornerRadius = 8 * SCALE;
        self.clipsToBounds = YES;
        
        self.backgroundColor = SDWhiteColor;
        
        
        CGFloat knowW = 380 * SCALE;
        CGFloat knowX = (self.width - knowW)/2;
        
        SDLoginButton *knowButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(knowX, self.height - buttonH - 30 * SCALE, knowW, buttonH)];
        self.knowButton = knowButton;
        [self addSubview:knowButton];
        [knowButton setTitle:@"知道了" forState:UIControlStateNormal];
        knowButton.titleLabel.font = [UIFont systemFontOfSize:30 * SCALE];
        
        [knowButton addTarget:self action:@selector(knowButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
    return self;
}

+ (void)show{
    
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    
    SDForgotOperatorPasswordView *alert = [self sharedForgotOperatorView];
    alert.shadowButton = shadowButton;
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
}

+ (void)dismiss{
    
    SDForgotOperatorPasswordView *alert = [self sharedForgotOperatorView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];
    
}

- (void)knowButtonDidClicked{
    
    
    [SDForgotOperatorPasswordView dismiss];
    
    
    
}

@end
