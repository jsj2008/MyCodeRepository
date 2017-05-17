//
//  PhonePinInputView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/13.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"

@interface PhonePinInputView : UIView {
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_inputLabel;
    IBOutlet UITextField *_inputField;
    IBOutlet UIButton *_commitButton;
    IBOutlet UIButton *_cancelButton;
}

@property UILabel *titleLabel;
@property UILabel *inputLabel;
@property UITextField *inputFeild;
@property UIButton *commitButton;
@property UIButton *cancelButton;

@end
