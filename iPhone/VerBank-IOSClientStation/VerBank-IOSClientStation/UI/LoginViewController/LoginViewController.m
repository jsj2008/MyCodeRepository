//
//  LoginViewController.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+CustomColor.h"
#import "IosLogic.h"
#import "UIFormat.h"
#import "UIImage+CustomButton.h"
#import "CustomSecmentControl.h"
#import "UIColor+CustomColor.h"

#import "SaveDataCaptain.h"
#import "LangCaptain.h"
#import "SaveDataCaptain.h"
#import "ResizeForKeyboard.h"
#import "ShowAlert.h"
#import "MTP4CommDataInterface.h"
#import "IosConfig.h"
#import "IosLayoutDefine.h"
#import "ChooseViewController.h"
#import "CommDataUtil.h"

#import "UserDefaultsSettingKey.h"
#import "ClientSystemConfig.h"
#import "TradeApi.h"

#import "CommDocCaptain.h"
#import "AppConfig.h"
#import "CertificateUtil.h"
#import "PasswordChangePopView.h"
#import "UserNameChangePopView.h"
#import "NoticeView.h"
#import "JBNoticeView.h"
#import "ClientAPI.h"

#import "CustomTranslate.h"

#import "SendDeviceUtil.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface LoginViewController()<ZLKeyboardDelegate, CustomSecmentControlViewDelegate, UITextFieldDelegate>{
    Boolean isSelectSave;
    //    CustomSecmentControl *segment;
    CGFloat currentY;
    
    UITextField *currentFeild;
    
    NSString *_replaceAiedString;
    
    //    UIAlertView *alert;
    LoginResult *nResult;
}

@end

@implementation LoginViewController

@synthesize backgroundImageView = _backgroundImageView;
@synthesize logoImageView = _logoImageView;
@synthesize aeidTextFild = _aeidTextFild;
@synthesize userNameTextFild = _userNameTextFild;
@synthesize passwordTextFild = _passwordTextFild;
@synthesize chooseButton = _chooseButton;
@synthesize loginButton = _loginButton;
@synthesize langChooseButton = _langChooseButton;
@synthesize segmentControlView = _segmentControlView;

@synthesize helpButton = _helpButton;
@synthesize helpLabel = _helpLabel;

//- (void)loadView{
//    [super loadView];
//    //
//    //        NSArray *familyNames = [UIFont familyNames];
//    //
//    //        for( NSString *familyName in familyNames ){
//    //
//    //            printf( "Family: %s \n", [familyName UTF8String] );
//    //
//    //            NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//    //
//    //            for( NSString *fontName in fontNames ){
//    //
//    //                printf( "\tFont: %s \n", [fontName UTF8String] );
//    //
//    //            }
//    //
//    //        }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化 之前
    [self beforeInit];
    
    // 初始化 配置信息
    [self initIosConfig];
    
    [self initLayout];
    
    [self addTarget];
    
    [ClientSystemConfig getInstance];
    
    if ([self isJailBreak]) {
        [self showJBNoticeView];
    }

//    [[AppConfig getInstance] saveConfigData];
//    TTrade *trade1 = [[TTrade alloc] init];
//    [trade1 setBuysell:1];
//    NSMutableArray *temp = [[NSMutableArray alloc] init];
//
//    
//    [temp addObject:trade1];
//    NSMutableArray *aTemp = [[NSMutableArray alloc] initWithArray:temp];
//    NSMutableArray *bTemp = [temp mutableCopy];
//    [trade1 setBuysell:100];

    /*
     if (![[[SaveDataCaptain getInstance] notFirstLaunch] isEqualToString:@"true"]) {
     [self showSandBoxNoticeView];
     [[SaveDataCaptain getInstance] setNotFirstLaunch:@"true"];
     [[SaveDataCaptain getInstance] saveConfigData];
     }
     */
    
}

- (void)beforeInit{
    _replaceAiedString = @"";
    self.loginButton.enabled  = false;
}

