//
//  ClientAPI.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "ClientAPI.h"
#import "AddressCaptain.h"
#import "JsonFactory.h"
#import "JEDISystem.h"
#import "API_IDEvent_NameInterface.h"
#import "IP_Ctrl1001.h"
#import "OP_Ctrl1001.h"
#import "DocOperator.h"
//#import "IosConfig.h"

static ClientAPI * clientAPI_Instance = nil;

@implementation ClientAPI

@synthesize userDocFixer = _userDocFixer;
@synthesize aeid = _aeid;
@synthesize userName = _userName;
@synthesize version = _version;
@synthesize crypyPassword = _crypyPassword;
@synthesize accountID = _accountID;
@synthesize addressCaptain = _addressCaptain;
@synthesize currentAddress = _currentAddress;
@synthesize isFirstLogin = _isFirstLogin;
@synthesize firstLoginTime = _firstLoginTime;
@synthesize docInited = _docInited;
@synthesize connectOperator = _connectOperator;
@synthesize accounts = _accounts;

//------------------------------------------------------------------------------------------------------
#pragma mark static functions
//------------------------------------------------------------------------------------------------------

+ (ClientAPI *) getInstance
{
    @synchronized(self){
        if(clientAPI_Instance == nil){
            clientAPI_Instance = [[ClientAPI alloc] init];
        }
        
        
        return clientAPI_Instance;
    }
}

//------------------------------------------------------------------------------------------------------
+ (BOOL) prepareAddressCaptain4XML:(NSString *)xml
{
    return [AddressCaptain loadDataFormatXML:xml];
}

//------------------------------------------------------------------------------------------------------
+ (NSString *) getUserName
{
    return [ClientAPI getInstance].userName;
}

//------------------------------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------------------------------
- (id) init
{
    if(self = [super init]){
        [JsonFactory initAllJsonClass];
        
        _userDocFixer = nil;
        _crypyPassword = nil;
        _addressCaptain = nil;
        _isFirstLogin = true;
        _firstLoginTime = -1;
        _docInited = false;
    }
    
    return self;
}

//------------------------------------------------------------------------------------------------------
- (void) dealloc
{
    [self destroy];
    
    [JsonFactory clearAllJonsClass];
}

//------------------------------------------------------------------------------------------------------
- (void) prepareCSTSList:(Boolean)isLive
                    aeid:(NSString *)aeid
                password:(NSString *)password
                userName:(NSString *)userName
                 version:(NSString *)version{
    _currentAddress = nil;
    
    if(_addressCaptain == nil || [_addressCaptain isLive] != isLive)
    {
        if(isLive){
            _addressCaptain = [AddressCaptain createLiveAddressCaptain:aeid byCSTSManager:false];
        }else{
            _addressCaptain = [AddressCaptain createDemoAddressCaptain:aeid byCSTSManager:false];
        }
    }//获取socket地址
    
    _aeid = aeid;
    _crypyPassword = [ClientAPI encryptAllone:password key:aeid];
    _userName = userName;
    _version = version;
}

- (void)resetPassword:(NSString *)password{
    _crypyPassword = [ClientAPI encryptAllone:password key:_aeid];
}

//------------------------------------------------------------------------------------------------------
- (LoginResult *)loginToBestAddress
{
    if(_addressCaptain == nil){
        @throw [[NSException alloc] initWithName:@"LoginToBestAddressError" reason:@"AddressCaptain == nil" userInfo:nil];
    }
    
    _currentAddress = [_addressCaptain getBestAddress];
    //    [_addressCaptain debugDescription];
    LoginResult *result = [self login:_currentAddress];
    return result;
}

//------------------------------------------------------------------------------------------------------
- (void)                requestToReLogin
{
    [API_IDEventCaptain fireEventChanged:NAME_ON_DO_RECONNECT eventData:nil];
}

//------------------------------------------------------------------------------------------------------
- (NSMutableArray *)    getAddressList
{
    return [_addressCaptain getServNames];
}

//------------------------------------------------------------------------------------------------------
//创建client线程
- (Boolean)             initDoc:(NSLocale *)locale
                  clientCfgKeys:(NSMutableArray *)clientCfgKeys
                      accountID:(long long)accountID;
{
    
    if (![[DocOperator getInstance] initDoc:locale otherCfgKeyVec:clientCfgKeys]) {
        return false;
    }
    _accountID = accountID;
    if (_userDocFixer != nil) {
        [_userDocFixer destroy];
    }
    
    _userDocFixer = [[UserDocFixer alloc] init];
    [_userDocFixer start];
    _docInited = true;
    return true;
}

//------------------------------------------------------------------------------------------------------
- (Boolean)             isNetOK
{
    return [[CSTSCaptain getInstance] isNetOK];
}

