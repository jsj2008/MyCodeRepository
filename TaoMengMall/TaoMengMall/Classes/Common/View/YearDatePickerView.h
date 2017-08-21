//
//  YearDatePickerView.h
//  XiaoPa
//
//  Created by wzningjie on 2016/11/28.
//  Copyright © 2016年 marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YearPickerView.h"
@class YearDatePickerView;

@protocol YearDatePickerViewDelegate <NSObject>

@optional
- (void)datePickerViewDidConfirm:(YearDatePickerView *)pickerView;
- (void)datePickerViewDidCancel:(YearDatePickerView *)pickerView;

@end

@interface YearDatePickerView : UIView

@property (nonatomic, strong) YearPickerView *pickerView;
@property (nonatomic, weak) id<YearDatePickerViewDelegate> delegate;
@property (nonatomic, strong,readonly) NSString *year;

- (instancetype)init;

- (void)show;
- (void)dismiss;

@end
