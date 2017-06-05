//
//  ViewController.m
//  YPReusableController
//
#import "ViewController.h"
#import "YPReusableController.h"
#import "YPSideController.h"

#import "YPBaseNavigationController.h"

#import "SDMainController.h"

#import "SDHeaderController.h"
#import "SDHelpController.h"
#import "SDHelpAppController.h"
#import "SDSettingController.h"
#import "SDMyDiscountController.h"
#import "SDMyLoanController.h"
#import "SDSharedController.h"
#import "SDMassageController.h"
#import "SDLoginController.h"
#import "SDLoanProcedureController.h"
#import "SDLoan.h"
#import "SDStartProveController.h"
#import "FMDeviceManager.h"

#import "SDUserInfo.h"
#import "SDLeftDetailView.h"
#import "SDHighProveController.h"
#import "SDUserVerifyDetail.h"
#import "SDProveRelationController.h"
#import "SDProveOperatorsController.h"
#import "OliveappLivenessDetectionViewController.h"
#import "SDAccount.h"
#import "SDBankCard.h"
#import "SDAddBankCardController.h"
#import "SDRefundController.h"
#import "SDLending.h"
#import "SDGestureLoginController.h"
#import "SDIDCardProveController.h"


@interface ViewController ()<SDGestureLoginControllerDelegate,SDMainControllerDelegate>

@property (nonatomic , strong) SDUserInfo *userInfo;

@property (nonatomic, strong) SDUserVerifyDetail *userVerifyDetail;

@property (nonatomic, strong) SDBankCard *defaultBankCard;

@property (nonatomic, weak) UIView *gestureView;

@property (nonatomic, strong) SDMainController *mainCon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 获取设备管理器实例
        FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
        
        // 获取设备指纹黑盒数据，请确保在应用开启时已经对SDK进行初始化，切勿在get的时候才初始化
        // 如果此处获取到的blackBox特别长(超过200字节)，说明调用get的时候init还没有完成(一般需要1-3秒)，进入了降级处理
        // 降级不影响正常设备信息的获取，只是会造成blackBox字段超长，且无法获取设备真实IP
        NSString *blackBox = manager->getDeviceInfo();
        NSLog(@"同盾设备指纹数据: %@", blackBox);

    });
    
    SDLoan *loan = [[SDLoan alloc] init];
    loan.price = 1000;
    loan.day = @(14);
    loan.charge = @(120);
    loan.discount = @(0);
    
    self.loan = loan;
    
    NSArray *titleArray = [YPCacheTool channelTitleArray];
    
    if (!titleArray) return;
    
    
    SDMainController *mainCon = [[SDMainController alloc] init];
    self.mainCon = mainCon;
    mainCon.delegate = self;

    NSArray *subViewController = @[mainCon];
    
    for (NSUInteger i = 0; i < subViewController.count; i++) {
        UIViewController *vc = subViewController[i];
        vc.yp_Title = titleArray[i];
    }
    

    YPReusableController *resusableVc = [[YPReusableController alloc] initWithParentViewController:self];
    resusableVc.subViewControllers = [subViewController copy];
    resusableVc.currentIndex = 0;
//    
////    resusableVc.leftImage_normal = [UIImage imageNamed:@"setting_accountHeadIcon"];
//    resusableVc.leftImage_normal = [UIImage imageNamed:@"home_left"];
//    resusableVc.rightImage_normal = [UIImage imageNamed:@"home_message"];
//    
    
    [resusableVc setRightBtnTouchBlock:^{
        
        SDUserInfo *userInfo = [SDUserInfo getUserInfo];
        
        if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
            
            [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
            
            
        }else{
            
            //消息
//            [self.navigationController pushViewController: animated:YES];
            
            [self presentViewController:[[SDMassageController alloc] init] animated:YES completion:nil];
        }
        
    }];
    
    [resusableVc setLeftBtnTouchBlock:^{
        
        [self loadVerifyDetails];
        
        // 开启侧滑功能
        [self.sideController presentLeftMenuViewController];
        
    }];
    
    //获取默认银行卡
    [self loadDefaultBankCard];
    
    [SDNotificationCenter addObserver:self selector:@selector(leftMenuDetailButtonDidClicked:) name:SDDetailButtonDidClickedNotification object:nil];
    
    [mainCon.loanButton addTarget:self action:@selector(loadUserVerifyDetail:) forControlEvents:UIControlEventTouchUpInside];
