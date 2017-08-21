//
//  YearPickerView.m
//  YearPicker
//
//  Created by Jakey on 14-7-31.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "YearPickerView.h"

@implementation YearPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initData];
        
    }
    return self;
}


-(void)initData{
    _years = [NSMutableArray array];
    self.delegate = self;
    self.dataSource = self;
}
- (void)reload{
    [_years removeAllObjects];
    for (NSInteger year = self.minYear; year<=self.maxYear ; year++) {
        [_years addObject:[NSString stringWithFormat:@"%ld",year]];
    }
    [self reloadAllComponents];
    [self selectRow:(self.maxYear - self.minYear) inComponent:0 animated:NO];
    self.currentYear = [NSString stringWithFormat:@"%ld",self.maxYear];
}
#pragma -mark - picker view delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_years count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%@年",_years[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.currentYear = _years[row];
    if (self.pickerDeleage && [self.pickerDeleage respondsToSelector:@selector(didSelectPickerYear:inputTag:)]) {
        [self.pickerDeleage  didSelectPickerYear:self.currentYear inputTag:self.tag];
    }
    NSLog(@"select year %@",_years[row]);
}


@end
