//
//  CertificateChangePopContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateChangePopContentView : UIView {
    IBOutlet UITextView     *_textView;
    IBOutlet UILabel        *_oPinLabel;
    IBOutlet UILabel        *_nPinLabel;
    IBOutlet UILabel        *_nPinAgainLabel;
    IBOutlet UITextField    *_oPinField;
    IBOutlet UITextField    *_nPinField;
    IBOutlet UITextField    *_nPinAgainField;
    IBOutlet UIButton       *_confirmButton;
}

@property UITextField *oPinField;
@property UITextField *nPinField;
@property UITextField *nPinAgainField;

+ (CertificateChangePopContentView *)newInstance;

@end
