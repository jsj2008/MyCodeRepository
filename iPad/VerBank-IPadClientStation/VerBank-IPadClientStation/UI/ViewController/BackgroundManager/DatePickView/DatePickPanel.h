//
//  DatePickPanel.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DatePickEnum) {
    DatePickEnumDateValue   = 0,
    DatePickEnumDateType    = 1,
};

@interface DatePickPanel : UIView

@property IBOutlet UIView   *dateValuePickMainView;
@property IBOutlet UIView   *dateTypePickMainView;

@property IBOutlet UIDatePicker *dateValuePicker;
@property IBOutlet UIPickerView *dateTypePickView;

@property DatePickEnum currentType;

- (void)setEnableView:(DatePickEnum)type;
@end
