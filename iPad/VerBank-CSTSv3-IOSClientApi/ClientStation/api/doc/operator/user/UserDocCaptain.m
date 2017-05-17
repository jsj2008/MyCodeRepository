//
//  UserDocCaptain.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "UserDocCaptain.h"
#import "CommDocCaptain.h"
#import "MoneyAccountFrozen.h"
#import "Margin2.h"

@interface UserDocCaptain(){
    NSLock* accountLock;
    NSLock* tradeLock;
    NSLock* orderLock;
    
    NSMutableDictionary *accountStoreMap;
    NSMutableDictionary *accountStoreListMapKeyByAeid;
    NSMutableDictionary *userLoginMap;
    NSMutableDictionary *groupDocMap;
    NSMutableArray *groupNameArray;
    
    NSMutableDictionary *trade4CFDMap;
    NSMutableDictionary *order4CFDMap;
    NSMutableDictionary *moneyAccountFrozenMap;
    NSMutableDictionary *margin2RecordMap;
    
}

@end

@implementation UserDocCaptain

- (id)init{
    if (self = [super init]) {
        accountLock = [[NSLock alloc] init];
        tradeLock = [[NSLock alloc] init];
        orderLock = [[NSLock alloc] init];
        accountStoreMap = [[NSMutableDictionary alloc] init];
        accountStoreListMapKeyByAeid = [[NSMutableDictionary alloc] init];
        userLoginMap = [[NSMutableDictionary alloc] init];
        groupDocMap = [[NSMutableDictionary alloc] init];
        
        groupNameArray = [[NSMutableArray alloc] init];
        trade4CFDMap = [[NSMutableDictionary alloc] init];
        order4CFDMap = [[NSMutableDictionary alloc] init];
        moneyAccountFrozenMap = [[NSMutableDictionary alloc] init];
        margin2RecordMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc{
    accountLock = nil;
    tradeLock = nil;
    orderLock = nil;
    accountStoreMap = nil;
    accountStoreListMapKeyByAeid = nil;
    userLoginMap = nil;
    groupDocMap = nil;
    
    groupNameArray = nil;
    trade4CFDMap = nil;
    order4CFDMap = nil;
    moneyAccountFrozenMap = nil;
    margin2RecordMap = nil;
}

//--------------------------------
//------user login operate -------
//--------------------------------
#pragma UserLoginOperator
- (UserLogin *)getUserLogin:(NSString *)aeid{
    return (UserLogin *)[userLoginMap objectForKey:aeid];
}

- (NSArray *)getUserLogin{
    return [userLoginMap allKeys];
}

- (void)removeUserLogin:(NSString *)aeid{
    [accountLock lock];
    @try {
        [userLoginMap removeObjectForKey:aeid];
    }@finally {
        [accountLock unlock];
    }
}

- (void)addUserLogin:(UserLogin *)login{
    [accountLock lock];
    @try {
        [userLoginMap setObject:login forKey:[login getAeid]];
    }@finally {
        [accountLock unlock];
    }
}

- (void)addUserLogins:(NSArray *)logins{
    if (logins == nil) {
        return;
    }
    [accountLock lock];
    @try {
        for (UserLogin* tempUserLogin in logins) {
            [userLoginMap setObject:tempUserLogin forKey:[tempUserLogin getAeid]];
        }
    }@finally {
        [accountLock unlock];
    }
}

- (void)clearUserLogin{
    [userLoginMap removeAllObjects];
}


//--------------------------------
//------group operator------------
//--------------------------------
#pragma groupOperator
- (GroupDoc *)getGroupDoc:(NSString *)groupName{
    return [groupDocMap objectForKey:groupName];
}

- (NSString *)getGroupNameByAccount:(long long)accountID{
    NSString *key = [NSString stringWithFormat:@"%lld", accountID];
    CDS_AccountStore *as = [accountStoreMap objectForKey:key];
    if (as != nil) {
        return [as getGroupName];
    }
    return nil;
}

- (GroupDoc *)getGroupDocByAccount:(long long)accountID{
    NSString *key = [NSString stringWithFormat:@"%lld", accountID];
    CDS_AccountStore *as = [accountStoreMap objectForKey:key];
    if (as != nil) {
        return [groupDocMap objectForKey:[as getGroupName]];
    }
    return nil;
}

- (NSArray *)getGroupNameVec{
    return groupNameArray;
}

- (void)addGroup:(GroupConfig *)groupConfig{
    if (groupConfig == nil) {
        return;
    }
    [accountLock lock];
    @try {
        if ([[groupDocMap allKeys] containsObject:[groupConfig getGroupName]]) {
            GroupDoc *groupDoc = (GroupDoc *)[groupDocMap objectForKey:[groupConfig getGroupName]];
            [groupDoc setGroupConfig:groupConfig];
        } else {
            GroupDoc *groupDoc = [[GroupDoc alloc] initWithGroupConfig:groupConfig];
            [groupDocMap setObject:groupDoc forKey:[groupConfig getGroupName]];
            
            NSArray *asv = [accountStoreMap allValues];
            for (CDS_AccountStore* as in asv) {
                if ([[as getGroupName] isEqualToString:[groupConfig getGroupName]]) {
                    [groupDoc addAccountStore:as];
                }
            }
            
            NSArray *trades = [trade4CFDMap allValues];
            for (TTrade* tempTrade in trades) {
                if ([groupDoc containAccount:[tempTrade getAccount]]) {
                    [groupDoc addTrade:tempTrade];
                }
            }
            
            NSArray *orders = [order4CFDMap allValues];
            for (TOrder *tempOrder in orders) {
                if ([groupDoc containAccount:[tempOrder getAccount]]) {
                    [groupDoc addOrder:tempOrder];
                }
            }
            
            groupNameArray = [NSMutableArray arrayWithArray:[groupDocMap allKeys]];
            
        }
    } @finally {
        [accountLock unlock];
    }
}

- (void)addGroups:(NSArray *)groupConfigs{
    if (groupConfigs == nil) {
        return;
    }
    for (GroupConfig *tempGroupConfig in groupConfigs) {
        [self addGroup:tempGroupConfig];
    }
}

- (void)deleteGroupUnsafe:(NSString *)groupName{
    if (groupName == nil) {
        return;
    }
    [accountLock lock];
    @try {
        if ([[groupDocMap allKeys] containsObject:groupName]) {
            [groupDocMap removeObjectForKey:groupName];
        }
        groupNameArray = [NSMutableArray arrayWithArray:[groupDocMap allKeys]];
    } @finally {
        [accountLock unlock];
    }
}

#pragma CDS_AccountStore operate
- (CDS_AccountStore *)getCDS_AccountStore:(long long)accountID{
    NSString *key = [NSString stringWithFormat:@"%lld", accountID];
    return [accountStoreMap objectForKey:key];
}

- (NSArray *)getCDS_AccountStoreArray{
    return [accountStoreMap allValues];
}

- (NSArray *)getCDS_AccountStoreByAeid:(NSString *)aeid{
    [accountLock lock];
    @try {
        NSArray *list = [accountStoreListMapKeyByAeid objectForKey:aeid];
        if (list == nil) {
            return [[NSArray alloc] init];
        } else {
            return list;
        }
    } @finally {
        [accountLock unlock];
    }
}

- (NSArray *)getCDS_AccountStoreByGroup:(NSString *)groupName{
    GroupDoc *gd = [self getGroupDoc:groupName];
    if (gd == nil) {
        return [[NSArray alloc] init];
    }
    return [gd getAccountStoreVector];
}

- (CDS_AccountStore *)removeCDS_AccountStore:(long long)accountID{
    CDS_AccountStore *as = nil;
    [accountLock lock];
    @try {
        NSString *key = [NSString stringWithFormat:@"%lld", accountID];
        as = [accountStoreMap objectForKey:key];
        [accountStoreMap removeObjectForKey:key];
        if (as != nil) {
            NSMutableArray *list = [accountStoreListMapKeyByAeid objectForKey:[as getAeid]];
            if (list != nil) {
                for (CDS_AccountStore *tempAS in list) {
                    if ([tempAS getAccountID] == accountID) {
                        [list removeObject:tempAS];
                        break;
                    }
                }
            }
            GroupDoc *groupDoc = [groupDocMap objectForKey:[as getGroupName]];
            if (groupDoc != nil) {
                [groupDoc removeAccountStore:accountID];
            }
        }
        return as;
    }@finally {
        [accountLock unlock];
    }
}

- (void)addCDS_AccountStore:(CDS_AccountStore *)accountStore{
    if (accountStore == nil) {
        return;
    }
    
    [self removeCDS_AccountStore:[accountStore getAccountID]];
    [accountLock lock];
    
    @try {
        NSString *key = [NSString stringWithFormat:@"%lld", [accountStore getAccountID]];
        [accountStoreMap setObject:accountStore forKey:key];
        
        NSMutableArray *list = [accountStoreListMapKeyByAeid objectForKey:[accountStore getAeid]];
        if (list == nil) {
            list = [[NSMutableArray alloc] init];
            [accountStoreListMapKeyByAeid setObject:list forKey:[accountStore getAeid]];
        }
        [list addObject:accountStore];
        
        GroupDoc *groupDoc = [groupDocMap objectForKey:[accountStore getGroupName]];
        if (groupDoc != nil) {
            [groupDoc addAccountStore:accountStore];
        }
    } @finally {
        [accountLock unlock];
    }
}

#pragma MoneyAccountOperate
- (void)setAccountStrategys:(NSArray *)accountStrategyArray{
    if (accountStrategyArray == nil) {
        return;
    }
    for (AccountStrategy *tempAS in accountStrategyArray) {
        [self setAccountStrategy:tempAS];
    }
}

- (void)setAccountStrategy:(AccountStrategy *)accountStrategy{
    if (accountStrategy == nil) {
        return;
    }
    //    NSString *key = [NSString stringWithFormat:@"%ld", [accountStrategy getAccount]];
    CDS_AccountStore *store = [self removeCDS_AccountStore:[accountStrategy getAccount]];
    if (store == nil) {
        store = [[CDS_AccountStore alloc] initWithAccountStrategy:accountStrategy];
    } else {
        [store setStrategy:accountStrategy];
    }
    [self addCDS_AccountStore:store];
}

- (void)updateLastTradeTime:(long long)account{
    CDS_AccountStore *as = [self getCDS_AccountStore:account];
    if (as == nil) {
        return;
    }
    [[as strategy] setLastTradeTime:[[NSDate alloc] init]];
}

- (void)resetMoneyAccounts:(NSArray *)accountArray{
    if (accountArray == nil) {
        return;
    }
    for (MoneyAccount *tempMA in accountArray) {
        [self setMoneyAccount:tempMA];
    }
}

- (void)setMoneyAccount:(MoneyAccount *)account{
    if (account == nil) {
        return;
    }
    CDS_AccountStore *store = [self getCDS_AccountStore:[account getAccount]];
    if (store != nil) {
        [store setMoneyAccount:account];
    }
}

- (void)killUser:(NSString *)aeid{
    NSArray *accountStoreArray = [self getCDS_AccountStoreByAeid:aeid];
    for (CDS_AccountStore *tempAS in accountStoreArray) {
        [[[CommDocCaptain getInstance] getSystemDocCaptain] removeInstrumentAccountCfg:[tempAS getAccountID]];
        [self killUserAccount:[tempAS getAccountID]];
    }
    [self removeUserLogin:aeid];
}

- (void)killUserAccount:(long long)account{
    [self removeCDS_AccountStore:account];
    [self clearOrderByAccount:account];
    [self clearTradeByAccount:account];
    [self removeCDS_AccountStore:account];
    //    this.clearOrderByAccount(accountID);
    //    this.clearTradeByAccount(accountID);
    //    this.removeCDS_AccountStore(accountID);
}

- (void)clearAccount{
    [accountLock lock];
    @try {
        [accountStoreMap removeAllObjects];
        [accountStoreListMapKeyByAeid removeAllObjects];
    } @finally {
        [accountLock unlock];
    }
}

- (void)clearAccountByAeid:(NSString *)aeid{
    
    NSArray *list = [self getCDS_AccountStoreByAeid:aeid];
    if (list != nil) {
//        for (CDS_AccountStore *as in list) {
        for (int i = 0; i < list.count; i++) {
            [self removeCDS_AccountStore:[[list objectAtIndex:i] getAccountID]];
        }
    }
}

- (void)clearAccountByGroupName:(NSString *)groupName{
    GroupDoc *gd = [self getGroupDoc:groupName];
    if (gd != nil) {
        NSArray *asArray = [gd getAccountStoreVector];
        for (CDS_AccountStore *as in asArray) {
            [self removeCDS_AccountStore:[as getAccountID]];
        }
    }
}

#pragma TradeOperator
- (TTrade *)getTrade:(long long)ticket{
    [tradeLock lock];
    @try {
        NSString *key = [NSString stringWithFormat:@"%lld", ticket];
        return [trade4CFDMap objectForKey:key];
    } @finally {
        [tradeLock unlock];
    }
}

- (NSArray *)getTradeArray{
    [tradeLock lock];
    @try {
        return [trade4CFDMap allValues];
    } @finally {
        [tradeLock unlock];
    }
}

- (TTrade *)removeTrade:(long long)ticket{
    TTrade *trade = nil;
    [tradeLock lock];
    @try {
        NSString *key = [NSString stringWithFormat:@"%lld", ticket];
        trade = [trade4CFDMap objectForKey:key];
        [trade4CFDMap removeObjectForKey:key];
        if (trade != nil) {
            CDS_AccountStore *as = [accountStoreMap objectForKey:[NSString stringWithFormat:@"%lld",[trade getAccount]]];
            if (as != nil) {
                [[self getGroupDoc:[as getGroupName]] removeTrade:ticket];
            }
        }
        return trade;
    } @finally {
        [tradeLock unlock];
    }
}

- (void)addTrade:(TTrade *)trade{
    @try {
        [[[CommDocCaptain getInstance] getFixUtil] fixTrade:trade];
    } @catch (NSException *e) {
        NSLog(@"%@ %@", [e name], [e reason]);
    }
    long long ticket = [trade getTicket];
    [self removeTrade:ticket];
    
    [tradeLock lock];
    @try {
        [trade4CFDMap setObject:trade forKey:[NSString stringWithFormat:@"%lld", ticket]];
        CDS_AccountStore *as = [accountStoreMap objectForKey:[NSString stringWithFormat:@"%lld", [trade getAccount]]];
        if (as != nil) {
            [[self getGroupDoc:[as getGroupName]] addTrade:trade];
        }
    } @finally {
        [tradeLock unlock];
    }
}

- (void)addTrades:(NSArray *)trades{
    if (trades == nil) {
        return;
    }
    for (TTrade *trade in trades) {
        [self addTrade:trade];
    }
}

- (void)resetTradeByAccount:(long long)accountID  Trades:(NSArray *)trades{
    
        [self clearTradeByAccount:accountID];

        [self addTrades:trades];
    
}

- (void)clearTrade{
    [trade4CFDMap removeAllObjects];
    for (GroupDoc *gd in [groupDocMap allValues]) {
        [gd clearTrade];
    }
}

- (void)clearTradeByAccount:(long long)accountID{
    CDS_AccountStore *store = [self getCDS_AccountStore:accountID];
    if (store == nil) {
        return;
    }
    GroupDoc *doc = [self getGroupDoc:[store getGroupName]];
    if (doc != nil) {
        NSArray *array = [[[doc getTradeDoc] getTTradeByAccountList:accountID] copy];
        if (array != nil) {
            for (TTrade *trade in array) {
                [self removeTrade:[trade getTicket]];
            }
        }
    }
}

- (void)clearTradeByAeid:(NSString *)aeid{
    NSArray *array = [self getCDS_AccountStoreByAeid:aeid];
    if (array != nil) {
        for (CDS_AccountStore *as in array) {
            [self clearTradeByAccount:[as getAccountID]];
        }
    }
}

- (void)clearTradeByGroup:(NSString *)group{
    GroupDoc *doc = [self getGroupDoc:group];
    if (doc != nil) {
        NSArray *array = [[doc getTradeDoc] getTTrades];
        if (array == nil) {
            return;
        }
        for (TTrade *trade in array) {
            [self removeTrade:[trade getTicket]];
        }
    }
}

#pragma Order operate
- (TOrder *)getOrder:(long long)orderID{
    [orderLock lock];
    @try {
        return [order4CFDMap objectForKey:[NSString stringWithFormat:@"%lld", orderID]];
    } @finally {
        [orderLock unlock];
    }
}

- (NSArray *)getOrderArray{
    [orderLock lock];
    @try {
        return [order4CFDMap allValues];
    } @finally {
        [orderLock unlock];
    }
}

- (void)removeOrder:(long long)orderID{
    [orderLock lock];
    @try {
        TOrder *order = [order4CFDMap objectForKey:[NSString stringWithFormat:@"%lld", orderID]];
        [order4CFDMap removeObjectForKey:[NSString stringWithFormat:@"%lld", orderID]];
        if (order != nil) {
            CDS_AccountStore *as = [accountStoreMap objectForKey:[@([order getAccount]) stringValue]];
            if (as != nil) {
                [[self getGroupDoc:[as getGroupName]] removeOrder:orderID];
            }
        }
    } @finally {
        [orderLock unlock];
    }
}

- (void)addOrder:(TOrder *)order{
    if (order == nil) {
        return;
    }
    NSString *key = [NSString stringWithFormat:@"%lld", [order getOrderID]];
    [self removeOrder:[order getOrderID]];
    
    [orderLock lock];
    @try {
        [order4CFDMap setObject:order forKey:key];
        CDS_AccountStore *as = [accountStoreMap objectForKey:[NSString stringWithFormat:@"%lld", [order getAccount]]];
        if (as != nil) {
            [[self getGroupDoc:[as getGroupName]] addOrder:order];
        }
    } @finally {
        [orderLock unlock];
    }
}

- (void)addOrders:(NSArray *)orders{
    if (orders == nil) {
        return;
    }
    for (TOrder *order in orders) {
        [self addOrder:order];
    }
}


- (void)resetOrderByAccount:(long long)accountID  TOrderArray:(NSArray *)orders{
//    [order4CFDMap removeAllObjects];
    [self clearOrderByAccount:accountID];
    [self addOrders:orders];
}

- (void)clearOrder{
    [order4CFDMap removeAllObjects];
    for (GroupDoc *gd in [groupDocMap allValues]) {
        [gd clearOrder];
    }
}

- (void)clearOrderByAccount:(long long)accountID{
    CDS_AccountStore *as = [accountStoreMap objectForKey:[NSString stringWithFormat:@"%lld", accountID]];
    if (as == nil) {
        return;
    }
    GroupDoc *doc = [self getGroupDoc:[as getGroupName]];
    if (doc != nil) {
        NSArray *array = [[[doc getOrderDoc] getTOrderByAccountList:accountID] copy];
        if (array != nil) {
            for (TOrder *order in array) {
                [self removeOrder:[order getOrderID]];
            }
        }
    }
}

- (void)clearOrderByAeid:(NSString *)aeid{
    NSArray *array = [self getCDS_AccountStoreByAeid:aeid];
    if (array != nil) {
        for (CDS_AccountStore *as in array) {
            [self clearOrderByAccount:[as getAccountID]];
        }
    }
}

- (void)clearOrderByGroup:(NSString *)groupName{
    GroupDoc *doc = [self getGroupDoc:groupName];
    if (doc != nil) {
        NSArray *array = [[doc getOrderDoc] getTOrders];
        for (TOrder *order in array) {
            [self removeOrder:[order getOrderID]];
        }
    }
}

#pragma MoneyAccountFrozen operate
- (void)resetMoneyAccountFrozen:(NSArray *)moneyAccountArray{
    @synchronized(moneyAccountFrozenMap){
        [moneyAccountFrozenMap removeAllObjects];
        for (MoneyAccountFrozen *maf in moneyAccountArray) {
            NSString *accountID = [NSString stringWithFormat:@"%lld", [maf getAccount]];
            NSMutableArray *array = nil;
            if (![[moneyAccountFrozenMap allKeys] containsObject:accountID]) {
                array = [[NSMutableArray alloc] init];
                [moneyAccountFrozenMap setObject:array forKey:accountID];
            } else {
                array = [moneyAccountFrozenMap objectForKey:accountID];
            }
            [array addObject:maf];
        }
    }
}

- (void)resetMoneyAccountFrozen4Account:(long long)accountID
                      MoneyAccountArray:(NSArray *)vec{
    @synchronized(moneyAccountFrozenMap){
        [moneyAccountFrozenMap removeAllObjects];
        for (MoneyAccountFrozen *maf in vec) {
            NSString *key = [NSString stringWithFormat:@"%lld", [maf getAccount]];
            if (accountID != [maf getAccount]) {
                continue;
            }
            NSMutableArray *array = nil;
            if (![[moneyAccountFrozenMap allKeys] containsObject:key]) {
                array = [[NSMutableArray alloc] init];
                [moneyAccountFrozenMap setObject:array forKey:key];
            } else {
                array = [moneyAccountFrozenMap objectForKey:key];
            }
            [array addObject:maf];
        }
    }
}

- (NSArray *)getMoneyAccountFrozen4Account:(long long)accountID{
    @synchronized(moneyAccountFrozenMap){
        NSString *key = [NSString stringWithFormat:@"%lld", accountID];
        if ([[moneyAccountFrozenMap allKeys] containsObject:key]) {
            return [moneyAccountFrozenMap objectForKey:key];
        }
        return [[NSMutableArray alloc] init];
    }
}

#pragma Margin2 operate
- (void)resetMargin2:(NSArray *)Margin2Array{
    @synchronized(margin2RecordMap){
        [margin2RecordMap removeAllObjects];
        for (Margin2 *margin in Margin2Array) {
            NSString *key = [NSString stringWithFormat:@"%lld", [margin getAccount]];
            NSMutableArray *array = nil;
            if (![[margin2RecordMap allKeys] containsObject:key]) {
                array = [[NSMutableArray alloc] init];
                [margin2RecordMap setObject:array forKey:key];
            } else {
                array = [margin2RecordMap objectForKey:key];
            }
            [array addObject:margin];
        }
    }
}

- (void)resetMargin24Account:(long long)accountID
                     Margin2:(NSArray *)margin2Array{
    @synchronized(margin2RecordMap){
        NSString *key = [NSString stringWithFormat:@"%lld", accountID];
        [margin2RecordMap removeObjectForKey:key];
        for (Margin2 *margin in margin2Array) {
            if (accountID != [margin getAccount]) {
                continue;
            }
            NSMutableArray *array = nil;
            if (![[margin2RecordMap allKeys] containsObject:key]) {
                array = [[NSMutableArray alloc] init];
                [margin2RecordMap setObject:array forKey:key];
            } else {
                array = [margin2RecordMap objectForKey:key];
            }
            [array addObject:margin];
        }
    }
}

- (NSArray *)getMargin24Account:(long long)accountID{
    @synchronized(margin2RecordMap){
        NSString *key = [NSString stringWithFormat:@"%lld", accountID];
        if ([[margin2RecordMap allKeys] containsObject:key]) {
            return [margin2RecordMap objectForKey:key];
        }
        return [[NSMutableArray alloc] init];
    }
}

@end
