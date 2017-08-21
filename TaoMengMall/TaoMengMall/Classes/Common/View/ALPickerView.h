//
//  ALPickerView.h
//  HongBao
//
//  Created by marco on 6/17/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALPickerView;

@protocol ALPickerViewDelegate <NSObject>

- (NSString *)pickerView:(ALPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component;
@optional
- (void)pickerView:(ALPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component;

- (void)pickerViewDidConfirm:(ALPickerView *)pickerView;
- (void)pickerViewDidCancel:(ALPickerView *)pickerView;

@end


@protocol ALPickerViewDataSource <NSObject>

- (NSInteger)numberOfComponentsInPickerView:(ALPickerView *)pickerView;

- (NSInteger)pickerView:(ALPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component;
@end


@interface ALPickerView : UIView

@property (nonatomic, weak) id<ALPickerViewDataSource> dataSource;
@property (nonatomic, weak) id<ALPickerViewDelegate> delegate;

//UIPickerView wrapper interface
- (NSInteger)selectedRowInComponent:(NSInteger)component;
- (void)reloadComponent:(NSInteger)componet;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

- (instancetype)init;

- (void)show;
- (void)dismiss;
@end
