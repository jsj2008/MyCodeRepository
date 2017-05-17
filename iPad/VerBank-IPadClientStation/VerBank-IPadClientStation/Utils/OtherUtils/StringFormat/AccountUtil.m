//
//  AccountUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/2.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AccountUtil.h"

#import "ClientAPI.h"

@implementation AccountUtil

+ (NSString *)getAccountID {
    NSString *accid = [@([[ClientAPI getInstance] accountID]) stringValue];
    
    if ([accid length] < 5) {
        return [[NSString alloc] initWithFormat:@"%@%@", [self getZeroByCount:5 - (int)[accid length]], accid];
    }
    
    NSString *accountString = [accid substringWithRange:NSMakeRange([accid length] - 5, 5)];
    
    return accountString;
}

+ (NSString *)getAccountID:(long long)accountID {
    NSString *accid = [@(accountID) stringValue];
    return [accid substringWithRange:NSMakeRange([accid length] - 5, 5)];
}

+ (NSString *)getZeroByCount:(int)count {
    NSString *zeroString = @"000000000";
    return [zeroString substringWithRange:NSMakeRange(0, count)];
}

@end
