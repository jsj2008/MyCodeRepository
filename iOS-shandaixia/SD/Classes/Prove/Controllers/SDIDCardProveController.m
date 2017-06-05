//
//  SDIDCardProveController.m
//  SD
//
//  Created by 余艾星 on 17/2/28.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDIDCardProveController.h"
#import "SDLoginButton.h"

#import "OliveappCaptureDatabaseImageViewController.h"
#import "OliveappCaptureIDCardPhotoViewController.h"

#import "OliveappOnDatabaseImageCapturedEventListener.h"
#import "OliveappIdcardCaptorViewController.h"
#import "OliveappIdcardCaptorResultDelegate.h"
#import "OliveappLivenessDetectionViewController.h"

#import "SDUserInfo.h"

#import "SDAccount.h"
#import "SDNameProveController.h"
#import "SDIDCradInfoController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface SDIDCardProveController ()<OliveappOnDatabaseImageCapturedEventListener,OliveappIdcardCaptorResultDelegate>

@property (nonatomic, weak) UIButton *cardBackButton;

@property (nonatomic, weak) UIButton *cardFontButton;

@property (nonatomic, weak) SDLoginButton *startButton;

@property (nonatomic, copy) NSString *fontBase;

@property (nonatomic, copy) NSString *backBase;

@property (nonatomic, strong) SDUserInfo *userInfo;

@end

@implementation SDIDCardProveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"身份证识别" titleColor:[UIColor whiteColor] backImageNamed:@"icon_black_move_normal" backGroundColor:[UIColor clearColor]];
    
    
    self.view.backgroundColor = FDColor(70, 151, 251);
    
    [self addUI];
    
}

