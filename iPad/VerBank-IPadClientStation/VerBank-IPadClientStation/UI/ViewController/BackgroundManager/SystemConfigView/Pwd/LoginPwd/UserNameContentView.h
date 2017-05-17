//
//  UserNameContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/7/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"

@interface UserNameContentView : LayoutContentView {
    IBOutlet UILabel        *_titleLabel;
    IBOutlet UITextView     *_textView;
    IBOutlet UILabel        *_userNameLabel;
    IBOutlet UITextField    *_userNameField;
    IBOutlet UIButton       *_confirmButton;
}

@property (nonatomic, retain) UITextField *userNameField;

@end
