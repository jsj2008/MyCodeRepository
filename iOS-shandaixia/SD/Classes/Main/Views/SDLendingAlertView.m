//
//  SDLendingAlertView.m
//  SD
//
//  Created by 余艾星 on 17/3/11.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDLendingAlertView.h"
#import "SDLoginButton.h"
#import "SDLending.h"

static SDLendingAlertView *_instance;

@interface SDLendingAlertView ()

@property (nonatomic, weak) UIButton *shadowButton;
@end

@implementation SDLendingAlertView





+ (instancetype)sharedLendingAlertView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = 550 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 400 * SCALE;
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
        
        CGFloat titleH = [@"审核" sizeOfMaxScreenSizeInFont:36 * SCALE].height;
        CGFloat titleY = 50 * SCALE;
        CGFloat titleX = 50 * SCALE;
        CGFloat buttonH = 80 * SCALE;
        
        UILabel *titleLabel = [UILabel labelWithText:@"审核" textColor:FDColor(34, 34, 34) font:36 * SCALE textAliment:1];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.frame = CGRectMake(0, titleY, self.width, titleH);
        
        
        CGFloat contentH = self.height - buttonH - titleH - titleY * 2;
        UILabel *contentLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:28 * SCALE textAliment:1];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        contentLabel.frame = CGRectMake(titleX, titleY + titleH, self.width - 2 * titleX, contentH);
        contentLabel.numberOfLines = 0;
        
        SDLoginButton *knowButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(titleX, self.height - buttonH - 30 * SCALE, self.width - titleX * 2.2, buttonH)];
        self.knowButton = knowButton;
        [self addSubview:knowButton];
        [knowButton setTitle:@"知道了" forState:UIControlStateNormal];
        knowButton.titleLabel.font = [UIFont systemFontOfSize:30 * SCALE];

        [knowButton addTarget:self action:@selector(knowButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

+ (void)show{
    
    SDLendingAlertView *alert = [self sharedLendingAlertView];
    
    
    
    
    if (!alert.shadowButton) {
        
        UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        shadowButton.backgroundColor = [UIColor blackColor];
        shadowButton.alpha = 0.6;
        [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
        
        alert.shadowButton = shadowButton;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
}

+ (void)dismiss{

    SDLendingAlertView *alert = [self sharedLendingAlertView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];
    
}

- (void)knowButtonDidClicked{

    
    [SDLendingAlertView dismiss];
    
    
    if ([self.delegate respondsToSelector:@selector(lendingAlertViewKnowButtonDidClicked:)]) {
        
        [self.delegate lendingAlertViewKnowButtonDidClicked:self.lending];
    }
    
}

- (void)setLending:(SDLending *)lending{

    _lending = lending;
    SDLendingAlertView *alert = [SDLendingAlertView sharedLendingAlertView];
    
//    alert.titleLabel
    
    NSString *title;
    
    
    switch (self.lending.status) {
        case SDLendingStatusPreCheck://0待审核，1审核中，2审核失败， 3等待放款， 4放款失败， 5放款成功， 6待回款，7已逾期

            title = @"待审核";
            break;
        case SDLendingStatusChecking:
            title = @"审核中";
            
            break;
        case SDLendingStatusCheckFailed:
            title = @"审核失败";
            
            alert.contentLabel.text = lending.defeatedInfo;
            
            break;
        case SDLendingStatusWaitMoney:
            title = @"等待放款";
            
            break;
        case SDLendingStatusLendFailed:
            title = @"放款中";
            
            
            
            break;
        case SDLendingStatusLoaning:
            title = @"放款中";
            
            
            
            break;
        case SDLendingStatusLendSuccess:
            
            title = @"放款成功";
            
            alert.contentLabel.text = lending.successInfo;
            
            break;
        case SDLendingStatusWaitRefund:
            title = @"待回款";
            
            break;
        case SDLendingStatusOverdue:
            title = @"已逾期";
            break;
            
        default:
            break;
    }
    
    self.titleLabel.text = title;
    
    
}

@end
