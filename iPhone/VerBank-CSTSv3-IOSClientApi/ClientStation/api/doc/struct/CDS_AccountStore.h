//
//  CDS_AccountStore.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"
#import "AccountStrategy.h"
#import "MoneyAccount.h"

@interface CDS_AccountStore : CommDocBasicStruct

- (id)init;
- (id)initWithAccountStrategy:(AccountStrategy *)accountStrategy;

@property AccountStrategy* strategy;
@property MoneyAccount* moneyAccount;
@property Boolean hasBeenFixed;

@property double C_balance;
@property double C_floatPL;
@property double C_equity;
@property double C_margin2;
@property double C_freeze;
@property double C_activeCapital4Margin;// 可以用来做保证金的资金

@property double C_margin_open_4Positions;

@property double C_margin_open_with_order_buy;
@property double C_margin_open_with_order_sell;
@property double C_margin_open_with_order;
@property double C_margin_call1;
@property double C_margin_call2;
@property double C_margin_liq;
@property double C_margin_unlock;

@property Boolean C_allPositionLocked;
@property double C_totalAmountInUSD4Trades;
@property double C_marginRate;

//@property Boolean debug_hasSetMA;
//@property Boolean debug_hasSetMANull;
//@property Boolean debug_hasCloneNull;
//@property NSMutableString* debug_nullStack;

- (long long)getAccountID;
- (NSString *)getAeid;
- (NSString *)getGroupName;
- (NSString *)getBasicCurrency;


@end
