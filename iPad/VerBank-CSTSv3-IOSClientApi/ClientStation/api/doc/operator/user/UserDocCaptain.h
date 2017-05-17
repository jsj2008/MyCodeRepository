//
//  UserDocCaptain.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLogin.h"
#import "GroupDoc.h"

@interface UserDocCaptain : NSObject
#pragma UserLogin
- (UserLogin *)getUserLogin:(NSString *)aeid;
- (NSArray *)getUserLogin;
- (void)removeUserLogin:(NSString *)aeid;
- (void)addUserLogin:(UserLogin *)login;
- (void)addUserLogins:(NSArray *)logins;
- (void)clearUserLogin;

#pragma groupOperator
- (GroupDoc *)getGroupDoc:(NSString *)groupName;
- (NSString *)getGroupNameByAccount:(long long)accountID;
- (GroupDoc *)getGroupDocByAccount:(long long)accountID;
- (NSArray *)getGroupNameVec;
- (void)addGroup:(GroupConfig *)groupConfig;
- (void)addGroups:(NSArray *)groupConfigs;
- (void)deleteGroupUnsafe:(NSString *)groupName;

#pragma CDS_AccountStrore operate
- (CDS_AccountStore *)getCDS_AccountStore:(long long)accountID;
- (NSArray *)getCDS_AccountStoreArray;
- (NSArray *)getCDS_AccountStoreByAeid:(NSString *)aeid;
- (NSArray *)getCDS_AccountStoreByGroup:(NSString *)groupName;
- (CDS_AccountStore *)removeCDS_AccountStore:(long long)accountID;
- (void)addCDS_AccountStore:(CDS_AccountStore *)accountStore;

#pragma moneyAccount Operate
- (void)setAccountStrategys:(NSArray *)accountStrategyArray;
- (void)setAccountStrategy:(AccountStrategy *)accountStrategy;
- (void)updateLastTradeTime:(long long)account;
- (void)resetMoneyAccounts:(NSArray *)accountArray;
- (void)setMoneyAccount:(MoneyAccount *)account;

- (void)killUser:(NSString *)aeid;
- (void)killUserAccount:(long long)account;
- (void)clearAccount;
- (void)clearAccountByAeid:(NSString *)aeid;
- (void)clearAccountByGroupName:(NSString *)groupName;

#pragma tradeOperator
- (TTrade *)getTrade:(long long)ticket;
- (NSArray *)getTradeArray;
- (TTrade *)removeTrade:(long long)ticket;
- (void)addTrade:(TTrade *)trade;
- (void)addTrades:(NSArray *)trades;
- (void)resetTradeByAccount:(long long)accountID  Trades:(NSArray *)trades;
- (void)clearTrade;
- (void)clearTradeByAccount:(long long)accountID;
- (void)clearTradeByAeid:(NSString *)aeid;
- (void)clearTradeByGroup:(NSString *)group;

#pragma orderOperator
- (TOrder *)getOrder:(long long)orderID;
- (NSArray *)getOrderArray;
- (void)removeOrder:(long long)orderID;
- (void)addOrder:(TOrder *)order;
- (void)addOrders:(NSArray *)orders;
- (void)resetOrderByAccount:(long long)accountID  TOrderArray:(NSArray *)orders;
- (void)clearOrder;
- (void)clearOrderByAccount:(long long)accountID;
- (void)clearOrderByAeid:(NSString *)aeid;
- (void)clearOrderByGroup:(NSString *)groupName;

#pragma MoneyAccountFrozen operate
- (void)resetMoneyAccountFrozen:(NSArray *)moneyAccountArray;
- (void)resetMoneyAccountFrozen4Account:(long long)accountID
                    MoneyAccountArray:(NSArray *)vec;
- (NSArray *)getMoneyAccountFrozen4Account:(long long)accountID;

#pragma Mragin2 operate
- (void)resetMargin2:(NSArray *)Margin2Array;
- (void)resetMargin24Account:(long long)accountID
                   Margin2:(NSArray *)margin2Array;
- (NSArray *)getMargin24Account:(long long)accountID;

@end
