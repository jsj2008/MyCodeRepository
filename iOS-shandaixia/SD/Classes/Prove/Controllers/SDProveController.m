//
//  SDProveController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/23.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDProveController.h"
#import "SDProveHeaderView.h"

@interface SDProveController ()

@end

@implementation SDProveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self createNavBarWithTitle:@"基础认证" titleColor:[UIColor whiteColor] backImageNamed:@"icon_black_move_normal" backGroundColor:[UIColor clearColor]];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
}

- (void)addHeaderWithImage:(NSString *)imageNamed{
    
    //蓝色背景
    CGFloat blueH = 314 * SCALE;
    SDProveHeaderView *blueView = [[SDProveHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, blueH)];
    blueView.progressImageView.image = [UIImage imageNamed:imageNamed];
    blueView.backgroundColor = FDColor(70, 151, 251);
    self.blueView = blueView;
    [self.view addSubview:blueView];
    
    
    //保障文本
    UILabel *safeLabel = [UILabel labelWithText:@"我们将依法保障你的个人信息安全" textColor:FDColor(153,153,153) font:22 * SCALE textAliment:1];
    safeLabel.frame = CGRectMake(0, SCREENHEIGHT - 52 * SCALE, SCREENWIDTH, 22 * SCALE);
    [self.view addSubview:safeLabel];
    
}

- (void)addContentWithImageNamed:(NSString *)imageNamed{
    
    //图片
    CGFloat imageY = (60 + 314) * SCALE;
    UIImageView *startImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    
    self.imageNamed = imageNamed;
    startImageView.y = imageY;
    startImageView.centerX = SCREENWIDTH/2;
    [startImageView sizeToFit];
    
    [self.view addSubview:startImageView];
    
    //开始验证按钮
    CGFloat buttonY = CGRectGetMaxY(startImageView.frame) + 60 * SCALE;
    CGFloat buttonX = 30 * SCALE;
    CGFloat buttonW = SCREENWIDTH - 2 * buttonX;
    CGFloat buttonH = 100 * SCALE;
    
    NSString *title;
    if ([imageNamed isEqualToString:@"bg_icon_OK"]) {
        
        title = @"开始借款";
    }else{
    
        title = @"开始验证";
    }
    
    UIButton *startButton = [UIButton roundButtonWithTitle:title titleColor:[UIColor whiteColor] titleFont:36 * SCALE backgroundColor:FDColor(70, 151, 251) frame:CGRectMake(buttonX,buttonY,buttonW,buttonH)];
    [self.view addSubview:startButton];
    
    [startButton addTarget:self action:@selector(startButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)startButtonDidClicked{

    
}

@end






