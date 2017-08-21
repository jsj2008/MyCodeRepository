//
//  CATotalBarView.m
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CATotalBarView.h"

@interface CATotalBarView ()

@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *payPriceLabel;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation CATotalBarView

- (instancetype)initWithFrame:(CGRect)frame totalPrice:(NSString *)totalPrice balance:(NSString *)balance canUseBalance:(BOOL)canUseBalance{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = Color_White;
        
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.payButton];
        
        self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：%@", totalPrice];
        [self.totalPriceLabel sizeToFit];
        self.totalPriceLabel.centerY = self.height / 2;
        
        self.payButton.centerY = self.totalPriceLabel.centerY;
        
        if ( canUseBalance && [totalPrice floatValue] > [balance floatValue] && [balance floatValue] > 0 ) {
            [self addSubview:self.payPriceLabel];
            self.payPriceLabel.text = [NSString stringWithFormat:@"还需：%.2f", [totalPrice floatValue] - [balance floatValue] ];
            [self.payPriceLabel sizeToFit];
            self.payPriceLabel.left = self.totalPriceLabel.left;
            self.payPriceLabel.top = self.totalPriceLabel.bottom + 1;
            
        }
        
    }
    
    return self;
    
}

#pragma mark - Getters And Setters

- (UILabel *)totalPriceLabel {
    
    if ( !_totalPriceLabel ) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 0, 0)];
        _totalPriceLabel.textColor = Color_Black;
        _totalPriceLabel.font = FONT(18);
        _totalPriceLabel.text = @"合计：";
        _totalPriceLabel.numberOfLines = 1;
        [_totalPriceLabel sizeToFit];
    }
    
    return _totalPriceLabel;
}

- (UILabel *)payPriceLabel {
    
    if ( !_payPriceLabel ) {
        _payPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _payPriceLabel.textColor = Color_Gray187;
        _payPriceLabel.font = FONT(14);
        _payPriceLabel.text = @"还需：";
        _payPriceLabel.numberOfLines = 1;
        [_payPriceLabel sizeToFit];
    }
    
    return _payPriceLabel;
}

- (UIButton *)payButton {
    
    if ( !_payButton ) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.frame = CGRectMake(0, 0, 101, 37);
        _payButton.titleLabel.font = FONT(16);
        _payButton.backgroundColor = Theme_Color;
        [_payButton addTarget:self action:@selector(handlePayButton) forControlEvents:UIControlEventTouchUpInside];
        [_payButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_payButton setTitle:@"付款" forState:UIControlStateNormal];
        _payButton.layer.masksToBounds = YES;
        _payButton.layer.cornerRadius = 2.0f;
//        _payButton.layer.borderColor = Color_Black.CGColor;
//        _payButton.layer.borderWidth = 1.;
        _payButton.right = SCREEN_WIDTH - 12;
    }
    
    return _payButton;
}

#pragma mark - Event Response

- (void)handlePayButton {
    
    if ( [self.delegate respondsToSelector:@selector(payButtonDidClick)]) {
        [self.delegate payButtonDidClick];
    }
    
}

@end
