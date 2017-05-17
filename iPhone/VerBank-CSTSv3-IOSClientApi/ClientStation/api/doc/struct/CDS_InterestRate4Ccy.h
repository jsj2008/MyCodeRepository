//
//  CDS_InterestRate4Ccy.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"

@interface CDS_InterestRate4Ccy : CommDocBasicStruct
@property NSString* typeID4Group;
@property NSString* typeID4Account;
@property NSString* currency;
@property double buy_cost;
@property double sell_cost;
@property double buy_add_group;
@property double sell_add_group;
@property double buy_add_account;
@property double sell_add_account;
@property double buy_sys;
@property double sell_sys;

- (double)getC_buy;
- (double)getC_sell;
- (NSString *)getDescription4Buy;
- (NSString *)getDescription4Sell;

@end
