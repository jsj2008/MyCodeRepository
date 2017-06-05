//
//  SDGestureController.m
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDGestureController.h"
#import "HMView.h"
#import "SDSmallGestureView.h"

@interface SDGestureController ()<HMViewDelegate>

@property (nonatomic, weak) SDSmallGestureView *smallGestureView;

@property (nonatomic, weak) UILabel *noticeLabel;

@property (nonatomic, copy) NSString *gesturePassword;

@end

@implementation SDGestureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = YPWhiteColor;
    
    [self createNavBarWithTitle:@"设置"];
    
    
    [self addUI];
    
}


- (void)addUI{
    
    CGFloat smallW = 100 * SCALE;
    
    SDSmallGestureView *smallGestureView = [[SDSmallGestureView alloc] initWithFrame:CGRectMake((SCREENWIDTH - smallW)/2, 170 * SCALE, smallW, smallW)];
    
    [self.view addSubview:smallGestureView];
    self.smallGestureView = smallGestureView;
    
    
    UILabel *noticeLabel = [UILabel labelWithText:@"请绘制手势图案, 最少四个点" textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:1];
    self.noticeLabel = noticeLabel;
    [self.view addSubview:noticeLabel];
    
    noticeLabel.frame = CGRectMake(0, 270 * SCALE + 54 * SCALE, SCREENWIDTH, 24 * SCALE);
    

    HMView *gestureView = [[HMView alloc] initWithFrame:CGRectMake(0, 400 * SCALE, SCREENWIDTH, SCREENHEIGHT)];
    gestureView.delegate = self;
    
    [self.view addSubview:gestureView];
    
}

- (void)viewTranslateDataWithView:(HMView * )view  andString:(NSString *)pwd{

    FDLog(@"pwd - %@",pwd);
    
    if (!self.gesturePassword) {
        
        if (pwd.length < 4) {
            
            [FDReminderView showWithString:@"手势密码长度太短, 请重新绘制"];
            
        }else{
        
            self.gesturePassword = pwd;
            
            self.noticeLabel.text = @"请再次绘制手势图案";
            self.noticeLabel.textColor = SDBlackColor;
        }
        
        
    }else{
    
        if (![self.gesturePassword isEqualToString:pwd]) {
            
            self.noticeLabel.text = @"与首次绘制不一致, 请重新绘制";
            self.noticeLabel.textColor = FDColor(255, 76, 76);
            
            self.gesturePassword = nil;
        }else{
        
            [FDReminderView showWithString:@"手势密码设置成功"];
            [self leftBtnDidTouch];
            [FDUserDefaults setObject:self.gesturePassword forKey:SDGusturePassword];
            [FDUserDefaults setObject:@"1" forKey:SDOpenGusturePassword];
        }
        
    }
    
    [self.smallGestureView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.backgroundColor = FDColor(207, 208, 222);
        
    }];
    
    [self.smallGestureView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *str = [NSString stringWithFormat:@"%@",@(idx)];
        
        if ([pwd containsString:str]) {
            
            obj.backgroundColor = FDColor(70, 151, 251);
        }
        
    }];
    
}

- (void)leftBtnDidTouch{

    [self dismissViewControllerAnimated:YES completion:nil];
    
//    self.navigationController
}


#pragma mark - Public
- (void)createNavBarWithTitle:(NSString *)title
{
    
    // 左侧按钮(固定)
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:leftBtn];
    [leftBtn setImage:[UIImage imageNamed:@"icon_white_move_normal"] forState:UIControlStateNormal];
    
    leftBtn.frame = CGRectMake(0, 20, 44, 44);
    [leftBtn addTarget:self action:@selector(leftBtnDidTouch) forControlEvents:UIControlEventTouchUpInside];
    
    
}


@end