//    [mainCon.refundButton addTarget:self action:@selector(refundButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [SDNotificationCenter addObserver:self selector:@selector(sliderMoved:) name:SDSliderMovedNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(loanTimeChoosen:) name:SDChoosenDayNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(refundButtonDidClicked:) name:SDRefundButtonDidClickedNitification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(loginSuccess) name:SDLoginSuccessNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(loadDefaultBankCard) name:SDBankCardChangedNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(loadVerifyDetails) name:SDReceivedPushingNotification object:nil];
    
    [self judgeGesture];
    
}

- (void)mainControllerScrollDelegate{

    [self loadVerifyDetails];
    
}


- (void)loginSuccess{
    
    self.gestureView.hidden = YES;
    
    //获取默认银行卡
    [self loadDefaultBankCard];
    
    self.userVerifyDetail = nil;
    
    [self loadVerifyDetails];
    
}

- (void)loadDefaultBankCard{

    if ([SDUserInfo getUserInfo].ID.length) {
        
        [SDBankCard defaultBankCardFinishedBlock:^(id object) {
            
            self.defaultBankCard = object;
            
            
        } failuredBlock:^(id object) {
            
            
        }];
        
    };

}


- (void)refundButtonDidClicked:(NSNotification *)notification{
    
    if (self.defaultBankCard.ID.length) {
        
        SDLending *lending = notification.userInfo[SDLendingData];
        
        SDRefundController *refund = [[SDRefundController alloc] init];
        
        refund.defaultBankCard = self.defaultBankCard;
        refund.lending = lending;
        
        [self.navigationController pushViewController:refund animated:YES];
        
    }else{
        
        [self.navigationController pushViewController:[[SDAddBankCardController alloc] init] animated:YES];
        
    }

    
}

