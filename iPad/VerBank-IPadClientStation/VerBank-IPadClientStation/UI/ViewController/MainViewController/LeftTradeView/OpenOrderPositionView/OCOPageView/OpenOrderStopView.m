//
//  OpenOrderStopView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenOrderStopView.h"
#import "LangCaptain.h"
#import "ActionUtils.h"

@implementation OpenOrderStopView

@synthesize stopPriceLabel;
@synthesize stopPriceTextField;

@synthesize amountLabel;
@synthesize amountTextField;

@synthesize stopMoveLabel;
@synthesize stopMoveTextField;

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

@end
