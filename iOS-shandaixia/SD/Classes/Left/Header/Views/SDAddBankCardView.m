//
//  SDAddBankCardView.m
//  SD
//
//  Created by 余艾星 on 17/2/27.
//  Copyright © 2017年 余艾星. All rights reserved.
//  新项目


#import "SDAddBankCardView.h"
#import "SDInputView.h"
#import "SDImageRightButton.h"
#import "SDBankCard.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SDAddBankCardView ()


@property (nonatomic, weak) UIImageView *cardImageView;

@end

@implementation SDAddBankCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = 100 * SCALE;
        CGFloat blank = 20 * SCALE;
        
        //银行卡号
        SDInputView *bankCardView = [[SDInputView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height) title:@"银行卡号" placeholder:@"请输入银行卡号"];
        self.bankCardView = bankCardView;
        [self addSubview:bankCardView];
        bankCardView.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        bankCardView.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        bankCardView.inputTextField.width += 20;
        
        //所属银行
        SDInputView *bankView = [[SDInputView alloc] initWithFrame:CGRectMake(0, height, SCREENWIDTH, height) title:@"所属银行" placeholder:@""];
        bankView.inputTextField.hidden = YES;
        bankView.chooseButton.hidden = NO;
        
        self.bankView = bankView;
        [self addSubview:bankView];
        UIImageView *cardImageView = [[UIImageView alloc] init];
        [bankView addSubview:cardImageView];
        self.cardImageView = cardImageView;
        CGFloat cardW = 40 * SCALE;
        cardImageView.frame = CGRectMake(bankView.chooseButton.x - cardW, (height - cardW)/2, cardW, cardW);
        
        //开户地区
//        SDInputView *districtView = [[SDInputView alloc] initWithFrame:CGRectMake(0, height * 2, SCREENWIDTH, height) title:@"设为默认" placeholder:@""];
//        districtView.inputTextField.hidden = YES;
//        districtView.chooseButton.hidden = NO;
//        self.districtView = districtView;
//        [self addSubview:districtView];
        
        
        //手机号
//        CGFloat phoneY = height * 2 + blank;
//        SDInputView *phoneView = [[SDInputView alloc] initWithFrame:CGRectMake(0, phoneY, SCREENWIDTH, height) title:@"手机号" placeholder:@""];
//        phoneView.inputTextField.text = [FDUserDefaults objectForKey:FDUserAccount];
//        phoneView.inputTextField.enabled = NO;
//        //small_white_image
//        phoneView.titlesButton.hidden = NO;
//        
//        [phoneView.titlesButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [phoneView.titlesButton setTitleColor:FDColor(153, 153, 153) forState:UIControlStateDisabled];
//        [phoneView.titlesButton setTitleColor:FDColor(70, 153, 253) forState:UIControlStateNormal];
//        
//        
//        self.phoneView = phoneView;
//        [self addSubview:phoneView];
//        
//        //验证码
//        SDInputView *verifyCodeView = [[SDInputView alloc] initWithFrame:CGRectMake(0, phoneY + height, SCREENWIDTH, height) title:@"验证码" placeholder:@"短信验证码"];
//        self.verifyCodeView = verifyCodeView;
//        [self addSubview:verifyCodeView];
//        verifyCodeView.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
//        
        CGFloat lineBlank = 30 * SCALE;
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(lineBlank, height, self.width - 2 * lineBlank, 1)];
        [self addSubview:line1];
        line1.backgroundColor = FDColor(240, 240, 240);
        
//        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(lineBlank, 2 *height, self.width - 2 * lineBlank, 1)];
//        [self addSubview:line2];
//        line2.backgroundColor = FDColor(240, 240, 240);
//
//        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(lineBlank,3 * height + blank, self.width - 2 * lineBlank, 1)];
//        [self addSubview:line3];
//        line3.backgroundColor = FDColor(240, 240, 240);

        
        
    }
    return self;
}

- (void)setBankCard:(SDBankCard *)bankCard{
    
    _bankCard = bankCard;
    
    if (bankCard.bankName) {
        
        self.bankView.chooseButton.titles.text = bankCard.bankName;
    }else{
    
        self.bankView.chooseButton.titles.text = @"请选择";
    }
    
    
    
    self.bankCard.cardNumber = bankCard.cardNumber;
    
    if (bankCard.logoUrl) {
        
        CGFloat titleW = [bankCard.bankName sizeOfMaxScreenSizeInFont:30 * SCALE].width + 15;
        
        CGFloat width = titleW + 90 * SCALE;
        
        self.cardImageView.x = SCREENWIDTH - width;
        
        [self.cardImageView sd_setImageWithURL:[NSURL URLWithString:bankCard.logoUrl]];
    }
    
    
}


@end
