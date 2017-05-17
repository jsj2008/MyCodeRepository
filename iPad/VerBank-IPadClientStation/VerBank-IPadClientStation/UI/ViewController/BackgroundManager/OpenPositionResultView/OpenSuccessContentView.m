//
//  OpenSuccessContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenSuccessContentView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "JumpDataCenter.h"

#import "LayoutCenter.h"
#import "BackgoundContentView.h"

@implementation OpenSuccessContentView

@synthesize titleLabel;
@synthesize accountLabel;
@synthesize timeLabel;
@synthesize instrumentLabel;
@synthesize amountLabel;
@synthesize buySellLabel;
@synthesize priceLabel;
@synthesize yesButton;

- (void)initContent {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"OpenTradeSucceed"]];
    [self.titleLabel setTextColor:[UIColor blueButtonColor]];
    [self.yesButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Confirm"]
                    forState:UIControlStateNormal];
    [self.yesButton addTarget:self
                       action:@selector(yesButtonAction)
             forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetContentView {
    OpenSuccessStruct *openSuccessStruct = [[JumpDataCenter getInstance] openSuccessStruct];
    [self.accountLabel      setText:openSuccessStruct.account];
    [self.timeLabel         setText:openSuccessStruct.time];
    [self.instrumentLabel   setText:openSuccessStruct.instrumentName];
    [self.amountLabel       setText:openSuccessStruct.amount];
    [self.buySellLabel      setText:openSuccessStruct.buySell];
    [self.priceLabel        setText:openSuccessStruct.price];
}

#pragma yesAction
- (void)yesButtonAction {
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_QuoteList];
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
    }
}

@end
