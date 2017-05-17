//
//  IosLogic.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IosLogic.h"
#import "MTP4CommDataInterface.h"
#import "JEDISystem.h"
#import "CommDataUtil.h"
#import "ClientAPI.h"
#import "IosConfig.h"
#import "LangCaptain.h"

#import "QuoteListViewController.h"
#import "LoginViewController.h"
#import "OpenPositionViewController.h"
#import "ClosePositionViewController.h"

#import "ChooseViewController.h"
#import "APIDoc.h"
#import "QuoteDataStore.h"
#import "PositionSumViewController.h"
#import "OrderHisViewController.h"
#import "OrderPositionViewController.h"
#import "MarketTradeViewController.h"
#import "HedgingViewController.h"
#import "OrderAddOrModifyViewController.h"
#import "PriceWarningViewController.h"
#import "PriceWarningAddOrModifyViewController.h"
#import "MessageViewController.h"
#import "ForexNewsViewController.h"
#import "ReviewViewController.h"
#import "OrderOpenAddOrModifyViewController.h"
#import "AboutViewController.h"
#import "MarginCallHisViewController.h"

#import "ShowAlert.h"
#import "SystemConfigViewController.h"

#import "DataCenter.h"
#import "CertificateUtil.h"

#import "DocOperator.h"

#import "AppConfig.h"
#import "SendDeviceUtil.h"
#import "OperationRecordsSave.h"

static IosLogic *iosLogic = nil;

#define IOSL_NET_STATE_LOST         0
#define IOSL_NET_STATE_CONNECTING   1
#define IOSL_NET_STATE_CONNECTED    2

@interface IosLogic(){
    UIWindow *_uiWindow;
    UIActivityIndicatorView  * _indicatorView;
    UIAlertView *_alertView;
    
    NSString *_userName;
    NSString *_aeid;
    NSString *_password;
    long long _accountID;
    
    int _netState;
    
    //    UITableView *_leftTableView;
    
    Boolean _isLive;
}

@end

@implementation IosLogic

@synthesize isLive = _isLive;

+ (IosLogic *)getInstance{
    if (iosLogic == nil) {
        iosLogic = [[IosLogic alloc] init];
    }
    return iosLogic;
}

- (id)init{
    if (self = [super init]) {
        _uiWindow = nil;
        
        _userName = nil;
        _aeid = nil;
        _password = nil;
        _isLive = true;
        
        _accountID = 0;
        [[LangCaptain getInstance] setLangTW];
        _netState = IOSL_NET_STATE_LOST;
        
        //        _leftTableView = nil;
    }
    return self;
}

- (Boolean)setAccount:(long long )account{
    [[ClientAPI getInstance] setAccountID:account];
    _accountID = account;
    return [self initDoc];
}

- (void)setWindow:(UIWindow *)window{
    _uiWindow = window;
}

- (UIWindow *)getWindow{
    return _uiWindow;
}

- (void)setUserName:(NSString *)userName aeid:(NSString *)aeid password:(NSString *)password{
    _userName = userName;
    _aeid = aeid;
    _password = password;
}

- (LoginResult *)loginWithUserName:(NSString *)userName aied:(NSString *)aeid password:(NSString *)password isLive:(Boolean)isLive {
    _userName = userName;
    _aeid = aeid;
    _password = password;
    _isLive = isLive;
    return [self loginToServer];
}

- (LoginResult *)loginToServer{
    LoginResult *nResult = nil;
    JEDI_SYS_Try{
        NSString *version = [[IosConfig getInstance] getVersion];
        [[ClientAPI getInstance] prepareCSTSList:_isLive
                                            aeid:_aeid
                                        password:_password
                                        userName:_userName
                                         version:version];
        
        nResult = [[ClientAPI getInstance] loginToBestAddress];
        
        if ([nResult result] != USERIDENTIFY_RESULT_SUCCEED) {
            return nResult;
        }
        
        if([nResult result] == USERIDENTIFY_RESULT_SUCCEED){
            _netState = IOSL_NET_STATE_CONNECTED;
            [self addLogicListener];
        }
        
        NSArray *accountArray = [nResult accountBasicArray];
        if ([accountArray count] == 0) {
            NSLog(@"basic account count is 0!");
        } else if([accountArray count] == 1){
            if (![self setAccount:[[[nResult accountBasicArray] objectAtIndex:0] getAccount]]) {
                [nResult setResult:USERIDENTIFY_RESULT_ERR_INITDOC];
                return nResult;
            }
        }
    }
    JEDI_SYS_EndTry
    
    return nResult;
}

