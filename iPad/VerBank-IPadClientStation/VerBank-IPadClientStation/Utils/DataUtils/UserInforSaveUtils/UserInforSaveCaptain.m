//
//  UserInforSaveCaptain.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "UserInforSaveCaptain.h"
#import "JEDISystem.h"
#import "NSData+Encrypt.h"

NSString *const userConfigFileName = @"ConfigSaveData";

NSString *const identifyNumber = @"UserIdentifyNumber";
NSString *const isSaveFlag = @"isSaveFlag";

NSString *const password = @"password";
NSString *const userName = @"userName";

NSString *const AESAppEnKey = @"AESAppEnKey";
NSString *const notFirstLuanchKey = @"NotFirstLuanchKey";

UserInforSaveCaptain *userInforSaveCaptain = nil;

@interface UserInforSaveCaptain(){
    NSString *_fileName;
    
    NSString *_isSaveData;
    NSString *_identifyNumber;
}

@end

@implementation UserInforSaveCaptain
@synthesize identifyNumber = _identifyNumber;
@synthesize password = _password;
@synthesize userName = _userName;
@synthesize notFirstLaunch = _notFirstLaunch;

+ (UserInforSaveCaptain *)getInstance{
    if (userInforSaveCaptain == nil) {
        userInforSaveCaptain = [[UserInforSaveCaptain alloc] initWithFileName:userConfigFileName];
    }
    return userInforSaveCaptain;
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
//        [ClientSystemConfig getInstance];
    }
    return self;
}


-(void) loadUserConfigSaveData {
    JEDI_SYS_Try {
        NSString *dataPath = NSTemporaryDirectory();
        dataPath = [NSString stringWithFormat:@"%@%@", dataPath, _fileName];
        
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
        
        //        NSData *decryptData = [userPinData AES256DecryptWithKey:AESEnKey];
        //        _userPin = [[NSString alloc] initWithData:decryptData encoding:NSASCIIStringEncoding];
        
        
        _isSaveData = [dictionary objectForKey:isSaveFlag];
        if (_isSaveData == nil) {
            _isSaveData = @"false";
        }
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
        
        if (_password != nil) {
            NSData* oriData = [_password dataUsingEncoding:NSUTF8StringEncoding];
            NSData* encryptData = [oriData AES256EncryptWithKey:AESAppEnKey];
            [dictPlist setObject:encryptData forKey:password];
        }
        
        if (_userName != nil) {
            NSData* oriData = [_userName dataUsingEncoding:NSUTF8StringEncoding];
            NSData* encryptData = [oriData AES256EncryptWithKey:AESAppEnKey];
            [dictPlist setObject:encryptData forKey:userName];
        }
        
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