- (void)addUI{

    UIImageView *idNoteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prove_IDCard_note_label"]];
    [idNoteImageView sizeToFit];
    idNoteImageView.centerX = SCREENWIDTH/2;
    idNoteImageView.y = 179 * SCALE;
    [self.view addSubview:idNoteImageView];
    
    
    UIImageView *cardFontImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"id_card1"]];
    [cardFontImageView sizeToFit];
    cardFontImageView.centerX = SCREENWIDTH/2;
    cardFontImageView.y = CGRectGetMaxY(idNoteImageView.frame) + 40 * SCALE;
    [self.view addSubview:cardFontImageView];
    UIButton *cardFontButton = [[UIButton alloc] init];
    self.cardFontButton = cardFontButton;
    cardFontButton.frame = cardFontImageView.frame;
    [self.view addSubview:cardFontButton];
    [cardFontButton addTarget:self action:@selector(cardButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *cardBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"id_card2"]];
    [cardBackImageView sizeToFit];
    cardBackImageView.centerX = SCREENWIDTH/2;
    cardBackImageView.y = CGRectGetMaxY(cardFontButton.frame) + 40 * SCALE;
    [self.view addSubview:cardBackImageView];
    UIButton *cardBackButton = [[UIButton alloc] init];
    self.cardBackButton = cardBackButton;
    
    cardBackButton.frame = cardBackImageView.frame;
    [self.view addSubview:cardBackButton];
    [cardBackButton addTarget:self action:@selector(cardButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    CGFloat x = 30 * SCALE;
    SDLoginButton *startButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(cardBackButton.frame) + 50 * SCALE, SCREENWIDTH - 2 * x, 100 * SCALE)];
    [startButton setTitle:@"开始识别" forState:UIControlStateNormal];
    startButton.backgroundColor = FDColor(255, 213, 49);
    
    [startButton setTitleColor:FDColor(153, 108, 0) forState:UIControlStateNormal];
    [self.view addSubview:startButton];
    [startButton addTarget:self action:@selector(cardButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cardFontButton.tag = 0;
    cardBackButton.tag = 1;
    startButton.tag = 2;
    //保障文本
    UILabel *safeLabel = [UILabel labelWithText:@"我们将依法保障你的个人信息安全" textColor:[UIColor whiteColor] font:22 * SCALE textAliment:1];
    safeLabel.frame = CGRectMake(0, SCREENHEIGHT - 42 * SCALE, SCREENWIDTH, 22 * SCALE);
    [self.view addSubview:safeLabel];
    
}

- (void)cardButtonDidClicked:(UIButton *)sender{
    

    self.cardBackButton.selected = self.cardFontButton.selected = self.startButton.selected = NO;
    sender.selected = YES;
    
    //使用下面代码可以使用自动捕获身份证照
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"IdcardCaptor" bundle: nil];
    OliveappIdcardCaptorViewController * idcardCaptorViewController = (OliveappIdcardCaptorViewController*) [board instantiateViewControllerWithIdentifier: @"idcardCaptorStoryboard"];
    
    //设置回调函数，记得将这个ViewController加上protocol <OliveappAsyncIdcardCaptorDelegate>
    if (sender.tag == 0) {
        
        //判断是否已授权
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == ALAuthorizationStatusDenied||authStatus == ALAuthorizationStatusRestricted) {
                [@"请在设置->隐私->相机中允许访问" showNotice];
                return ;
            }  
        }
        
        // 身份证正面
        [idcardCaptorViewController setDelegate:self
                                   withCardType:FRONT_IDCARD
                                withCaptureMode:MIXED_MODE
                             withDurationSecond:20];
        
        [self presentViewController:idcardCaptorViewController animated:YES completion:nil];
        
    } else if (sender.tag == 1) {
        
        //判断是否已授权
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == ALAuthorizationStatusDenied||authStatus == ALAuthorizationStatusRestricted) {
                [@"请在设置->隐私->相机中允许访问" showNotice];
                return ;
            }
        }
        
        // 身份证反面
        [idcardCaptorViewController setDelegate:self
                                   withCardType:BACK_IDCARD
                                withCaptureMode:MIXED_MODE
                             withDurationSecond:20];
        
        [self presentViewController:idcardCaptorViewController animated:YES completion:nil];
    }else{
    
        [SVProgressHUD showWithStatus:@"正在验证"];
        
        self.view.userInteractionEnabled = NO;
        
        if (self.backBase.length > 0 && self.fontBase.length > 0) {
            
            

            [SDAccount idCardInfoWithCardTypeFront:self.fontBase cardTypeBack:self.backBase finishedBlock:^(id object) {
                
                [SVProgressHUD dismiss];
                
                self.view.userInteractionEnabled = YES;
                
                SDUserInfo *userInfo = object;
                
                
                if (userInfo.idCard.length) {
                    
                    SDIDCradInfoController *cardCon = [[SDIDCradInfoController alloc] init];
                    
                    cardCon.userInfo = object;
                    
                    [self.navigationController pushViewController:cardCon animated:YES];
                }else{
                    
                    [self clearData];
                
                    [@"获取身份信息失败,请重试" showNotice];
                }
                
            } failuredBlock:^(id object) {
                
                [SVProgressHUD dismiss];
                self.view.userInteractionEnabled = YES;
                
                [self clearData];
                
                
                [@"解析身份证失败, 请重试" showNotice];
            }];
        }else{
        
            self.view.userInteractionEnabled = YES;
            [@"请先添加身份信息" showNotice];
            
            [SVProgressHUD dismiss];
        }
    }
    
}

- (void)clearData{

    [self.cardBackButton setImage:[UIImage imageWithBgColor:[UIColor clearColor]] forState:UIControlStateNormal];
    
    [self.cardFontButton setImage:[UIImage imageWithBgColor:[UIColor clearColor]] forState:UIControlStateNormal];
    self.fontBase = self.backBase = @"";
    
}

/**
 *  捕获身份证算法的回调
 *  @param imgData 捕获到的身份证照，如需网络传输，请调用UIImageJPEGRepresentation(imageContent, 0.7)
 */


- (void) onDetectionSucc: (NSData *) imgData {
    
    FDLog(@"success ------------");
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //显示翻拍照结果
        UIImage * idcardImage = [UIImage imageWithData:imgData];
        if (self.cardFontButton.selected) {
            
            self.fontBase = [imgData base64EncodedStringWithOptions:0];
            
            
            [self.cardFontButton setImage:idcardImage forState:UIControlStateNormal];
        }else if(self.cardBackButton.selected){
        
            self.backBase = [imgData base64EncodedStringWithOptions:0];
            
            [self.cardBackButton setImage:idcardImage forState:UIControlStateNormal];
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    });
}




/**
 *  身份证翻拍用户点击取消按钮后的响应事件
 */
- (void) onCancelCapture {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  身份证捕获界面取消的回调
 */
- (void) onIdcardCaptorCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBtnDidTouch{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
