//
//  CSTotalBarView.m
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CSTotalBarView.h"

@interface CSTotalBarView ()

@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UIButton *orderButton;

@end

@implementation CSTotalBarView

- (instancetype)initWithFrame:(CGRect)frame totalPrice:(NSString *)totalPrice {
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = Color_White;
        
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.orderButton];
        
        self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：%@", totalPrice];
        [self.totalPriceLabel sizeToFit];
        self.totalPriceLabel.centerY = self.height / 2;
        
        self.orderButton.centerY = self.totalPriceLabel.centerY;
        
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

- (UIButton *)orderButton {
    
    if ( !_orderButton ) {
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderButton.frame = CGRectMake(0, 0, 101, 37);
        _orderButton.titleLabel.font = FONT(16);
        _orderButton.backgroundColor = Theme_Color;
        [_orderButton addTarget:self action:@selector(handleOrderButton) forControlEvents:UIControlEventTouchUpInside];
        [_orderButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_orderButton setTitle:@"提交订单" forState:UIControlStateNormal];
        _orderButton.layer.masksToBounds = YES;
        _orderButton.layer.cornerRadius = 2.0f;
//        _orderButton.layer.borderColor = Color_Black.CGColor;
//        _orderButton.layer.borderWidth = 1.;
        _orderButton.right = SCREEN_WIDTH - 12;
    }
    
    return _orderButton;
}

#pragma mark - Event Response

- (void)handleOrderButton {
    
    if ( [self.delegate respondsToSelector:@selector(orderButtonDidClick)]) {
        [self.delegate orderButtonDidClick];
    }
    
}

@end
