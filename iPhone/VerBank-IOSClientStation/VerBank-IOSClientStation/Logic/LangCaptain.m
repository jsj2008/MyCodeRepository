//
//  LangCaptain.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LangCaptain.h"
#import "GDataXMLNode.h"
#import "JEDISystem.h"
#import "MTP4CommDataInterface.h"
#import "APIDoc.h"
#import "DecimalUtil.h"

static LangCaptain *langCaptain = nil;

@interface LangCaptain(){
    NSMutableDictionary *_errCodeMap;
    NSMutableDictionary *_langMap;
    NSMutableDictionary *_resultMap;
    // 為了有序 ， 新加一個name的array
    NSMutableArray *_marginCallConfigArray;
    NSMutableDictionary *_marginCallConfigMap;
    
    NSString *_langConfig;
}

@end

@implementation LangCaptain

#pragma init

+ (LangCaptain *)getInstance{
    if (langCaptain == nil) {
        langCaptain = [[LangCaptain alloc] init];
    }
    return langCaptain;
}

- (id)init{
    if (self = [super init]) {
        _errCodeMap             = [[NSMutableDictionary alloc] init];
        _langMap                = [[NSMutableDictionary alloc] init];
        _resultMap              = [[NSMutableDictionary alloc] init];
        _marginCallConfigArray  = [[NSMutableArray alloc] init];
        _marginCallConfigMap    = [[NSMutableDictionary alloc] init];
        _langConfig             = LangConfig_TW;
    }
    return self;
}

#pragma parse

- (void)parse{
    [self clearMap];
    [self parseErrMessageConfig];
    [self parseLangConfig];
    [self parseResultConfig];
    [self parseMarginCallConfig];
}

- (void)clearMap {
    [_errCodeMap removeAllObjects];
    [_langMap removeAllObjects];
    [_resultMap removeAllObjects];
    [_marginCallConfigArray removeAllObjects];
    [_marginCallConfigMap removeAllObjects];
}

- (void)parseResultConfig{
    //获取工程目录的xml文件
    NSString *path = [NSString stringWithFormat:@"config/%@/MessageResult", _langConfig];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    
    //获取根节点（resources）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（Item）
    NSArray * items = [rootElement elementsForName:@"item"];
    [self parseElements:items atDictionary:_resultMap];
}

- (void)parseLangConfig{
    //获取工程目录的xml文件
    NSString *path = [NSString stringWithFormat:@"config/%@/MessageLang", _langConfig];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    
    //获取根节点（resources）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（Item）
    NSArray * items = [rootElement elementsForName:@"item"];
    [self parseElements:items atDictionary:_langMap];
}

- (void)parseErrMessageConfig{
    //获取工程目录的xml文件
    NSString *path = [NSString stringWithFormat:@"config/%@/MessageErr", _langConfig];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    
    //获取根节点（resources）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（Item）
    NSArray * items = [rootElement elementsForName:@"item"];
    [self parseElements:items atDictionary:_errCodeMap];
}

- (void)parseMarginCallConfig {
    //获取工程目录的xml文件
    NSString *path = [NSString stringWithFormat:@"config/%@/MarginCallConfig", _langConfig];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    
    //获取根节点（resources）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（Item）
    NSArray * items = [rootElement elementsForName:@"item"];
    [self parseElements:items atDictionary:_marginCallConfigMap];
    [self parseElements:items atArray:_marginCallConfigArray];
}

- (void) parseElements:(NSArray *) items atArray:(NSMutableArray *)array {
    if(items && items.count > 0){
        JEDI_SYS_Try{
            for (GDataXMLElement * item in items){
                NSString *value = [item stringValue];
                [array addObject:value];
            }
        }JEDI_SYS_EndTry
    }
}

- (void) parseElements:(NSArray *) items atDictionary:(NSMutableDictionary *)dic {
    if(items && items.count > 0){
        JEDI_SYS_Try{
            for (GDataXMLElement * item in items){
                NSString *name = [[item attributeForName:@"name"] stringValue];
                NSString *value = [item stringValue];
                [dic setObject:value forKey:name];
            }
        }JEDI_SYS_EndTry
    }
}

#pragma langConfig

