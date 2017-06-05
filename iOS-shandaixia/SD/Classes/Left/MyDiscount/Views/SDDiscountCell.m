//
//  SDDiscountCell.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/20.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDDiscountCell.h"
#import "SDDiscount.h"
#import "SDSpecialDiscount.h"

@interface SDDiscountCell ()

/** 背景图 */
@property (nonatomic, weak) UIImageView *backImageView;

/** 图标 */
@property (nonatomic, weak) UIImageView *iconImageView;

//左侧虚线
@property (nonatomic, weak) UIImageView *leftImageView;

/** 价钱 */
@property (nonatomic, weak) UILabel *priceLabel;

/** 免息券 */
@property (nonatomic, weak) UILabel *discountLabel;

/** 可用条件1 */
@property (nonatomic, weak) UILabel *conditionfFirstLabel;

/** 可用条件2 */
@property (nonatomic, weak) UILabel *conditionSecondLabel;

/** 可用时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 虚线 */
@property (nonatomic, weak) UIImageView *lineView;



@end

@implementation SDDiscountCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"SDDiscountCell";
    SDDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SDDiscountCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.backgroundColor = FDColor(240, 240, 240);
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(240, 240, 240)]];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /** 背景图 */
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hb_bg"]];
        [self.contentView addSubview:backImageView];
        self.backImageView = backImageView;
//        [backImageView sizeToFit];
 
        /** 图标 */
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_mx_money"]];
        [backImageView addSubview:iconImageView];
        self.iconImageView = iconImageView;
//        [iconImageView sizeToFit];
        
        /** 价格 */
        UILabel *priceLabel = [UILabel labelWithText:@"" textColor:FDColor(255,54,54) font:80 * SCALE textAliment:NSTextAlignmentLeft];
        [backImageView addSubview:priceLabel];
        self.priceLabel = priceLabel;

        
        /** 免息券 */
        UILabel *discountLabel = [UILabel labelWithText:@"免息券" textColor:FDColor(34, 34, 34) font:30 * SCALE textAliment:NSTextAlignmentLeft];
        discountLabel.font = [UIFont boldSystemFontOfSize:30 * SCALE];
        [backImageView addSubview:discountLabel];
        self.discountLabel = discountLabel;
        
        /** 可用条件1 */
        UILabel *conditionfFirstLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:20 * SCALE textAliment:NSTextAlignmentLeft];
        [backImageView addSubview:conditionfFirstLabel];
        self.conditionfFirstLabel = conditionfFirstLabel;
        
        /** 可用条件2 */
        UILabel *conditionSecondLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:20 * SCALE textAliment:NSTextAlignmentLeft];
        [backImageView addSubview:conditionSecondLabel];
        self.conditionSecondLabel = conditionSecondLabel;
        
        /** 可用时间 */
        UILabel *timeLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:20 * SCALE textAliment:NSTextAlignmentLeft];
        [backImageView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIButton *selectedButton = [UIButton buttonWithImage:@"btn_normal" backImageNamed:nil];
        [selectedButton setImage:[UIImage imageNamed:@"btn_press"] forState:UIControlStateSelected];
        selectedButton.hidden = YES;
        [selectedButton sizeToFit];
        
        self.selectedButton = selectedButton;
        
        [backImageView addSubview:selectedButton];
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"discount_imaginary-line"]];
        [backImageView addSubview:leftImageView];
        [leftImageView sizeToFit];
        self.leftImageView = leftImageView;

        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //背景图
    CGFloat backX = 30 * SCALE;
    CGFloat backW = self.width - backX * 2;
    CGFloat backY = 20 * SCALE;
    
    self.backImageView.frame = CGRectMake(backX, backY, backW, self.height - backY);
    
    //图标
    CGFloat iconW = 18 * SCALE;
    CGFloat iconX = 63 * SCALE;
    CGFloat iconH = 26 * SCALE;

    
    //借款
    CGFloat priceX = iconW + iconX + 12 * SCALE;
    CGFloat priceY = 96 * SCALE;
    CGFloat priceW = [@"999" sizeOfMaxScreenSizeInFont:80 * SCALE].width + 2;
    CGFloat priceH = 66 * SCALE;
    
    
    
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    //图标
    CGFloat iconY = CGRectGetMaxY(self.priceLabel.frame) - iconH * 1.1;
    self.iconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    

    //虚线
    CGFloat lineW = 1 * SCALE;
    CGFloat lineY = 50 * SCALE;
    CGFloat lineX = CGRectGetMaxX(self.priceLabel.frame) + 24 * SCALE;
    CGFloat lineH = self.height - 2 * lineY;
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    self.leftImageView.centerY = self.backImageView.height/2;
    self.leftImageView.x = lineX;
    
    //免息券
    CGFloat discountY = lineY;
    CGFloat discountX = lineX + 20 * SCALE;
    CGFloat discountH = 30 * SCALE;
    CGFloat discountW = self.width/2;
    
    self.discountLabel.frame = CGRectMake(discountX, discountY, discountW, discountH);
    
    
    //可用条件1
    CGFloat condition1H = 20 * SCALE;
    CGFloat condition1Y = CGRectGetMaxY(self.discountLabel.frame) + condition1H;
    
    self.conditionfFirstLabel.frame = CGRectMake(discountX, condition1Y, discountW, condition1H);
    
    //可用条件2
    CGFloat condition2Y = CGRectGetMaxY(self.conditionfFirstLabel.frame) + 14 * SCALE;
    
    self.conditionSecondLabel.frame = CGRectMake(discountX, condition2Y, discountW, condition1H);
    
    //可用时间
    CGFloat timeY = CGRectGetMaxY(self.conditionSecondLabel.frame) + 14 * SCALE;
    self.timeLabel.frame = CGRectMake(discountX, timeY, discountW, condition1H);
    
    self.selectedButton.x = self.backImageView.width - 48 * SCALE - self.selectedButton.width;
    self.selectedButton.centerY = self.backImageView.height/2;
    
}



