//
//  DateTypePickeView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/15.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "DateTypePickerView.h"
#import "LangCaptain.h"
#import "MTP4CommDataInterface.h"
#import "TranslateUtil.h"

@interface DateTypePickerView()<UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *pickerArray;
}

@end

@implementation DateTypePickerView

@synthesize datePicker = _datePicker;
@synthesize doneButton = _doneButton;

+ (DateTypePickerView *)newInstanceWithArray:(NSArray *)array {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DateTypePickerView" owner:self options:nil];
    DateTypePickerView *view = [nib objectAtIndex:0];
    [view initPicker:array];
    return view;
}

//- (void)initContentView {
    //    //    ORDER_EXPIRE_TYPE_GTC = 0,
    //    //    ORDER_EXPIRE_TYPE_DAY = 1,
    //    //    ORDER_EXPIRE_TYPE_WEEK = 2,
    //    //    ORDER_EXPIRE_TYPE_USER_DEFINED = 3,
    //    NSString *Hour1   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"1Hour"]];
    //    NSString *Hour2   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"2Hour"]];
    //    NSString *Hour4   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"4Hour"]];
    //    NSString *Hour8   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"8Hour"]];
    //    NSString *Hour12   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"12Hour"]];
    //    NSString *Hour16   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"16Hour"]];
    //
    //    NSString *gtc   = [NSString stringWithFormat:@"  GTC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"]];
    //    NSString *week  = [NSString stringWithFormat:@"  GTW %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"]];
    //    NSString *day   = [NSString stringWithFormat:@"  NYC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"]];
    //    NSString *other = [NSString stringWithFormat:@"  Other %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"]];
    //
    //    pickerArray = [[NSArray alloc] initWithObjects:Hour1, Hour2, Hour4, Hour8, Hour12, Hour16, gtc, day, week, other, nil];
    
//    [self initPicker];
//}


//- (void)initContentViewPriceWarning {
//    
//    //    NSString *Hour1   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"1Hour"]];
//    //    NSString *Hour2   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"2Hour"]];
//    //    NSString *Hour4   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"4Hour"]];
//    //    NSString *Hour8   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"8Hour"]];
//    //    NSString *Hour12   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"12Hour"]];
//    //    NSString *Hour16   = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"16Hour"]];
//    //
//    //    NSString *day   = [NSString stringWithFormat:@"  NYC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"]];
//    //    NSString *week  = [NSString stringWithFormat:@"  GTW %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"]];
//    //    NSString *gtc   = [NSString stringWithFormat:@"  GTC %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"]];
//    //    NSString *other = [NSString stringWithFormat:@"  Other %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"]];
//    
//    pickerArray = [[NSArray alloc] initWithObjects:
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H1],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H2],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H4],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H8],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H12],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_H16],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_DAY],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_WEEK],
//                   [[NSNumber alloc] initWithInt:ORDER_EXPIRE_TYPE_GTC], nil];
//    
//    [self initPicker];
//}

- (void)initPicker:(NSArray *)array {
    pickerArray = array;
    [_datePicker setDelegate:self];
    [_datePicker setDataSource:self];
    [_datePicker setBackgroundColor:[UIColor whiteColor]];
    [_doneButton setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor clearColor]];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [TranslateUtil translatePickDate:[[pickerArray objectAtIndex:row] intValue]];
}

@end
