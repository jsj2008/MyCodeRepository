//
//  STChangeGenderViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "STChangeGenderViewController.h"
#import "MineRequest.h"
#import "UserService.h"

@interface STChangeGenderViewController ()

@property (nonatomic, strong) UIView *inputBgView2;
@property (nonatomic, strong) UIImageView *iconView2;
@property (nonatomic, strong) UIView *iconBgView2;
@property (nonatomic, strong) UIButton *maleButton;
@property (nonatomic, strong) UIButton *femaleButton;

@property (nonatomic, strong) UIButton *completeButton;

@end

@implementation STChangeGenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;
    
    [self addNavigationBar];
    
    self.title = @"修改性别";
    
    [self render];
    
}

#pragma mark - Private Methods

- (void) render
{
    [self.view addSubview:self.inputBgView2];
    [self.inputBgView2 addSubview:self.iconBgView2];
    [self.inputBgView2 addSubview:self.iconView2];
    [self.inputBgView2 addSubview:self.maleButton];
    [self.inputBgView2 addSubview:self.femaleButton];
    
    if ( [@"1" isEqualToString:[UserService sharedService].gender] ) {
        
        self.maleButton.selected = YES;
        self.femaleButton.selected = NO;
        
    } else {
        
        self.maleButton.selected = NO;
        self.femaleButton.selected = YES;
        
    }
    
    [self.view addSubview:self.completeButton];
}

#pragma mark - Getters And Setters

- (UIView *)inputBgView2 {
    
    if ( !_inputBgView2 ) {
        _inputBgView2 = [[UIView alloc] initWithFrame:CGRectMake( 20, 20 + NAVBAR_HEIGHT, SCREEN_WIDTH - 40, 44)];
        _inputBgView2.layer.masksToBounds = YES;
        _inputBgView2.layer.cornerRadius = 4;
        _inputBgView2.layer.borderWidth = 1;
        _inputBgView2.layer.borderColor = Color_Gray230.CGColor;
        _inputBgView2.backgroundColor = Color_White;
    }
    
    return _inputBgView2;
}

- (UIView *)iconBgView2 {
    
    if ( !_iconBgView2 ) {
        _iconBgView2 = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 85, 44)];
        _iconBgView2.backgroundColor = Color_Gray230;
    }
    
    return _iconBgView2;
}

- (UIImageView *)iconView2
{
    if ( !_iconView2 ) {
        _iconView2 = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 28, 23)];
        _iconView2.image = [UIImage imageNamed:@"icon_set_gender"];
        _iconView2.centerX = self.iconBgView2.centerX;
        _iconView2.centerY = self.iconBgView2.centerY;
    }
    
    return _iconView2;
}

- (UIButton *)maleButton {
    
    if ( !_maleButton ) {
        _maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _maleButton.frame = CGRectMake(0, 0, 40, 44);
        _maleButton.centerY = self.iconBgView2.centerY;
        _maleButton.left = self.iconBgView2.right + 35;
        [_maleButton setTitle:@" 男" forState:UIControlStateNormal];
        [_maleButton setTitleColor:Color_Gray187 forState:UIControlStateNormal];
        [_maleButton setImage:[UIImage imageNamed:@"icon_radio_normal"] forState:UIControlStateNormal];
        [_maleButton setImage:[UIImage imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
        _maleButton.titleLabel.font = FONT(16);
        [_maleButton addTarget:self action:@selector(handleGenderButton:) forControlEvents:UIControlEventTouchUpInside];
        _maleButton.selected = YES;
    }
    
    return _maleButton;
}

- (UIButton *)femaleButton {
    
    if ( !_femaleButton ) {
        _femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _femaleButton.frame = CGRectMake(0, 0, 40, 44);
        _femaleButton.centerY = self.iconBgView2.centerY;
        _femaleButton.left = self.maleButton.right + 25;
        [_femaleButton setTitle:@" 女" forState:UIControlStateNormal];
        [_femaleButton setTitleColor:Color_Gray187 forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:@"icon_radio_normal"] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
        _femaleButton.titleLabel.font = FONT(16);
        [_femaleButton addTarget:self action:@selector(handleGenderButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _femaleButton;
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

- (void) handleGenderButton:(UIButton *)button
{
    self.maleButton.selected = NO;
    self.femaleButton.selected = NO;
    
    button.selected = YES;
    
}

- (void) handleCompleteButton
{
    NSString *gender = @"1";//男
    
    if ( self.femaleButton.selected ) {
        gender = @"2";//女
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafeObject:gender forKey:@"gender"];
    
    weakify(self);
    
    [MineRequest changeGenderWithParams:params success:^{
        
        [[UserService sharedService] updateInfo:gender for:@"gender"];
        
        strongify(self);
        
        [self clickback];
        
    } failure:^(StatusModel *status) {
        
        strongify(self);
        
        [self showNotice:status.msg];
        
    }];
    
}
@end
