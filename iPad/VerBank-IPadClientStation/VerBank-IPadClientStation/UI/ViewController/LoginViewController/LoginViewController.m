//
//  LoginViewController.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LoginViewController.h"
//#import "ZLKeyboard.h"
#import "LoginResult.h"
#import "IOSVersionDefine.h"
#import "IOSLayoutDefine.h"
#import "IosConfig.h"
#import "UserInforSaveCaptain.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"
#import "UIFormat.h"
#import "StringUtils.h"
#import "NoticeView.h"
#import "ResizeForKeyboard.h"
#import "IosLogic.h"
#import "UserDefaultsSettingKey.h"
#import "TradeApi.h"
#import "CommDocCaptain.h"
#import "ScreenAuotoSizeScale.h"
#import "ClientSystemConfig.h"
#import "AccountChooseView.h"
#import "ChooseDataCenter.h"

#import "CustomSegmentControl.h"
#import "UIColor+CustomColor.h"
#import "JBNoticeView.h"

#import "ZLKeyboardView.h"

#import "SendDeviceUtil.h"
#import "CheckUtils.h"
#import "LayoutCenter.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

#import "CertificateUtil.h"
#import "JumpDataCenter.h"

#import "LoginPwdContentView.h"
#import "UserNameContentView.h"
#import "ValueTimeUtil.h"

@interface LoginViewController () < UITextFieldDelegate, CustomSegmentProtocol, ZLKeyboardDelegate>{
    IBOutlet UIImageView *_backgroundImageView;
    IBOutlet UIImageView *_logoImageView;
    IBOutlet UnableTextField *_aeidTextFild;
    IBOutlet UnableTextField *_userNameTextFild;
    IBOutlet UnableTextField *_passwordTextFild;
    IBOutlet UIButton *_chooseButton;
    IBOutlet UILabel *_chooseLabel;
    
    IBOutlet UIButton *_langChooseButton;
    IBOutlet UIButton *_loginButton;
//    IBOutlet CustomSegmentControl *_segmentControlView;
    
    IBOutlet UIButton *_helpButton;
    IBOutlet UILabel *_helpLabel;
    
    IBOutlet UIButton *_privateButton;
    
    Boolean isSelectSave;
    //    CustomSecmentControl *segment;
    CGFloat currentY;
    
    UITextField *currentFeild;
    
    NSString *_replaceAiedString;
    
    //    UIAlertView *alert;
    LoginResult *nResult;
}

@property (nonatomic, retain)UIImageView *backgroundImageView;
@property (nonatomic, retain)UIImageView *logoImageView;
@property (nonatomic, retain)UnableTextField *aeidTextFild;
@property (nonatomic, retain)UnableTextField *userNameTextFild;
@property (nonatomic, retain)UnableTextField *passwordTextFild;

@property (nonatomic, retain)UIButton *chooseButton;
@property (nonatomic, retain)UILabel *chooseLabel;
@property (nonatomic, retain)UIButton *langChooseButton;

@property (nonatomic, retain)UIButton *loginButton;
@property IBOutlet CustomSegmentControl *segmentControlView;

@property (nonatomic, retain)UIButton *helpButton;
@property (nonatomic, retain)UILabel *helpLabel;

//@property (nonatomic, retain)ZLKeyboard *keyboard;

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
@synthesize segmentControlView;

@synthesize helpButton = _helpButton;
@synthesize helpLabel = _helpLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    if (![[[UserInforSaveCaptain getInstance] notFirstLaunch] isEqualToString:@"true"]) {
        [self showSandBoxNoticeView];
        [[UserInforSaveCaptain getInstance] setNotFirstLaunch:@"true"];
        [[UserInforSaveCaptain getInstance] saveConfigData];
    }
    
    //    LoginPwdContentView *userNameView = [LoginPwdContentView newInstance];
    //    [userNameView setFrame:CGRectMake(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 6, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 3 * 2)];
    //    [self.view addSubview:userNameView];
    
    NSLog(@"%@", [ValueTimeUtil getCurrentDayTradeDayTime:@"2015-06-10" interval:10800]);
    //    NSLog(@"%@", [ValueTimeUtil getCurrentWeekTradeDayTime:@"2012-08-22" interval:10800]);
}

- (void)beforeInit{
    _replaceAiedString = @"";
    self.loginButton.enabled  = false;
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
        isSelectSave = [[UserInforSaveCaptain getInstance] isSaveConfigData];
    }else{
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"SystemNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"SystemInitDocFailed"]
                                                            delegate:nil];
    }
}