- (void)loanButtonDidClicked{
    
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
        
        [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
        
        return;
    }else{
    
        
        
        
        [self LoanBasicVerify];
        
        
        
    }
    

    


    //未登录
//    [self.navigationController presentViewController:[[SDLoginController alloc] init]  animated:YES completion:nil];
    
    
    
    
//    [self.navigationController pushViewController:[[SDHighProveController alloc] init] animated:YES];
    

}
- (void)leftMenuDetailButtonDidClicked:(NSNotification *)noti{
    
    
    
    __weak typeof(self) weakSelf = self;
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    
    
    SDLeftDetailViewButtonType tag = (SDLeftDetailViewButtonType)[noti.userInfo[SDDetailButtonDidClickedWithTag] integerValue];
    
    __block UIViewController *vc = [[UIViewController alloc] init];
     
    /*
     SDLeftDetailViewButtonTypeMyLoan,
     SDLeftDetailViewButtonTypeMyDiscount,
     SDLeftDetailViewButtonTypeShared,
     SDLeftDetailViewButtonTypeHighProve,
     SDLeftDetailViewButtonTypeSetting,
     SDLeftDetailViewButtonTypeHelpAndResponds
     */
    FDLog(@"tag --- %@",@(tag));
    
    switch (tag) {
            //我的借款
        case SDLeftDetailViewButtonTypeMyLoan:
        {
        
            if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
                
                [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
                
                return;
            }
            
            vc = [[SDMyLoanController alloc] init];
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }
            break;
            
            //我的优惠券
        case SDLeftDetailViewButtonTypeMyDiscount:
        {
            
            if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
                
                [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
                
                return;
            }
        
            vc = [[SDMyDiscountController alloc] init];
            
            [vc setValue:@"1" forKey:@"discountType"];
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }
            break;
            
            //分享好友
        case SDLeftDetailViewButtonTypeShared:
        {
            
            vc = [[SDSharedController alloc] init];
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }
            break;
            
            //设置
        case SDLeftDetailViewButtonTypeSetting:
        {
            
            if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
                
                [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
                
                return;
            }
            
            vc = [[SDSettingController alloc] init];
            
//            vc.plistName = @"YAXSetting";
            
            [vc setValue:@"YAXSetting" forKey:@"plistName"];
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }
            break;
            
            //帮助与反馈
        case SDLeftDetailViewButtonTypeHelpAndResponds:
        {
            
//            vc = [[SDHelpController alloc] init];
            vc = [[SDHelpAppController alloc] init];
            
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case SDLeftDetailViewButtonTypeHeader:
        {
            if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
                
                [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
                
                return;
            }

            vc = [[SDHeaderController alloc] init];
            
            [vc setValue:@"FDPersonalCenter" forKey:@"plistName"];
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }
            break;
        case SDLeftDetailViewButtonTypeHighProve:
        {
            

            if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
                
                [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
                
                return;
            }
            
            if (![weakSelf.userVerifyDetail.autonymStatus isEqual:@(1)]) {
                
                
                
                
                //未验证
                SDStartProveController *startCon = [[SDStartProveController alloc] init];
                [startCon addContentWithImageNamed:@"bigicon_card"];
                [startCon addHeaderWithImage:@"progress-bar1"];
                [weakSelf.navigationController pushViewController:startCon animated:YES];
                [self basicVerifyNotice];
                return;
            }else if (![weakSelf.userVerifyDetail.ocrStatus isEqual:@(1)]){
                
                
                
                
                [weakSelf next];
                
                [self basicVerifyNotice];
                return;
                
            }else if (![weakSelf.userVerifyDetail.kinsfolkStatus isEqual:@(1)]){
                
                
                
                
                [weakSelf.navigationController pushViewController:[[SDProveRelationController alloc] init] animated:YES];
                
                [self basicVerifyNotice];
                return;
                
            }else if ([self.userVerifyDetail.operatorStatus isEqual:@(0)]){
                
                
                [self.navigationController pushViewController:[[SDProveOperatorsController alloc] init] animated:YES];
                
                [self basicVerifyNotice];
                
            }else if ([self.userVerifyDetail.operatorStatus isEqual:@(2)]){
                
                [@"运营商认证中" showNotice];
            }else{
                
                vc = [[SDHighProveController alloc] init];
                
                [self.navigationController pushViewController:vc animated:NO];
                
            }

            
            
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)loadVerifyDetails{
    
    
    if ([self.userVerifyDetail.autonymStatus isEqual:@(1)] && [self.userVerifyDetail.ocrStatus isEqual:@(1)] && [self.userVerifyDetail.kinsfolkStatus isEqual:@(1)] && [self.userVerifyDetail.operatorStatus isEqual:@(1)]) return;

    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    if(userInfo.ID.length){
        
        [SDUserVerifyDetail getUserVerifyDetailFinishedBlock:^(id object) {
            
            self.userVerifyDetail = object;
            self.mainCon.userVerifyDetail = object;
            
            
        } failuredBlock:^(id object) {
            
        }];
    }
    
}

- (void)basicVerifyNotice{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [@"请先完成基础认证" showNotice];
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)loanTimeChoosen:(NSNotification *)notification{
    
    NSInteger day = [notification.userInfo[SDChoosenDay] integerValue];
    
    self.loan.day = @(day);
    self.loan.charge = @((NSInteger)(day * percent * self.loan.price));
    
}

- (void)sliderMoved:(NSNotification *)notification{
    
    //到账金额
    NSInteger receivedMoney = [notification.userInfo[SDReceivedMoney] integerValue];
    
    self.loan.price = receivedMoney;
    
    self.loan.charge = @((NSInteger)([self.loan.day floatValue] * percent * self.loan.price));
    
}

- (void)dealloc {
    
    [SDNotificationCenter removeObserver:self];
    
}

- (void)clickHighProveButton{

    
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

- (void)LoanBasicVerify{
    
    
    
    
    if (![self.userVerifyDetail.autonymStatus isEqual:@(1)]) {
        
        //未验证
        SDStartProveController *startCon = [[SDStartProveController alloc] init];
        [startCon addContentWithImageNamed:@"bigicon_card"];
        [startCon addHeaderWithImage:@"progress-bar1"];
        [self.navigationController pushViewController:startCon animated:YES];
    }else if (![self.userVerifyDetail.ocrStatus isEqual:@(1)]){
        
        
        [self next];
    }else if (![self.userVerifyDetail.kinsfolkStatus isEqual:@(1)]){
        
        
        [self.navigationController pushViewController:[[SDProveRelationController alloc] init] animated:YES];
    }
    //TODO 添加一个运营商为-1的状态,0带表没通过,1代表通过,2代表运营商认证中,-1代表认证失败,需要重新认证
    else if ([self.userVerifyDetail.operatorStatus isEqual:@(0)] || [self.userVerifyDetail.operatorStatus isEqual:@(-1)]){
        
        
        [self.navigationController pushViewController:[[SDProveOperatorsController alloc] init] animated:YES];
    }
    else if ([self.userVerifyDetail.operatorStatus isEqual:@(2)]){
        
        [@"运营商认证中" showNotice];
    }
    else{
        
        if (self.defaultBankCard.ID.length) {
            
            //    直接借款
            SDLoanProcedureController *procedureCon = [[SDLoanProcedureController alloc] init];
            
            procedureCon.plistName = @"FDProcedure";
            
            procedureCon.loan = self.loan;
            
            procedureCon.defaultBankCard = self.defaultBankCard;
            
            [self.navigationController pushViewController:procedureCon animated:YES];
            
        }else{
            
            [self.navigationController pushViewController:[[SDAddBankCardController alloc] init] animated:YES];
            
        }
        
        
    }
    
}


- (void)getDefaultBankCard{
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    if ([SDUserInfo getUserInfo].ID.length) {
        
        [self loadVerifyDetails];
    }
    
    
}

- (void)judgeGesture{

    if ([[FDUserDefaults objectForKey:SDOpenGusturePassword] isEqualToString:@"1"]) {
        
        
        
        SDGestureLoginController *gestureController = [[SDGestureLoginController alloc] init];
        
        [self addChildViewController:gestureController];
        
        gestureController.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        
        self.gestureView = gestureController.view;
        gestureController.delegate = self;
        
//        [[UIApplication sharedApplication].keyWindow addSubview:gestureController.view];
        
        [self.view addSubview:gestureController.view];
        
    }else{
        
        SDUserInfo *user = [SDUserInfo getUserInfo];
        
        if (user.ID.length){
        
            [SDNotificationCenter postNotificationName:SDLoginSuccessNotification object:nil];
        }
        //discountSum
    
//
    }

}

- (void)gestureLoginButtonDidClicked:(NSInteger)tag{

    
    
    switch (tag) {
        case 0:
        {
        
            [FDUserDefaults setObject:@"" forKey:FDUserAccount];
            [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.gestureView.hidden = YES;
                
            });

        }
            
            break;
        case 1:
            
        {
            [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
            self.gestureView.hidden = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.gestureView.hidden = YES;
                
            });
        }
            
            break;
        case 2:
        {
        
            [UIView animateWithDuration:0.3 animations:^{
                
                self.gestureView.y = SCREENHEIGHT;
                
                [SDNotificationCenter postNotificationName:SDLoginSuccessNotification object:nil];
                
            } completion:^(BOOL finished) {
                
                [self.gestureView removeFromSuperview];
                
            }];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
}

- (void)loadUserVerifyDetail:(UIButton *)button{
    
    button.userInteractionEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.userInteractionEnabled = YES;
    });
    
    [self loanButtonDidClicked];
    
    
}


@end








