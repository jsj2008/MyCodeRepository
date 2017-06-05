//
//  SDRocketAlertView.m
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDRocketAlertView.h"



#import "SDLoginButton.h"


static SDRocketAlertView *_instance;

@interface SDRocketAlertView ()

@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UIImageView *rocket;

@end

@implementation SDRocketAlertView





+ (instancetype)sharedRocketAlertView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = 550 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 706 * SCALE;
        CGFloat y = (SCREENHEIGHT - height)/2;
        
        _instance = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        
        
    });
    
    return _instance;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *rocket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"highProve_rocket"]];
        self.rocket = rocket;
        [rocket sizeToFit];
        
        rocket.height = self.width * (rocket.height/rocket.width);
        
        rocket.width = self.width;
        
        rocket.y = 0;
        
        rocket.x = 0;
        
        [self addSubview:rocket];
        
        self.layer.cornerRadius = 8 * SCALE;
        self.clipsToBounds = YES;
        
        self.backgroundColor = SDWhiteColor;
        
        CGFloat titleH = [@"马上认证, 立即提速" sizeOfMaxScreenSizeInFont:36 * SCALE].height;
        CGFloat titleY = 50 * SCALE + rocket.height;
        CGFloat titleX = 50 * SCALE;
        CGFloat buttonH = 80 * SCALE;
        
        UILabel *titleLabel = [UILabel labelWithText:@"马上认证, 立即提速" textColor:FDColor(34, 34, 34) font:36 * SCALE textAliment:1];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.frame = CGRectMake(0, titleY, self.width, titleH);
        
        CGFloat contentH = 150 * SCALE;
        UILabel *contentLabel = [UILabel labelWithText:@"立即进行高级认证, 借款审核速度大大提升 !" textColor:FDColor(102, 102, 102) font:28 * SCALE textAliment:1];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        contentLabel.numberOfLines = 0;
        contentLabel.frame = CGRectMake(titleX, titleY + titleH, self.width - 2 * titleX, contentH);
        
//        contentLabel.y = CGRectGetMaxY(titleLabel.frame) + 30 * SCALE;
        
        SDLoginButton *knowButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(titleX, self.height - buttonH - 30 * SCALE, self.width - titleX * 2.2, buttonH)];
        self.knowButton = knowButton;
        [self addSubview:knowButton];
        [knowButton setTitle:@"我知道了" forState:UIControlStateNormal];
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
    
    
    SDRocketAlertView *alert = [self sharedRocketAlertView];
    alert.shadowButton = shadowButton;
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
}

+ (void)dismiss{
    
    SDRocketAlertView *alert = [self sharedRocketAlertView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];
    
}

- (void)knowButtonDidClicked{
    
    
    [SDRocketAlertView dismiss];
    
    
    
}


@end