- (void)setDiscount:(SDDiscount *)discount{

    _discount = discount;
    
    /** 价钱 */
    self.priceLabel.text = [NSString stringWithFormat:@"%@",@(discount.discountAmount)];
    
    /** 免息券 */
    
    NSInteger type = [discount.discountType integerValue];
    
    switch (type) {
        case 1:
            
            self.discountLabel.text = @"免息券";
            
            break;
        case 2:
            self.discountLabel.text = @"全额免息券";
            break;
        case 3:
            self.discountLabel.text = @"提额券";
            break;
        default:
            break;
    }
    
    
    
    
    /** 可用条件1 */
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",discount.remarks];
    
    
    NSRange range = [str rangeOfString:@","];
    
    
    self.conditionfFirstLabel.text = [str substringToIndex:range.location];
    
    /** 可用条件2 */
    self.conditionSecondLabel.text = [str substringFromIndex:range.location + 1];
    
    /** 可用时间 */
    NSString *start = [FDDateFormatter interceptTimeStampFromStr:discount.startDate];
    NSString *end = [FDDateFormatter interceptTimeStampFromStr:discount.periodValidity];
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",start,end];
    
}

- (void)setDiscountType:(NSString *)discountType{

    _discountType = discountType;
    
    if ([discountType isEqualToString:@"2"]) {
        
        self.priceLabel.textColor = self.discountLabel.textColor = FDColor(153, 153, 153);
        
        self.iconImageView.image = [UIImage imageNamed:@"discount_rmb_gray"];
        self.backImageView.image = [UIImage imageNamed:@"hb_bg_disable"];
    }
}

- (void)setSpecialDiscount:(SDSpecialDiscount *)specialDiscount{

    _specialDiscount = specialDiscount;
    
    /** 价钱 */
    self.priceLabel.text = [NSString stringWithFormat:@"%@",@(specialDiscount.discountAmount)];
    
    /** 免息券 */
    
    NSInteger type = [specialDiscount.pushType integerValue];
    
    switch (type) {
        case 1:
            
            self.discountLabel.text = @"系统推送";
            
            break;
        case 2:
            self.discountLabel.text = @"活动推送";
            break;
        case 3:
            self.discountLabel.text = @"提额券";
            break;
        default:
            break;
    }
    
    
    
    
    /** 可用条件1 */
    self.conditionfFirstLabel.text = [NSString stringWithFormat:@"满%@元可用",specialDiscount.amount];
    
    /** 可用条件2 */
    self.conditionSecondLabel.text = [NSString stringWithFormat:@"%@天周期以上可用一张",specialDiscount.cycle];
    
    /** 可用时间 */
    NSString *start = [FDDateFormatter interceptTimeStampFromStr:specialDiscount.startDate];
    NSString *end = [FDDateFormatter interceptTimeStampFromStr:specialDiscount.periodValidity];
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",start,end];
    
    
}

@end
