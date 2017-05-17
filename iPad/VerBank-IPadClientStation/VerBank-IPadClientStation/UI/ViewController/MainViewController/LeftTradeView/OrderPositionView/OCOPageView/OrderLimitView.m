//
//  LimitView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderLimitView.h"
#import "LangCaptain.h"
#import "ActionUtils.h"
#import "JumpDataCenter.h"

@implementation OrderLimitView

@synthesize limitPriceLabel;
@synthesize limitPriceTextField;

@synthesize amountLabel;
@synthesize amountTextField;

@synthesize idtLimitLabel;
@synthesize idtLimitTextField;

@synthesize idtStopLabel;
@synthesize idtStopTextField;

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
