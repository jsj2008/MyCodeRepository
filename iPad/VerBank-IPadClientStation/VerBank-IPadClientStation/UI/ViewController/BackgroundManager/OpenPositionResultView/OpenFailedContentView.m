//
//  OpenFailedContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenFailedContentView.h"
#import "LangCaptain.h"
#import "JumpDataCenter.h"
#import "BackgoundContentView.h"

@implementation OpenFailedContentView

@synthesize titleLabel;
@synthesize contentTextView;
@synthesize yesButton;

- (void)initContent {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"OpenTradeFaild"]];
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
    [self.contentTextView setText:[[JumpDataCenter getInstance] openFailedMessage]];
}

- (void)closeAction {
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
    }
}

@end