- (Boolean)initDoc{
    
    //
    // init doc
    //
    NSLocale *locale = [NSLocale currentLocale];//本地化国家语言
    if(![[locale localeIdentifier] isEqualToString:@"zh_CN"]){
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//en_US
    }
    
    NSMutableArray * cfgKeys = [[IosConfig getInstance] getClientConfigKeyArray];
    if(cfgKeys == nil){
        cfgKeys = [[NSMutableArray alloc] init];
    }
    
    if (![[ClientAPI getInstance] initDoc:locale clientCfgKeys:cfgKeys accountID:[[ClientAPI getInstance] getAccount]]) {
        return false;
    }
    
    return true;
}


#pragma mark Reconnect
- (void) addLogicListener
{
    [API_IDEventCaptain addListener:NAME_NAME_ON_NET_LOST
                           observer:self
                           listener:@selector(handleNetLostEvent:)];
    
    [API_IDEventCaptain addListener:NAME_ON_DO_RECONNECT
                           observer:self
                           listener:@selector(handleReconnectEvent:)];
    
    [API_IDEventCaptain addListener:NAME_ON_CONNECTED
                           observer:self
                           listener:@selector(handleConnectedEvent:)];
    
    [API_IDEventCaptain addListener:OTHER_ON_KICKOUT
                           observer:self
                           listener:@selector(handleKickoutEvent:)];
    
    [API_IDEventCaptain addListener:OTHER_ON_KICK_BY_SYS
                           observer:self
                           listener:@selector(handleKickoutBySysEvent:)];
    
    [API_IDEventCaptain addListener:NAME_ON_QUOTELIST_INITED
                           observer:self
                           listener:@selector(quoteDatainit)];
}

//----------------------------------------------------------------------------------------
- (void) removeLogicListener
{
    [API_IDEventCaptain removeListener:NAME_NAME_ON_NET_LOST observer:self];
    [API_IDEventCaptain removeListener:NAME_ON_DO_RECONNECT  observer:self];
    [API_IDEventCaptain removeListener:NAME_ON_CONNECTED     observer:self];
    
    [API_IDEventCaptain removeListener:OTHER_ON_KICKOUT      observer:self];
    [API_IDEventCaptain removeListener:OTHER_ON_KICK_BY_SYS  observer:self];
    [API_IDEventCaptain removeListener:NAME_ON_QUOTELIST_INITED observer:self];
}

//----------------------------------------------------------------------------------------
- (void) handleNetLostEvent:(NSNotification *) notify
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_netState == IOSL_NET_STATE_CONNECTING || _netState == IOSL_NET_STATE_CONNECTED) {
            return;
        }
        //        [[ShowAlert getInstance] showAlerViewWithTitle:@"网络错误" andMessage:@"与服务器断开了, 请检查网络是否正常，稍后将自动为您重连！"];
    });
}

//----------------------------------------------------------------------------------------
- (void) handleReconnectEvent:(NSNotification *) notify
{
    //
    // handle reconnect, call loginToServer
    //
    if(_netState == IOSL_NET_STATE_CONNECTING){
        return;
    }
    
    _netState = IOSL_NET_STATE_CONNECTING;
    [NSThread detachNewThreadSelector:@selector(runReconnectToServer) toTarget:self withObject:nil];
}

//----------------------------------------------------------------------------------------
- (void) runReconnectToServer
{
    JEDI_SYS_Try{
        [[ClientAPI getInstance] prepareCSTSList:_isLive
                                            aeid:_aeid
                                        password:_password
                                        userName:_userName
                                         version:[[IosConfig getInstance] getVersion]];
        
        LoginResult *nResult = [[ClientAPI getInstance] loginToBestAddress];
        
        if([nResult result] == USERIDENTIFY_RESULT_SUCCEED){
            _netState = IOSL_NET_STATE_CONNECTED;
            [API_IDEventCaptain fireEventChanged:NAME_ON_CONNECTED eventData:nil];
            // 断线重连后， 更新数据 // 若不断的断线重连， 会不会有问题。
            [[DocOperator getInstance] resetUserDoc];
            [SendDeviceUtil sendDevice:[@([[ClientAPI getInstance] getAccount]) stringValue]];
            [SendDeviceUtil sendPriceWarningRead];
//            [NSThread detachNewThreadSelector:@selector(setDeviceToken:)
//                                     toTarget:self
//                                   withObject:[@(account) stringValue]];
        } else {
            _netState = IOSL_NET_STATE_LOST;
            [NSThread sleepForTimeInterval:1.0]; // 1 s
            [API_IDEventCaptain fireEventChanged:NAME_ON_DO_RECONNECT eventData:nil];
        }
    }
    JEDI_SYS_EndTry
}

