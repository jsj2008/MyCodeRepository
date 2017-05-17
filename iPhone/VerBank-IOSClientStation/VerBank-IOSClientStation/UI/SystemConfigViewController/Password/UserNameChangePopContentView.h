//
//  UserNameChangeView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/13.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNameChangePopContentView : UIView {
    IBOutlet UITextView     *_textView;
    IBOutlet UILabel        *_userNameLabel;
    IBOutlet UITextField    *_userNameField;
    IBOutlet UIButton       *_confirmButton;
}

@property (nonatomic, retain) UITextField *userNameField;

+ (UserNameChangePopContentView *)newInstance;

@end
