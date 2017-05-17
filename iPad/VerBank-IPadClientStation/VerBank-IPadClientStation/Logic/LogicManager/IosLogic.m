//
//  IosLogic.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IosLogic.h"
#import "JEDISystem.h"
#import "LoginViewController.h"
#import "LangCaptain.h"
#import "LoginResult.h"
#import "ClientAPI.h"
#import "IosConfig.h"
#import "DocOperator.h"
#import "QuoteDataStore.h"
#import "ShowAlertManager.h"
#import "MainViewController.h"
#import "CommDocCaptain.h"
#import "JumpDataCenter.h"
#import "PhonePinChecker.h"
#import "CertificateSaveData.h"

static IosLogic *iosLogic = nil;

#define IOSL_NET_STATE_LOST         0
#define IOSL_NET_STATE_CONNECTING   1
#define IOSL_NET_STATE_CONNECTED    2

@interface IosLogic() {
    NSString *_userName;
    NSString *_aeid;
    NSString *_password;
//    long long _accountID;
    
    int _netState;
    
    Boolean _isLive;
}

@end

@implementation IosLogic

@synthesize uiWindow = _uiWindow;

+ (IosLogic *)getInstance {
    if (iosLogic == nil) {
        iosLogic = [[IosLogic alloc] init];
    }
    return iosLogic;
}

- (id)init{
    if (self = [super init]) {
        
        _userName = nil;
        _aeid = nil;
        _password = nil;
        _isLive = true;
        
//        _accountID = 0;
        [[LangCaptain getInstance] setLangTW];
        _netState = IOSL_NET_STATE_LOST;
        
    }
    return self;
}

#pragma LoginAction

- (Boolean)setAccount:(long long )account{
//    [[ClientAPI getInstance] setAccountID:account];
//    _accountID = account;
    return [self initDoc];
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
            [[ClientAPI getInstance] setAccountID:[[[nResult accountBasicArray] objectAtIndex:0] getAccount]];
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
    
    if (![[ClientAPI getInstance] initDoc:locale clientCfgKeys:cfgKeys accountID:[[ClientAPI getInstance] accountID]]) {
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
    NSString *strMsg = [[LangCaptain getInstance] getLangByCode:@"ReconnectSuccess"];
    
    dispatch_async(dispatch_get_main_queue(), ^{@autoreleasepool{
        //        [[ShowAlert getInstance] showDisMissAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"NetReconnect"] andMessage:strMsg];
        [[ShowAlertManager getInstance] showDisappearanceAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"NetReconnect"]
                                                                    Message:strMsg];
    }});
}

//----------------------------------------------------------------------------------------
- (void) handleKickoutEvent:(NSNotification *) notify
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self logoutFromServer];
        //        [[ShowAlert getInstance] showAlerViewWithTitle:@"" andMessage:[[LangCaptain getInstance] getLangByCode:@"KickOut"]];
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:@""
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"KickOut"]
                                                            delegate:nil];
    });
    
}

//----------------------------------------------------------------------------------------
- (void) handleKickoutBySysEvent:(NSNotification *) notify
{
    //    [[ShowAlert getInstance] hideActivityIndicator];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self logoutFromServer];
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:@""
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"KickOutBySys"]
                                                            delegate:nil];
    });
}

#pragma UIManager
- (Boolean)gotoLoginViewController {
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

- (Boolean)gotoMainViewController {
    JEDI_SYS_Try {
        if(_uiWindow == nil)
            return NO;
        
        if (![_uiWindow.rootViewController isKindOfClass:[MainViewController class]]) {
            MainViewController * viewController = [[MainViewController alloc] init];
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
//    [CertificateUtil setDestroyTimeTick];
}

- (void)logoutAction {
    //    [[DataCenter getInstance] clearData];
    [[JumpDataCenter getInstance] destroy];
    [[PhonePinChecker getInstance] destroy];
    [[CertificateSaveData getInstance] destroy];
}

- (void)quoteDatainit{
    [QuoteDataStore getInstance];
    [QuoteDataStore setInited:true];
}

@end
