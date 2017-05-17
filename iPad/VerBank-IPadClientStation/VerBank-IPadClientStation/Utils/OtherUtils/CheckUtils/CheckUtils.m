//
//  CheckUtils.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "CheckUtils.h"
#import "ToCloseTradeNode.h"
#import "APIDoc.h"
#import "LangCaptain.h"
#import "ShowAlertManager.h"
#import "ClientAPI.h"
#import "StringUtils.h"
#import "TradeApi.h"

const int MINLENGTH = 6;
const int MAXLENGTH = 12;
const int PhinePinLength = 6;

@implementation CheckUtils

+ (Boolean)isLegalTradeAmount:(double)amount {
    if (amount - round(amount) > 0.000001) {
        return false;
    }
    return true;
}

+ (int)isHeadgeTradeAmountValiedBuyTicket:(NSArray *)toCloseBuyTickes sellNodes:(NSArray *)toCloseSellTickes{
    double buyCloseAmt = 0.0f;
    double sellCloseAmt = 0.0f;
    for (ToCloseTradeNode *node in toCloseBuyTickes) {
        TTrade *tradeNode = [[APIDoc getUserDocCaptain] getTrade:[node getTicket]];
        if ([tradeNode getAmount] < [node getAmount] - 0.0000001) {
            return CheckCode_CloseAmtMoreThanOrderAmt;
        }
        buyCloseAmt += [node getAmount];
    }
    
    for (ToCloseTradeNode *node in toCloseSellTickes) {
        TTrade *tradeNode = [[APIDoc getUserDocCaptain] getTrade:[node getTicket]];
        if ([tradeNode getAmount] < [node getAmount] - 0.0000001) {
            return CheckCode_CloseAmtMoreThanOrderAmt;
        }
        sellCloseAmt += [node getAmount];
    }
    
    if (fabs(buyCloseAmt - sellCloseAmt) > 0.00001) {
        return CheckCode_BuySellAmtNotMatch;
    }
    return CheckCode_Valid;
}

+ (NSString *)transCheckCode:(int)code {
    switch (code) {
        case CheckCode_CloseAmtMoreThanOrderAmt:
            return [[LangCaptain getInstance] getLangByCode:@"CheckCode_CloseAmtMoreThanOrderAmt"];
        case CheckCode_BuySellAmtNotMatch:
            return [[LangCaptain getInstance] getLangByCode:@"CheckCode_BuySellAmtNotMatch"];
        default:
            break;
    }
    return @"";
}

+ (Boolean)checkAmount:(double)amount buySell:(Boolean)isBuySell instrument:(NSString *)instrument {
    if (amount < 0.0001) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountNill"]
                                                            delegate:nil];
        return false;
    }
    
    if (![CheckUtils isLegalTradeAmount:amount]) {
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:[[LangCaptain getInstance] getLangByCode:@"AmountErr"]
                                                            delegate:nil];
        return false;
    }
    
    NSString *tradeAmtLeg = [[APIDoc getGeneralCheckUtil] isTradeAmountLegal4MKTTrade2:instrument
                                                                                  acid:[[ClientAPI getInstance] accountID]
                                                                               buySell:isBuySell
                                                                                amount:amount];
    
    if (tradeAmtLeg != nil) {
        NSString *errMsg = [[LangCaptain getInstance] getTradeErrMsgByErrorCode:tradeAmtLeg];
        [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                          andMessage:errMsg
                                                            delegate:nil];
        return false;
    }
    return true;
}

+ (UpdateType)getOCOTypeByStop:(double)stopPrice limitPrice:(double)limitPrice {
    UpdateType type = UpdateTypeNull;
    if (limitPrice >= 0.00001) {
        type |= UpdateTypeLimit;
    }
    
    if (stopPrice >= 0.00001) {
        type |= UpdateTypeStop;
    }
    return type;
}

+ (NSString *)getOCOStringByStop:(double)stopPrice limitPrice:(double)limitPrice {
    UpdateType type = UpdateTypeNull;
    if (limitPrice >= 0.00001) {
        type |= UpdateTypeLimit;
    }
    
    if (stopPrice >= 0.00001) {
        type |= UpdateTypeStop;
    }
    
    NSString *ocoString = @"errOCO";
    switch (type) {
        case UpdateTypeLimit:
            ocoString = @"Limit";
            break;
        case UpdateTypeStop:
            ocoString = @"Stop";
            break;
        case UpdateTypeOCO:
            ocoString = @"OCO";
            break;
            
        default:
            break;
    }
    
    return ocoString;
}

