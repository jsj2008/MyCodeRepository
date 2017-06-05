//
//  SDLoanDetailView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/20.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoanDetailView.h"
#import "SDNumberView.h"
#import "SDMyLoanDetail.h"
#import "SDMyLoan.h"
#import "SDAlignBothSideView.h"

@interface SDLoanDetailView()

//应还款总额
@property (nonatomic, weak) UIButton *refundMoneyButton;

//是否逾期
@property (nonatomic, weak) SDNumberView *priceNumberView;

// 是否逾期
//@property (nonatomic, weak) UILabel *overdueStateLabel;

//借款金额
@property (nonatomic, weak) SDAlignBothSideView *loanMoneyLabel;

//还款日期
@property (nonatomic, weak) SDAlignBothSideView *refundTimeLabel;

//借款期限
@property (nonatomic, weak) SDAlignBothSideView *loanTimeLabel;

//到账金额
@property (nonatomic, weak) SDAlignBothSideView *receivedMoneyLabel;

//手续费
@property (nonatomic, weak) SDAlignBothSideView *chargeLabel;

//优惠券
@property (nonatomic, weak) SDAlignBothSideView *discountLabel;

//虚线
@property (nonatomic, weak) UIImageView *lineImageView;

@end

@implementation SDLoanDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //        应还款总额
        UIButton *refundMoneyButton = [UIButton buttonWithTitle:@"  应还款总额(元)" titleColor:FDColor(34, 34, 34) titleFont:28 * SCALE imageNamed:@"small_icon"];
        
        self.refundMoneyButton = refundMoneyButton;
        [self addSubview:refundMoneyButton];
        
        //        是否逾期
        SDNumberView *priceNumberView = [[SDNumberView alloc] init];
        self.priceNumberView = priceNumberView;
        [self addSubview:priceNumberView];
        priceNumberView.numberLabel.font = [UIFont systemFontOfSize:50 * SCALE];
        priceNumberView.numberLabel.textColor = FDColor(34, 34, 34);
        priceNumberView.descriptionButton.titleLabel.font = [UIFont systemFontOfSize:26 * SCALE];
        [priceNumberView.descriptionButton setTitleColor:FDColor(243, 143, 49) forState:UIControlStateNormal];
        
        //        UILabel *overdueStateLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        //        self.overdueStateLabel = overdueStateLabel;
        //        [self addSubview:overdueStateLabel];
        
        
        //借款金额
        //        UILabel *loanMoneyLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        //        self.loanMoneyLabel = loanMoneyLabel;
        //        [self addSubview:loanMoneyLabel];
        
        SDAlignBothSideView *loanMoneyLabel = [SDAlignBothSideView alignViewWithPropFont:24 * SCALE propColor:FDColor(102, 102, 102) desFont:24 * SCALE desColor:FDColor(102, 102, 102)];
        self.loanMoneyLabel = loanMoneyLabel;
        [self addSubview:loanMoneyLabel];
        
        
        //还款日期
        //        UILabel *refundTimeLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        //        self.refundTimeLabel = refundTimeLabel;
        //        [self addSubview:refundTimeLabel];
        SDAlignBothSideView *refundTimeLabel = [SDAlignBothSideView alignViewWithPropFont:24 * SCALE propColor:FDColor(102, 102, 102) desFont:24 * SCALE desColor:FDColor(102, 102, 102)];
        self.refundTimeLabel = refundTimeLabel;
        [self addSubview:refundTimeLabel];
        
        //借款期限
        //        UILabel *loanTimeLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        //        self.loanTimeLabel = loanTimeLabel;
        //        [self addSubview:loanTimeLabel];
        SDAlignBothSideView *loanTimeLabel = [SDAlignBothSideView alignViewWithPropFont:24 * SCALE propColor:FDColor(102, 102, 102) desFont:24 * SCALE desColor:FDColor(102, 102, 102)];
        self.loanTimeLabel = loanTimeLabel;
        [self addSubview:loanTimeLabel];
        
        //到账金额
        //        UILabel *receivedMoneyLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        //        self.receivedMoneyLabel = receivedMoneyLabel;
        //        [self addSubview:receivedMoneyLabel];
        SDAlignBothSideView *receivedMoneyView = [SDAlignBothSideView alignViewWithPropFont:24 * SCALE propColor:FDColor(102, 102, 102) desFont:24 * SCALE desColor:FDColor(102, 102, 102)];
        self.receivedMoneyLabel = receivedMoneyView;
        [self addSubview:receivedMoneyView];
        
        //手续费
        //        UILabel *chargeLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        //        self.chargeLabel = chargeLabel;
        //        [self addSubview:chargeLabel];
        SDAlignBothSideView *chargeLabel = [SDAlignBothSideView alignViewWithPropFont:24 * SCALE propColor:FDColor(102, 102, 102) desFont:24 * SCALE desColor:FDColor(102, 102, 102)];
        self.chargeLabel = chargeLabel;
        [self addSubview:chargeLabel];
        
        //优惠券
        //        UILabel *discountLabel = [UILabel labelWithText:@"" textColor:FDColor(102, 102, 102) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        //        self.discountLabel = discountLabel;
        //        [self addSubview:discountLabel];
        SDAlignBothSideView *discountLabel = [SDAlignBothSideView alignViewWithPropFont:24 * SCALE propColor:FDColor(102, 102, 102) desFont:24 * SCALE desColor:FDColor(102, 102, 102)];
        self.discountLabel = discountLabel;
        [self addSubview:discountLabel];
        
        //虚线
        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(231, 231, 231)]];
        [self addSubview:lineImageView];
        self.lineImageView = lineImageView;
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    //应还款总额
    CGFloat refundW = self.width/2.5;
    CGFloat refundH = 54 * SCALE;
    CGFloat refundY = 34 * SCALE;
    CGFloat refundX = (self.width - refundW)/2;
    self.refundMoneyButton.frame = CGRectMake(refundX, refundY, refundW, refundH);
    
    //是否逾期
    CGFloat outW = self.width/3;
    CGFloat outH = 102 * SCALE;
    CGFloat outY = CGRectGetMaxY(self.refundMoneyButton.frame) + 65 * SCALE;
    CGFloat outX = (self.width - outW)/2;
    self.priceNumberView.frame = CGRectMake(outX, outY, outW, outH);
    
    //    CGFloat outW = self.width / 3;
    //    CGFloat outH = 50 * SCALE;
    //    CGFloat outY = 34 * SCALE;
    //    CGFloat outX = (self.width - outW) / 2;
    //    self.overdueStateLabel.frame = CGRectMake(outX, outY, outW, outH);
    
    //虚线
    CGFloat lineX = 30 * SCALE;
    CGFloat lineW = self.width - 2 * lineX;
    CGFloat lineH = 1 * SCALE;
    CGFloat lineY = CGRectGetMaxY(self.priceNumberView.frame) + 44 * SCALE;
    self.lineImageView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    //    CGFloat lineX = 30 * SCALE;
    //    CGFloat lineW = self.width - 2 * lineX;
    //    CGFloat lineH = 1 * SCALE;
    //    CGFloat lineY = CGRectGetMaxY(self.overdueStateLabel.frame) + 44 * SCALE;
    //    self.lineImageView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat cellX = 30 * SCALE;
    CGFloat cellHeight = 24 * SCALE;
    CGFloat cellWidth = self.width - 60 * SCALE;
    CGFloat marginH = 47 * SCALE;
    //借款金额
    CGFloat moneyY = CGRectGetMaxY(self.lineImageView.frame) + 54 * SCALE;
    self.loanMoneyLabel.frame = CGRectMake(cellX, moneyY, cellWidth, cellHeight);
    
    //还款日期
    CGFloat refundTimeY = CGRectGetMaxY(self.loanMoneyLabel.frame) + marginH;
    self.refundTimeLabel.frame = CGRectMake(cellX, refundTimeY, cellWidth, cellHeight);
    
    //借款期限
    CGFloat loanTimeY = CGRectGetMaxY(self.refundTimeLabel.frame) + marginH;
    self.loanTimeLabel.frame = CGRectMake(cellX, loanTimeY, cellWidth, cellHeight);
    
    //到账金额
    CGFloat receivedY = CGRectGetMaxY(self.loanTimeLabel.frame) + marginH;
    self.receivedMoneyLabel.frame = CGRectMake(cellX, receivedY, cellWidth, cellHeight);
    //    CGFloat receivedY = CGRectGetMaxY(self.loanTimeLabel.frame) + 46 * SCALE;
    //    self.receivedMoneyLabel.frame = CGRectMake(moneyX, receivedY, moneyW, moneyH);
    
    //手续费
    CGFloat chargeY = CGRectGetMaxY(self.receivedMoneyLabel.frame) + marginH;
    self.chargeLabel.frame = CGRectMake(cellX, chargeY, cellWidth, cellHeight);
    //    self.chargeLabel.frame = CGRectMake(refundTimeX, receivedY, moneyW, moneyH);
    
    //优惠券
    CGFloat discountY = CGRectGetMaxY(self.chargeLabel.frame) + marginH;
    self.discountLabel.frame = CGRectMake(cellX, discountY, cellWidth, cellHeight);
    //    self.discountLabel.frame = CGRectMake(self.width - moneyW * 0.9, receivedY, moneyW, moneyH);
    
    
    [self set];
    
}