- (void)initLayout{
    // backgroundView
    [self.backgroundImageView setBackgroundColor:[UIColor backgroundColor]];
    
    // logoView
    [self.logoImageView setImage:[UIImage imageNamed:@"images/logo/logo.png"]];
    
    // chooseButton
    [self updateChooseButtonImage];
    [self.chooseButton setTitle:@"" forState:UIControlStateNormal];
    
    if (IOS7_OR_LATER) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (void)initIosConfig{
    BOOL bIosConfig = YES;
    //ClientConfig文件配置
    bIosConfig = bIosConfig && [IosConfig loadClientConfig];
    bIosConfig = bIosConfig && [IosConfig loadAddressInfoForLogin];
    
    if(bIosConfig){
        self.loginButton.enabled  = YES;
        isSelectSave = [[SaveDataCaptain getInstance] isSaveConfigData];
    }else{
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SystemNotice"] andMessage:[[LangCaptain getInstance] getLangByCode:@"SystemInitDocFailed"]];
    }
}

- (void)viewWillLayoutSubviews{
    // 会调用多次
    [UIFormat setViewStyle:self.loginButton
       withBackgroundColor:nil
        andTextNormalColor:[UIColor whiteColor]
          andTextHighColor:[UIColor whiteColor]
               andTextFont:nil
                 andCorner:UIRectCornerAllCorners];
    //    [UIFormat setComplexBlueButtonColor:self.loginButton];
    //    [self.loginButton setBackgroundColor:[UIColor whiteColor]];
    
    [UIFormat setViewStyle:self.langChooseButton
       withBackgroundColor:[UIColor grayColor]
        andTextNormalColor:[UIColor whiteColor]
          andTextHighColor:[UIColor whiteColor]
               andTextFont:[UIFont systemFontOfSize:10.0f]
                 andCorner:UIRectCornerAllCorners];
    
  
    
}

- (void)keyboardInit{
    ZLKeyboard *keyboard = [[ZLKeyboard alloc] initWithType:LoginNumberKeyboard];
    keyboard.delegate = self;
    self.keyboard = keyboard;
    self.userNameTextFild.inputView = self.keyboard;
    self.passwordTextFild.inputView = self.keyboard;
    self.aeidTextFild.inputView = self.keyboard;
    //    [self.aeidTextFild setDelegate:self];
    //    [self.userNameTextFild setDelegate:self];
    //
    //    [self.userNameTextFild setDelegate:self];
    //    [self.passwordTextFild setDelegate:self];
    //    [self.aeidTextFild setDelegate:self];
    //    [self.userNameTextFild becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // langChooseButton
    self.langChooseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.langChooseButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // chooseLabel
    //    [self.chooseLabel setFont:[UIFont fontWithName:nil size:10.0f]];
    [self.chooseLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [self.chooseLabel setTextColor:[UIColor whiteColor]];
    
    // helpLable
    [self.helpLabel setTextColor:[UIColor whiteColor]];
    [self.helpLabel setFont:[UIFont systemFontOfSize:10.0f]];
    
    // helpButton
    //    [self.helpButton setBackgroundImage:[UIImage imageNamed:@"images/normal/help.png"] forState:UIControlStateNormal];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 15, 15)];
    [imageView setImage:[UIImage imageNamed:@"images/normal/help.png"]];
    [self.helpButton addSubview:imageView];
    [self.helpButton setTitle:@"" forState:UIControlStateNormal];
    [self updateLang];
    
    NSString *identifyNumber = [[SaveDataCaptain getInstance] identifyNumber];
    if (identifyNumber == nil || [identifyNumber isEqualToString:@""]) {
        [self.aeidTextFild setText:@""];
    } else {
        _replaceAiedString = [CommDataUtil getHiddenString:identifyNumber];
        [self.aeidTextFild setText:[CommDataUtil convertHiddenCode:identifyNumber]];
    }
    
    ////////
        NSString *userName = [[SaveDataCaptain getInstance] userName];
        if (userName == nil || [userName isEqualToString:@""]) {
            [self.userNameTextFild setText:@""];
        } else {
            [self.userNameTextFild setText:userName];
        }
    
        NSString *password = [[SaveDataCaptain getInstance] password];
        if (password == nil || [password isEqualToString:@""]) {
            [self.passwordTextFild setText:@""];
        } else {
            [self.passwordTextFild setText:password];
        }
    ///////////
    
    NSString *aiedString = [[LangCaptain getInstance] getLangByCode:@"IdentifyNumber"];
    NSString *userNameString = [[LangCaptain getInstance] getLangByCode:@"UserName"];
    NSString *passwordString = [[LangCaptain getInstance] getLangByCode:@"Password"];
    
    [self.aeidTextFild setPlaceholder:aiedString];
    [self.userNameTextFild setPlaceholder:userNameString];
    [self.passwordTextFild setPlaceholder:passwordString];
    self.aeidTextFild.textAlignment = NSTextAlignmentCenter;
    self.userNameTextFild.textAlignment = NSTextAlignmentCenter;
    self.passwordTextFild.textAlignment = NSTextAlignmentCenter;
    [self.aeidTextFild setDelegate:self];
    [self.userNameTextFild setDelegate:self];
    [self.passwordTextFild setDelegate:self];
    [self.passwordTextFild setSecureTextEntry:YES];
    [self.userNameTextFild setSecureTextEntry:YES];
    
    [self keyboardInit];
    
    [UIFormat setComplexBlueButtonColor:self.loginButton];
}

- (void)addTarget{
    [self.loginButton addTarget:self action:@selector(jumpToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseButton addTarget:self action:@selector(changeChooseButtonImage) forControlEvents:UIControlEventTouchUpInside];
    [self.langChooseButton addTarget:self action:@selector(changeLang) forControlEvents:UIControlEventTouchUpInside];
    //    [self.helpButton addTarget:self action:@selector(showHelpView) forControlEvents:UIControlEventTouchUpInside];
    [_helpLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHelpView)]];
    [_privateButton addTarget:self action:@selector(showPrivateView) forControlEvents:UIControlEventTouchUpInside];
    [_segmentControlView setSegmentDelegate:self];
}

- (void)showHelpView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:backView];
    NoticeView *noticeView = [NoticeView newInstance];
    [noticeView setShowViewTitle:[[LangCaptain getInstance] getLangByCode:@"NoticeTitle"]];
    [noticeView setShowViewContent:[[LangCaptain getInstance] getLangByCode:@"NoticeContent"]];
    [backView addSubview:noticeView];
}

