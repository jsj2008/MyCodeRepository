//
//  IosConfig.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IosConfig.h"
#import "ClientAPI.h"
#import "GDataXMLNode.h"
#import "LangCaptain.h"

static IosConfig *iosConfig = nil;

@interface IosConfig(){
    NSString *_appName;
    NSString *_appID;
    NSString *_version;
    NSString *_type;
    
    NSString *_langConfig;
}

@end

@implementation IosConfig

+ (IosConfig *)getInstance{
    if (iosConfig == nil) {
        iosConfig = [[IosConfig alloc] init];
    }
    return iosConfig;
}

- (id)init{
    if (self = [super init]) {
        _appName = nil;
        _appID = nil;
        _version = nil;
        _type = nil;
    }
    return self;
}

+ (Boolean)loadAddressInfoForLogin{
    return [ClientAPI prepareAddressCaptain4XML:@"config/login"];
}

+ (Boolean)loadClientConfig{
    NSString *path = [NSString stringWithFormat:@"config/%@/ClientConfig",[[LangCaptain getInstance] getLangConfig]];
    return [[IosConfig getInstance] loadClientConfig:path];
}

- (Boolean)loadClientConfig:(NSString *)fileName {
    JEDI_SYS_Try{
        //获取工程目录的xml文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
        NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
        
        //使用NSData对象初始化
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
        
        //获取根节点（app）
        GDataXMLElement *rootElement = [doc rootElement];
        _appName = [[rootElement attributeForName:@"name"] stringValue];
        _appID   = [[rootElement attributeForName:@"id"] stringValue];
        _version = [[rootElement attributeForName:@"version"] stringValue];
        _type    = [[rootElement attributeForName:@"type"] stringValue];
        return YES;
    }
    JEDI_SYS_EndTry
    
    return NO;
}

- (NSMutableArray *)getClientConfigKeyArray{
    JEDI_SYS_Try{
        // key 暂时为空
        NSMutableArray * keyArray = [[NSMutableArray alloc] init];
        //        [keyArray addObject:[self getClientConfigKeyBy:ccKey_CommLabel_About_ProductInfo]];
        return keyArray;
    }JEDI_SYS_EndTry
    
    return nil;
}

- (NSString *)getClientConfigKeyBy:(NSString *)key{
    return [NSString stringWithFormat:@"%@_%@", _appID, key];
}

#pragma property
- (NSString *)getAppName{
    return _appName;
}

- (NSString *)getAppId{
    return _appID;
}

- (NSString *)getVersion{
    return _version;
}

- (NSString *)getType {
    return _type;
}

@end