- (void)set{
    
    //    self.priceNumberView.numberLabel.text = @"550.00";
    //    [self.priceNumberView.descriptionButton setTitle:@"审核中" forState:UIControlStateNormal];
    //    self.loanMoneyLabel.text = @"借款金额：500元";
    //    self.refundTimeLabel.text = @"还款日期：2016.12.12";
    //    self.loanTimeLabel.text = @"借款期限：7天";
    //    self.receivedMoneyLabel.text = @"到账金额：470元";
    //    self.chargeLabel.text = @"手续费：30元";
    //    self.discountLabel.text = @"优惠券：5元免息";
}

- (void)setMyLoanDetail:(SDMyLoanDetail *)myLoanDetail{
    
    _myLoanDetail = myLoanDetail;
    
    self.priceNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",myLoanDetail.actualReimAmount];
    
    if ([myLoanDetail.status integerValue] > 2) {
        
        self.priceNumberView.numberLabel.text = [NSString stringWithFormat:@"%@",myLoanDetail.stillAmount];
    }
    
    self.loanMoneyLabel.propLabel.text = @"借款金额";
    self.loanMoneyLabel.descriptionLabel.text = [NSString stringWithFormat:@"%@元", myLoanDetail.borrowingAmount];
    
    self.refundTimeLabel.propLabel.text = @"还款日期";
    self.refundTimeLabel.descriptionLabel.text = [NSString stringWithFormat:@"%@", [FDDateFormatter interceptTimeStampFromStr:[NSString stringWithFormat:@"%@",myLoanDetail.reimDate]]];
    
    self.loanTimeLabel.propLabel.text = @"借款期限";
    self.loanTimeLabel.descriptionLabel.text = [NSString stringWithFormat:@"%@天", @(myLoanDetail.applyNper)];
    
    self.receivedMoneyLabel.propLabel.text = @"到账金额";
    self.receivedMoneyLabel.descriptionLabel.text = [NSString stringWithFormat:@"%@元", myLoanDetail.actualAccountAmount];
    
    self.chargeLabel.propLabel.text = @"手续费";
    self.chargeLabel.descriptionLabel.text = [NSString stringWithFormat:@"%@元", myLoanDetail.poundageAmount];
    
    self.discountLabel.propLabel.text = @"优惠券";
    self.discountLabel.descriptionLabel.text = [NSString stringWithFormat:@"%@元免息", myLoanDetail.preferentialAmount];
    
    //    self.loanMoneyLabel.text = [NSString stringWithFormat:@"借款金额：%@元",myLoanDetail.borrowingAmount];
    //    self.refundTimeLabel.text = [NSString stringWithFormat:@"还款日期：%@",[FDDateFormatter interceptTimeStampFromStr:[NSString stringWithFormat:@"%@",myLoanDetail.reimDate]]];
    //    self.loanTimeLabel.text = [NSString stringWithFormat:@"借款期限：%@天",@(myLoanDetail.applyNper)];
    //    self.receivedMoneyLabel.text = [NSString stringWithFormat:@"到账金额：%@元",myLoanDetail.actualAccountAmount];
    //    self.chargeLabel.text = [NSString stringWithFormat:@"手续费：%@元",myLoanDetail.poundageAmount];
    //    self.discountLabel.text = [NSString stringWithFormat:@"优惠券：%@元免息",myLoanDetail.preferentialAmount];
    
    
    
    //订单状态,状态 -1订单关闭，0待审核，1审核中，2审核失败， 3等待放款， 4放款失败， 5放款成功， 6待回款，7已逾期， 8还款成功
    
    NSString *status;
    UIColor *color;
    switch ([myLoanDetail.status integerValue]) {
        case -1:
            status = @"订单关闭";
            color = SDMyLoanStatusCloseColor;
            break;
        case 0:
            status = @"待审核";
            color = SDMyLoanStatusPreCheckColor;
            break;
        case 1:
            status = @"审核中";
            color = SDMyLoanStatusCheckingColor;
            break;
        case 2:
            status = @"审核失败";
            color = SDMyLoanStatusFailedColor;
            break;
        case 3:
            status = @"等待放款";
            color = SDMyLoanStatusLendingColor;
            break;
        case 4:
            status = @"放款中";
            color = SDMyLoanStatusPreCheckColor;
            break;
        case 5:
            status = @"放款成功";
            color = SDMyLoanStatusLendSuccessColor;
            break;
        case 6:
            status = @"待回款";
            color = SDMyLoanStatusWaitRefundColor;
            break;
        case 7:
            status = @"已逾期";
            color = SDMyLoanStatusOverdueColor;
            
            break;
        case 8:
            status = @"还款成功";
            color = SDMyLoanStatusRufundSuccessColor;
            break;
            
        default:
            break;
    }
    
    //    self.overdueStateLabel.text = status;
    //    self.overdueStateLabel.textColor = color;
    //    [self.overdueStateLabel setTitle:status forState:UIControlStateNormal];
    //    [self.overdueStateLabel setTitleColor:color forState:UIControlStateNormal];
    [self.priceNumberView.descriptionButton setTitle:status forState:UIControlStateNormal];
    [self.priceNumberView.descriptionButton setTitleColor:color forState:UIControlStateNormal];
}

@end









