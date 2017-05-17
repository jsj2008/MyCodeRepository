//
//  PasswordChangePopContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordChangePopContentView : UIView {
    IBOutlet UITextView     *_textView;
    IBOutlet UILabel        *_oPasswordLabel;
    IBOutlet UILabel        *_nPasswordLabel;
    IBOutlet UILabel        *_nPasswordAgainLabel;
    IBOutlet UITextField    *_oPasswordField;
    IBOutlet UITextField    *_nPasswordField;
    IBOutlet UITextField    *_nPasswordAgainField;
    IBOutlet UIButton       *_confirmButton;
}

@property UITextField *oPasswordField;
@property UITextField *nPasswordField;
@property UITextField *nPasswordAgainField;


+ (PasswordChangePopContentView *)newInstance;

@end