- (void)viewWillLayoutSubviews{
    // 会调用多次
    
    [UIFormat setViewStyle:self.langChooseButton
       withBackgroundColor:[UIColor grayColor]
        andTextNormalColor:[UIColor whiteColor]
          andTextHighColor:[UIColor whiteColor]
               andTextFont:[UIFont systemFontOfSize:10.0f]
                 andCorner:UIRectCornerAllCorners];
//    [self.view layoutIfNeeded];
//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
//    [_segmentControlView layoutContentButtons];
 
}

- (void)keyboardInit{
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLoginNumber];
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    //    [view addSubview:inputView];
    self.userNameTextFild.inputView = inputView;
    self.passwordTextFild.inputView = inputView;
    self.aeidTextFild.inputView     = inputView;
    
    [TextFieldUtil removeShortCutItem:self.userNameTextFild];
    [TextFieldUtil removeShortCutItem:self.passwordTextFild];
    [TextFieldUtil removeShortCutItem:self.aeidTextFild];
    
    [self.userNameTextFild  setDelegate:(id)inputView];
    [self.passwordTextFild  setDelegate:(id)inputView];
    [self.aeidTextFild      setDelegate:(id)inputView];
    
    [inputView setKeyboardDelegate:self];
    
    [self.userNameTextFild setSecureTextEntry:true];
    [self.passwordTextFild setSecureTextEntry:true];
    
    if(IOS9_OR_LATER) {
        UITextInputAssistantItem *item = [self.userNameTextFild inputAssistantItem];
        item.leadingBarButtonGroups = @[];
        item.trailingBarButtonGroups = @[];
    } else {
        // Fallback on earlier versions
    }
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
    [self.helpLabel setFont:[UIFont systemFontOfSize:11.0f]];
    
    // helpButton
    //    [self.helpButton setBackgroundImage:[UIImage imageNamed:@"images/normal/help.png"] forState:UIControlStateNormal];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 15, 15)];
    [imageView setImage:[UIImage imageNamed:@"images/normal/help.png"]];
    [self.helpButton addSubview:imageView];
    [self.helpButton setTitle:@"" forState:UIControlStateNormal];
    [self updateLang];
    
    NSString *identifyNumber = [[UserInforSaveCaptain getInstance] identifyNumber];
    if (identifyNumber == nil || [identifyNumber isEqualToString:@""]) {
        [self.aeidTextFild setText:@""];
    } else {
        _replaceAiedString = [StringUtils getHiddenString:identifyNumber];
        [self.aeidTextFild setText:[StringUtils convertHiddenCode:identifyNumber]];
    }
    
    //    if ([identifyNumber isEqualToString:@"H220432857"]) {
    //        [self.aeidTextFild setText:@"G221110215"];
    //    } else {
    //        [self.aeidTextFild setText:@"H220432857"];
    //
    //    }
    
    ////////
    //    NSString *userName = [[UserInforSaveCaptain getInstance] userName];
    //    if (userName == nil || [userName isEqualToString:@""]) {
    //        [self.userNameTextFild setText:@""];
    //    } else {
    //        [self.userNameTextFild setText:userName];
    //    }
    //
    //    NSString *password = [[UserInforSaveCaptain getInstance] password];
    //    if (password == nil || [password isEqualToString:@""]) {
    //        [self.passwordTextFild setText:@""];
    //    } else {
    //        [self.passwordTextFild setText:password];
    //    }
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
    //    [self.aeidTextFild setDelegate:self];
    //    [self.userNameTextFild setDelegate:self];
    //    [self.passwordTextFild setDelegate:self];
    //    [self.passwordTextFild setSecureTextEntry:YES];
       [self.segmentControlView setDelegate:self];
    [self keyboardInit];
}

