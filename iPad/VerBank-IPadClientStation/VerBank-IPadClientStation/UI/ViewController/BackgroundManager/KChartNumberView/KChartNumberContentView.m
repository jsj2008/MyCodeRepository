//
//  KChartNumberContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "KChartNumberContentView.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"
#import "ClientSystemConfig.h"
#import "BackgoundContentView.h"
#import "LayoutCenter.h"

@interface KChartNumberContentView()<UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *_contentArray;
}

@end

@implementation KChartNumberContentView

@synthesize titleLabel;
@synthesize pickerView;
@synthesize okButton;

- (void)initContent {
    [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"KChartNumberChoose"]];
    [okButton setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
    
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    [self.okButton addTarget:self
                      action:@selector(okAction)
            forControlEvents:UIControlEventTouchUpInside];
    
    _contentArray = [[NSArray alloc] initWithObjects:
                     [[NSNumber alloc] initWithInt:1], [[NSNumber alloc] initWithInt:2],
                     [[NSNumber alloc] initWithInt:3], [[NSNumber alloc] initWithInt:4], nil];
}

- (void)resetContentView {
    
    NSNumber *currentKChartNumber = [[ClientSystemConfig getInstance] currentKChartNumber];
    
//    self.instrumentArray = [[ClientSystemConfig getInstance] getSelectedInstrumentArray];
//    
//    NSString *currentInstrumentName = [[JumpDataCenter getInstance] createTradeInstrument];
    NSUInteger index = [_contentArray indexOfObject:currentKChartNumber];
//
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:index inComponent:0 animated:NO];
}

#pragma picke delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_contentArray == nil) {
        return 0;
    }
    return _contentArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [[_contentArray objectAtIndex:row] stringValue];
    return [NSString stringWithFormat:@"%@%@", [[LangCaptain getInstance] getLangByCode:@"KChartNumber"], [_contentArray objectAtIndex:row]];
}

#pragma okAction
- (void)okAction {
    NSInteger selectIndex = [pickerView selectedRowInComponent:0];
    NSNumber *currentNumber = [_contentArray objectAtIndex:selectIndex];
    [[ClientSystemConfig getInstance] setCurrentKChartNumber:currentNumber];
    [[ClientSystemConfig getInstance] saveConfigData];
    [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:NormalScreenStatus];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showSystemConfigView];
}

@end
