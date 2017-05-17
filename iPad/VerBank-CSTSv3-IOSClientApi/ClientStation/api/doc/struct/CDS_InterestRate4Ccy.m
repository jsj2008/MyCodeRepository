//
//  CDS_InterestRate4Ccy.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CDS_InterestRate4Ccy.h"
#import "JEDISystem.h"

@implementation CDS_InterestRate4Ccy

@synthesize typeID4Group;
@synthesize typeID4Account;
@synthesize currency;
@synthesize buy_cost;
@synthesize sell_cost;
@synthesize buy_add_group;
@synthesize sell_add_group;
@synthesize buy_add_account;
@synthesize sell_add_account;
@synthesize buy_sys;
@synthesize sell_sys;

- (double)getC_buy{
    return MAX(0.01, buy_sys - buy_add_group - buy_add_account);
}

- (double)getC_sell{
    return sell_sys + sell_add_group + sell_add_account;
}

- (NSString *)getDescription4Buy{
    return [self _getDescription:buy_sys :[self getC_buy]];
    
}
- (NSString *)getDescription4Sell{
    return [self _getDescription:sell_sys :[self getC_sell]];
}


- (NSString *)_getDescription:(double)cost :(double)total{
    NSMutableString *tempString = [[NSMutableString alloc] init];
    [tempString appendString:@"Interest Rate Info: "];
    [tempString appendString:@"CCY="];
    [tempString appendString:currency];
    [tempString appendString:@","];
    [tempString appendString:[self formatRate:cost]];
    [tempString appendString:@","];
    [tempString appendString:@"TOTAL="];
    [tempString appendString:[self formatRate:total]];
    return tempString;
}

- (NSString *)formatRate:(double)rate{
    return [JEDISystem stringFromDouble:rate maxFraction:6 minFraction:6];
}

@end