- (void)showPrivateView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:backView];
    NoticeView *noticeView = [NoticeView newInstance];
    [noticeView setShowViewTitle:[[LangCaptain getInstance] getLangByCode:@"PrivateTitle"]];
    [noticeView setShowViewContent:[[LangCaptain getInstance] getLangByCode:@"PrivateContent"]];
    [backView addSubview:noticeView];
}

- (void)showJBNoticeView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:backView];
    JBNoticeView *noticeView = [JBNoticeView newInstance];
    [noticeView.contentTextView setText:[[LangCaptain getInstance] getLangByCode:@"JBNoticeContent"]];
    [backView addSubview:noticeView];
}

- (void)showSandBoxNoticeView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:backView];
    JBNoticeView *noticeView = [JBNoticeView newInstance];
    [noticeView.contentTextView setText:[[LangCaptain getInstance] getLangByCode:@"SandBoxNoticeContent"]];
    [backView addSubview:noticeView];
}

- (void)jumpToMainViewController{
    
    if(![self isValiedPasswordAndUsername]){
        return;
    }
    
    [_aeidTextFild resignFirstResponder];
    [_userNameTextFild resignFirstResponder];
    [_passwordTextFild resignFirstResponder ];
    [ResizeForKeyboard setViewPosition:self.view forY:0];
    
    NSString *aeid = self.aeidTextFild.text;
    self.aeidTextFild.text = [aeid uppercaseString];
    
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLogin"] onView:self.view];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableString *aeidString =  [[NSMutableString alloc] initWithString:self.aeidTextFild.text];
        [aeidString replaceOccurrencesOfString:@"****" withString:_replaceAiedString options:NSLiteralSearch range:NSMakeRange(0, [aeidString length])];
        
        nResult = [[IosLogic getInstance] loginWithUserName:self.userNameTextFild.text
                                                       aied:aeidString
                                                   password:self.passwordTextFild.text
                                                     isLive:[_segmentControlView selectIndex] == 0 ? true : false];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
            
            if([nResult result] == USERIDENTIFY_RESULT_SUCCEED){
                
                if ([nResult passwordNeedChange]) {
                    // 修改密碼
                    PasswordChangePopView *passwordChangePopView = [[PasswordChangePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) leftButton:false];
                    [self.view addSubview:passwordChangePopView];
                    
                    
                    return;
                }
                if ([nResult userNameNeedChange]) {
                    // 修改使用者代碼
                    UserNameChangePopView *userNameChangePopView = [[UserNameChangePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) leftButton:false];
                    [self.view addSubview:userNameChangePopView];
                    return;
                }
                
                [self login];
                
            }else{
                NSString * errMsg=[[LangCaptain getInstance] getResultByCode:[@([nResult result]) stringValue]];
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"] andMessage:errMsg];
            }
        });
    });
}

- (void)checkNeedChangeUserName {
    if ([nResult userNameNeedChange]) {
        // 修改使用者代碼
        UserNameChangePopView *userNameChangePopView = [[UserNameChangePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) leftButton:false];
        [self.view addSubview:userNameChangePopView];
    }
}

