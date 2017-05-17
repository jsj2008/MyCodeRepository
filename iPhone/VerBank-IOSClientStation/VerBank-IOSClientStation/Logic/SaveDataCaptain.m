//
//  SaveDataCaptain.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SaveDataCaptain.h"
#import "JEDISystem.h"
#import "ClientSystemConfig.h"
#import "NSData+Encrypt.h"

NSString *const userConfigFileName = @"ConfigSaveData";

NSString *const identifyNumber = @"UserIdentifyNumber";
NSString *const isSaveFlag = @"isSaveFlag";

NSString *const password = @"password";
NSString *const userName = @"userName";
NSString *const AESAppEnKey = @"AESEnKey";
NSString *const notFirstLuanchKey = @"NotFirstLuanchKey";

SaveDataCaptain *saveDataCaptain = nil;

@interface SaveDataCaptain(){
    NSString *_fileName;
    
    NSString *_isSaveData;
    NSString *_identifyNumber;
}

@end

@implementation SaveDataCaptain

@synthesize identifyNumber = _identifyNumber;
@synthesize password = _password;
@synthesize userName = _userName;
@synthesize notFirstLaunch = _notFirstLaunch;

+ (SaveDataCaptain *)getInstance{
    if (saveDataCaptain == nil) {
        saveDataCaptain = [[SaveDataCaptain alloc] initWithFileName:userConfigFileName];
    }
    return saveDataCaptain;
}

- (id)initWithFileName:(NSString *)fileName{
    if (self = [super init]) {
        _fileName = fileName;
        _isSaveData = @"false";
        _identifyNumber = @"";
        _password = @"";
        _userName = @"";
        _notFirstLaunch = @"false";
        [self loadUserConfigSaveData];
        [ClientSystemConfig getInstance];
    }
    return self;
}


-(void) loadUserConfigSaveData
{
    JEDI_SYS_Try {
        NSString *dataPath = NSTemporaryDirectory();
        dataPath = [NSString stringWithFormat:@"%@%@", dataPath, _fileName];
        
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
        
        if (dictionary == nil) {
            return;
        }
//        NSData *decryptData = [userPinData AES256DecryptWithKey:AESEnKey];
//        _userPin = [[NSString alloc] initWithData:decryptData encoding:NSASCIIStringEncoding];
        
        
        _isSaveData = [dictionary objectForKey:isSaveFlag];
        _notFirstLaunch = [dictionary objectForKey:notFirstLuanchKey];
//        _identifyNumber = [dictionary objectForKey:identifyNumber];
        NSData *_identifyNumberData = [dictionary objectForKey:identifyNumber];
        if (_identifyNumberData != nil) {
            NSData *decryptData = [_identifyNumberData AES256DecryptWithKey:AESAppEnKey];
            _identifyNumber = [[NSString alloc] initWithData:decryptData encoding:NSASCIIStringEncoding];
        }
        
        NSData *passwordData = [dictionary objectForKey:password];
        if (passwordData != nil) {
            NSData *decryptData = [passwordData AES256DecryptWithKey:AESAppEnKey];
            _password = [[NSString alloc] initWithData:decryptData encoding:NSASCIIStringEncoding];
        }
        
        NSData *userNameData = [dictionary objectForKey:userName];
        if (userNameData != nil) {
            NSData *decryptData = [userNameData AES256DecryptWithKey:AESAppEnKey];
            _userName = [[NSString alloc] initWithData:decryptData encoding:NSASCIIStringEncoding];
        }
        
//        _password = [dictionary objectForKey:password];
//        _userName = [dictionary objectForKey:userName];
    }JEDI_SYS_EndTry
}

- (void)saveConfigData{
    [self writeUserConfigPlist:_fileName];
}

-(void) writeUserConfigPlist:(NSString *) plistFile{
    JEDI_SYS_Try {
        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
        
        [dictPlist setObject:_isSaveData forKey:isSaveFlag];
        [dictPlist setObject:_notFirstLaunch forKey:notFirstLuanchKey];
        if (_identifyNumber != nil) {
            NSData* oriData = [_identifyNumber dataUsingEncoding:NSUTF8StringEncoding];
            NSData* encryptData = [oriData AES256EncryptWithKey:AESAppEnKey];
            [dictPlist setObject:encryptData forKey:identifyNumber];
        }
        
//        [dictPlist setObject:_identifyNumber forKey:identifyNumber];
        // 正式版 這兩個字段不存
        if (_password != nil) {
            NSData* oriData = [_password dataUsingEncoding:NSUTF8StringEncoding];
            NSData* encryptData = [oriData AES256EncryptWithKey:AESAppEnKey];
            [dictPlist setObject:encryptData forKey:password];
        }
//        [dictPlist setObject:_password forKey:password];
        
        if (_userName != nil) {
            NSData* oriData = [_userName dataUsingEncoding:NSUTF8StringEncoding];
            NSData* encryptData = [oriData AES256EncryptWithKey:AESAppEnKey];
            [dictPlist setObject:encryptData forKey:userName];
        }
//        [dictPlist setObject:_userName forKey:userName];
        
        NSString *plistPath = NSTemporaryDirectory();
        plistPath = [NSString stringWithFormat:@"%@%@", plistPath, plistFile];
        
        if(![dictPlist writeToFile:plistPath atomically:YES]){
            NSLog(@"write user config file failed.");
        }
    } JEDI_SYS_EndTry
}

- (Boolean)isSaveConfigData{
    if ([_isSaveData isEqualToString:@"true"]) {
        return true;
    } else {
        return false;
    }
}

- (void)setIsSaveConfigData:(NSString *)isSave{
    _isSaveData = isSave;
}

@end
