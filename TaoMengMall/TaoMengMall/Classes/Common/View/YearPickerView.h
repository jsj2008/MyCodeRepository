//
//  YearPickerView.h
//  YearPicker
//
//  Created by Jakey on 14-7-31.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YearPickerDelegate<NSObject>

@optional
-(void)didSelectPickerYear:(NSString *)year inputTag:(NSInteger)tag;
@end


@interface YearPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>{
    NSMutableArray *_years;
}
@property (nonatomic,assign) id<YearPickerDelegate>pickerDeleage;
@property (nonatomic) NSInteger minYear;
@property (nonatomic) NSInteger maxYear;
@property (nonatomic) NSInteger tag;
@property (nonatomic,strong) NSString *currentYear;

- (void)reload;
@end
