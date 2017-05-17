//
//  CertificatePwdInputContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"

@interface CertificatePwdInputContentView : LayoutContentView

@property IBOutlet UILabel      *titleLabel;
@property IBOutlet UIButton     *backButton;

@property IBOutlet UILabel      *certificateLabel;
@property IBOutlet UITextField  *passwordField;
@property IBOutlet UIButton     *downloadButton;
@property IBOutlet UITextView   *textView;

@end