- (void)login {
    if ([[nResult accountBasicArray] count] == 1) {
        
        if ([[DataCenter getInstance] messageIsAllRead]) {
            [[IosLogic getInstance] gotoQuoteListViewController];
        } else {
            [[IosLogic getInstance] gotoMessageViewController];
        }
        
        long long account= [[[nResult accountBasicArray] objectAtIndex:0] getAccount];
        
        //        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
        [SendDeviceUtil sendDevice:[@(account) stringValue]];
        [SendDeviceUtil sendPriceWarningRead];
        [[OperationRecordsSave getInstance] sendToServer];
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_LOGIN subType:APP_OPT_TYPE_NONE];
        
        //        [NSThread detachNewThreadSelector:@selector(setDeviceToken:)
        //                                 toTarget:self
        //                               withObject:[@(account) stringValue]];
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //            [[TradeApi getInstance] setDeviceTokenAeid:self.aeidTextFild.text
        //                                             accountID:[[nResult accountBasicArray] objectAtIndex:0]
        //                                             groupName:[[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:account]
        //                                           deviceToken:deviceToken
        //                                            deviceType:PUSH_TYPE_IPHONE];
        //        });
    } else {
        [[IosLogic getInstance] gotoChooseViewController:AccountChoose
                                             chooseArray:[nResult accountBasicArray]];
    }
    
    if ([CertificateUtil checkTradeCertState]) {
        FnCertState *certState = [[DataCenter getInstance] fnCertState];
        if (certState != nil) {
            NSString *endtime = [JEDIDateTime getCertificateTimeString:[certState getEndValidTime]];
            NSDate * endDate = [JEDIDateTime dateFromString:endtime withFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeInterval time = [endDate timeIntervalSinceDate:[NSDate new]];
            int day = time / 3600 / 24;
            if (day <= 30) {
                // 这个标志暂时没用
                //                [[DataCenter getInstance] setIsNeedShowCertificateEndTime:true];
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"CertificateBecomingDue"]];
            }
            
            //            NSLog(@"inteerval time is ........ %f", time);
            //            NSLog(@"inteerval day is ........... %f", time / 3600 / 24);
            //            NSDate *endDate = [NSDate date][certState getEndValidTime];
        }
    }
    
    if (isSelectSave) {
        [[SaveDataCaptain getInstance] setIsSaveConfigData:@"true"];
    } else {
        [[SaveDataCaptain getInstance] setIsSaveConfigData:@"false"];
    }
    
    NSMutableString *aeidString = [[NSMutableString alloc] initWithString:self.aeidTextFild.text];
    [aeidString replaceOccurrencesOfString:@"****" withString:_replaceAiedString options:NSLiteralSearch range:NSMakeRange(0, [aeidString length])];
    
    NSString *aied = isSelectSave ? aeidString : @"";
    NSString *userName = isSelectSave ? self.userNameTextFild.text : @"";
    NSString *password = isSelectSave ? self.passwordTextFild.text : @"";
    [[SaveDataCaptain getInstance] setIdentifyNumber:aied];
    [[SaveDataCaptain getInstance] setUserName:userName];
    [[SaveDataCaptain getInstance] setPassword:password];
    [[SaveDataCaptain getInstance] saveConfigData];
}

//- (void)setDeviceToken:(id)account {
//    int time = 3;
//    while (time > 0) {
//        time--;
//        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
//        TradeResult *result = [[TradeApi getInstance] setDeviceTokenAeid:[[ClientAPI getInstance] aeid]
//                                                               accountID:account
//                                                               groupName:[[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:[account longLongValue]]
//                                                             deviceToken:deviceToken
//                                                              deviceType:PUSH_TYPE_IPHONE];
//        [NSThread sleepForTimeInterval:3];
//        if ([result succeed]) {
//            return;
//        }
//    }
//    NSLog(@"device token register failed");
//}