- (void)setLangTW{
    [self setLangConfig:LangConfig_TW];
}

- (void)setLangCN{
    [self setLangConfig:LangConfig_CN];
}

- (void)setLangConfig:(NSString *)config{
    _langConfig = config;
    [[LangCaptain getInstance] parse];
}

- (NSString *)getLangConfig{
    return _langConfig;
}

- (Boolean)isLangTW{
    if ([_langConfig isEqualToString:LangConfig_TW]) {
        return true;
    } else {
        return false;
    }
}

#pragma getLang
- (NSString *)getLangByCode:(NSString *)code{
    return ([_langMap objectForKey:code] == nil) ? code : [_langMap objectForKey:code];
}

- (NSString *)getErrMessageByCode:(NSString *)code{
    return ([_errCodeMap objectForKey:code] == nil) ? code : [_errCodeMap objectForKey:code];
}

- (NSString *)getMarginLangByCode:(NSString *)code {
    return ([_marginCallConfigMap objectForKey:code] == nil) ? code : [_marginCallConfigMap objectForKey:code];
}

- (NSString *)getResultByCode:(NSString *)code{
    code = [NSString stringWithFormat:@"Login_Result_%@", code];
    return ([_resultMap objectForKey:code] == nil) ? code : [_resultMap objectForKey:code];
}

- (NSString *)getPaswordResultByCode:(NSString *)code{
    code = [NSString stringWithFormat:@"ErrorCode_ChangePsd_Result_%@", code];
    return ([_resultMap objectForKey:code] == nil) ? code : [_resultMap objectForKey:code];
}

