//
//  SDRefundView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/4.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDRefundView.h"
#import "SDRefundNumberView.h"
#import "SDLending.h"

@interface SDRefundView ()

//顶部阴影
@property (nonatomic,weak) UIView *topShadowView;


@property (nonatomic,weak) UIView *middleShadowView;

//待还金额
@property (nonatomic, weak) SDRefundNumberView *refundNumberView;

//还款倒计时
@property (nonatomic, weak) SDRefundNumberView *refundTimeNumberView;

//还款日期
@property (nonatomic, weak) SDRefundNumberView *refundDayNumberView;

//警告背景
@property (nonatomic,weak) UIView *warningShadowView;

//警告
@property (nonatomic,weak) UILabel *warningLabel;

//逾期文本
@property (nonatomic,weak) UILabel *overDueLabel;

@property (nonatomic, assign) CGFloat overDueHeight;

@property (nonatomic, weak) UIButton *questionButton;


@end

@implementation SDRefundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.overDueHeight = 0;
        
        self.backgroundColor = SDWhiteColor;
        
        //待还金额
        SDRefundNumberView *refundNumberView = [SDRefundNumberView numberViewWithNumberFont:70 * SCALE numberColor:FDColor(255, 132, 0) desFont:24 * SCALE desColor:FDColor(34, 34, 34) imageNamed:@"card_icon"];
        [refundNumberView.descriptionButton setTitle:@" 待还金额(元)" forState:UIControlStateNormal];
        [self addSubview:refundNumberView];
        self.refundNumberView = refundNumberView;
        
        UILabel *overDueLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:24 * SCALE textAliment:1];
        [self addSubview:overDueLabel];
        self.overDueLabel = overDueLabel;
        overDueLabel.backgroundColor = FDColor(250, 250, 250);
        
        //还款倒计时
        SDRefundNumberView *refundTimeNumberView = [SDRefundNumberView numberViewWithNumberFont:50 * SCALE numberColor:FDColor(34, 34, 34) desFont:24 * SCALE desColor:FDColor(34, 34, 34) imageNamed:@"icon_clock-1"];
        [self addSubview:refundTimeNumberView];
        self.refundTimeNumberView = refundTimeNumberView;

        [refundTimeNumberView.descriptionButton setTitle:@"还款倒计时(天)" forState:UIControlStateNormal];
        
        //还款日期
        SDRefundNumberView *refundDayNumberView = [SDRefundNumberView numberViewWithNumberFont:40 * SCALE numberColor:FDColor(34, 34, 34) desFont:24 * SCALE desColor:FDColor(34, 34, 34) imageNamed:@"calendar_icon"];
        [self addSubview:refundDayNumberView];
        self.refundDayNumberView = refundDayNumberView;
        [refundDayNumberView.descriptionButton setTitle:@" 还款日期" forState:UIControlStateNormal];
        
        //顶部阴影
        UIView *topShadowView = [[UIView alloc] init];
        self.topShadowView = topShadowView;
        [self addSubview:topShadowView];
        topShadowView.backgroundColor = FDColor(243, 245, 249);
        
        
        UIView *middleShadowView = [[UIView alloc] init];
        self.middleShadowView = middleShadowView;
        [self addSubview:middleShadowView];
        middleShadowView.backgroundColor = FDColor(243, 245, 249);
        
        //还款按钮
        UIButton *refundButton = [UIButton buttonWithTitle:@"立即还款" titleColor:[UIColor whiteColor] titleFont:36 * SCALE];
        refundButton.backgroundColor = FDColor(70, 151, 251);
        self.refundButton = refundButton;
        [self addSubview:refundButton];
        
        //警告背景
        UIView *warningShadowView = [[UIView alloc] init];
        self.warningShadowView = warningShadowView;
        [self addSubview:warningShadowView];
        warningShadowView.backgroundColor = FDColor(250, 250, 250);

        
        //警告
        NSString *warn = @"温馨提示：如逾期还款将会产生逾期管理费，同时影响您的信用记录和信用额度。";
        UILabel *warningLabel = [UILabel labelWithText:warn textColor:FDColor(153,153,153) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        self.warningLabel = warningLabel;
        warningLabel.numberOfLines = 0;
        [warningShadowView addSubview:warningLabel];
        
        UIButton *questionButton = [UIButton buttonWithImage:@"icon_problem" backImageNamed:nil];
        self.questionButton = questionButton;
        [self addSubview:questionButton];
        [questionButton sizeToFit];
        
        [questionButton addTarget:self action:@selector(questionButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    //顶部阴影
    CGFloat topHeight = 20 * SCALE;
    
    self.topShadowView.frame = CGRectMake(0, 0, SCREENWIDTH, topHeight);
    
    
    //到期应还
    CGFloat refundY = 70 * SCALE;
    CGFloat refundH = 114 * SCALE;
    CGFloat refundW = 150;
    
    self.refundNumberView.frame = CGRectMake(0, refundY, refundW, refundH);
    self.refundNumberView.centerX = SCREENWIDTH/2;
    self.refundNumberView.centerY = 100 * SCALE;
    
    self.questionButton.x = CGRectGetMaxX(self.refundNumberView.frame) - self.questionButton.width - 10 * SCALE;
    self.questionButton.centerY = self.refundNumberView.y + 27  * SCALE;
    
    
    self.middleShadowView.frame = CGRectMake(0, 220 * SCALE + self.overDueHeight, SCREENWIDTH, topHeight);
    
    CGFloat overX = 30 * SCALE;
    CGFloat overH = self.overDueHeight;
    CGFloat overW = self.width - 2 * overX;
    CGFloat overY = self.middleShadowView.y - 100 * SCALE;
    self.overDueLabel.frame = CGRectMake(30 * SCALE, overY, overW, overH);
    
    //还款倒计时
    CGFloat timeY = 290 * SCALE + self.overDueHeight;
    
    self.refundTimeNumberView.frame = CGRectMake(0, timeY, refundW, refundH);;
    self.refundTimeNumberView.centerX = SCREENWIDTH/4;
    self.refundTimeNumberView.centerY = 330 * SCALE + self.overDueHeight;
    
    //还款日期
    self.refundDayNumberView.frame = self.refundTimeNumberView.frame;
    self.refundDayNumberView.centerX = SCREENWIDTH * 3/4;
    
    //警告
    CGFloat warnY = 420 * SCALE + self.overDueHeight;
    CGFloat warnX = 30 * SCALE;
    CGFloat warnH = 126 * SCALE;
    CGFloat warnW = SCREENWIDTH - 2 * warnX;
    
    self.warningShadowView.frame = CGRectMake(warnX, warnY, warnW, warnH);
    
    CGFloat labelX = 36 * SCALE;
    CGFloat labelW = warnW - labelX * 2;
    CGFloat labelH = warnH/2;
    
    self.warningLabel.frame = CGRectMake(labelX, warnX, labelW, labelH);
    
    //申请状态按钮
    CGFloat buttonH = 100 * SCALE;
    self.refundButton.frame = CGRectMake(0, self.height - buttonH, SCREENWIDTH, buttonH);
    
    
}

- (void)setLending:(SDLending *)lending{
    
    _lending = lending;
    
    FDLog(@"lending - %@",lending);
    
    self.refundNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",lending.stillAmount];
    self.refundTimeNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",lending.repaymentDay];
    self.refundDayNumberView.numberLabel.text = [FDDateFormatter interceptTimeStampFromStr:lending.reimDate];
    
    if ([lending.overdueDay integerValue] > 0) {
        
        self.overDueHeight = 60 * SCALE;
        
        [self setNeedsLayout];
        NSString *borrowingAmount = [NSString stringWithFormat:@"%@",@(lending.borrowingAmount)];
        
        self.overDueLabel.text = [NSString stringWithFormat:@"借款金额%@ + 逾期管理费%@",borrowingAmount,@(lending.lateAmount)];
        
//        [self.refundNumberView.descriptionButton setImage:[UIImage imageNamed:@"small_white_image"] forState:UIControlStateNormal];
        
        [self.refundTimeNumberView.descriptionButton setTitle:@" 已逾期(天)" forState:UIControlStateNormal];
        
        self.refundTimeNumberView.numberLabel.text = lending.overdueDay;
        
        self.refundTimeNumberView.numberLabel.textColor = FDColor(255, 132, 0);
        self.warningLabel.text = @"逾期会产生逾期管理费,并对您的信用造成严重影响, 请务必按时还款";
        
    }
    
    
}

- (void)questionButtonDidClicked:(UIButton *)button{
    
    button.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.userInteractionEnabled = YES;
    });

    [@"待还金额=借款金额-优惠券+逾期管理费-已还金额" showNotice];
    
}



@end










