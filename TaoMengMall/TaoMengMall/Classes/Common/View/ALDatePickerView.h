//
//  ALDatePickerView.h
//  KeHan
//
//  Created by marco on 6/18/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALDatePickerView;

@protocol ALDatePickerViewDelegate <NSObject>

@optional
- (void)datePickerViewDidConfirm:(ALDatePickerView *)pickerView;
- (void)datePickerViewDidCancel:(ALDatePickerView *)pickerView;

@end


@interface ALDatePickerView : UIView
@property (nonatomic, strong, readonly) UIDatePicker *pickerView;
@property (nonatomic, weak) id<ALDatePickerViewDelegate> delegate;
@property (nonatomic, strong,readonly) NSDate *date;

- (instancetype)init;

- (void)show;
- (void)dismiss;
@end