- (NSString *)getOrderTradeErrMsgByErrCode:(NSString *)errorCode {
    NSString *str;
    if ([errorCode isEqualToString:@"20112"]) {
        str = @"OrderTrade_HEDGE_";
    } else {
        str = @"OrderTrade_RESULT_";
    }
    str = [str stringByAppendingString:errorCode];
    
    NSMutableString *errMsg = [[NSMutableString alloc] initWithString:[self getResultMessage:str]];
    if ([errMsg containsString:@"//MinTradeLot//"]) {
        NSString *minTradeAmountString = [DecimalUtil formatMoney:[[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMinAmount] digist:2];
        [errMsg replaceOccurrencesOfString:@"//MinTradeLot//" withString:minTradeAmountString options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
        NSString *basicCurrency = [[APIDoc getSystemDocCaptain] getSystemBasicCurrency];
        [errMsg replaceOccurrencesOfString:@"//BasicCurrency//" withString:basicCurrency options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
    } else if ([errMsg containsString:@"//MaxTradeLot//"]) {
        NSString *maxTradeAmountString = [DecimalUtil formatMoney:[[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMaxAmount] digist:2];
        [errMsg replaceOccurrencesOfString:@"//MaxTradeLot//" withString:maxTradeAmountString options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
        NSString *basicCurrency = [[APIDoc getSystemDocCaptain] getSystemBasicCurrency];
        [errMsg replaceOccurrencesOfString:@"//BasicCurrency//" withString:basicCurrency options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
    }
    return errMsg == nil ? [[LangCaptain getInstance] getLangByCode:@"OperatorFaild"] : errMsg;
}

- (NSString *)getTradeErrMsgByErrorCode:(NSString *)errorCode {
    NSString *code = [NSString stringWithFormat:@"RESULT_%@", errorCode];
    NSMutableString *errMsg = [[NSMutableString alloc] initWithString:[self getResultMessage:code]];
    if ([errMsg containsString:@"//MinTradeLot//"]) {
        NSString *minTradeAmount = [DecimalUtil formatMoney:[[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMinAmount] digist:2];
        [errMsg replaceOccurrencesOfString:@"//MinTradeLot//" withString:minTradeAmount options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
        NSString *basicCurrency = [[APIDoc getSystemDocCaptain] getSystemBasicCurrency];
        [errMsg replaceOccurrencesOfString:@"//BasicCurrency//" withString:basicCurrency options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
    } else if ([errMsg containsString:@"//MaxTradeLot//"]){
        NSString *maxTradeAmountString = [DecimalUtil formatMoney:[[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMaxAmount] digist:2];
        [errMsg replaceOccurrencesOfString:@"//MaxTradeLot//" withString:maxTradeAmountString options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
        NSString *basicCurrency = [[APIDoc getSystemDocCaptain] getSystemBasicCurrency];
        [errMsg replaceOccurrencesOfString:@"//BasicCurrency//" withString:basicCurrency options:NSLiteralSearch range:NSMakeRange(0, [errMsg length])];
    }
    return errMsg == nil ? [[LangCaptain getInstance] getLangByCode:@"OperatorFaild"] : errMsg;
}

#pragma getMarginCallConfig
- (NSArray *)getMarginCallConfig {
    return _marginCallConfigArray;
}

// private
- (NSString *)getResultMessage:(NSString *)code{
    return ([_resultMap objectForKey:code] == nil) ? code : [_resultMap objectForKey:code];
}


- (NSString *)getOrderHisCloseReason:(int)reason{
    switch (reason) {
        case ORDERCLOSEREASON_SUCCEED_QUOTESCAN:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_SUCCEED_QUOTESCAN"];
        case ORDERCLOSEREASON_SUCCEED_USERTRADE:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_SUCCEED_USERTRADE"];
        case ORDERCLOSEREASON_SUCCEED_PHONEORDERTRADE:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_SUCCEED_PHONEORDERTRADE"];
        case ORDERCLOSEREASON_SUCCEED_DEALERTRADE:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_SUCCEED_DEALERTRADE"];
        case ORDERCLOSEREASON_SUCCEED_DEALERAFFIRM:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_SUCCEED_DEALERAFFIRM"];
        case ORDERCLOSEREASON_SUCCEED_FUNDTRADE:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_SUCCEED_FUNDTRADE"];
        case ORDERCLOSEREASON_MODIFY_ByUSER:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_MODIFY_ByUSER"];
        case ORDERCLOSEREASON_MODIFY_ByPHONEORDER:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_MODIFY_ByPHONEORDER"];
        case ORDERCLOSEREASON_MODIFY_ByDEALER:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_MODIFY_ByDEALER"];
        case ORDERCLOSEREASON_MODIFY_ByFUND:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_MODIFY_ByFUND"];
        case ORDERCLOSEREASON_CANCEL_ByUser:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_CANCEL_ByUser"];
        case ORDERCLOSEREASON_CANCEL_ByPHONEORDER:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_CANCEL_ByPHONEORDER"];
        case ORDERCLOSEREASON_CANCEL_ByDEALER:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_CANCEL_ByDEALER"];
        case ORDERCLOSEREASON_CANCEL_ByTimeOut:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_CANCEL_ByTimeOut"];
        case ORDERCLOSEREASON_CANCEL_corPositionClosed:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_CANCEL_corPositionClosed"];
        case ORDERCLOSEREASON_CANCEL_ByFund:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_CANCEL_ByFund"];
        case ORDERCLOSEREASON_FAILED_OUTOFNOPL:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_FAILED_OUTOFNOPL"];
        case ORDERCLOSEREASON_FAILED_OUTOFPOSITIONLIMIT:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_FAILED_OUTOFPOSITIONLIMIT"];
        case ORDERCLOSEREASON_FAILED_MARGINNOTENOUGH:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_FAILED_MARGINNOTENOUGH"];
        case ORDERCLOSEREASON_FAILED_OTHER:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_FAILED_OTHER"];
        case ORDERCLOSEREASON_FAILED_PRESELLERR:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_FAILED_PRESELLERR"];
        case ORDERCLOSEREASON_FAILED_CUTLOSS:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_FAILED_CUTLOSS"];
        case ORDERCLOSEREASON_MODIFY_MoveStop:
            return [[LangCaptain getInstance] getLangByCode:@"ORDERCLOSEREASON_MODIFY_MoveStop"];
        default:
            break;
    }
    return [@(reason) stringValue];
}

- (NSString *)getExpireType:(int)expire{
    switch (expire) {
        case ORDER_EXPIRE_TYPE_DAY:
            return [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"];
        case ORDER_EXPIRE_TYPE_WEEK:
            return [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"];
        case ORDER_EXPIRE_TYPE_USER_DEFINED:
            return [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"];
        default:
            return [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"];
    }
}

@end
