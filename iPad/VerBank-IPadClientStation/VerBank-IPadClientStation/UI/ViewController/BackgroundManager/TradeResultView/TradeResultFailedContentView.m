//
//  OrderFailedContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/5.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TradeResultFailedContentView.h"
#import "LangCaptain.h"
#import "JumpDataCenter.h"
#import "BackgoundContentView.h"

@implementation TradeResultFailedContentView

@synthesize titleLabel;
@synthesize contentTextView;
@synthesize yesButton;

- (void)initContent {
    [self setBackgroundColor:[UIColor whiteColor]];
//    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"OrderTradeFaild"]];
    [self.titleLabel setBackgroundColor:[UIColor redColor]];
    [self.yesButton setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
                    forState:UIControlStateNormal];
    [self.contentTextView setEditable:false];
    [self.contentTextView setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
    
    [self.yesButton addTarget:self
                       action:@selector(closeAction)
             forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetContentView {
    [self.titleLabel setText:[[JumpDataCenter getInstance] tradeResultTitle]];
    [self.contentTextView setText:[[JumpDataCenter getInstance] tradeResultMessage]];
}

- (void)closeAction {
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
    }
}

@end
