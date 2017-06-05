//
//  SDIDCradInfoController.m
//  SD
//
//  Created by 余艾星 on 17/3/1.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDIDCradInfoController.h"
#import "SDIDCradInfoView.h"
#import "SDIDCardHeaderView.h"
#import "OliveappLivenessDetectionViewController.h"
#import "SDAccount.h"
#import "SDNameProveController.h"
#import "SDProveRelationController.h"

@interface SDIDCradInfoController ()

@property (nonatomic, weak) SDIDCardHeaderView *blueView;

@end

@implementation SDIDCradInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"身份证识别" titleColor:[UIColor whiteColor] backImageNamed:@"icon_black_move_normal" backGroundColor:[UIColor clearColor]];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    
    [self addHeaderWithImage:@"bigicon_card-1"];
    
}

- (void)addHeaderWithImage:(NSString *)imageNamed{
    
    //蓝色背景
    CGFloat blueH = 431 * SCALE;
    SDIDCardHeaderView *blueView = [[SDIDCardHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, blueH) imageNamed:imageNamed];
    
    blueView.backgroundColor = FDColor(70, 151, 251);
    self.blueView = blueView;
    [self.view addSubview:blueView];
    
    //个人信息
    SDIDCradInfoView *infoView = [[SDIDCradInfoView alloc] initWithFrame:CGRectMake(0, blueH, SCREENWIDTH, 380 * SCALE)];
    
    infoView.userInfo = self.userInfo;
    
    [self.view addSubview:infoView];
    
    //开始验证按钮
    CGFloat buttonY = CGRectGetMaxY(infoView.frame) + 60 * SCALE;
    CGFloat buttonX = 30 * SCALE;
    CGFloat buttonW = SCREENWIDTH - 2 * buttonX;
    CGFloat buttonH = 100 * SCALE;
    
    UIButton *startButton = [UIButton roundButtonWithTitle:@"下一步" titleColor:[UIColor whiteColor] titleFont:36 * SCALE backgroundColor:FDColor(70, 151, 251) frame:CGRectMake(buttonX,buttonY,buttonW,buttonH)];
    [self.view addSubview:startButton];
    
    [startButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    
    //保障文本
    UILabel *safeLabel = [UILabel labelWithText:@"我们将依法保障你的个人信息安全" textColor:FDColor(153,153,153) font:22 * SCALE textAliment:1];
    safeLabel.frame = CGRectMake(0, SCREENHEIGHT - 52 * SCALE, SCREENWIDTH, 22 * SCALE);
    [self.view addSubview:safeLabel];
    
}

- (void)next{

    
    
    
    NSLog(@"开始活体检测");
    
    //获取活体检测的storyboard和viewcontroller对象
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"LivenessDetection" bundle: nil];
    
    
    /**
     对于iPad，活体检测有两种布局，竖屏和横屏。综合防hack,通过率和体验，强力推荐使用竖屏布局！
     */
    OliveappLivenessDetectionViewController* livenessViewController = (OliveappLivenessDetectionViewController*) [board instantiateViewControllerWithIdentifier: @"LivenessDetectionStoryboard"];
    
    //横屏布局的界面，如果要使用的话，请使用下面代码
    //    OliveappLivenessDetectionViewController* livenessViewController = (OliveappLivenessDetectionViewController*) [board instantiateViewControllerWithIdentifier: @"LivenessDetectionLandscapeStoryboard"];
    
    //以下样例代码展示了如何初始化活体检测
    __weak typeof(self) weakSelf = self;
    NSError *error;
    BOOL isSuccess;
    
    //Mode有两种模式，默认第二种，体验更好
    // INSTANT_CHANGE,活体检测动作成功后不等语音播放完就进入下一个动作
    // FLUENT_CHANGE,活体检测动作成功后会等语音播放完才进入下一个动作
    isSuccess = [livenessViewController setConfigLivenessDetection: weakSelf
                                                          withMode: FLUENT_CHANGE
                                                         withError: &error];
    //弹出活体检测界面，可用show,push
    [self presentViewController:livenessViewController animated:YES completion:nil];
}


/////////////////// 结果回调函数 /////////////////////

/**
 *  活体检测成功的回调
 *
 *  @param detectedFrame 返回检测到的图像
 */
- (void) onLivenessSuccess: (OliveappDetectedFrame*)detectedFrame {
    
    //detectedFrame中有4个用于比对的数据包，具体使用哪个数据包进行比对请咨询对接工作人员
    //对数据包进行Base64编码的方法，用户发送Http请求,下面以带翻拍的数据包为样例
    //NSString * data = [OliveappBase64Helper encode:detectedFrame.verificationDataFullWithFanpai];
    
    NSLog(@"活体检测成功");
    
    
    self.view.userInteractionEnabled = NO;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [SVProgressHUD showWithStatus:@"正在对比身份信息"];
        
        [SDAccount testUserWithOliveappDetectedFrame:detectedFrame finishedBlock:^(id object) {
            
            
            
            [SVProgressHUD dismiss];
            
            NSString *str = object[@"msg"];
            
            self.view.userInteractionEnabled = YES;
            
            
            if ([str containsString:@"成功"]) {
                
                [FDReminderView showWithString:object[@"msg"]];
                
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    
                    
                    SDProveRelationController *nameCon = [[SDProveRelationController alloc] init];
                    
                    //                nameCon.userInfo = self.userInfo;
                    
                    [self.navigationController pushViewController:nameCon animated:YES];
                    
                });
                
            }else{
                
                [FDReminderView showWithString:@"活体检测失败"];
            }
            
        } failuredBlock:^(id object) {
            
            self.view.userInteractionEnabled = YES;
            
            [FDReminderView showWithString:@"请检查网络"];
        }];
    }];
    
}


/**
 *  活体检测失败的回调
 *
 *  @param sessionState  活体检测的返回状态
 *  @param detectedFrame 返回检测到的图像
 */
- (void) onLivenessFail: (int)sessionState withDetectedFrame: (OliveappDetectedFrame*)detectedFrame {
    NSLog(@"活体检测失败");
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [@"活体检测失败,请重新检测" showNotice];
        
    }];
}




/**
 *  取消按钮的操作方法
 */
- (void) onLivenessCancel {
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBtnDidTouch{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
