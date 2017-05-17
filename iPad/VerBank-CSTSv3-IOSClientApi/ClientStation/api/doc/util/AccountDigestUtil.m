//
//  AccountDigestUtil.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AccountDigestUtil.h"
#import "JEDIDigest.h"
#import "JEDISystem.h"
#import "JEDITranslater.h"

//#import "AccountStore.h"
#import "TTrade4CFD.h"
#import "TOrders4CFD.h"
#import "CDS_AccountStore.h"
#import "CommDocCaptain.h"

static NSNumberFormatter *numberFormatter = nil;

@implementation AccountDigestUtil

- (Boolean)isAccountDigestMatch:(long long)accountID  Digest:(NSString *)digest{
    JEDI_SYS_Try{
        NSString *info = [self getAccountInfo:accountID];
        NSData *digestBuff = [self getDigesBuff:info];
        return [self isDigestMatch:digestBuff digest:digest];
    }JEDI_SYS_EndTry
}

- (Boolean)isUserDigestMatch:(NSString *)user  Digest:(NSString *)digest{
    JEDI_SYS_Try{
        NSString *info = [self getUserInfo:user];
        NSData *digestBuff = [self getDigesBuff:info];
        return [self isDigestMatch:digestBuff digest:digest];
    }JEDI_SYS_EndTry
}

-(Boolean)isDigestMatch:(NSData *)digestData digest:(NSString *)digest{
    JEDI_SYS_Try{
        NSString * digestLocale = nil;
        
        digestLocale = [self parseBuff2String:digestData radix:36 unsign:false];
        if([digestLocale isEqualToString:digest]){
            return true;
        }
        
        digestLocale = [self parseBuff2String:digestData radix:36 unsign:true];
        if([digestLocale isEqualToString:digest]){
            return true;
        }
        
        digestLocale = [self parseBuff2String:digestData radix:16 unsign:true];
        if([digestLocale isEqualToString:digest]){
            return true;
        }
        
        digestLocale = [self parseBuff2String:digestData radix:16 unsign:false];
        if([digestLocale isEqualToString:digest]){
            return true;
        }
    }JEDI_SYS_EndTry
    return false;
}

//- (NSData *)getGroupDigest:(NSString *)group{
//    JEDI_SYS_Try{
//        NSMutableString *sb = [[NSMutableString alloc] init];
//        NSArray *array = [[[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStoreByGroup:group] sortedArrayUsingComparator:^NSComparisonResult(CDS_AccountStore *obj1, CDS_AccountStore *obj2) {
//            if ([obj1 getAccountID] > [obj2 getAccountID]) {
//                return (NSComparisonResult)NSOrderedDescending;
//            }
//            if ([obj1 getAccountID] < [obj2 getAccountID]) {
//                return (NSComparisonResult)NSOrderedAscending;
//            }
//            return (NSComparisonResult)NSOrderedSame;
//        }];
//        for (CDS_AccountStore *as in array) {
//            [sb stringByAppendingString:[self getAccountDigest:[as getAccountID]]];
//        }
//
//    }JEDI_SYS_EndTry
//}


- (NSString *)getUserDigest:(NSString *)aeid{
    return [self getUserDigest:aeid  Radix:36  Unsign:false];
}

- (NSString *)getUserDigest:(NSString *)aeid  Radix:(int)radix  Unsign:(Boolean)unsign{
    JEDI_SYS_Try{
        NSString *info = [self getUserInfo:aeid];
        NSData *buf = [self getDigesBuff:info];
        return [self parseBuff2String:buf radix:radix unsign:unsign];
    }JEDI_SYS_EndTry
}

