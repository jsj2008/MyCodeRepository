//
//  SDHighProveSuccessNotice.m
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDHighProveSuccessNotice.h"
#import "SDLoginButton.h"
#import "SDLending.h"

static SDHighProveSuccessNotice *_instance;

@interface SDHighProveSuccessNotice ()

@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UILabel *percentLabel;

@end

@implementation SDHighProveSuccessNotice





+ (instancetype)sharedHighProveSuccessAlertView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = 550 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 446 * SCALE;
        CGFloat y = (SCREENHEIGHT - height)/2;
        
        _instance = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        
        
    });
    
    return _instance;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.layer.cornerRadius = 8 * SCALE;
        self.clipsToBounds = YES;
        
        self.backgroundColor = SDWhiteColor;
        
        CGFloat titleH = [@"马上认证, 立即提速" sizeOfMaxScreenSizeInFont:36 * SCALE].height;
        CGFloat titleY = 50 * SCALE;
        CGFloat titleX = 50 * SCALE;
        CGFloat buttonH = 80 * SCALE;
        
        UILabel *titleLabel = [UILabel labelWithText:@"提升成功" textColor:FDColor(34, 34, 34) font:36 * SCALE textAliment:1];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.frame = CGRectMake(0, titleY, self.width, titleH);
        
        
        CGFloat contentH = 30 * SCALE;
        UILabel *contentLabel = [UILabel labelWithText:@"恭喜你! 你的借款速度提升了" textColor:FDColor(102, 102, 102) font:28 * SCALE textAliment:1];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        contentLabel.numberOfLines = 0;
        contentLabel.frame = CGRectMake(titleX, titleY + titleH + 20 * SCALE, self.width - 2 * titleX, contentH);
        
        //        contentLabel.y = CGRectGetMaxY(titleLabel.frame) + 30 * SCALE;
        
        UILabel *percentLabel = [UILabel labelWithText:@"+ 30%" textColor:FDColor(34, 34, 34) font:70 * SCALE textAliment:1];
        [self addSubview:percentLabel];
        self.percentLabel = percentLabel;
        
        percentLabel.frame = CGRectMake(titleX, CGRectGetMaxY(contentLabel.frame) + contentH * 2, self.width - 2 * titleX, 70 * SCALE);
        
        
        SDLoginButton *knowButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(titleX, self.height - buttonH - 30 * SCALE, self.width - titleX * 2.2, buttonH)];
        self.knowButton = knowButton;
        [self addSubview:knowButton];
        [knowButton setTitle:@"提升完毕" forState:UIControlStateNormal];
        knowButton.titleLabel.font = [UIFont systemFontOfSize:30 * SCALE];
        
        [knowButton addTarget:self action:@selector(knowButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return self;
}

+ (void)showWithSpeed:(NSString *)speed{
    
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    
    
    SDHighProveSuccessNotice *alert = [self sharedHighProveSuccessAlertView];
    alert.shadowButton = shadowButton;
    alert.percentLabel.text = [NSString stringWithFormat:@"+ %@ %%",speed];
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
}

+ (void)dismiss{
    
    SDHighProveSuccessNotice *alert = [self sharedHighProveSuccessAlertView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];
    
}

- (void)knowButtonDidClicked{
    
    
    [SDHighProveSuccessNotice dismiss];
    
    
    
}

@end
