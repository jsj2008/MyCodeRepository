//
//  LoginPwdContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"

@interface LoginPwdContentView : LayoutContentView

@property IBOutlet UILabel      *titleLabel;

@property IBOutlet UITextView   *textView;
@property IBOutlet UILabel      *oPwdLabel;
@property IBOutlet UILabel      *nPwdLabel;
@property IBOutlet UILabel      *nPwdAgainLabel;
@property IBOutlet UITextField  *oPwdTextField;
@property IBOutlet UITextField  *nPwdTextField;
@property IBOutlet UITextField  *nPwdAgainTextField;

@property IBOutlet UIButton     *commitButton;

@property IBOutlet UIButton     *backButton;

@end
