//
//  SDHighProveController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/13.
//  Copyright © 2017年 tyiti. All rights reserved.
//



#import "SDHighProveController.h"
#import "SDHighProveView.h"
#import "SDSpeedView.h"
#import "SDTBController.h"
#import "SDJDController.h"
#import "SDYHController.h"
#import "SDSBController.h"
#import "SDGJJController.h"
#import "SDXXWController.h"
#import "MoxieSDK.h"
#import "SDProvinceController.h"
#import "SDCity.h"
#import "SDUserVerifyDetail.h"
#import "SDUserInfo.h"
#import "SDLendingAlertView.h"
#import "SDLoginButton.h"
#import "SDRocketAlertView.h"
#import "SDHighProveSuccessNotice.h"

@interface SDHighProveController ()<SDHighProveViewDelegate,MoxieSDKDelegate,SDLendingAlertViewDelegate>



@property (nonatomic, weak) SDHighProveView *highProveView;

@property (nonatomic, weak) SDSpeedView *speedView;

@property (nonatomic, weak) UIImageView *rocket;

@end

@implementation SDHighProveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self createNavBarWithTitle:@"高级认证提升借款速度" titleColor:[UIColor whiteColor] backImageNamed:@"icon_black_move_normal" backGroundColor:[UIColor clearColor]];
    
    [MoxieSDK shared].delegate = self;
//    [MoxieSDK shared].mxUserId = theUserID;
    [MoxieSDK shared].mxApiKey = theApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].mxUserId = [SDUserInfo getUserInfo].ID;
    [MoxieSDK shared].quitOnLoginDone = YES;
    [MoxieSDK shared].quitOnFail = YES;
    [MoxieSDK shared].useNavigationPush = NO;
    
    [MoxieSDK shared].backImage = [UIImage imageNamed:@"icon_black_move_normal"];
    
    [self addContent];
    
//    [self loadVerifyDetail];
    
    [self notice];
    
    [SDNotificationCenter addObserver:self selector:@selector(highProveSuccess:) name:SDHighProveSuccessNotification object:nil];
    
    
}

- (void)dealloc{

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
    [SDNotificationCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self loadVerifyDetail];
}

- (void)addContent{

    
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big_bg_gjrz"]];
    
    imageView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    
    [self.view addSubview:imageView];
    
    imageView.userInteractionEnabled = YES;
    
    //提速率
    CGFloat speedW = 240 * SCALE;
    CGFloat speedX = (SCREENWIDTH - speedW)/2;
    CGFloat speedY = 171 * SCALE;
    
    SDSpeedView *speedView = [[SDSpeedView alloc] initWithFrame:CGRectMake(speedX, speedY, speedW, speedW)];
    [self.view addSubview:speedView];
    self.speedView = speedView;
    
//    speedView.backgroundColor = FDRandomColor;
    
    //验证
    SDHighProveView *highProveView = [[SDHighProveView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT/2.1, SCREENWIDTH, 400)];
    highProveView.delegate = self;
    [self.view addSubview:highProveView];
    self.highProveView = highProveView;
    
    //保障信息
    UIImageView *guaranteeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"high_prove_ guarantee_label"]];
    
    [guaranteeImageView sizeToFit];
    
    guaranteeImageView.centerX = SCREENWIDTH/2;
    guaranteeImageView.y = SCREENHEIGHT - 25;
    
    [self.view addSubview:guaranteeImageView];
    
}

- (void)highProveViewButtonDidClicked:(SDProveType)type{

    switch (type) {
        case SDProveTypeTaobao:
            
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            
            [MoxieSDK shared].taskType = @"taobao";
            [[MoxieSDK shared] startFunction];
            
            
//        [self.navigationController pushViewController:[[SDTBController alloc] init] animated:YES];
        }
            
            break;
        case SDProveTypeJingdong:
            
        {
            [self.navigationController pushViewController:[[SDJDController alloc] init] animated:YES];
        }
            
            break;
        case SDProveTypeYanghang:
            
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            
            [MoxieSDK shared].taskType = @"zhengxin";
            [[MoxieSDK shared] startFunction];
//            [self.navigationController pushViewController:[[SDYHController alloc] init] animated:YES];
        }
            
            break;
        case SDProveTypeShebao:
            
        {
            SDProvinceController *pCon = [[SDProvinceController alloc] init];
            pCon.channelType = @"SHE_BAO";
            [self.navigationController pushViewController:pCon animated:YES];
            
//            [self.navigationController pushViewController:[[SDSBController alloc] init] animated:YES];
        }
            
            break;
        case SDProveTypeGongjijin:
            
        {
            
            SDProvinceController *pCon = [[SDProvinceController alloc] init];
            pCon.channelType = @"GJJ";
            [self.navigationController pushViewController:pCon animated:YES];
        }
            
            break;
        case SDProveTypeXueXinWang:
            
        {
            
            SDGJJController *gjjCon = [[SDGJJController alloc] init];
            gjjCon.channelType = @"CHSI";
            SDCity *city = [[SDCity alloc] init];
            city.code = @"000000";
            gjjCon.city = city;
            
            [gjjCon getData];
            
            [self.navigationController pushViewController:gjjCon animated:YES];
//            [self.navigationController pushViewController:[[SDXXWController alloc] init] animated:YES];
        }
            break;
            
        default:
            break;
    }

}

- (void)loadVerifyDetail{

    [SDUserVerifyDetail getUserVerifyDetailFinishedBlock:^(id object) {
        
        self.userVerifyDetail = object;
        self.highProveView.userVerifyDetail = object;
        self.speedView.userVerifyDetail = object;
        
    } failuredBlock:^(id object) {
        
    }];
    
}

- (void)notice{
    
    
    
    if ([NSString isFirstInHighProve]) {
        
        [SDRocketAlertView show];
    }
    
    
}

#pragma MoxieSDK Delegate
- (void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    
    FDLog(@"resultDictionary - %@",resultDictionary);
    
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *searchId = resultDictionary[@"searchId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,searchId:%@,message:%@,account:%@",code,taskType,taskId,searchId,message,account);
    
    
          //假如code是2则继续查询该任务进展
          if(code == 2){
              
              [SDNotificationCenter postNotificationName:SDHighProveSuccessNotification object:nil userInfo:@{SDHighProveSpeedCount:@"20"}];
              
          } //假如code是1则成功
          else if(code == 1){
              [SDNotificationCenter postNotificationName:SDHighProveSuccessNotification object:nil userInfo:@{SDHighProveSpeedCount:@"20"}];
              
          } // 户没有做任何操作
          else if(code == -1){
          } //该任务失败按失败处
          else{
          }
      
}


- (void)highProveSuccess:(NSNotification *)noti{

    NSString *speed = noti.userInfo[SDHighProveSpeedCount];
    
    [SDHighProveSuccessNotice showWithSpeed:speed];
    
}

@end











