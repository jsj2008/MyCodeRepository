//
//  SDShouldRefundView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDShouldRefundView.h"
#import "SDNumberView.h"

@interface SDShouldRefundView ()

//到期应还
@property (nonatomic, weak) SDNumberView *refundNumberView;

//到账金额
@property (nonatomic, weak) SDNumberView *receivedNumberView;

//手续费用
@property (nonatomic, weak) SDNumberView *chargeNumberView;

//借款时间
@property (nonatomic, weak) SDNumberView *loanTimeNumberView;

@property (nonatomic, assign) CGFloat day;

@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIView *line2;

@end

@implementation SDShouldRefundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.day = 14;
        
//        self.backgroundColor = [UIColor yellowColor];
        
//        self.percent = 0.05;
        
        //到期应还
        
        SDNumberView *refundNumberView = [[SDNumberView alloc] init];
        self.refundNumberView = refundNumberView;
        [self addSubview:refundNumberView];
        
        //到账金额
        
        SDNumberView *receivedNumberView = [[SDNumberView alloc] init];
        self.receivedNumberView = receivedNumberView;
        [self addSubview:receivedNumberView];
        
        
        //手续费用
        SDNumberView *chargeNumberView = [[SDNumberView alloc] init];
        self.chargeNumberView = chargeNumberView;
        [self addSubview:chargeNumberView];
        
        
        //借款时间
        SDNumberView *loanTimeNumberView = [[SDNumberView alloc] init];
        self.loanTimeNumberView = loanTimeNumberView;
        [self addSubview:loanTimeNumberView];
        
        [SDNotificationCenter addObserver:self selector:@selector(sliderMoved:) name:SDSliderMovedNotification object:nil];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = FDColor(231, 231, 231);
        self.line1 = line1;
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = FDColor(231, 231, 231);
        self.line2 = line2;
        [self addSubview:line2];

        
        
        [SDNotificationCenter addObserver:self selector:@selector(loanTimeChoosen:) name:SDChoosenDayNotification object:nil];
        
    }
    return self;
}

- (void)dealloc{
    
    [SDNotificationCenter removeObserver:self];
}

- (void)loanTimeChoosen:(NSNotification *)notification{
    
    CGFloat day = [notification.userInfo[SDChoosenDay] floatValue];
    
    self.day = day;
    
    self.loanTimeNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@(day)];
    
    //到账金额
    
    NSInteger receivedMoney = [self.receivedNumberView.numberLabel.text integerValue];
    
    self.refundNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@((NSInteger)(receivedMoney * (1 + percent * day)))];
    
    self.chargeNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@((NSInteger)(receivedMoney * self.day * percent))];
    
}

- (void)sliderMoved:(NSNotification *)notification{
    
    //到账金额
    NSInteger receivedMoney = [notification.userInfo[SDReceivedMoney] integerValue];
    
    NSInteger i = (NSInteger)receivedMoney * (1 + self.day * percent);
    
    self.refundNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@(i)];
    
    self.receivedNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@(receivedMoney)];
    
    self.chargeNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@((NSInteger)(receivedMoney * self.day * percent))];
    
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //到期应还
    CGFloat refundY = 50 * SCALE;
    CGFloat refundH = 88 * SCALE;
    CGFloat refundW = 120;
    
    self.refundNumberView.frame = CGRectMake(0, refundY, refundW, refundH);
    self.refundNumberView.centerX = SCREENWIDTH/2;
    
    //到账金额
    CGFloat receivedY = refundY + refundH + 56 * SCALE;
    CGFloat receivedH = 66 * SCALE;
    CGFloat receivedW = 150 * SCALE;
    CGFloat receivedX = 30 * SCALE;

    self.receivedNumberView.frame = CGRectMake(receivedX, receivedY, receivedW, receivedH);

    
    
    //手续费用
    self.chargeNumberView.frame = self.receivedNumberView.frame;
    self.chargeNumberView.centerX = SCREENWIDTH/2;

    
    
    //借款时间
    self.loanTimeNumberView.frame = self.receivedNumberView.frame;
    self.loanTimeNumberView.x = SCREENWIDTH - receivedW - receivedX;
    
    //线
    self.line1.x = (self.chargeNumberView.x - CGRectGetMaxX(self.receivedNumberView.frame))/2 + CGRectGetMaxX(self.receivedNumberView.frame);
    
    self.line2.x = (self.loanTimeNumberView.x - CGRectGetMaxX(self.chargeNumberView.frame))/2 + CGRectGetMaxX(self.chargeNumberView.frame);
    
    self.line1.width = self.line2.width = 1 * SCALE;
    self.line1.height = self.line2.height = 40 * SCALE;
    self.line1.centerY = self.line2.centerY = self.receivedNumberView.centerY;
    

    self.refundNumberView.numberLabel.text = @"1120";
    self.refundNumberView.numberLabel.textColor = FDColor(241, 130, 48);
    self.refundNumberView.numberLabel.font = [UIFont systemFontOfSize:50 * SCALE];
    [self.refundNumberView.descriptionButton setTitle:@"  借款金额(元)" forState:UIControlStateNormal];
    [self.refundNumberView.descriptionButton setImage:[UIImage imageNamed:@"card_icon"] forState:UIControlStateNormal];
    
    self.receivedNumberView.numberLabel.text = @"1000";
    [self.receivedNumberView.descriptionButton setTitle:@"到账金额(元)" forState:UIControlStateNormal];
    
    self.chargeNumberView.numberLabel.text = @"120";
    [self.chargeNumberView.descriptionButton setTitle:@"手续费用(元)" forState:UIControlStateNormal];
    
    self.loanTimeNumberView.numberLabel.text = @"14";
    [self.loanTimeNumberView.descriptionButton setTitle:@"借款时间(天)" forState:UIControlStateNormal];
}

@end














