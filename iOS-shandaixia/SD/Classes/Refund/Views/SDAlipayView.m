//
//  SDAlipayView.m
//  SD
//
//  Created by 余艾星 on 17/3/17.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDAlipayView.h"
#import "SDLending.h"
#import "SDLoginButton.h"
#import "SDUserCenter.h"
#import "SDAccount.h"

#define AlipayAccount @""
#define FONT (24 * SCALE)

static SDAlipayView *_instance;

@interface SDAlipayView ()

@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UIImageView *noticeImageView;

@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *remarkLabel;
@property (nonatomic, weak) UIButton *copyingButton;

@property (nonatomic, strong) SDUserCenter *userCenter;

@end

@implementation SDAlipayView





+ (instancetype)sharedAlipayView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = 578 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 800 * SCALE;
        CGFloat y = (SCREENHEIGHT - height)/2;
        
        _instance = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        
        
    });
    
    return _instance;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat titleH = [@"马上认证, 立即提速" sizeOfMaxScreenSizeInFont:FONT].height;
        CGFloat titleY = 50 * SCALE;
        CGFloat titleX = 50 * SCALE;
        CGFloat buttonH = 80 * SCALE;
        
        NSString *title = [NSString stringWithFormat:@"官方账号: %@",AlipayAccount];
        
        CGFloat width = [title sizeOfMaxScreenSizeInFont:FONT].width;
        
        UILabel *titleLabel = [UILabel labelWithText:title textColor:FDColor(34, 34, 34) font:FONT textAliment:0];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.frame = CGRectMake(titleX, titleY, width, titleH);
        
        UIButton *copyingButton = [UIButton buttonWithImage:@"alipay_copy" backImageNamed:nil];
        [copyingButton sizeToFit];
        self.copyingButton = copyingButton;
        [self addSubview:copyingButton];
        copyingButton.x = CGRectGetMaxX(titleLabel.frame) + 20 * SCALE;
        copyingButton.centerY = titleLabel.centerY;
        [copyingButton addTarget:self action:@selector(copyingButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat priceY = CGRectGetMaxY(titleLabel.frame) + 47 * SCALE;
        UILabel *priceLabel = [UILabel labelWithText:@"转账金额:" textColor:SDBlackColor font:FONT textAliment:0];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        priceLabel.frame = CGRectMake(titleX, priceY, self.width, titleH);
        
        CGFloat remarkY = CGRectGetMaxY(priceLabel.frame) + 47 * SCALE;
        UILabel *remarkLabel = [UILabel labelWithText:@"转账备注:" textColor:SDBlackColor font:FONT textAliment:0];
        [self addSubview:remarkLabel];
        self.remarkLabel = remarkLabel;
        remarkLabel.frame = CGRectMake(titleX, remarkY, self.width, titleH);
        
        UIImageView *noticeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alipay_pic"]];
        self.noticeImageView = noticeImageView;
        [noticeImageView sizeToFit];
        
        [noticeImageView sizeToFit];
        
        noticeImageView.y = CGRectGetMaxY(remarkLabel.frame) + 56 * SCALE;
        
        noticeImageView.centerX = self.width/2;
        [self addSubview:noticeImageView];
        
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
        
        [self loadUserCenter];
        
        [self loadAlipayAccount];
        
    }
    return self;
}

+ (void)showWithLending:(SDLending *)lending{
    
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    
    SDAlipayView *alert = [self sharedAlipayView];
    alert.shadowButton = shadowButton;
    alert.alpha = 0;
    
    alert.priceLabel.text = [NSString stringWithFormat:@"转账金额: %@元",lending.stillAmount];
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
    [UIView animateWithDuration:0.25 animations:^{
       
        alert.alpha = 1;
        shadowButton.alpha = 0.6;
    }];
    
}

+ (void)dismiss{
    
    SDAlipayView *alert = [self sharedAlipayView];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        alert.alpha = 0;
        alert.shadowButton.alpha = 0;
    } completion:^(BOOL finished) {
        
        [alert removeFromSuperview];
        [alert.shadowButton removeFromSuperview];
    }];
    
}

- (void)knowButtonDidClicked{
    
    
    [SDAlipayView dismiss];
    
    
    
}

- (void)copyingButtonDidClicked{

    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = AlipayAccount;
    
    [pab setString:string];
    
    if (pab == nil) {
        
        [FDReminderView showWithString:@"复制失败"];
        
        
    }else
    {
        
        [FDReminderView showWithString:@"复制成功"];
    }

}

- (void)loadUserCenter{

    [SDUserCenter getUserCenterFinishedBlock:^(id object) {
        
        self.userCenter = object;
        
        self.remarkLabel.text = [NSString stringWithFormat:@"转账备注: %@ %@",self.userCenter.realName,[FDUserDefaults objectForKey:FDUserAccount]];
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)loadAlipayAccount{

    [SDAccount getAlipayAccountFinishedBlock:^(id object) {
        
        NSString *str = object[@"data"];
        
        NSLog(@"str  - %@",str);
        
        if (str.length) {
            
            self.titleLabel.text = [NSString stringWithFormat:@"官方账号: %@",str];
            
            
            CGFloat width = [self.titleLabel.text sizeOfMaxScreenSizeInFont:FONT].width;
            
            self.titleLabel.width = width;
            
            self.copyingButton.x = CGRectGetMaxX(self.titleLabel.frame) + 20 * SCALE;
            
            
        }
        
    } failuredBlock:^(id object) {
        
    }];
}

@end








