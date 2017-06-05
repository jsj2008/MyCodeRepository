//
//  SDRefundCardView.m
//  SD
//
//  Created by 余艾星 on 17/3/13.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDRefundCardView.h"
#import "SDBankCard.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDLending.h"

@interface SDRefundCardView ()<UITextFieldDelegate>


@property (nonatomic, weak) UILabel *cardNameLabel;

@property (nonatomic, weak) UILabel *cardNumberLabel;


@property (nonatomic, weak) UIImageView *refundImageView;



@property (nonatomic, weak) UIButton *allRefundButton;

@end


@implementation SDRefundCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = SDWhiteColor;
        
        UILabel *cardNameLabel = [UILabel labelWithText:@"" textColor:FDColor(34, 34, 34) font:(30 * SCALE) textAliment:NSTextAlignmentLeft];
        self.cardNameLabel = cardNameLabel;
        [self addSubview:cardNameLabel];
        
        
        UIImageView *bankIconImageView = [[UIImageView alloc] init];
        self.bankIconImageView = bankIconImageView;
        [self addSubview:bankIconImageView];
        
        UILabel *cardNumberLabel = [UILabel labelWithText:@"" textColor:FDColor(153, 153, 153) font:(24 * SCALE) textAliment:NSTextAlignmentLeft];
        self.cardNumberLabel = cardNumberLabel;
        [self addSubview:cardNumberLabel];
        
        UIButton *chooseButton = [UIButton buttonWithImage:@"icon_next" backImageNamed:nil];
        [chooseButton sizeToFit];
        self.chooseButton = chooseButton;
        [self addSubview:chooseButton];
        chooseButton.hidden = YES;
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(220, 220, 220)]];
        self.lineImageView = lineImageView;
        [self addSubview:lineImageView];
        
        UIImageView *refundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_money"]];
        self.refundImageView = refundImageView;
        [self addSubview:refundImageView];
        
        UITextField *refundTextField = [UITextField textFieldWithFont:34 * SCALE color:FDColor(34, 34, 34) placeholder:@"总还款金额"];
        self.refundTextField = refundTextField;
        [self addSubview:refundTextField];
        refundTextField.delegate = self;
        refundTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [refundTextField addTarget:self action:@selector(refundTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        
        refundTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UIButton *allRefundButton = [UIButton buttonWithTitle:@"全额输入" titleColor:FDColor(70, 151, 251) titleFont:26 * SCALE];
        self.allRefundButton = allRefundButton;
        [self addSubview:allRefundButton];
        
        [allRefundButton addTarget:self action:@selector(allRefundButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat iconX = 30 * SCALE;
    CGFloat iconW = 80 * SCALE;
    CGFloat iconH = iconW;
    CGFloat iconY = 25 * SCALE;
    self.bankIconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(self.bankIconImageView.frame) + 24 * SCALE;
    CGFloat nameW = 200;
    CGFloat nameY = iconY;
    CGFloat nameH = [@"招" sizeOfMaxScreenSizeInFont:30 * SCALE].height;
    self.cardNameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    
    CGFloat numberH = [@"招" sizeOfMaxScreenSizeInFont:24 * SCALE].height;
    CGFloat numberY = CGRectGetMaxY(self.bankIconImageView.frame) - numberH;
    CGFloat numberX = nameX;
    CGFloat numberW = nameW;
    self.cardNumberLabel.frame = CGRectMake(numberX, numberY, numberW, numberH);
    
    self.chooseButton.centerY = 120 * SCALE/2;
    self.chooseButton.x = self.width - iconX - self.chooseButton.width;
    
    self.lineImageView.frame = CGRectMake(iconX, 120 * SCALE - 1, self.width - 2 * iconX, 1 * SCALE);
    
    CGFloat refundCenterY = 200 * SCALE;
    CGFloat refundX = 50 * SCALE;
    [self.refundImageView sizeToFit];
    self.refundImageView.centerY = refundCenterY;
    self.refundImageView.x = refundX;
    
    
    CGFloat allW = [@"全额输入" sizeOfMaxScreenSizeInFont:26 * SCALE].width;
    CGFloat allX = self.width - 30 * SCALE - allW;
    CGFloat allH = 26 * SCALE;
    self.allRefundButton.frame = CGRectMake(allX, 0, allW, allH);
    self.allRefundButton.centerY = refundCenterY;
    
    
    CGFloat textX = CGRectGetMaxX(self.refundImageView.frame) + 44 * SCALE;
    CGFloat textH = 50 * SCALE;
    CGFloat textW = allX - textX - 30 * SCALE;
    self.refundTextField.frame = CGRectMake(textX, 0, textW, textH);
    self.refundTextField.centerY = refundCenterY;

}

- (void)setBankCard:(SDBankCard *)bankCard{
    
    _bankCard = bankCard;
    
    self.cardNameLabel.text = bankCard.bankName;
    
    NSString *cardType;
    
    if ([bankCard.cardType isEqualToString:@"DC"]) {
        
        cardType = @"储蓄卡";
    }else{
        
        cardType = @"储蓄卡";
        
    }
    
    self.cardNumberLabel.text = [NSString stringWithFormat:@"尾号%@%@",[bankCard.cardNumber substringFromIndex:bankCard.cardNumber.length - 4],cardType];
    
    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankCard.logoUrl]];
    
    self.chooseButton.hidden = !bankCard.isDefault;
    
    
}

- (void)setLending:(SDLending *)lending{

    _lending = lending;
    
    self.refundTextField.placeholder = [NSString stringWithFormat:@"总还款金额%@元",lending.stillAmount];
    
}

- (void)allRefundButtonDidClicked{

    self.refundTextField.text = [NSString stringWithFormat:@"%@",self.lending.stillAmount];
    
}

- (void)refundTextFieldChanged:(UITextView *)textField{

    FDLog(@"------- textField - %@",textField.text);
    
    CGFloat num = [textField.text floatValue];
    
    if (num > [self.lending.stillAmount floatValue]) {
        
        textField.text = [NSString stringWithFormat:@"%@",self.lending.stillAmount];
        
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 当前输入的字符是'.'
    if ([string isEqualToString:@"."]) {
        
        // 已输入的字符串中已经包含了'.'或者""
        if ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""]) {
            
            return NO;
        } else {
            
            return YES;
        }
    } else {// 当前输入的不是'.'
        
        // 第一个字符是0时, 第二个不能再输入0
        if (textField.text.length == 1) {
            
            unichar str = [textField.text characterAtIndex:0];
            if (str == '0' && [string isEqualToString:@"0"]) {
                
                return NO;
            }
            
            if (str != '0' && str != '1') {// 1xx或0xx
                
                return YES;
            } else {
                
                if (str == '1') {
                    
                    return YES;
                } else {
                    
                    if ([string isEqualToString:@""]) {
                        
                        return YES;
                    } else {
                        
                        return NO;
                    }
                }
                
                
            }
        }
        
        // 已输入的字符串中包含'.'
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            
            NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
            [str insertString:string atIndex:range.location];
            
            if (str.length >= [str rangeOfString:@"."].location + 4) {
                
                return NO;
            }
            NSLog(@"str.length = %ld, str = %@, string.location = %ld", str.length, string, range.location);
            
            
        } else {
            
            if (textField.text.length > 5) {
                
                return range.location < 6;
            }
        }
        
        
    }
    
    
    return YES;
}

@end













