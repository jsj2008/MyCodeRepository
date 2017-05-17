//
//  LoginViewController.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKeyboard.h"
#import "LoginSegmentControl.h"
#import "UnableTextField.h"

@interface LoginViewController : UIViewController{
    IBOutlet UIImageView *_backgroundImageView;
    IBOutlet UIImageView *_logoImageView;
    IBOutlet UnableTextField *_aeidTextFild;
    IBOutlet UnableTextField *_userNameTextFild;
    IBOutlet UnableTextField *_passwordTextFild;
    IBOutlet UIButton *_chooseButton;
    IBOutlet UILabel *_chooseLabel;
    
    IBOutlet UIButton *_langChooseButton;
    IBOutlet UIButton *_loginButton;
    IBOutlet LoginSegmentControl *_segmentControlView;
    
    IBOutlet UIButton *_helpButton;
    IBOutlet UILabel *_helpLabel;
    IBOutlet UIButton *_privateButton;
}

@property (nonatomic, retain)UIImageView *backgroundImageView;
@property (nonatomic, retain)UIImageView *logoImageView;
@property (nonatomic, retain)UnableTextField *aeidTextFild;
@property (nonatomic, retain)UnableTextField *userNameTextFild;
@property (nonatomic, retain)UnableTextField *passwordTextFild;

@property (nonatomic, retain)UIButton *chooseButton;
@property (nonatomic, retain)UILabel *chooseLabel;
@property (nonatomic, retain)UIButton *langChooseButton;

@property (nonatomic, retain)UIButton *loginButton;
@property (nonatomic, retain)LoginSegmentControl *segmentControlView;

@property (nonatomic, retain)UIButton *helpButton;
@property (nonatomic, retain)UILabel *helpLabel;

@property (nonatomic, retain)ZLKeyboard *keyboard;

- (void)login;
- (void)checkNeedChangeUserName;

@end
