//
//  InstrumentPickContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "InstrumentPickContentView.h"
#import "LangCaptain.h"
#import "ClientSystemConfig.h"
#import "UIColor+CustomColor.h"
#import "JumpDataCenter.h"
#import "LayoutCenter.h"
#import "BackgoundContentView.h"
#import "JumpDataCenter.h"

@interface InstrumentPickContentView()<UIPickerViewDelegate, UIPickerViewDataSource> {
}

@end

@implementation InstrumentPickContentView

@synthesize titleLabel;
@synthesize pickerView;
@synthesize okButton;

@synthesize instrumentArray;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"InstrumentPick"]];
    [okButton setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
    
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    [self.okButton addTarget:self
                      action:@selector(okAction)
            forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetContentView {
    self.instrumentArray = [[ClientSystemConfig getInstance] getSelectedInstrumentArray];
    
    NSString *currentInstrumentName = nil;
    if ([[JumpDataCenter getInstance] kChartWebView] == nil) {
        currentInstrumentName = [[JumpDataCenter getInstance] createTradeInstrument];
    } else {
        currentInstrumentName = [[[JumpDataCenter getInstance] kChartWebView] getInstrumentName];
    }
    
    NSUInteger index = 0;
    if ([self.instrumentArray containsObject:currentInstrumentName]) {
        index = [self.instrumentArray indexOfObject:currentInstrumentName];
    }
    
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:index inComponent:0 animated:NO];
}

#pragma picke delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.instrumentArray == nil) {
        return 0;
    }
    return self.instrumentArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.instrumentArray objectAtIndex:row];
}

#pragma okAction
- (void)okAction {
    NSString *selectInstrument = [self.instrumentArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    if ([[JumpDataCenter getInstance] kChartWebView] == nil) {
        [[JumpDataCenter getInstance] setCreateTradeInstrument:selectInstrument];
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didUpdateCurrentViewFunction];
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:selectInstrument];
    } else {
        NSString *currentInstrumentName = [[[JumpDataCenter getInstance] kChartWebView] getInstrumentName];
        if (![currentInstrumentName isEqualToString:selectInstrument]) {
            [[[JumpDataCenter getInstance] kChartWebView] setInstrumentName:selectInstrument];
            [[[JumpDataCenter getInstance] kChartWebView] loadQuoteHisData];
        }
        
        [[JumpDataCenter getInstance] setKChartWebView:nil];
    }
    
    if ([[self superview] isKindOfClass:[BackgoundContentView class]]) {
        [(BackgoundContentView *)[self superview] closeView];
    }
}

@end
