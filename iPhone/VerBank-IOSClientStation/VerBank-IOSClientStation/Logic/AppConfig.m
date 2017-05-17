//
//  AppConfig.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "AppConfig.h"
#import "JEDISystem.h"
#import "CommDataUtil.h"
#import "ClientAPI.h"
#import "NSData+Encrypt.h"
#import "IosLogic.h"
#import "CertificateUtil.h"

NSString *const appConfigSaveData = @"AppConfigSaveData";

NSString *const GUIDKey = @"GUIDKey";
NSString *const UserPinKey = @"UserPinKey";
NSString *const CNKey = @"CNKey";
NSString *const CsrKey = @"CsrKey";
NSString *const KeySetKey = @"KeySetKey";
NSString *const KeySetDataKey = @"KeySetDataKey";

NSString *const CertificateContextKey = @"CertificateContextKey";

NSString *const AESEnKey = @"AESEnKey";

static AppConfig *appConfig = nil;

@interface AppConfig(){
    NSString *_GUID;
    NSString *_userPin;
    NSString *_CN;
    NSString *_csr;
    NSString *_keySet;
    NSString *_keySetData;
    
    NSString *_certificateContext;
    
    NSString *_fileName;
}

@end

@implementation AppConfig

@synthesize GUID = _GUID;
@synthesize certificateContext = _certificateContext;
//@synthesize userPin = _userPin;
//@synthesize CN = _CN;
//@synthesize csr = _csr;
//@synthesize keySet = _keySet;

- (char *)getUserPin {
    return (char *)[_userPin UTF8String];
}

- (void)setUserPin:(char *)userPin {
    _userPin = [NSString stringWithCString:userPin encoding:NSUTF8StringEncoding];
}

- (char *)getCN {
    return (char *)[_CN UTF8String];
}

- (void)setCN:(char *)cn {
    _CN = [NSString stringWithCString:cn encoding:NSUTF8StringEncoding];
}

- (char *)getCsr {
    return (char *)[_csr UTF8String];
}

- (void)setCsr:(char *)csr {
    _csr = [NSString stringWithCString:csr encoding:NSUTF8StringEncoding];
}

- (char *)getKeySet {
    return (char *)[_keySet UTF8String];
}

- (void)setKeySet:(char *)keySet {
    _keySet = [NSString stringWithCString:keySet encoding:NSUTF8StringEncoding];
}

- (char *)getKeySetData {
    return (char *)[_keySetData UTF8String];
}

- (void)setKeySetData:(char *)keySetData {
    _keySetData = [NSString stringWithCString:keySetData encoding:NSUTF8StringEncoding];
}

+ (AppConfig *)getInstance {
    if (appConfig == nil) {
        appConfig = [[AppConfig alloc] initWithFileName:appConfigSaveData];
    }
    return appConfig;
}

- (id)initWithFileName:(NSString *)fileName{
    if (self = [super init]) {
        _fileName = fileName;
        [self loadUserConfigSaveData];
    }
    return self;
}

- (void)saveConfigData {
    [self writeUserConfigPlist:_fileName];
}

-(void) loadUserConfigSaveData {
//    JEDI_SYS_Try {
        NSString *dataPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //        NSLog(@"%@", dataPath);
        dataPath = [NSString stringWithFormat:@"%@/%@", dataPath, _fileName];
        
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
        // 每个Aeid下的信息都不一样， 并要保存以前的Aeid信息
        
        NSString *aeid = [[ClientAPI getInstance] aeid];
        if (aeid == nil) {
            [[IosLogic getInstance] logoutFromServer];
            return;
        }
        
        NSDictionary *userDic = [dictionary objectForKey:[[ClientAPI getInstance] aeid]];
        if (userDic == nil) {
            dataPath = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), _fileName];
            dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
            userDic = [dictionary objectForKey:[[ClientAPI getInstance] aeid]];
        }
        
        _GUID = [userDic objectForKey:GUIDKey];
        if (_GUID == nil || [_GUID isEqualToString:@""]) {
            _GUID = [CommDataUtil getDeviceID];
        }
        
        NSData *userPinData = [userDic objectForKey:UserPinKey];
        if (userPinData != nil) {
            NSData *decryptData = [userPinData AES256DecryptWithKey:AESEnKey];
            _userPin = [[NSString alloc] initWithData:decryptData encoding:NSASCIIStringEncoding];
        }
        
        _CN = [userDic objectForKey:CNKey];
        if (_CN == nil) {
            _CN = [NSString stringWithFormat:@"CN=%@", [[ClientAPI getInstance] aeid]];
        }
        
        _csr = [userDic objectForKey:CsrKey];
        _keySet = [userDic objectForKey:KeySetKey];
        _keySetData = [userDic objectForKey:KeySetDataKey];
        _certificateContext = [userDic objectForKey:CertificateContextKey];
        if (_certificateContext == nil) {
            _certificateContext = @"";
        }
        
//    }JEDI_SYS_EndTry
}

-(void) writeUserConfigPlist:(NSString *) plistFile{
    JEDI_SYS_Try {
        //        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
        NSString *dataPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        dataPath = [NSString stringWithFormat:@"%@/%@", dataPath, _fileName];
        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:dataPath];
        if (dictPlist == nil) {
            dictPlist = [[NSMutableDictionary alloc] init];
        }
        
        NSMutableDictionary *userDic = [dictPlist objectForKey:[[ClientAPI getInstance] aeid]];
        
        if (userDic == nil) {
            userDic = [[NSMutableDictionary alloc] init];
        }
        
        [userDic setObject:_GUID forKey:GUIDKey];
        if (_userPin != nil) {
            NSData* oriData = [_userPin dataUsingEncoding:NSUTF8StringEncoding];
            NSData* encryptData = [oriData AES256EncryptWithKey:AESEnKey];
            [userDic setObject:encryptData forKey:UserPinKey];
        }
        [userDic setObject:_CN forKey:CNKey];
        [userDic setObject:_csr forKey:CsrKey];
        [userDic setObject:_keySet forKey:KeySetKey];
        [userDic setObject:_keySetData forKey:KeySetDataKey];
        [userDic setObject:_certificateContext forKey:CertificateContextKey];
        
        [dictPlist setObject:userDic forKey:[[ClientAPI getInstance] aeid]];
        
        if(![dictPlist writeToFile:dataPath atomically:YES]){
            NSLog(@"write user config file failed.");
        }
    } JEDI_SYS_EndTry
}

- (void)destroy {
    appConfig = nil;
    [CertificateUtil resetIsLoadPrivate];
}

@end