//------------------------------------------------------------------------------------------------------
- (void)                destroy
{
    if(_userDocFixer != nil)
    {
        [_userDocFixer destroy];
    }
    
    _userDocFixer = nil;
    
    _addressCaptain = nil;
    _currentAddress = nil;
    _accounts = nil;
    
    _isFirstLogin = true;
    _firstLoginTime = -1;
    _connectOperator = nil;
    clientAPI_Instance = nil;
    
    [self setUserName:nil];
    [self setCrypyPassword:nil];
}

//------------------------------------------------------------------------------------------------------
- (AddressNode *)       getCurrentAddress
{
    return _currentAddress;
}

//------------------------------------------------------------------------------------------------------
- (AddressCaptain *)    getAddressCaptain
{
    return _addressCaptain;
}

//------------------------------------------------------------------------------------------------------
- (NSMutableArray *)    getAccounts
{
    return _accounts;
}

//- (long long)getAccount{
//    return _accountID;
//}


#pragma Login
//------------------------------------------------------------------------------------------------------
- (LoginResult *)                 login:(AddressNode *)addressNode
{
    LoginResult *result = nil;
    
    JEDI_SYS_Try{
        Boolean flag = [[CSTSCaptain getInstance] initWithAddressCaptain:_addressCaptain
                                                             addressNode:addressNode];
        
        if (!flag) {
            result = [[LoginResult alloc] init];
            [result setResult:USERIDENTIFY_RESULT_ERR_NETERR];
            return result;
        } else {
            result = [self _doLogin:_aeid
                   encryptedPasswod:_crypyPassword
                           userName:_userName
                            version:_version];
        }
    }JEDI_SYS_EndTry
    
    if ([result result] == USERIDENTIFY_RESULT_SUCCEED) {
        if (_connectOperator == nil) {
            _connectOperator = [[APIReConnectOperator alloc] init];
        }
        _isFirstLogin = false;
    }
    
    return result;
}


//------------------------------------------------------------------------------------------------------
- (LoginResult *)                 _doLogin:(NSString *)aeid
                          encryptedPasswod:(NSString *)encryptedPassword
                                  userName:(NSString *)userName
                                   version:(NSString *)version
{
    LoginResult *result = [[LoginResult alloc] init];
    IP_Ctrl1001 *ip = [[IP_Ctrl1001 alloc] init];
    [ip setAeid:aeid];
    [ip setPassword:encryptedPassword];
    [ip setUserName:userName];
    [ip setVersion:version];
    //    [ip setFirstLogin:_isFirstLogin];
    [ip setIsFirstLogin:_isFirstLogin];
    [ip setFirstLoginTime:_firstLoginTime];
    //    long long l1 = [[NSDate alloc] init];
    OPFather *opfather = [[CSTSCaptain getInstance] trade:ip];
    //    long long l2 = [[NSDate alloc] init];
    
    if (![opfather isSuccessed]) {
        [result setResult:USERIDENTIFY_RESULT_ERR_CASTSERR];
    } else {
        OP_Ctrl1001 *op = (OP_Ctrl1001 *)opfather;
        _accounts = [op getAccountList];
        if (_isFirstLogin) {
            _firstLoginTime = [op getLoginTime];
        }
        
        [result setResult:[op getResult]];
        [result setPasswordNeedChange:[op getPasswordNeedChange]];
        [result setUserNameNeedChange:[op getUserNameNeedChange]];
        [result setAccountBasicArray:[op getAccountList]];
    }
    return result;
}

//------------------------------------------------------------------------------------------------------
+ (NSString *)          encryptAllone:(NSString *)password key:(NSString *) key
{
    //加密
    if (password == nil || password.length == 0) {
        return nil;
    }
    
    if ((key == nil) || (key.length == 0)) {
        key = @"1a2b3c4d5e6f7g8h9i";
    }
    
    NSMutableArray * ba = [[NSMutableArray alloc] init];
    [ClientAPI byteEnPassword:password key:key list:ba];
    return [ClientAPI gsEnFromBa:ba key:key];
}

//------------------------------------------------------------------------------------------------------
+ (void) byteEnPassword:(NSString *) password key:(NSString *) key list:(NSMutableArray *) ba
{
    int size = (int)password.length;
    int keySize = (int)key.length;
    
    for (int i = 0; i < size; i++)
    {
        unichar b = [password characterAtIndex:i];
        int index = i % keySize;
        
        b = (unichar)(b ^ [key characterAtIndex:index]);
        [ba addObject:[NSNumber numberWithUnsignedShort:b]];
    }
}

//------------------------------------------------------------------------------------------------------
+ (NSString *) gsEnFromBa:(NSMutableArray *) ba key:(NSString *) key
{
    int size = (int)ba.count;
    int keySize = (int)key.length;
    NSString * nsPassword = [[NSString alloc]init];
    
    for (int i = 0; i < size; i++)
    {
        unichar b = [[ba objectAtIndex:i] unsignedShortValue];
        int index = i % keySize;
        unichar bk = [key characterAtIndex:index];
        int r = b + bk;
        
        nsPassword = [nsPassword stringByAppendingString:[JEDISystem stringFromInt:r withLength:3]];
    }
    return nsPassword;
}


@end
