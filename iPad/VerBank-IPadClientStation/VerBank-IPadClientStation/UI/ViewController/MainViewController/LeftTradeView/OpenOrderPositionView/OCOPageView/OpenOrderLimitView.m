//
//  OpenOrderLimitView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenOrderLimitView.h"
#import "LangCaptain.h"
#import "ActionUtils.h"

@implementation OpenOrderLimitView

@synthesize limitPriceLabel;
@synthesize limitPriceTextField;

@synthesize amountLabel;
@synthesize amountTextField;

@synthesize valueTimeLabel;
@synthesize valueTimeButton;

@synthesize buttonPanelView;

//@synthesize commitButton;
//@synthesize cancelButton;

- (void)initContent {
    [self setBackgroundColor:[UIColor blackColor]];
    
//    [commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"TradeCommit"] forState:UIControlStateNormal];
//    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    [valueTimeButton addTarget:[ActionUtils getInstance]
                        action:@selector(showDatePickView:)
              forControlEvents:UIControlEventTouchUpInside];
    [valueTimeButton setTimeShowButton:_showTimeButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    [self.commitButton layoutIfNeeded];
    //    [self.commitButton setNeedsDisplay];
}

@end
