//
//  DocUtil.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by zhanglei on 15/7/7.
//  Copyright (c) 2013年 allone. All rights reserved.
//

#import "DocUtil.h"
#import "CommDocCaptain.h"
#import "MTP4CommDataInterface.h"
#import "InstrumentsGroupCfg.h"
#import "DataUtil.h"

@implementation DocUtil

- (Boolean)isTradableIgnoreQuoteTimeoutWithGroup:(NSString *)group
                                       Account:(long long)account
                                    Instrument:(NSString *)instrument{
    if (![[CommDocCaptain getInstance] isInited]) {
        return false;
    }
    
    if ([[[[CommDocCaptain getInstance] getSystemDocCaptain] systemConfig] getCloseStatus] != CLOSESTATUS_OPEN) {
        return false;
    }
    
    if (![[[CommDocCaptain getInstance] getSystemDocCaptain] isQuoteTradableIgnoreQuoteEnable:instrument]) {
        return false;
    }
    
    GroupDoc *groupDoc = [[[CommDocCaptain getInstance] getUserDocCaptain] getGroupDoc:group];
    if (group == nil || [[groupDoc groupConfig] getIsTradeable] == FALSE) {
        return false;
    }
    
    CDS_AccountStore *as = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:account];
    
    if (as == nil || [[as strategy] getIsDead] == TRUE || [[as strategy] getIsTradeable] == FALSE) {
        return false;
    }

    return true;
}

- (double)getMaxAmountWithGroup:(NSString *)group
                      Account:(long long)account
                   Instrument:(NSString *)instrument{
    double maxAmount = -1;
    InstrumentsAccountCfg *icc = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsAccountCfg:account :instrument];
    
    if (icc != nil) {
        maxAmount = [icc getMaxAmount];
        if (maxAmount > 0) {
            return maxAmount;
        }
    }
    InstrumentsGroupCfg *igc = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsGroupCfg:group :instrument];
    
    if (igc != nil) {
        maxAmount = [igc getMaxAmount];
        if (maxAmount > 0) {
            return maxAmount;
        }
    }
    return [[[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument] getMaxAmount];
}

- (double)getMinAmountWithGroup:(NSString *)group
                      Account:(long long)account
                   Instrument:(NSString *)instrument{
    double minPos = -1;
    
    InstrumentsAccountCfg *icc = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsAccountCfg:account :instrument];
    if (icc != nil) {
        minPos = [icc getMinAmount];
        if (minPos > 0.0001) {
            return minPos;
        }
    }
    
    InstrumentsGroupCfg *igc = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsGroupCfg:group :instrument];
    if (igc != nil) {
        minPos = [igc getMinAmount];
        if (minPos > 0.0001) {
            return minPos;
        }
    }
    return [[[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument] getMinAmount];
}

- (Boolean)isAmountLegalWitjAccount:(long long)accountID
                       Instrument:(NSString *)instrument
                           Amount:(double)amount{
    
    CDS_AccountStore *as = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:accountID];
    
    if (as == nil) {
        return false;
    }
    double maxAmount = [self getMaxAmountWithGroup:[as getGroupName]  Account:accountID  Instrument:instrument];
    
    if (amount - maxAmount > 0.00001) {
        return false;
    }
    double minAmount = [self getMinAmountWithGroup:[as getGroupName]  Account:accountID  Instrument:instrument];
    
    int tempi = (int) ((amount + 0.00001) / minAmount);
    double left = fabs(amount - tempi * minAmount);

    if (left < 0.00001) {
        return true;
    } else if (fabs(left - minAmount) < 0.00001) {
        return true;
    } else {
        return false;
    }
}

- (Boolean)isTradableWithGroup:(NSString *)group
                     Account:(long long)accountID
                  Instrument:(NSString *)instrument{
    if (![self isTradableIgnoreQuoteTimeoutWithGroup:group  Account:accountID  Instrument:instrument]) {
        return false;
    }
    return [[[CommDocCaptain getInstance] getSystemDocCaptain] isQuoteTradable:instrument];
}

- (Boolean)isQuoteTradable:(NSString *)instrument{
    QuoteData *quote = [[[CommDocCaptain getInstance] getSystemDocCaptain] getQuote:instrument];
    if (quote == nil) {
        return false;
    }
    Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument];
    
    if (inst == nil) {
        return false;
    }
    
    //unknow
    if ([[[NSDate alloc] init] timeIntervalSince1970] * 1000L - [quote getQuoteTime] > [inst getPriceValidTimeGap] *1000L) {
        return false;
    }
    
    if (![quote getTradeable] && (![quote getClose])) {
        return false;
    }
    
    return [[[CommDocCaptain getInstance] getSystemDocCaptain] isQuoteTradable:instrument];
}

- (Boolean)isForceToUptradeWithInstrument:(NSString *)instrument
                                Account:(long long)account
                                 Amount:(double)amount{
    Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument];
    if (inst == nil) {
        return false;
    }
    if ([inst getForeceToUptrade] == TRUE) {
        return true;
    }
    
    CDS_AccountStore *as = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:account];
    
    if (as == nil) {
        return false;
    }
    return ([[as strategy] getIsUptrade] == TRUE);
}

- (double)formatPriceWithOriPrice:(double)oriPrice
                  InstrumentName:(NSString *)instrument{
    Instrument *inst = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrument:instrument];
    return [self formatPriceWithOriPrice:oriPrice  Instrument:inst];
}

- (double)formatPriceWithOriPrice:(double)oriPrice
                     Instrument:(Instrument *)instrument{
    if (instrument == nil) {
        return oriPrice;
    }
    return [DataUtil roundDouble:oriPrice _scale:[instrument getDigits] + [instrument getExtraDigit]];
}

- (double)getCallWithdraw:(CDS_AccountStore *)as{
    double value = MAX(0, [self _getWithdrawable_2:as]);
    return value;
}

- (double)_getWithdrawable_1:(CDS_AccountStore *)as{
    double total = [[as moneyAccount] getCashBalance] - [as C_freeze];
    return total;
}

- (double)_getWithdrawable_2:(CDS_AccountStore *)as{
    double balance = [[as moneyAccount]  getCashBalance] + [[as moneyAccount] getFixedDeposit] + [as C_margin2];
    double freeze = [as C_freeze];
    double marginUsed = [as C_margin_open_4Positions];
    double total = balance - freeze - marginUsed;
    if ([as C_floatPL] < 0) {
        total += [as C_floatPL];
    }
    if ([[as moneyAccount] getTbs] < 0) {
        total += [[as moneyAccount] getTbs];
    }
    return total;
}

@end
