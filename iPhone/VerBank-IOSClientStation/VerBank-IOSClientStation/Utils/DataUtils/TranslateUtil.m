//
//  TranslateUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TranslateUtil.h"
#import "MTP4CommDataInterface.h"
#import "LangCaptain.h"

@implementation TranslateUtil

+ (NSString *)translateCloseType:(int)type reason:(int)closeReason {
    if (closeReason == ORDERCLOSEREASON_CANCEL_ByUser
        || closeReason == ORDERCLOSEREASON_CANCEL_ByPHONEORDER
        || closeReason == ORDERCLOSEREASON_CANCEL_ByDEALER
        || closeReason == ORDERCLOSEREASON_CANCEL_ByTimeOut
        || closeReason == ORDERCLOSEREASON_CANCEL_ByFund) {
        return [[LangCaptain getInstance] getLangByCode:@"Cancel"];
    }
    
    if (closeReason == ORDERCLOSEREASON_FAILED_MARGINNOTENOUGH) {
        return [[LangCaptain getInstance] getLangByCode:@"Failed(MARGINNOTENOUGH)"];
    }
    if (closeReason == ORDERCLOSEREASON_CANCEL_corPositionClosed) {
        return [[LangCaptain getInstance] getLangByCode:@"Cancel(PositionClose)"];
    }
    switch (type) {
        case TRADETYPE_MKT:
            return [[LangCaptain getInstance] getLangByCode:@"MktPrice"];
        case TRADETYPE_LIMIT:
            return [[LangCaptain getInstance] getLangByCode:@"LimitPrice"];
        case TRADETYPE_STOP:
            return [[LangCaptain getInstance] getLangByCode:@"Stop"];
        case TRADETYPE_MODIFY:
            return [[LangCaptain getInstance] getLangByCode:@"Modify"];
        case TRADETYPE_DELETE:
            return [[LangCaptain getInstance] getLangByCode:@"Cancel"];
        case TRADETYPE_FAILED:
            return [[LangCaptain getInstance] getLangByCode:@"Failed"];
    }
    return [NSString stringWithFormat:@"%d", type];
    
}

+ (NSString *)translateAccStreamType:(int)accStreamType adjustType:(int)adjustType {
    switch (accStreamType) {
        case ACCOUNTSTREAMTYPE_DEPOSIT:
            return [[LangCaptain getInstance] getLangByCode:@"Deposit"];
        case ACCOUNTSTREAMTYPE_WITHDRAW:
            return [[LangCaptain getInstance] getLangByCode:@"Withdraw"];
        case ACCOUNTSTREAMTYPE_CHARGE:
            return [[LangCaptain getInstance] getLangByCode:@"CHARGE"];
        case ACCOUNTSTREAMTYPE_ADJUST:
            switch (adjustType) {
                case ACCOUNTSTREAM_ADJUST_TYPE_DEPOSIT:
                    return [[LangCaptain getInstance] getLangByCode:@"FixSurvival(deposit)"];
                case ACCOUNTSTREAM_ADJUST_TYPE_ADJUST:
                    return [[LangCaptain getInstance] getLangByCode:@"FixSurvival(adjust)"];
                default:
                    return [[LangCaptain getInstance] getLangByCode:@"FixSurvival()"];
            }
        case ACCOUNTSTREAMTYPE_ROLLOVER:
            return [[LangCaptain getInstance] getLangByCode:@"Rollerover"];
        case ACCOUNTSTREAMTYPE_COMMISION:
            return [[LangCaptain getInstance] getLangByCode:@"COMMISION"];
        case ACCOUNTSTREAMTYPE_TRADE:
            return [[LangCaptain getInstance] getLangByCode:@"Trade"];
        case ACCOUNTSTREAMTYPE_IBCHARGE:
            return [[LangCaptain getInstance] getLangByCode:@"IBCHARGE"];
        case ACCOUNTSTREAMTYPE_LIQUIDATION:
            return [[LangCaptain getInstance] getLangByCode:@"Liquidation"];
        case ACCOUNTSTREAMTYPE_MARGIN2:
            return [[LangCaptain getInstance] getLangByCode:@"MARGIN2"];
        case ACCOUNTSTREAMTYPE_PROMPT:
            return [[LangCaptain getInstance] getLangByCode:@"PROMPT"];
        case ACCOUNTSTREAMTYPE_FIXDEPOSIT:
            return [[LangCaptain getInstance] getLangByCode:@"FIXDEPOSIT"];
        case ACCOUNTSTREAMTYPE_HALFANNUAL_INTEREST:
            return [[LangCaptain getInstance] getLangByCode:@"HalfannualInterest"];
        case ACCOUNTSTREAMTYPE_ADJUST_FIXDEPOSIT:
            switch (adjustType) {
                case ACCOUNTSTREAM_ADJUST_TYPE_DEPOSIT:
                     return [[LangCaptain getInstance] getLangByCode:@"FixDeposit(deposit)"];
                case ACCOUNTSTREAM_ADJUST_TYPE_ADJUST:
                    return [[LangCaptain getInstance] getLangByCode:@"FixDeposit(adjust)"];
                default:
                    return [[LangCaptain getInstance] getLangByCode:@"FixDeposit()"];
            }
        case ACCOUNTSTREAMTYPE_CLOSEACCOUNT_INTEREST:
            return [[LangCaptain getInstance] getLangByCode:@"Interest"];
    }
    return [@(accStreamType) stringValue];
}

+ (NSString *)translateCA:(int)caState {
    NSString *langString = [NSString stringWithFormat:@"CA_%d", caState];
    return [[LangCaptain getInstance] getLangByCode:langString];
}

+ (NSString *)translatePickDate:(int)type {
    NSString *string = @"";
    switch (type) {
        case ORDER_EXPIRE_TYPE_H1:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"1Hour"]];
            break;
        case ORDER_EXPIRE_TYPE_H2:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"2Hour"]];
            break;
        case ORDER_EXPIRE_TYPE_H4:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"4Hour"]];
            break;
        case ORDER_EXPIRE_TYPE_H8:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"8Hour"]];
            break;
        case ORDER_EXPIRE_TYPE_H12:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"12Hour"]];
            break;
        case ORDER_EXPIRE_TYPE_H16:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"16Hour"]];
            break;
        case ORDER_EXPIRE_TYPE_DAY:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_DAY"]];
            break;
        case ORDER_EXPIRE_TYPE_WEEK:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_WEEK"]];
            break;
        case ORDER_EXPIRE_TYPE_GTC:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_GTC"]];
            break;
        case ORDER_EXPIRE_TYPE_USER_DEFINED:
            string = [NSString stringWithFormat:@"  %@", [[LangCaptain getInstance] getLangByCode:@"ORDER_EXPIRE_TYPE_USER_DEFINED"]];
            break;
        default:
            break;
    }
    return string;
}

@end
