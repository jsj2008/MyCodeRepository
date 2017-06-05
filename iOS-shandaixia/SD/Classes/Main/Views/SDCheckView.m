//
//  SDCheckView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/3.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDCheckView.h"
#import "SDNumberView.h"
#import "SDLoan.h"
#import "SDLending.h"

@interface SDCheckView ()

//顶部阴影
@property (nonatomic,weak) UIView *topShadowView;
@property (nonatomic,weak) UIView *backView;

//中间虚线
@property (nonatomic,weak) UIView *middleLineView;

//到期应还
@property (nonatomic, weak) SDNumberView *refundNumberView;

//借款时间
@property (nonatomic, weak) SDNumberView *loanTimeNumberView;

//借款金额
@property (nonatomic, weak) SDNumberView *loanNumberView;

//到账金额
@property (nonatomic, weak) SDNumberView *receivedNumberView;

//手续费用
@property (nonatomic, weak) SDNumberView *chargeNumberView;

//申请状态图片
@property (nonatomic, weak) UIImageView *statusImageView;

//申请状态按钮
@property (nonatomic, weak) UIButton *statusButton;

//审核文本
@property (nonatomic, weak) UILabel *checkLabel;

@end


@implementation SDCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = SDWhiteColor;
        
        //顶部虚线
        UIView *backView = [[UIView alloc] init];
        self.backView = backView;
        [self addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = FDColor(243, 245, 249);
        
        UIView *middleLineView = [[UIView alloc] init];
        self.middleLineView = middleLineView;
        [backView addSubview:middleLineView];
        self.middleLineView.backgroundColor = FDColor(240, 240, 240);
        
        //到期应还
        SDNumberView *refundNumberView = [[SDNumberView alloc] init];
        self.refundNumberView = refundNumberView;
        [backView addSubview:refundNumberView];
        refundNumberView.numberLabel.textColor = FDColor(255, 132, 0);
        refundNumberView.numberLabel.text = @"530";
        [refundNumberView.descriptionButton setTitle:@" 到期应还(元)" forState:UIControlStateNormal];
        refundNumberView.numberLabel.font = [UIFont systemFontOfSize:50 * SCALE];
        [refundNumberView.descriptionButton setImage:[UIImage imageNamed:@"card_icon"] forState:UIControlStateNormal];
        
        //借款时间
        SDNumberView *loanTimeNumberView = [[SDNumberView alloc] init];
        self.loanTimeNumberView = loanTimeNumberView;
        [backView addSubview:loanTimeNumberView];
        loanTimeNumberView.numberLabel.text = @"7";
        [loanTimeNumberView.descriptionButton setTitle:@" 借款时间(天)" forState:UIControlStateNormal];
        loanTimeNumberView.numberLabel.textColor = FDColor(34, 34, 34);
        loanTimeNumberView.numberLabel.font = [UIFont systemFontOfSize:50 * SCALE];
        [loanTimeNumberView.descriptionButton setImage:[UIImage imageNamed:@"icon2"] forState:UIControlStateNormal];

        //借款金额
        SDNumberView *loanNumberView = [[SDNumberView alloc] init];
        self.loanNumberView = loanNumberView;
        [backView addSubview:loanNumberView];
        loanNumberView.numberLabel.text = @"500";
        [loanNumberView.descriptionButton setTitle:@"借款金额(元)" forState:UIControlStateNormal];
        
        //到账金额
        SDNumberView *receivedNumberView = [[SDNumberView alloc] init];
        self.receivedNumberView = receivedNumberView;
        [backView addSubview:receivedNumberView];
        receivedNumberView.numberLabel.text = @"500";
        [receivedNumberView.descriptionButton setTitle:@"到账金额(元)" forState:UIControlStateNormal];
        
        //手续费用
        SDNumberView *chargeNumberView = [[SDNumberView alloc] init];
        self.chargeNumberView = chargeNumberView;
        [backView addSubview:chargeNumberView];
        chargeNumberView.numberLabel.text = @"30";
        [chargeNumberView.descriptionButton setTitle:@"手续费用(元)" forState:UIControlStateNormal];
        
        
        chargeNumberView.numberLabel.textColor = receivedNumberView.numberLabel.textColor = loanNumberView.numberLabel.textColor = FDColor(34, 34, 34);
        chargeNumberView.numberLabel.font = receivedNumberView.numberLabel.font = loanNumberView.numberLabel.font = [UIFont systemFontOfSize:28 * SCALE];
        
        
        [refundNumberView.descriptionButton setTitleColor:FDColor(102, 102, 102) forState:UIControlStateNormal];
        [loanTimeNumberView.descriptionButton setTitleColor:FDColor(102, 102, 102) forState:UIControlStateNormal];
        [chargeNumberView.descriptionButton setTitleColor:FDColor(102, 102, 102) forState:UIControlStateNormal];
        [receivedNumberView.descriptionButton setTitleColor:FDColor(102, 102, 102) forState:UIControlStateNormal];
        [loanNumberView.descriptionButton setTitleColor:FDColor(102, 102, 102) forState:UIControlStateNormal];
        
        refundNumberView.descriptionButton.titleLabel.font = loanTimeNumberView.descriptionButton.titleLabel.font = chargeNumberView.descriptionButton.titleLabel.font = loanNumberView.descriptionButton.titleLabel.font = receivedNumberView.descriptionButton.titleLabel.font = [UIFont systemFontOfSize:24 * SCALE];
        
        
        //申请状态图片
        UIImageView *statusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"small_progress-bar1"]];
        [statusImageView sizeToFit];
        self.statusImageView = statusImageView;
        [backView addSubview:statusImageView];
        
        //申请状态按钮
        UIButton *statusButton = [UIButton buttonWithTitle:@"审核中" titleColor:[UIColor whiteColor] titleFont:36 * SCALE];
        statusButton.backgroundColor = FDColor(190, 190, 190);
        self.statusButton = statusButton;
        [self addSubview:statusButton];

        //审核文本
        UILabel *checkLabel = [UILabel labelWithText:@"审核中: 您提交的借款申请已受理, 请耐心等待审核." textColor:FDColor(102,102,102) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        self.checkLabel = checkLabel;
        [backView addSubview:checkLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //顶部阴影
    CGFloat topHeight = 20 * SCALE;
    CGFloat backH = (204 + 446) * SCALE;
    
    self.backView.frame = CGRectMake(0, topHeight, SCREENWIDTH, backH);
    
    
    //到期应还
    CGFloat refundY = 70 * SCALE;
    CGFloat refundH = 90 * SCALE;
    CGFloat refundW = 120;
    
    self.refundNumberView.frame = CGRectMake(0, refundY, refundW, refundH);
    self.refundNumberView.centerX = SCREENWIDTH/4;
    
    self.loanTimeNumberView.frame = self.refundNumberView.frame;
    self.loanTimeNumberView.centerX = SCREENWIDTH * 3/4;
    
    
    //到账金额
    CGFloat receivedY = 244 * SCALE;
    CGFloat receivedH = 72 * SCALE;
    CGFloat receivedW = [@"借款金额(0元)" sizeOfMaxScreenSizeInFont:24 * SCALE].width;
    CGFloat receivedX = 30 * SCALE;
    
    self.receivedNumberView.frame = CGRectMake(receivedX, receivedY, receivedW, receivedH);
    self.receivedNumberView.centerX = SCREENWIDTH/2;
    
    self.middleLineView.frame = CGRectMake(receivedX, 204 * SCALE, SCREENWIDTH - 2 * receivedX, 1);
    
    //手续费用
    CGFloat blank = 126 * SCALE;
    self.chargeNumberView.frame = self.receivedNumberView.frame;
    self.chargeNumberView.x = CGRectGetMaxX(self.receivedNumberView.frame) + blank;
    
    //借款金额
    self.loanNumberView.frame = self.receivedNumberView.frame;
    self.loanNumberView.x = self.receivedNumberView.x - blank - receivedW;
    
    //申请状态图片
    CGFloat imageY = CGRectGetMaxY(self.receivedNumberView.frame) + 78 * SCALE;
    self.statusImageView.y = imageY;
    self.statusImageView.centerX = self.width/2;
    
    //申请状态按钮
    CGFloat buttonH = 100 * SCALE;
    self.statusButton.frame = CGRectMake(0, self.height - buttonH, SCREENWIDTH, buttonH);
    
    //审核文本
    CGFloat checkH = 24 * SCALE;
    CGFloat checkY = backH - 62 * SCALE - checkH;
    self.checkLabel.frame = CGRectMake(0, checkY, SCREENWIDTH, checkH);
    
}

- (void)setLending:(SDLending *)lending{
    
    _lending = lending;
    
    if (lending.status == SDLendingStatusChecking || lending.status == SDLendingStatusWaitMoney || lending.status == SDLendingStatusLendFailed  || lending.status == SDLendingStatusLoaning) {
        
        self.statusImageView.image = [UIImage imageNamed:@"small_progress-bar1"];
    
        
        if (lending.status == SDLendingStatusWaitMoney || lending.status == SDLendingStatusLendFailed || lending.status == SDLendingStatusLoaning) {
            
            self.checkLabel.text = @"您提交的借款申请已通过，请等待放款";

            self.statusImageView.image = [UIImage imageNamed:@"home_progress-bar2"];
            [self.statusButton setTitle:@"放款中" forState:UIControlStateNormal];
        }
    
    }
    
    self.refundNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",lending.actualReimAmount];
    self.loanTimeNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",lending.applyNper];
    self.loanNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@(lending.borrowingAmount)];
    self.receivedNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@(lending.actualAccountAmount)];
    self.chargeNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",@(lending.poundageAmount)];
    
    
}


@end









