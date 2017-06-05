//
//  SDSubmitView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/25.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSubmitView.h"
#import "SDLoan.h"
#import "SDSpecialDiscount.h"

@interface SDSubmitView ()

@property (nonatomic, weak) UILabel *priceLabel;

@property (nonatomic, weak) UIView *lineView;

@end

@implementation SDSubmitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *priceLabel = [UILabel labelWithText:@"还款金额: ¥ 1000" textColor:FDColor(34, 34, 34) font:26 * SCALE textAliment:NSTextAlignmentLeft];
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        
        UIButton *submitButton = [UIButton buttonWithTitle:@"确认提交" titleColor:FDColor(153, 108, 0) titleFont:30 * SCALE];
        self.submitButton = submitButton;
        submitButton.backgroundColor = FDColor(255, 214, 49);
        [self addSubview:submitButton];
        
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        self.lineView = lineView;
        self.lineView.backgroundColor = FDColor(231, 231, 231);
        
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat buttonW = 206 * SCALE;
    CGFloat labelX = 30 * SCALE;
    CGFloat labelW = self.width - buttonW - labelX;
    CGFloat labelH = self.height;
    self.priceLabel.frame = CGRectMake(labelX, 0, labelW, labelH);
    
    self.submitButton.frame = CGRectMake(self.width - buttonW, 0, buttonW, self.height);
    
    
    CGFloat width = [@"还款金额:¥1000" sizeOfMaxScreenSizeInFont:26 * SCALE].width;
    self.lineView.width = 1 * SCALE;
    self.lineView.height = 30 * SCALE;
    self.lineView.centerY = self.height/2;
    self.lineView.x = labelX + width + 30 * SCALE;
    
    
}

#pragma mark - 生成一个带有属性的文字
- (NSMutableAttributedString *)attributedTextWithColor:(UIColor *)color font:(NSInteger)font str:(NSString *)str{
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str];
    //设置字号
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, str.length)];
    //设置文字颜色
    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str.length)];
    
    return attributedText;
    
}

- (void)setLoan:(SDLoan *)loan{

    _loan = loan;
    
    
    CGFloat sum = [loan.charge integerValue] + loan.price;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]  init];
    
    [str appendAttributedString:[self attributedTextWithColor:FDColor(34, 34, 34) font:26 * SCALE str:[NSString stringWithFormat:@"还款金额: ¥%@",@(sum)]]];
    
    [str appendAttributedString:[self attributedTextWithColor:FDColor(153, 153, 153) font:26 * SCALE str:[NSString stringWithFormat:@"        ¥%@ + ¥%@",@(loan.price),loan.charge]]];
    
    self.priceLabel.attributedText = str;
    
}

- (void)setSpecialDiscount:(SDSpecialDiscount *)specialDiscount{

    _specialDiscount = specialDiscount;
    
    
    CGFloat discount = specialDiscount.discountAmount;
    CGFloat sum = [_loan.charge integerValue] + _loan.price - discount;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]  init];
    
    [str appendAttributedString:[self attributedTextWithColor:FDColor(34, 34, 34) font:26 * SCALE str:[NSString stringWithFormat:@"还款金额: ¥%@",@(sum)]]];
    
    [str appendAttributedString:[self attributedTextWithColor:FDColor(153, 153, 153) font:26 * SCALE str:[NSString stringWithFormat:@"       ¥%@ + ¥%@",@(_loan.price),_loan.charge]]];
    
    [str appendAttributedString:[self attributedTextWithColor:FDColor(255, 130, 0) font:26 * SCALE str:[NSString stringWithFormat:@" - ¥%@",@(discount)]]];
    
    self.priceLabel.attributedText = str;
    
}

@end