//----------------------------------------------------------------------------------------
- (void) handleConnectedEvent:(NSNotification *) notify
{
    
    //    NSString * strMsg = @"初始化DOC失败！";
    //    NSString *strMsg = [[LangCaptain getInstance] getLangByCode:@"InitDocFailed"];
    
    //
    // init doc
    //
    //    NSMutableArray * cfgKeys = [[IosConfig getInstance] getClientConfigKeyArray];
    //    if(cfgKeys == nil){
    //        cfgKeys = [[NSMutableArray alloc] init];
    //    }
    
    //    NSLocale *locale = [NSLocale currentLocale];
    //    if(![[locale localeIdentifier] isEqualToString:@"zh_CN"]){
    //        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//en_US
    //    }
    
    //    NSLog(@"== %lld", [[ClientAPI getInstance]getAccount]);
    //    NSLog(@"== %lld", _accountID);
    
    //    if ([[ClientAPI getInstance] initDoc:locale clientCfgKeys:cfgKeys accountID:_accountID]) {
    //        strMsg = [[LangCaptain getInstance] getLangByCode:@"ReconnectSuccess"];
    //    }
    
    NSString *strMsg = [[LangCaptain getInstance] getLangByCode:@"ReconnectSuccess"];
    
    dispatch_async(dispatch_get_main_queue(), ^{@autoreleasepool{
        [[ShowAlert getInstance] showDisMissAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"NetReconnect"] andMessage:strMsg];
    }});
}

//----------------------------------------------------------------------------------------
- (void) handleKickoutEvent:(NSNotification *) notify
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self logoutFromServer];
        [[ShowAlert getInstance] showAlerViewWithTitle:@"" andMessage:[[LangCaptain getInstance] getLangByCode:@"KickOut"]];
    });
    
}

//----------------------------------------------------------------------------------------
- (void) handleKickoutBySysEvent:(NSNotification *) notify
{
    //    [[ShowAlert getInstance] hideActivityIndicator];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self logoutFromServer];
        [[ShowAlert getInstance] showAlerViewWithTitle:@"" andMessage:[[LangCaptain getInstance] getLangByCode:@"KickOutBySys"]];
    });
}

#pragma mark Aler & Indicator
//- (void)    showAlerViewWithTitle:(NSString *) title andMessage:(NSString *) message
//{
//
//    if(_alertView != nil){
//        [_alertView dismissWithClickedButtonIndex:[_alertView cancelButtonIndex] animated:NO];
//    }
//
//    _alertView = [[UIAlertView alloc]initWithTitle:title
//                                           message:message
//                                          delegate:nil
//                                 cancelButtonTitle:[[LangCaptain getInstance] getLangByCode:@"YES"]
//                                 otherButtonTitles:nil, nil];
//
//    [_alertView show];
//}

//------------------------------------------------------------------------------------
//- (void)    showActivityIndicator
//{
//    if(_uiWindow == nil || _uiWindow.rootViewController == nil){
//        return;
//    }
//
//    if(_indicatorView == nil)
//    {
//        _indicatorView = [[UIActivityIndicatorView alloc]
//                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    }
//
//    UIView * showInView = _uiWindow.rootViewController.view;
//    CGRect frame = showInView.frame;
//
//    [_indicatorView setCenter:CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2)];
//
//    [showInView addSubview:_indicatorView];
//    [_indicatorView startAnimating];
//}
//
////------------------------------------------------------------------------------------
//- (void)    hideActivityIndicator
//{
//    if(_indicatorView != nil)
//    {
//        [_indicatorView stopAnimating];
//        [_indicatorView removeFromSuperview];
//    }
//}

#pragma ViewController Jump

