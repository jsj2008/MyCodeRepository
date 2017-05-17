//
//  CommDataUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "CommDataUtil.h"
#import "APIDoc.h"
#import "ClientAPI.h"
#import "QuoteDataStore.h"
#import "DecimalUtil.h"
#import "MTP4CommDataInterface.h"
#import <UIKit/UIKit.h>

@implementation CommDataUtil
//-------------------------------------------------------------------------
//+ (double)  getMaxLots:(NSString *) instrument accountID:(long long)accountID {
//    CDS_AccountStore *aStore = [[APIDoc getUserDocCaptain] getCDS_AccountStore:accountID];
//    if(aStore != nil){
//        NSString *group = [aStore getGroupName];
//        return [[APIDoc getDocUtil] getMinAmountWithGroup:group
//                                                  Account:accountID
//                                               Instrument:instrument];
//    }
//    return -1;
//}
//
////-------------------------------------------------------------------------
+ (double)  getMinLots:(NSString *) instrument {
    long long accountID = [[ClientAPI getInstance] accountID];
    CDS_AccountStore *aStore = [[APIDoc getUserDocCaptain] getCDS_AccountStore:accountID];
    if(aStore != nil){
        NSString *group = [aStore getGroupName];
        return [[APIDoc getDocUtil] getMinAmountWithGroup:group
                                                  Account:accountID
                                               Instrument:instrument];
    }
    return -1;
}

////-------------------------------------------------------------------------
//+ (double)  getOpenMarginPercentage:(NSString *) instrument
//{
//    AccountStore * aStore = [[DataDoc getInstance] getAccountStore];
//    if(aStore != nil)
//    {
//        NSString * group = [aStore getGroupName];
//        return [DocUtil getOpenMarginPercentage:group
//                                        account:[aStore getAccountID]
//                                     instrument:instrument];
//    }
//
//    return -1;
//}


//-------------------------------------------------------------------------
//+ (BOOL)    isVisableForInstrument:(Instrument *) instrument
//{
//    if(instrument == nil) return NO;
//
//    if([instrument getIsDead] == _TRUE){
//        return NO;
//    }
//
//    if([instrument getIsVisable] == _FALSE){
//        return NO;
//    }
//
//    if([instrument getGroup_isVisable] == _FALSE){
//        return NO;
//    }
//
//    if([instrument getAccount_isVisable] == _FALSE){
//        return NO;
//    }
//
//    return YES;
//}


//-------------------------------------------------------------------------
//+ (NSString *) showNameForInstrument:(NSString *) instrument
//{
//    return [[[DataDoc getInstance] getLangPack] getInstrumentName:instrument];
//}


//-------------------------------------------------------------------------
//+(BOOL ) isTradeable:(Instrument *)instrument{
//    if (instrument==NULL) {
//        return false;
//    }
//    if (![DocUtil isMarketOpen:[instrument getInstrument]]) {
//        return false;
//    }
//
//    if ([[DataDoc getInstance]getQuote:[instrument getInstrument]]==NULL||[instrument getIsDead ]==TRUE) {
//        return false;
//    }
//
//    AccountStore *as=[[DataDoc getInstance]getAccountStore];
//    if (as==NULL) {
//        return false;
//    }else{
//        if (![DocUtil isTradableIgnoreQuoteTimeout:[as getGroupName] account:[as getAccountID] instrument:[instrument getInstrument]]) {
//            return false;
//        }
//        return true;
//    }
//}
//
////-------------------------------------------------------------------------
//+(BOOL) isMKTTradeable:(Instrument *)instrument
//{
//    if (![self isTradeable:instrument]) {
//        return false;
//    }
//
//    AccountStore *as=[[DataDoc getInstance]getAccountStore];
//    if (as!=NULL) {
//        return [DocUtil isMKTTradeable:[as getGroupName] account:[as getAccountID] instrument:[instrument getInstrument]];
//    }
//    return false;
//}

//-------------------------------------------------------------------------
//+ (Boolean) isDemoAccount:(NSString *) userName//判断用户名
//{
//    if(userName == nil || userName.length == 0){
//        return false;
//    }
//
//    NSRange range = [userName rangeOfString:@"-"];
//    return (range.location != NSNotFound && range.length > 0);
//}

//-------------------------------------------------------------------------
//+ (Boolean) isNumberString:(NSString *) str
//{
//    if(str == nil || str.length == 0){
//        return false;
//    }
//
//    int nPoints = 0;
//
//    for(int i=0; i<str.length; ++i)
//    {
//        unichar nChar = [str characterAtIndex:i];
//
//        if(i==0 && nChar == '-') {
//            continue;
//        }
//
//        if(nChar == ',') {
//            continue;
//        }
//
//        if(nChar == '.')
//        {
//            nPoints++;
//            if (nPoints == 1)
//            continue;
//            else
//            return false;
//        }
//
//        if(nChar < '0' || nChar > '9'){
//            return false;
//        }
//    }
//
//    return true;
//}

