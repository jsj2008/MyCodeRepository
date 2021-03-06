//
//  StopView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderStopView.h"
#import "LangCaptain.h"
#import "ActionUtils.h"

@implementation OrderStopView

@synthesize stopPriceLabel;
@synthesize stopPriceTextField;

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
    [valueTimeButton addTarget:[ActionUtils getInstance]
                        action:@selector(showDatePickView:)
              forControlEvents:UIControlEventTouchUpInside];
     [valueTimeButton setTimeShowButton:_showTimeButton];
}

@end