- (Boolean)gotoLoginViewController{
    JEDI_SYS_Try {
        if(_uiWindow == nil)
            return NO;
        
        if (![_uiWindow.rootViewController isKindOfClass:[LoginViewController class]]) {
            LoginViewController * viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoQuoteListViewController{
    JEDI_SYS_Try {
        if(_uiWindow == nil)
            return NO;
        
        if (![_uiWindow.rootViewController isKindOfClass:[QuoteListViewController class]]) {
            QuoteListViewController * viewController = [[QuoteListViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoMainViewController{
    JEDI_SYS_Try {
        if(_uiWindow == nil)
            return NO;
        
        if (![_uiWindow.rootViewController isKindOfClass:[QuoteListViewController class]]) {
            QuoteListViewController * viewController = [[QuoteListViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

-(Boolean)gotoChooseViewController:(int)chooseType chooseArray:(NSArray *)array{
    JEDI_SYS_Try {
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[ChooseViewController class]]) {
            ChooseViewController *viewController = [[ChooseViewController alloc] initWithChooseType:chooseType
                                                                                        chooseArray:array];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
        
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoClosePositionViewController{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[ClosePositionViewController class]]) {
            ClosePositionViewController *viewController = [[ClosePositionViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
        
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoOpenPositionViewController{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        //        if (![_uiWindow.rootViewController isKindOfClass:[OpenPositionViewController class]]) {
        OpenPositionViewController *viewController = [[OpenPositionViewController alloc] init];
        _uiWindow.rootViewController = viewController;
        //        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoPositionSumViewController{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[PositionSumViewController class]]) {
            PositionSumViewController *viewController = [[PositionSumViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoOrderHisViewController{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[OrderHisViewController class]]) {
            OrderHisViewController *viewController = [[OrderHisViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoOrderPositionViewController{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        NSLog(@".................... jump");
        if (![_uiWindow.rootViewController isKindOfClass:[OrderPositionViewController class]]) {
            OrderPositionViewController *viewController = [[OrderPositionViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoMarketTradeViewController{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[MarketTradeViewController class]]) {
            MarketTradeViewController *viewController = [[MarketTradeViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoHedgingViewController{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[HedgingViewController class]]) {
            HedgingViewController *viewController = [[HedgingViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoOrderAddOrModifyViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[OrderAddOrModifyViewController class]]) {
            OrderAddOrModifyViewController *viewController = [[OrderAddOrModifyViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoOrderOpenAddOrModifyViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[OrderOpenAddOrModifyViewController class]]) {
            OrderOpenAddOrModifyViewController *viewController = [[OrderOpenAddOrModifyViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoAbountViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[AboutViewController class]]) {
            AboutViewController *viewController = [[AboutViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

-(Boolean)gotoMarginCallHisViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[MarginCallHisViewController class]]) {
            MarginCallHisViewController *viewController = [[MarginCallHisViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

-(Boolean)gotoSystemConfigViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[SystemConfigViewController class]]) {
            SystemConfigViewController *viewController = [[SystemConfigViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoPriceWarningAddOrModifyViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[PriceWarningAddOrModifyViewController class]]) {
            PriceWarningAddOrModifyViewController *viewController = [[PriceWarningAddOrModifyViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoPriceWarningViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[PriceWarningViewController class]]) {
            PriceWarningViewController *viewController = [[PriceWarningViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoMessageViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[MessageViewController class]]) {
            MessageViewController *viewController = [[MessageViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoForexNewsViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[ForexNewsViewController class]]) {
            ForexNewsViewController *viewController = [[ForexNewsViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoReviewViewController {
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[ReviewViewController class]]) {
            ReviewViewController *viewController = [[ReviewViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (Boolean)gotoTest{
    JEDI_SYS_Try{
        if (_uiWindow == nil) {
            return NO;
        }
        
        if (![_uiWindow.rootViewController isKindOfClass:[UIViewController class]]) {
            UIViewController *viewController = [[UIViewController alloc] init];
            _uiWindow.rootViewController = viewController;
        }
        return YES;
    }JEDI_SYS_EndTry
    return NO;
}

- (void)logoutFromServer{
    [self removeLogicListener];
    [[CSTSCaptain getInstance] destroy];
    [[QuoteDataStore getInstance] destroy];
    [[CommDocCaptain getInstance] destroy];
    [[ClientAPI getInstance] destroy];
    [self gotoLoginViewController];
    [self logoutAction];
    [CertificateUtil setDestroyTimeTick];
    
    [[AppConfig getInstance] destroy];
}

- (void)logoutAction {
    [[DataCenter getInstance] clearData];
}

#pragma listener

- (void)quoteDatainit{
    [QuoteDataStore getInstance];
    [QuoteDataStore setInited:true];
}

@end
