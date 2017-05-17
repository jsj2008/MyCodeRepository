//
//  DateTypePickeView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/15.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum  {
//    EXPIRE_TYPE_GTC = 0,
//    EXPIRE_TYPE_DAY = 1,
//    EXPIRE_TYPE_WEEK = 2,
//    EXPIRE_TYPE_USER_DEFINED = 3,
//    EXPIRE_TYPE_1HUOR = 4,
//    EXPIRE_TYPE_2HUOR = 5,
//    EXPIRE_TYPE_4HUOR = 6,
//    EXPIRE_TYPE_8HUOR = 7,
//    EXPIRE_TYPE_12HUOR = 8,
//    EXPIRE_TYPE_16HUOR = 9
//}ExpireType;

@interface DateTypePickerView : UIView {
    IBOutlet UIPickerView *_datePicker;
    IBOutlet UIButton *_doneButton;
}

@property UIPickerView *datePicker;
@property UIButton *doneButton;

+ (DateTypePickerView *)newInstanceWithArray:(NSArray *)array;

//+ (DateTypePickerView *)newInstance;

@end
