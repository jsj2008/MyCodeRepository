//
//  DataPickContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "DatePickContentView.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "MTP4CommDataInterface.h"
#import "JumpDataCenter.h"
#import "BackgoundContentView.h"

@interface DatePickContentView() <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSMutableArray *_dateTypeArray;
    
    ValueTimeButton *_valueTimeButton;
}

@end

@implementation DatePickContentView

@synthesize titleLabel;
@synthesize datePickPanel;
@synthesize okButton;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"TimePick"]];
    [okButton setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
    
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self.datePickPanel.dateTypePickView setDelegate:self];
    [self.datePickPanel.dateTypePickView setDataSource:self];
    
    //    [self.okButton addTarget:self
    //                      action:@selector(okAction)
    //            forControlEvents:UIControlEventTouchUpInside];
    
    //    ORDER_EXPIRE_TYPE_GTC = 0,
    //    ORDER_EXPIRE_TYPE_DAY = 1,
    //    ORDER_EXPIRE_TYPE_WEEK = 2,
    //    ORDER_EXPIRE_TYPE_USER_DEFINED = 3,
    _dateTypeArray = [[NSMutableArray alloc] init];
    
    
    [self.datePickPanel.dateValuePicker setMinimumDate:[NSDate new]];
    
    [self.okButton addTarget:self
                      action:@selector(okAction)
            forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetContentView {
    [super resetContentView];
    
    NSNumber *h1        = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H1];
    NSNumber *h2        = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H2];
    NSNumber *h4        = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H4];
    NSNumber *h8        = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H8];
    NSNumber *h12        = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H12];
    NSNumber *h16        = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H16];
    
    NSNumber *day       = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_DAY];
    NSNumber *week      = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_WEEK];
    NSNumber *gtc       = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_GTC];
    NSNumber *userDefine = [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_USER_DEFINED];
    _valueTimeButton = [[JumpDataCenter getInstance] valueTimeButton];
    [_dateTypeArray removeAllObjects];
    if (_valueTimeButton.valueTimeButtonType == 2) {
        //        _dateTypeArray = [[NSArray alloc] initWithObjects:h1, h2, h4, h8, h12, h16, day,week,gtc,nil];
        [_dateTypeArray addObject:h1];
        [_dateTypeArray addObject:h2];
        [_dateTypeArray addObject:h4];
        [_dateTypeArray addObject:h8];
        [_dateTypeArray addObject:h12];
        [_dateTypeArray addObject:h16];
        
        [_dateTypeArray addObject:day];
        [_dateTypeArray addObject:week];
        [_dateTypeArray addObject:gtc];
    }else {
        //        _dateTypeArray = [[NSArray alloc] initWithObjects:day,week,gtc,userDefine,nil];
        [_dateTypeArray addObject:day];
        [_dateTypeArray addObject:week];
        [_dateTypeArray addObject:gtc];
        [_dateTypeArray addObject:userDefine];
    }
    
    [self.datePickPanel.dateTypePickView reloadAllComponents];
    
    
    NSNumber *selectNumber = [[NSNumber alloc] initWithUnsignedInteger:[_valueTimeButton getDateType]];
    for (int i = 0; i < [_dateTypeArray count]; i++) {
        if ([selectNumber compare:[_dateTypeArray objectAtIndex:i]] == NSOrderedSame) {
            [self.datePickPanel.dateTypePickView selectRow:i inComponent:0 animated:NO];
        }
    }
    if ([_valueTimeButton getDateValueDate] == nil) {
        [self.datePickPanel.dateValuePicker setDate:[NSDate new]];
    } else {
        [self.datePickPanel.dateValuePicker setDate:[_valueTimeButton getDateValueDate]];
    }
    
    [self.datePickPanel setEnableView:DatePickEnumDateType];
}

#pragma okAction
- (void)okAction {
    
    Boolean isDisappear = false;
    
    if (self.datePickPanel.currentType == DatePickEnumDateType) {
        isDisappear = [self pickDateTypeAction];
    } else if (self.datePickPanel.currentType == DatePickEnumDateValue) {
        isDisappear = [self pickDateValueAction];
    }
    
    if (isDisappear) {
        //        [self closeView];
        if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
            [(BackgoundContentView *)[self superview] closeView];
        }
    }
}

#pragma picke delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_dateTypeArray == nil) {
        return 0;
    }
    return _dateTypeArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSNumber *number = [_dateTypeArray objectAtIndex:row];
    return [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"ORDER_EXPIRE_TYPE_%@", number]];
}

#pragma okAction
- (Boolean)pickDateTypeAction {
    NSInteger selectIndex = [self.datePickPanel.dateTypePickView selectedRowInComponent:0];
    NSInteger dateType = [[_dateTypeArray objectAtIndex:selectIndex] integerValue];
    [_valueTimeButton setDateType:dateType];
    if (dateType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        [self.datePickPanel setEnableView:DatePickEnumDateValue];
        return false;
    }
    return true;
}

- (Boolean)pickDateValueAction {
    [_valueTimeButton setDateValueTime:self.datePickPanel.dateValuePicker.date];
    return true;
}

- (void)addListener {
    
}

- (void)removeListener {
    
}

@end
