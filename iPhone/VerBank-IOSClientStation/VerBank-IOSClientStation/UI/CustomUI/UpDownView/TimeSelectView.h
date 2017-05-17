//
//  TimeSelectView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSelectView : UIView {
    IBOutlet UIDatePicker *_datePicker;
    IBOutlet UIButton *_doneButton;
}

@property UIDatePicker *datePicker;
@property UIButton *doneButton;

+ (TimeSelectView *)newInstance;

@end
