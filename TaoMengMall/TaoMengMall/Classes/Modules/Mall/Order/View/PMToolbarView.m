//
//  ITToolbarView.m
//  HongBao
//
//  Created by Ivan on 16/2/11.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "PMToolbarView.h"

@interface PMToolbarView ()

@property (nonatomic, strong) UIButton *buyButton;

@end


@implementation PMToolbarView

- (PMToolbarView *) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = Color_White;
    
    [self addSubview:self.buyButton];
    self.buyButton.left = 40;
    self.buyButton.top = ( self.height - self.buyButton.height ) / 2;
    return self;
}


#pragma mark - Getters And Setters
- (UIButton *)buyButton {
    
    if ( !_buyButton ) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.frame = CGRectMake(0, 0, SCREEN_WIDTH - 40 * 2, 32);
        _buyButton.titleLabel.font = FONT(14);
        [_buyButton addTarget:self action:@selector(handleBuyButton) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton setTitleColor:Color_White forState:UIControlStateNormal];
        [_buyButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_buyButton setBackgroundColor:Theme_Color];
        _buyButton.layer.borderColor = [Theme_Color CGColor];
        _buyButton.layer.borderWidth = 1.0f;
    }
    
    return _buyButton;
}

#pragma mark - Event Response
- (void) handleBuyButton {
    
    if ([self.delegate respondsToSelector:@selector(buyButtonDidClick)]) {
        [self.delegate buyButtonDidClick];
    }
    
}

@end
