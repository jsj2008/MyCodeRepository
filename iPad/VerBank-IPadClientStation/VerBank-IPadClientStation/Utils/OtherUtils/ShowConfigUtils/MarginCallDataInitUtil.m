//
//  MarginCallDataInitUtil m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/26
//  Copyright (c) 2015年 zhanglei  All rights reserved
//

#import "MarginCallDataInitUtil.h"
#import "APIDoc.h"
#import "ClientAPI.h"
#import "DecimalUtil.h"
#import "LangCaptain.h"

static MarginCallDataInitUtil *instance = nil;

@interface MarginCallDataInitUtil() {
    CDS_AccountStore *accountStore;
    long long accountID;
    NSString *currency;
}

@end

@implementation MarginCallDataInitUtil

+ (MarginCallDataInitUtil *)getInstance {
    if (instance == nil) {
        instance = [[MarginCallDataInitUtil alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        accountID = [[ClientAPI getInstance] accountID];
        accountStore = [[APIDoc getUserDocCaptain] getCDS_AccountStore:accountID];
        currency = [accountStore getBasicCurrency];
    }
    return self;
}

- (NSDictionary *) getMarginCallDic {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[self getFloatPL] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"FloatPL"]];
    [dic setObject:[self getOwnBalance] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"OwnBalance"]];
    [dic setObject:[self getTotalBalance] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"TotalBalance"]];
    [dic setObject:[self getOwnEquity] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"OwnEquity"]];
    [dic setObject:[self getTotalEquity] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"TotalEquity"]];
    
    [dic setObject:[self getMargin2] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"Margin2"]];
    [dic setObject:[self getCashBalance] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"CashBalance"]];
    [dic setObject:[self getFixedDeposit] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"FixedDeposit"]];
    [dic setObject:[self getC_Equity] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"C_Equity"]];
    [dic setObject:[self getTotalTBS] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"TotalTBS"]];
    [dic setObject:[self getBackTaxMargin] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"BackTaxMargin"]];
    [dic setObject:[self getPledge] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"Pledge"]];
    [dic setObject:[self getMagin_Open] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"Magin_Open"]];
    [dic setObject:[self getMagin_Open_4Positions] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"Magin_Open_4Positions"]];
    [dic setObject:[self getTradeable_amount] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"Tradeable_amount"]];
    [dic setObject:[self getCallWithdraw] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"CallWithdraw"]];
    [dic setObject:[self getEquity2MaginOpen] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"Equity2MaginOpen"]];
    [dic setObject:[self getActiveCapital4Margin] forKey:[[LangCaptain getInstance] getMarginLangByCode:@"ActiveCapital4Margin"]];
    return dic;
}


#pragma private
- (NSString *) getAccount {
    return [@(accountID) stringValue];
}

- (NSString *) getFloatPL {
    return [DecimalUtil formatMoney:[accountStore C_floatPL] digist:2];
}

- (NSString *) getOwnBalance {
    return [DecimalUtil formatMoney:[accountStore C_balance] - [accountStore C_margin2] digist:2];
}

- (NSString *) getTotalBalance {
    return [DecimalUtil formatMoney:[accountStore C_balance] digist:2];
}

- (NSString *) getOwnEquity {
    return [DecimalUtil formatMoney:[accountStore C_equity] - [accountStore C_margin2] digist:2];
}

- (NSString *) getTotalEquity  {
    return [DecimalUtil formatMoney:[accountStore C_equity] digist:2];
}

- (NSString *) getMargin2  {
    return [DecimalUtil formatMoney:[accountStore C_margin2] digist:2];
}

- (NSString *) getCashBalance  {
    return [DecimalUtil formatMoney:[[accountStore moneyAccount] getCashBalance] digist:2];
}

- (NSString *) getFixedDeposit  {
    return [DecimalUtil formatMoney:[[accountStore moneyAccount] getFixedDeposit] digist:2];
}

- (NSString *) getC_Equity  {
    return [DecimalUtil formatMoney:[accountStore C_equity] digist:2];
}

- (NSString *) getTotalTBS  {
    return [DecimalUtil formatMoney:[[accountStore moneyAccount] getTbs] digist:2];
}

- (NSString *) getBackTaxMargin  {
    double backTaxMargin = [accountStore C_margin_open_4Positions] - [accountStore C_activeCapital4Margin];
    if (backTaxMargin < 0.000001) {
        return [DecimalUtil formatMoney:0 digist:2];
    }
    return [DecimalUtil formatMoney:backTaxMargin digist:2];
}

- (NSString *) getPledge  {
    double pledge = [[accountStore moneyAccount] getFixedDeposit] + [accountStore C_margin2];
    return [DecimalUtil formatMoney:pledge digist:2];
}

- (NSString *) getMagin_Open  {
    return [DecimalUtil formatMoney:[accountStore C_margin_open_4Positions] digist:2];
}

- (NSString *) getMagin_Open_4Positions  {
    return [DecimalUtil formatMoney:[accountStore C_margin_open_4Positions] digist:2];
}

- (NSString *) getTradeable_amount  {
    double d1 = [accountStore C_activeCapital4Margin] - [accountStore C_margin_open_4Positions];
    if (d1 <= 0.0001) {
        return [DecimalUtil formatMoney:0 digist:2];
    }
    return [DecimalUtil formatMoney:d1 digist:2];
}

- (NSString *) getCallWithdraw  {
    double callWithdraw = [[APIDoc getDocUtil] getCallWithdraw:accountStore];
    return [DecimalUtil formatMoney:callWithdraw digist:2];
}

- (NSString *) getEquity2MaginOpen  {
    if ([accountStore C_margin_open_4Positions] < 0.000001) {
        return @"N/A";
    }
    NSString *rate1 = [DecimalUtil formatPercent:[accountStore C_marginRate] withDigist:2];
    NSString *rate2 = [DecimalUtil formatPercent:[accountStore C_activeCapital4Margin] / [accountStore C_margin_open_4Positions] withDigist:2];
    return [NSString stringWithFormat:@"%@(%@)", rate1, rate2];
}

- (NSString *) getActiveCapital4Margin  {
    return [DecimalUtil formatMoney:[accountStore C_activeCapital4Margin] digist:2];
}
@end