+ (Boolean)isPwdLegal:(NSString *)pwd accountID:(NSString *)accountID {
    if ([pwd isEqualToString:accountID]) {
        return false;
    }
    
    if (![self lengthCheck:pwd]) {
        return false;
    }
    
    if (![self contentCheck:pwd]) {
        return false;
    }
    
    if (![self is3CharsOK:pwd]) {
        return false;
    }
    return true;
}

// check
+ (Boolean)lengthCheck:(NSString *)pwd {
    return [pwd length] >= MINLENGTH && [pwd length] <= MAXLENGTH;
}

+ (Boolean)contentCheck:(NSString *)pwd {
    Boolean hasNumber = false;
    Boolean hasUpperCase = false;
    Boolean hasLowerCase = false;
    Boolean hasMarks = false;
    
    for (int i = 0; i<[pwd length]; i++) {
        char commitChar = [pwd characterAtIndex:i];
        if([self isUppercase:commitChar]){
            hasUpperCase = true;
        }else if([self isLowercase:commitChar]){
            hasLowerCase = true;
        }else if([self isNumber:commitChar]){
            hasNumber = true;
        }else{
            hasMarks = true;
        }
    }
    if (hasNumber && hasLowerCase && (hasUpperCase || hasMarks)) {
        return true;
    } else {
        return false;
    }
}

+ (Boolean)is3CharsOK:(NSString *)pwd {
    int length = (int)[pwd length];
    unsigned char sData[length];
    for (int i = 0; i < length; i++) {
        sData[i] = [pwd characterAtIndex:i];
    }
    
    for (int i = 0; i < length - 2; i ++) {
        char c1 = sData[i];
        char c2 = sData[i + 1];
        char c3 = sData[i + 2];
        if (c1 == c2 && c2 == c3) {
            return false;
        }
        
        int g1 = c2 - c1;
        int g2 = c3 - c2;
        if (g1 != g2) {
            continue;
        }
        
        if (abs(g1) != 1) {
            continue;
        }
        
        if ([self isUppercase:c1] && [self isUppercase:c3]) {
            return false;
        }
        
        if ([self isLowercase:c1] && [self isLowercase:c3]) {
            return false;
        }
        
        if ([self isNumber:c1] && [self isNumber:c3]) {
            return false;
        }
    }
    return true;
}

+ (Boolean)isNumber:(char)checkChar {
    return checkChar > 47 && checkChar < 58;
}

+ (Boolean)isUppercase:(char)checkChar {
    return checkChar > 64 && checkChar < 91;
}

+ (Boolean)isLowercase:(char)checkChar {
    return checkChar > 96 && checkChar < 123;
}

// phonePin
+ (Boolean)isPhonePinLegal:(NSString *)phonePin {
    if ([phonePin length] != PhinePinLength) {
        return false;
    }
    
    if (![StringUtils isPureInt:phonePin]) {
        return false;
    }
    
    if (![self check:phonePin]) {
        return false;
    }
    
    return true;
}

+ (Boolean) check:(NSString *)phonePin {
    
    char char0 = [phonePin characterAtIndex:0];
    char char1 = [phonePin characterAtIndex:1];
    char char2 = [phonePin characterAtIndex:2];
    char char3 = [phonePin characterAtIndex:3];
    char char4 = [phonePin characterAtIndex:4];
    char char5 = [phonePin characterAtIndex:5];
    
    if (![self checkIsLegal:char0 char1:char1 char2:char2]) {
        return false;
    }
    if (![self checkIsLegal:char1 char1:char2 char2:char3]) {
        return false;
    }
    if (![self checkIsLegal:char2 char1:char3 char2:char4]) {
        return false;
    }
    if (![self checkIsLegal:char3 char1:char4 char2:char5]) {
        return false;
    }
    
    return true;
}

+ (Boolean) checkIsLegal:(char) c0 char1:(char)c1 char2:(char)c2 {
    if (c0 == c1 && c1 == c2) {
        return false;
    }
    if ((c1 - c0) == (c2 - c1)) {
        if (abs(c1 - c0) == 1) {
            return false;
        }
    }
    return true;
}

+ (Boolean)messageIsAllRead {
    NSString *clientAeid = [[ClientAPI getInstance] aeid];
    TradeResult_SimpleReport *result = [[TradeApi getInstance] report_MessageToAccount:clientAeid];
    
    if (![result succeed]) {
        return false;
    }
    
    NSArray *reportList = [result reportList];
    
    if (reportList == nil || [reportList count] == 0) {
        return true;
    }
    NSDate *monthBeforDate = [NSDate dateWithTimeInterval:-24 * 60 *60 * 30 sinceDate:[NSDate date]];
    
    for (MessageToAccount *ma in reportList) {
        if ([[ma getTime] compare:monthBeforDate] == NSOrderedDescending) {
            if ([ma getIsRead] != _TRUE) {
                return false;
            }
        }
    }
    return true;
}

@end
