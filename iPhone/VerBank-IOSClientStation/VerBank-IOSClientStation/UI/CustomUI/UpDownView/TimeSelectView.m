//
//  TimeSelectView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TimeSelectView.h"

@implementation TimeSelectView

@synthesize datePicker = _datePicker;
@synthesize doneButton = _doneButton;


+ (TimeSelectView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TimeSelectView" owner:self options:nil];
    TimeSelectView *view = [nib objectAtIndex:0];
    [view initContentView];
    return view;
}

- (void)initContentView {
    [_datePicker setMinimumDate:[NSDate new]];
}

@end