- (NSString *)getUserInfo:(NSString *)aeid{
    JEDI_SYS_Try{
        NSArray *array = [[[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStoreByAeid:aeid] sortedArrayUsingComparator:^NSComparisonResult(CDS_AccountStore *obj1, CDS_AccountStore *obj2) {
            if ([obj1 getAccountID] > [obj2 getAccountID]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([obj1 getAccountID] < [obj2 getAccountID]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        NSMutableString *sb = [[NSMutableString alloc] init];
        for (CDS_AccountStore *as in array) {
            [sb stringByAppendingFormat:@"%lld", [as getAccountID]];
        }
        return sb;
    }JEDI_SYS_EndTry
}

//- (NSData *)getAccountDigestBuf:(long long)acid{}
- (NSString *)getAccountDigest:(long long)acid{
    return [self getAccountDigest:acid  Radix:36  Unsign:false];

}
- (NSString *)getAccountDigest:(long long)acid  Radix:(int)radix  Unsign:(Boolean)unsign{
    JEDI_SYS_Try{
        NSString *info = [self getAccountInfo:acid];
        NSData *buf = [self getDigesBuff:info];
        return [self parseBuff2String:buf radix:radix unsign:false];
    }JEDI_SYS_EndTry
}

- (NSString *)getAccountInfo:(long long)acid{
    CDS_AccountStore *as = [[[CommDocCaptain getInstance] getUserDocCaptain] getCDS_AccountStore:acid];
    GroupDoc *groupDoc = [[[CommDocCaptain getInstance] getUserDocCaptain] getGroupDocByAccount:acid];
    NSMutableArray *tradeArray = [[groupDoc getTradeDoc] getTTradeByAccountList:acid];
    NSMutableArray *orderArray = [[groupDoc getOrderDoc] getTOrderByAccountList:acid];
    
    NSMutableArray *tradeVec = nil;
    NSMutableArray *orderVec = nil;
    if (tradeArray != nil) {
        tradeVec = [[NSMutableArray alloc] initWithArray:[tradeArray sortedArrayUsingComparator:^NSComparisonResult(TTrade *obj1, TTrade *obj2) {
            if ([obj1 getTicket] > [obj2 getTicket]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else if ([obj1 getTicket] < [obj2 getTicket]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else {
                return [obj1 getSplitno] > [obj2 getSplitno] ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending;
            }
        }]];
    }
    
    if (orderArray != nil) {
        orderVec = [[NSMutableArray alloc] initWithArray:[orderArray sortedArrayUsingComparator:^NSComparisonResult(TOrder *obj1, TOrder *obj2) {
            if ([obj1 getOrderID] > [obj2 getOrderID]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else if ([obj1 getOrderID] < [obj2 getOrderID]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else {
                return [obj1 getOsplitNo] > [obj2 getOsplitNo] ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending;
            }
        }]];
    }
    NSString *info = [self getAccountInfo:as tradeList:tradeVec orderList:orderVec];
    return info;
}

-(NSString *)   getAccountInfo:(CDS_AccountStore *)account
                     tradeList:(NSMutableArray *)tradeList
                     orderList:(NSMutableArray *)orderList
{
    NSMutableString *sb = [[NSMutableString alloc] init];
    [sb appendString:@"$account="];
    [sb appendFormat:@"%lld", [account getAccountID]];
    [sb appendString:@","];
    MoneyAccount *tempMac = [account moneyAccount];
    double tempMoney = [tempMac getCashBalance] - [tempMac getTbs] - [tempMac getFixedDeposit] - [tempMac getMargin2];
    if (fabs(tempMoney) > 0.01) {
        [sb appendFormat:@"%@=%@",[tempMac getCurrencyName], [self formatDouble:tempMoney]];
    }
    [sb appendString:@"@"];
    if (tradeList != nil) {
        [sb appendString:@"trade="];
        [sb appendFormat:@"%lu", (unsigned long)[tradeList count]];
        [sb appendString:@","];
        for (TTrade *trade in tradeList) {
            [sb appendFormat:@"%lld_%d", [trade getTicket], [trade getSplitno]];
            [sb appendString:@"#"];
        }
    }
    [sb appendString:@"@"];
    
    if (orderList != nil) {
        [sb appendString:@"order="];
        [sb appendFormat:@"%lu", (unsigned long)[orderList count]];
        [sb appendString:@","];
        for (TOrder *order in orderList) {
            [sb appendFormat:@"%lld_%d", [order getOrderID], [order getOsplitNo]];
            [sb appendString:@"#"];
        }
    }
    return sb;
}

-(NSData *)     getDigesBuff:(NSString *)str {
    return [JEDIDigest digestDataFromString:str];
}

-(NSString *)   parseBuff2String:(NSData *)buf radix:(int)radix unsign:(Boolean)unsign {
    return [JEDITranslater stringFromData:buf radix:radix unsign:unsign];
}

-(NSString *)   formatDouble:(double)data {
    if(numberFormatter == nil){
            numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
            [numberFormatter setMaximumFractionDigits:4];
            [numberFormatter setMinimumFractionDigits:4];
            [numberFormatter setMinimumIntegerDigits:1];
    }
    
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:data]];
}

@end