//-------------------------------------------------------------------------
+ (double)  numberFromString:(NSString *) str
{
    if(str == nil || str.length == 0){
        return 0.0;
    }
    
    NSMutableString * strMutable = [NSMutableString stringWithString:str];
    
    NSRange range = NSMakeRange(0, strMutable.length);
    [strMutable replaceOccurrencesOfString:@"," withString:@"" options:NSLiteralSearch range:range];
    
    return [strMutable doubleValue];
}

#pragma LimitStopPrice
+ (double) getLimitPrice:(NSString *)instrument bunysell:(Boolean)buySell {
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:instrument];
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:instrument];
    
    if (pss == nil) {
        return 0;
    }
    
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:instrument];
    
    double limitPrice = 0.0f;
    double price = 0.0f;
    if (buySell) {
        price = [pss getAsk];
        limitPrice = price - [inst getSafeGap4OpenOrder] * [instUtil getOnePointPrice];
    } else {
        price = [pss getBid];
        limitPrice = price + [inst getSafeGap4OpenOrder] * [instUtil getOnePointPrice];
    }
    
    return limitPrice;
}

+ (double) getStopPrice:(NSString *)instrument bunysell:(Boolean)buySell {
    CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:instrument];
    Instrument *inst = [[APIDoc getSystemDocCaptain] getInstrument:instrument];
    
    if (pss == nil) {
        return 0;
    }
    
    InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:instrument];
    
    double stopPrice = 0.0f;
    double price = 0.0f;
    if (buySell) {
//        price = [pss getAsk];
        price = [pss getBid];
        stopPrice = price + [inst getSafeGap4OpenOrder] * [instUtil getOnePointPrice];
    } else {
//        price = [pss getBid];
        price = [pss getAsk];
        stopPrice = price - [inst getSafeGap4OpenOrder] * [instUtil getOnePointPrice];
    }
    
    return stopPrice;
}

+ (double)getDefaultCcy1Amount:(NSString *)instrument {
    Instrument *inst =[[APIDoc getSystemDocCaptain] getInstrument:instrument];
    if (inst == nil) {
        return 0.0f;
    }
    
    double webTradeMinAmount = [[[APIDoc getSystemDocCaptain] systemConfig] getWebTradeMinAmount];
    NSString *basicCurrency = [[APIDoc getSystemDocCaptain] getSystemBasicCurrency];
    JEDI_SYS_Try {
        double tradeAmount = [[APIDoc getExchangeUtil] exchange:basicCurrency
                                                         Amount:webTradeMinAmount
                                                           Ccy2:[inst getCcy1]];
        double m = tradeAmount / 10000;
//        return round(m) *10000;
        return ceil(m) * 10000;
    } JEDI_SYS_EndTry
    return 0;
}

+ (NSString *)convertHiddenCode:(NSString *)text {
    if (text == nil || [text length] == 0) {
        return @"";
    }
    
    int length = (int)[text length];
    
    if (length <= 5) {
        return text;
    }
    
    int sublength = length - 4;
    
    int beginLength = round(sublength / 2);
    int endLength = sublength - beginLength;
    NSString *beginText = [text substringWithRange:NSMakeRange(0, beginLength)];
    NSString *endText = [text substringWithRange:NSMakeRange(beginLength + 4, endLength)];
    
    NSString *returnString = [beginText stringByAppendingString:@"****"];
    returnString = [returnString stringByAppendingString:endText];
    return returnString;
}

+ (NSString *)getHiddenString:(NSString *)text {
    if (text == nil || [text length] == 0) {
        return @"";
    }
    
    int length = (int)[text length];
    
    if (length <= 5) {
        return text;
    }
    
    int sublength = length - 4;
    int beginLength = round(sublength / 2);
    
    return [text substringWithRange:NSMakeRange(beginLength, 4)];
}

+ (NSString *)createGUID {
//    CFUUIDRef puuid = CFUUIDCreate(nil);
//    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
//    NSString* guid = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
//    return guid;
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)getDeviceID {
    NSString *strIDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    
    NSString *strDeviceID = [NSString stringWithFormat:@"%@-%@", strIDFV, strDate];
    
    return strDeviceID;
}

+ (Boolean)isUptradeOrder:(long long)orderID {
    if (orderID > 0) {
        TOrder *order = [[APIDoc getUserDocCaptain] getOrder:orderID];
        if (order != nil) {
            return !([order getIsManual] == _TRUE);
        }
    }
    return false;
}

+ (Boolean)isPriceReached:(long long)orderID {
    if (orderID > 0) {
        TOrder *order = [[APIDoc getUserDocCaptain] getOrder:orderID];
        if (order != nil) {
            return !([order getIsPriceReached] == _TRUE);
        }
    }
    return false;
}

+ (Boolean)isFloatZero:(float)value {
    if (value > -0.000001 && value < 0.000001) {
        return true;
    } else {
        return false;
    }
}

@end
