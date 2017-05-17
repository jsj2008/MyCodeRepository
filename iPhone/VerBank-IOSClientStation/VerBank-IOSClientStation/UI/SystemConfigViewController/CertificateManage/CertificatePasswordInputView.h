//
//  CertificatePasswordInputView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/23.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificatePasswordInputView : UIView {
    IBOutlet UILabel *_certificateLabel;
    IBOutlet UITextField *_passwordField;
    IBOutlet UIButton *_downloadButton;
    IBOutlet UITextView *_textView;
}

@property (nonatomic, retain)UILabel *certficateLabel;
@property (nonatomic, retain)UITextField *passwordField;
@property (nonatomic, retain)UIButton *downloadButton;
@property (nonatomic, retain)UITextView *textView;

+ (CertificatePasswordInputView *)newInstance;

@end
