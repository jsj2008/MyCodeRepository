//
//  CDS_AccountStore.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CDS_AccountStore.h"

@implementation CDS_AccountStore

- (id)initWithAccountStrategy:(AccountStrategy *)accountStrategy{
    self = [self init];
    [self setStrategy:accountStrategy];
    return self;
}

- (id)init{
    if (self = [super init]) {
        strategy = nil;
        moneyAccount = nil;
        hasBeenFixed = false;
        
        C_balance = 0;
        C_floatPL = 0;
        C_equity = 0;
        C_margin2 = 0;
        C_freeze = 0;
        C_activeCapital4Margin = 0;// 可以用来做保证金的资金
        
        C_margin_open_4Positions = 0;
        
        C_margin_open_with_order_buy = 0;
        C_margin_open_with_order_sell = 0;
        C_margin_open_with_order = 0;
        C_margin_call1 = 0;
        C_margin_call2 = 0;
        C_margin_liq = 0;
        C_margin_unlock = 0;
        
        C_allPositionLocked = false;
        C_totalAmountInUSD4Trades = 0;
        C_marginRate = 0;
        
//        debug_hasSetMA = false;
//        debug_hasSetMANull = false;
//        debug_hasCloneNull = false;
//        debug_nullStack = [[NSMutableString alloc] init];

    }
    return self;
}

- (id)copy{
    CDS_AccountStore *store = (CDS_AccountStore *)[super copy];
    if (moneyAccount != nil) {
        [store setMoneyAccount:(MoneyAccount *)[moneyAccount copy]];
    }else{
        [store setMoneyAccount:nil];
    }
    return store;
}

@synthesize strategy;
@synthesize moneyAccount;
@synthesize hasBeenFixed;

@synthesize C_balance;
@synthesize C_floatPL;
@synthesize C_equity;
@synthesize C_margin2;
@synthesize C_freeze;
@synthesize C_activeCapital4Margin;// 可以用来做保证金的资金

@synthesize C_margin_open_4Positions;

@synthesize C_margin_open_with_order_buy;
@synthesize C_margin_open_with_order_sell;
@synthesize C_margin_open_with_order;
@synthesize C_margin_call1;
@synthesize C_margin_call2;
@synthesize C_margin_liq;
@synthesize C_margin_unlock;

@synthesize C_allPositionLocked;
@synthesize C_totalAmountInUSD4Trades;
@synthesize C_marginRate;

//@synthesize debug_hasSetMA;
//@synthesize debug_hasSetMANull;
//@synthesize debug_hasCloneNull;
//@synthesize debug_nullStack;

- (long long)getAccountID{
    return [strategy getAccount];
}

- (NSString *)getAeid{
    return [strategy getAeid];
}

- (NSString *)getGroupName{
    return [strategy getGroupName];
}

- (NSString *)getBasicCurrency{
    return [strategy getBasicCurrency];
}


@end
