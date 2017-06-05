//
//  SDNameProveController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/6.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDNameProveController.h"
#import "SDProveHeaderView.h"
#import "SDInputView.h"
#import "SDProveRelationController.h"
#import "SDUserInfo.h"

@interface SDNameProveController ()

//名字
@property (nonatomic, weak) SDInputView *nameInputView;

//身份证号码
@property (nonatomic, weak) SDInputView *idInputView;

@end

@implementation SDNameProveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addHeaderWithImage:@"progress-bar1"];
    
    [self addContent];
}

- (void)addContent{
    
    CGFloat height = 100 * SCALE;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.blueView.height + 20 * SCALE, SCREENWIDTH, 200 * SCALE)];

    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    //名字
    SDInputView *nameInputView = [[SDInputView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height) title:@"真实姓名" placeholder:@"请输入姓名"];
    self.nameInputView = nameInputView;
    [backView addSubview:nameInputView];
    
    //身份证
    SDInputView *idInputView = [[SDInputView alloc] initWithFrame:CGRectMake(0, height, SCREENWIDTH, height) title:@"身份证号" placeholder:@"请输入身份证号码"];
    self.idInputView = idInputView;
    [backView addSubview:idInputView];
    
    nameInputView.inputTextField.enabled = NO;
    idInputView.inputTextField.enabled = NO;
    
    nameInputView.inputTextField.text = self.userInfo.name;
    idInputView.inputTextField.text = self.userInfo.idCard;
    
    //虚线
    CGFloat nameX = 30 * SCALE;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(nameX, height, SCREENWIDTH - 2 * nameX, 1 * SCALE)];
    lineView.backgroundColor = FDColor(240, 240, 240);
    [backView addSubview:lineView];
    
    
    //下一步
    CGFloat buttonY = CGRectGetMaxY(backView.frame) + 60 * SCALE;
    CGFloat buttonX = 30 * SCALE;
    CGFloat buttonW = SCREENWIDTH - 2 * buttonX;
    CGFloat buttonH = height;
    
    UIButton *nextButton = [UIButton roundButtonWithTitle:@"下一步" titleColor:[UIColor whiteColor] titleFont:36 * SCALE backgroundColor:FDColor(70, 151, 251) frame:CGRectMake(buttonX,buttonY,buttonW,buttonH)];
    [self.view addSubview:nextButton];
    
    [nextButton addTarget:self action:@selector(nextButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)nextButtonDidClicked{

    [self.navigationController pushViewController:[[SDProveRelationController alloc] init] animated:YES];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.nameInputView.inputTextField endEditing:YES];
    [self.idInputView.inputTextField endEditing:YES];
    
}

- (void)leftBtnDidTouch{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