- (void)addTarget{
    [self.loginButton addTarget:self action:@selector(jumpToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseButton addTarget:self action:@selector(changeChooseButtonImage) forControlEvents:UIControlEventTouchUpInside];
    [self.langChooseButton addTarget:self action:@selector(changeLang) forControlEvents:UIControlEventTouchUpInside];
    [self.helpButton addTarget:self action:@selector(showHelpView) forControlEvents:UIControlEventTouchUpInside];
    [_privateButton addTarget:self action:@selector(showPrivateView) forControlEvents:UIControlEventTouchUpInside];
    [self.segmentControlView setDelegate:self];
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
    
    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLogin"] onView:self.view];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableString *aeidString =  [[NSMutableString alloc] initWithString:self.aeidTextFild.text];
        [aeidString replaceOccurrencesOfString:@"****" withString:_replaceAiedString options:NSLiteralSearch range:NSMakeRange(0, [aeidString length])];
        
        nResult = [[IosLogic getInstance] loginWithUserName:self.userNameTextFild.text
                                                       aied:aeidString
                                                   password:self.passwordTextFild.text
                                                     isLive:[self.segmentControlView currentSelectIndex] == 0 ? true : false];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlertManager getInstance] hidenAlertWaitView];
            
            if([nResult result] == USERIDENTIFY_RESULT_SUCCEED){
                
                if ([nResult passwordNeedChange]) {
                    // 修改密碼
                    // iOSDelay
                    LoginPwdContentView *loginPwdView = [LoginPwdContentView newInstance];
                    [loginPwdView.backButton setHidden:true];
                    [loginPwdView setFrame:CGRectMake(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 6, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 3 * 2)];
                    [self.view addSubview:loginPwdView];
                    return;
                }
                if ([nResult userNameNeedChange]) {
                    // 修改使用者代碼
                    // iOSDelay
                    UserNameContentView *userNameView = [UserNameContentView newInstance];
                    [userNameView setFrame:CGRectMake(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 6, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 3 * 2)];
                    [self.view addSubview:userNameView];
                    return;
                }
                [[OperationRecordsSave getInstance] sendToServer];
                
                [self login];
            }else{
                NSString * errMsg=[[LangCaptain getInstance] getResultByCode:[@([nResult result]) stringValue]];
                [[ShowAlertManager getInstance] showConfirmAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
                                                                   andMessage:errMsg
                                                                     delegate:nil];
            }
        });
    });
}

- (void)checkNeedChangeUserName {
    if ([nResult userNameNeedChange]) {
        // 修改使用者代碼
        // iOSDelay
        UserNameContentView *userNameView = [UserNameContentView newInstance];
        [userNameView setFrame:CGRectMake(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 6, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 3 * 2)];
        [self.view addSubview:userNameView];
    } else {
        [self login];
    }
}

- (void)login {
    if ([[nResult accountBasicArray] count] == 1) {
        
        [[IosLogic getInstance] gotoMainViewController];
        
        //        if (![CheckUtils messageIsAllRead]) {
        //            [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_Message];
        //        }
        [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_LOGIN subType:APP_OPT_TYPE_NONE];
        long long account= [[[nResult accountBasicArray] objectAtIndex:0] getAccount];
        [SendDeviceUtil sendDevice:[@(account) stringValue]];
        [SendDeviceUtil sendPriceWarningRead];
        //        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //            [[TradeApi getInstance] setDeviceTokenAeid:self.aeidTextFild.text
        //                                             accountID:[[nResult accountBasicArray] objectAtIndex:0]
        //                                             groupName:[[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:account]
        //                                           deviceToken:deviceToken
        //                                            deviceType:PUSH_TYPE_IPHONE];
        //        });
    } else {
        //         iOSDelay
        //        [[IosLogic getInstance] gotoChooseViewController:AccountChoose
        //                                             chooseArray:[nResult accountBasicArray]];
        [[ChooseDataCenter getInstance] setAccountChooseArray:[nResult accountBasicArray]];
        AccountChooseView *chooseView = [[AccountChooseView alloc] init];
        [self.view addSubview:chooseView];
    }
    
    if ([CertificateUtil checkCertState]) {
        FnCertState *certState = [[JumpDataCenter getInstance] fnCertState];
        if (certState != nil) {
            NSString *endtime = [JEDIDateTime getCertificateTimeString:[certState getEndValidTime]];
            NSDate * endDate = [JEDIDateTime dateFromString:endtime withFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeInterval time = [endDate timeIntervalSinceDate:[NSDate new]];
            int day = time / 3600 / 24;
            if (day <= 30) {
                // 这个标志暂时没用
                [[ShowAlertManager getInstance] showSystemAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"CANotice"]
                                                                  andMessage:[[LangCaptain getInstance] getLangByCode:@"CertificateBecomingDue"]
                                                                    delegate:nil];
                //                 showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"Notice"]
                //                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"CertificateBecomingDue"]];
            }
        }
    }
    
    if (isSelectSave) {
        [[UserInforSaveCaptain getInstance] setIsSaveConfigData:@"true"];
    } else {
        [[UserInforSaveCaptain getInstance] setIsSaveConfigData:@"false"];
    }
    
    NSMutableString *aeidString = [[NSMutableString alloc] initWithString:self.aeidTextFild.text];
    [aeidString replaceOccurrencesOfString:@"****" withString:_replaceAiedString options:NSLiteralSearch range:NSMakeRange(0, [aeidString length])];
    
    NSString *aied = isSelectSave ? aeidString : @"";
    NSString *userName = isSelectSave ? self.userNameTextFild.text : @"";
    NSString *password = isSelectSave ? self.passwordTextFild.text : @"";
    [[UserInforSaveCaptain getInstance] setIdentifyNumber:aied];
    [[UserInforSaveCaptain getInstance] setUserName:userName];
    [[UserInforSaveCaptain getInstance] setPassword:password];
    [[UserInforSaveCaptain getInstance] saveConfigData];
}

