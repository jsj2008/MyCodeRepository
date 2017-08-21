//
//  STChangeNameViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/16.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "STChangeNameViewController.h"
#import "MineRequest.h"
#import "UserService.h"
#import "XMAppThemeHelper.h"

@interface STChangeNameViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *inputBgView1;
@property (nonatomic, strong) UIImageView *iconView1;
@property (nonatomic, strong) UIView *iconBgView1;
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UIButton *completeButton;

@end

@implementation STChangeNameViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 56, 20);
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:[XMAppThemeHelper defaultTheme].navigationBarButtonColor forState:UIControlStateNormal];
    doneButton.titleLabel.font = FONT(16);
    [doneButton addTarget:self action:@selector(handleCompleteButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButton = doneButton;

    self.title = @"修改昵称";
    [self render];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.nameTextField becomeFirstResponder];
}

#pragma mark - Private Methods

- (void) render
{
//    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    topView.backgroundColor = Color_White;
//    UIBarButtonItem * btnSpace1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
//    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace1,btnSpace2,doneButton,nil];
//    [topView setItems:buttonsArray];
//    [[UITextField appearance] setInputAccessoryView:topView];
    
    [self.view addSubview:self.inputBgView1];
    //[self.inputBgView1 addSubview:self.iconBgView1];
    //[self.inputBgView1 addSubview:self.iconView1];
    [self.inputBgView1 addSubview:self.nameTextField];
    
    //[self.view addSubview:self.completeButton];
}

#pragma mark - Getters And Setters

- (UIView *)inputBgView1 {
    
    if ( !_inputBgView1 ) {
        _inputBgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20 + NAVBAR_HEIGHT, SCREEN_WIDTH, 60)];
        _inputBgView1.backgroundColor = Color_White;
    }
    
    return _inputBgView1;
}

- (UIView *)iconBgView1 {
    
    if ( !_iconBgView1 ) {
        _iconBgView1 = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 85, 44)];
        _iconBgView1.backgroundColor = Color_Gray230;
    }
    
    return _iconBgView1;
}

- (UIImageView *)iconView1
{
    if ( !_iconView1 ) {
        _iconView1 = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 23, 25)];
        _iconView1.image = [UIImage imageNamed:@"icon_set_name"];
        _iconView1.centerX = self.iconBgView1.centerX;
        _iconView1.centerY = self.iconBgView1.centerY;
    }
    
    return _iconView1;
}

- (UITextField *)nameTextField {
    
    if ( !_nameTextField ) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 8, SCREEN_WIDTH - 24, 44)];
        _nameTextField.borderStyle = UITextBorderStyleNone;
        _nameTextField.placeholder = @"设置你的昵称";
        _nameTextField.font = FONT(16);
        _nameTextField.delegate = self;
        _nameTextField.textColor = Color_Gray42;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.inputAccessoryView = [UIView new];
        _nameTextField.text = [UserService sharedService].name;
    }
    
    return _nameTextField;
    
}

- (UIButton *)completeButton {
    
    if ( !_completeButton ) {
        _completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeButton.frame = CGRectMake(20, 90 + NAVBAR_HEIGHT, SCREEN_WIDTH - 40, 44);
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton setTitleColor:Color_White forState:UIControlStateNormal];
        _completeButton.titleLabel.font = FONT(16);
        _completeButton.layer.masksToBounds = YES;
        _completeButton.layer.cornerRadius = 4;
        _completeButton.layer.borderWidth = 1;
        _completeButton.layer.borderColor = Color_Red12.CGColor;
        _completeButton.backgroundColor = Color_Red12;
//        _completeButton.enabled = NO;
        [_completeButton addTarget:self action:@selector(handleCompleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _completeButton;
}


#pragma mark - Event Response

- (void) dismissKeyBoard {
    [self.nameTextField resignFirstResponder];
}

- (void) handleCompleteButton
{
    
    if ( IsEmptyString(self.nameTextField.text) ) {
        [self showNotice:@"请输入昵称"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *name = [self.nameTextField.text trim];
    
    [params setSafeObject:name forKey:@"name"];
    
    [MineRequest changeNameWithParams:params success:^{
        
        [[UserService sharedService] updateInfo:name for:@"name"];
        
        [self clickback];
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
        
    }];

}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self handleCompleteButton];
    return YES;
}

@end
