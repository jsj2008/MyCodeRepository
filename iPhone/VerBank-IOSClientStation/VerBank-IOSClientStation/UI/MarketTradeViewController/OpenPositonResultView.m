//
//  OpenPositonResultView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OpenPositonResultView.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"

@implementation OpenPositonResultView

@synthesize titleLabel = _titleLabel;
@synthesize accountLabel = _accountLabel;
@synthesize timeLabel = _timeLabel;
@synthesize instrumentLabel = _instrumentLabel;
@synthesize amountLabel = _amountLabel;
@synthesize buySellLabel = _buySellLabel;
@synthesize priceLabel = _priceLabel;
@synthesize confirmButton = _confirmButton;

+ (OpenPositonResultView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OpenPositonResultView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
    self.layer.cornerRadius = 10.0f;
    
    [self.titleLabel setTextColor:[UIColor blueButtonColor]];
    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"OpenTradeSucceed"]];
    
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:_confirmButton];
    [UIFormat setComplexBlueButtonColor:_confirmButton];
    
    [_confirmButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"] forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