- (Boolean)isValiedPasswordAndUsername{
    if (self.aeidTextFild == nil || self.aeidTextFild.text == nil || self.aeidTextFild.text.length == 0) {
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"AeidIsNill"]];
        return false;
    }
    
    //    if(self.userNameTextFild == nil || self.userNameTextFild.text == nil || self.userNameTextFild.text.length == 0){
    //        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
    //                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"UserNameIsNill"]];
    //        return false;
    //    }
    
    if(self.passwordTextFild == nil || self.passwordTextFild.text == nil || self.passwordTextFild.text.length == 0){
        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"PwdIsNill"]];
        return false;
    }
    
    //    if(self.userNameTextFild.text.length == 0 || self.passwordTextFild.text.length == 0 || self.aeidTextFild.text.length == 0){
    //        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
    //                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"PwdOrUserNameisNill"]];
    //        return false;
    //    }
    
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    currentFeild = textField;
    if (currentFeild == self.passwordTextFild || currentFeild == self.userNameTextFild) {
        [self.keyboard setIsNeedPwd:true];
        
    } else {
        [self.keyboard setIsNeedPwd:false];
    }
    
    [self.keyboard setCurrentTextField:currentFeild];
    [self.keyboard resetInputString:textField.text];
    //    [self.keyboard setNeedsLayout];
    [self.keyboard setNeedsDisplay];
    currentY = textField.frame.origin.y;
    [ResizeForKeyboard setViewPosition:self.view forY:DISTANCE_FROM_TOP - currentY];
    
    //    UITextPosition * start = currentFeild.selectedTextRange.start;
    //    UITextPosition *position = [currentFeild positionFromPosition:start offset:-2];
    //    //    self.currentTextField.text = [self.currentTextField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    //    UITextRange *textRange = [currentFeild textRangeFromPosition:position toPosition:position];
    //    [currentFeild setSelectedTextRange:textRange];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [ResizeForKeyboard setViewPosition:self.view forY:0];
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma update
- (void)updateChooseButtonImage{
    NSString *imagePath = @"";
    if (isSelectSave) {
        imagePath = @"images/normal/select.png";
    } else {
        imagePath = @"images/normal/unselect.png";
    }
    [self.chooseButton setBackgroundImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
}

- (void)updateLang{
    [self.chooseLabel setText:[[LangCaptain getInstance] getLangByCode:@"SaveIdentifyNumber"]];
    if ([[LangCaptain getInstance] isLangTW]) {
        [self.langChooseButton setTitle:[[LangCaptain getInstance] getLangByCode:@"LangTW"] forState:UIControlStateNormal];
    } else {
        [self.langChooseButton setTitle:[[LangCaptain getInstance] getLangByCode:@"LangCN"] forState:UIControlStateNormal];
    }
    
    [self.loginButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Login"] forState:UIControlStateNormal];
    
    NSString *liveAccountLang = [[LangCaptain getInstance] getLangByCode:@"LiveAccount"];
    NSString *demoAccountLang = [[LangCaptain getInstance] getLangByCode:@"DemoAccount"];
    NSArray *titleArray = @[liveAccountLang, demoAccountLang];
    [_segmentControlView updateTitle:titleArray];
    
    //        for (UIView *view in [_segmentControlView subviews]) {
    //            [view setUserInteractionEnabled:false];
    //        }
    
    [self.helpLabel setText:[[LangCaptain getInstance] getLangByCode:@"Help"]];
    [_privateButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Private"] forState:UIControlStateNormal];
    
    //    NSLog(@"%@", [[UIDevice currentDevice] systemVersion]);
}

- (void)changeLang{
    if ([[LangCaptain getInstance] isLangTW]) {
        [[LangCaptain getInstance] setLangCN];
    } else{
        [[LangCaptain getInstance] setLangTW];
    }
    [self updateLang];
}

- (void)changeChooseButtonImage{
    isSelectSave = !isSelectSave;
    [self updateChooseButtonImage];
}

#pragma segmentDelegate
- (void)customSecmentControlClick:(NSInteger)index{
    if (index == 0) {
        [[IosLogic getInstance] setIsLive:true];
    } else {
        [[IosLogic getInstance] setIsLive:false];
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma keyboardDelegate

- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string{
    if(currentFeild == self.aeidTextFild) {
        UITextRange *range = currentFeild.selectedTextRange;
        [keyboard resetInputString:[string uppercaseString]];
        currentFeild.text = [string uppercaseString];
        [currentFeild setSelectedTextRange:range];
    } else {
        UITextRange *range = currentFeild.selectedTextRange;
        currentFeild.text = string;
        [currentFeild setSelectedTextRange:range];
    }
}

- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string {
    if (currentFeild == self.passwordTextFild) {
        currentFeild.text = @"";
        [keyboard resetInputString:@""];
    }
}

- (void)keyboardReturn {
    [currentFeild resignFirstResponder];
    [ResizeForKeyboard setViewPosition:self.view forY:0];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#define USER_APP_PATH                 @"/User/Applications/"
- (BOOL)isJailBreak {
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
        NSLog(@"The device is jail broken!");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
        NSLog(@"applist = %@", applist);
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

@end