- (Boolean)isValiedPasswordAndUsername{
    if (self.aeidTextFild == nil || self.aeidTextFild.text == nil || self.aeidTextFild.text.length == 0) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"AeidIsNill"]
                                                            delegate:nil];
        return false;
    }
    
    if(self.passwordTextFild == nil || self.passwordTextFild.text == nil || self.passwordTextFild.text.length == 0){
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"LoginFailed"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"PwdIsNill"]
                                                            delegate:nil];
        return false;
    }
    
    return true;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    ZLKeyboardView *view = (ZLKeyboardView *)textField.inputView;
//    [view setCurrentTextField:textField];
//
//    currentY = textField.frame.origin.y;
//    [ResizeForKeyboard setViewPosition:self.view forY:DISTANCE_FROM_TOP - currentY];
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    [ResizeForKeyboard setViewPosition:self.view forY:0];
//    return true;
//}

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
    
    //    NSString *liveAccountLang = [[LangCaptain getInstance] getLangByCode:@"LiveAccount"];
    //    NSString *demoAccountLang = [[LangCaptain getInstance] getLangByCode:@"DemoAccount"];
    //    NSArray *titleArray = @[liveAccountLang, demoAccountLang];
    //    [_segmentControlView updateTitle:titleArray];
    //    [_segmentControlView setbutt];
    
    //    for (UIView *view in [_segmentControlView subviews]) {
    //        [view setUserInteractionEnabled:false];
    //    }
    
    [self.helpLabel setText:[[LangCaptain getInstance] getLangByCode:@"Help"]];
    [_privateButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Private"] forState:UIControlStateNormal];
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

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}

#pragma keyboardDelegate

//- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string{
////    if(currentFeild == self.aeidTextFild) {
////        UITextRange *range = currentFeild.selectedTextRange;
////        [keyboard resetInputString:[string uppercaseString]];
////        currentFeild.text = [string uppercaseString];
////        [currentFeild setSelectedTextRange:range];
////    } else {
////        UITextRange *range = currentFeild.selectedTextRange;
////        currentFeild.text = string;
////        [currentFeild setSelectedTextRange:range];
////    }
//}
//
//- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string {
//    if (currentFeild == self.passwordTextFild) {
//        currentFeild.text = @"";
//        [keyboard resetInputString:@""];
//    }
//}
//
//- (void)keyboardReturn {
//    [currentFeild resignFirstResponder];
//    [ResizeForKeyboard setViewPosition:self.view forY:0];
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma customSegment delegate
- (NSArray *)getSegmentNameArray {
    NSString *liveAccountLang = [[LangCaptain getInstance] getLangByCode:@"LiveAccount"];
    NSString *demoAccountLang = [[LangCaptain getInstance] getLangByCode:@"DemoAccount"];
    return @[liveAccountLang, demoAccountLang];
}

- (CGFloat)getCornerRadius {
    return 8.0f;
}

- (CGFloat)getCornerWidth {
    return 1.0f;
}
- (CGFloat)getButtobMiddleAdge {
    return 2.0f;
}

- (void)didClickButtonAtIndex:(NSUInteger)index {
    // 点击事件， 暂时没用
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//      [self.segmentControlView setNeedsLayout];
//    [self.segmentControlView layoutIfNeeded];
//  
//}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}

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
