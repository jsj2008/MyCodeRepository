//
//  SDMyLoanCell.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/20.
//  Copyright © 2017年 tyiti. All rights reserved.
//



#import "SDMyLoanCell.h"
#import "SDMyLoan.h"
#import "FDDateFormatter.h"

@interface SDMyLoanCell ()

/** 图标 */
@property (nonatomic, weak) UIImageView *iconImageView;

/** 借款 */
@property (nonatomic, weak) UILabel *priceLabel;

/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 状态 */
@property (nonatomic, weak) UILabel *statusLabel;

/** 箭头 */
@property (nonatomic, weak) UIImageView *arrowImageView;




//逾期
@property (nonatomic, weak) UIImageView *outOfTimeImageView;

@end

@implementation SDMyLoanCell



#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"SDMyLoanCell";
    SDMyLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SDMyLoanCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        /** 图标 */
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        [iconImageView sizeToFit];
        
        /** 价格 */
        UILabel *priceLabel = [UILabel labelWithText:@"" textColor:FDColor(34, 34, 34) font:30 * SCALE textAliment:NSTextAlignmentLeft];
        [self.contentView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        /** 时间 */
        UILabel *timeLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 状态 */
        UILabel *statusLabel = [UILabel labelWithText:@"" textColor:[UIColor yellowColor] font:26 * SCALE textAliment:NSTextAlignmentRight];
        [self.contentView addSubview:statusLabel];
        self.statusLabel = statusLabel;

        
        /** 箭头 */
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_next"]];
        [self.contentView addSubview:arrowImageView];
        self.arrowImageView = arrowImageView;
        [arrowImageView sizeToFit];
        
        /** 底部阴影 */
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(231, 231, 231)]];
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
        
        
        /** 逾期 */
        UIImageView *outOfTimeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_yq"]];
        [self.contentView addSubview:outOfTimeImageView];
        self.outOfTimeImageView = outOfTimeImageView;
        [outOfTimeImageView sizeToFit];
        outOfTimeImageView.hidden = YES;
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //图标
    CGFloat iconX = 30 * SCALE;
    self.iconImageView.frame = CGRectMake(iconX, (self.height - self.iconImageView.height)/2, self.iconImageView.width, self.iconImageView.height);
    
    //借款
    CGFloat priceX = CGRectGetMaxX(self.iconImageView.frame) + 10 * SCALE;
    CGFloat priceY = self.iconImageView.y + 4 * SCALE;
    CGFloat priceW = 100;
    CGFloat priceH = 30 * SCALE;
    
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    //时间
    CGFloat timeH = 24 * SCALE;
    CGFloat timeY = CGRectGetMaxY(self.iconImageView.frame) - timeH;
    self.timeLabel.frame = CGRectMake(priceX, timeY, self.width/2, timeH);
    
    //箭头
    CGFloat arrowX = self.width - self.arrowImageView.width - 30 * SCALE;
    CGFloat arrowY = (self.height - self.arrowImageView.height)/2;
    self.arrowImageView.frame = CGRectMake(arrowX, arrowY, self.arrowImageView.width, self.arrowImageView.height);
    
    //状态
    CGFloat statusW = self.width * 0.25;
    CGFloat statusH = 26 * SCALE;
    CGFloat statusX = arrowX - statusW - 10 * SCALE;
    CGFloat statusY = (self.height - statusH)/2;
    self.statusLabel.frame = CGRectMake(statusX, statusY, statusW, statusH);
    
    
    //底部虚线
    self.lineView.frame = CGRectMake(iconX, self.height - 1, self.width - iconX * 2, 1 * SCALE);
 
    //逾期
    self.outOfTimeImageView.x = (self.width - self.outOfTimeImageView.width)/2;
    self.outOfTimeImageView.y = 0;
    
    
    [self set];
    
    
}

- (void)set{

//    self.statusLabel.textColor = FDColor(242, 135, 48);
//    
//    self.priceLabel.text = @"1000.00";
//    self.timeLabel.text = @"2016.10.10-2016.12.15";
//    self.statusLabel.text = @"审核中";
//    
}

- (void)setMyLoan:(SDMyLoan *)myLoan{

    _myLoan = myLoan;
    
    
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@",myLoan.borrowingAmount];
    
    NSString *start = [FDDateFormatter interceptTimeStampFromStr:myLoan.lendingDate];
    NSString *end = [FDDateFormatter interceptTimeStampFromStr:myLoan.reimDate];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ - %@",start,end];
    
    
    //订单状态,状态 -1订单关闭，0待审核，1审核中，2审核失败， 3等待放款， 4放款失败， 5放款成功， 6待回款，7已逾期， 8还款成功
    
    NSString *status;
    switch ([myLoan.status integerValue]) {
        case -1:
            status = @"订单关闭";
            self.statusLabel.textColor = SDMyLoanStatusCloseColor;
            break;
        case 0:
            status = @"待审核";
            self.statusLabel.textColor = SDMyLoanStatusPreCheckColor;
            break;
        case 1:
            status = @"审核中";
            self.statusLabel.textColor = SDMyLoanStatusCheckingColor;
            break;
        case 2:
            status = @"审核失败";
            self.statusLabel.textColor = SDMyLoanStatusFailedColor;
            break;
        case 3:
            status = @"等待放款";
            self.statusLabel.textColor = SDMyLoanStatusLendingColor;
            break;
        case 4:
            status = @"放款中";
            self.statusLabel.textColor = SDMyLoanStatusPreCheckColor;
            break;
        case 5:
            status = @"放款成功";
            self.statusLabel.textColor = SDMyLoanStatusLendSuccessColor;
            break;
        case 6:
            status = @"待回款";
            self.statusLabel.textColor = SDMyLoanStatusWaitRefundColor;
            break;
        case 7:
            status = @"已逾期";
            self.statusLabel.textColor = SDMyLoanStatusOverdueColor;
            _outOfTimeImageView.hidden = NO;
            break;
        case 8:
            status = @"还款成功";
            self.statusLabel.textColor = SDMyLoanStatusRufundSuccessColor;
            break;
        case 10:
            status = @"放款中";
            self.statusLabel.textColor = SDMyLoanStatusLendSuccessColor;
            break;
            
        default:
            break;
    }
    
    self.statusLabel.text = status;
    
}



@end







