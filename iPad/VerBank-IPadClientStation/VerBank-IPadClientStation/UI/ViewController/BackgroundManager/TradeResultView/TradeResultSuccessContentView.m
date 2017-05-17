//
//  OrderFailedContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/5.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TradeResultSuccessContentView.h"
#import "LangCaptain.h"
#import "JumpDataCenter.h"
#import "BackgoundContentView.h"
#import "LayoutCenter.h"
#import "UIColor+CustomColor.h"

@implementation TradeResultSuccessContentView

@synthesize titleLabel;
@synthesize contentTextView;
@synthesize yesButton;

- (void)initContent {
    [self setBackgroundColor:[UIColor whiteColor]];
    //    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"OrderTradeFaild"]];
    [self.titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [self.yesButton setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
                    forState:UIControlStateNormal];
    [self.contentTextView setEditable:false];
    [self.contentTextView setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
    
    [self.yesButton addTarget:self action:@selector(doSuccessAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetContentView {
    [self.titleLabel setText:[[JumpDataCenter getInstance] tradeResultTitle]];
    [self.contentTextView setText:[[JumpDataCenter getInstance] tradeResultMessage]];
}

- (void)doSuccessAction {
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_QuoteList];
    }
}

@end
