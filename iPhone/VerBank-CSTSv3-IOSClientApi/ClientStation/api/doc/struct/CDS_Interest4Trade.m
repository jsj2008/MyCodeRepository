//
//  CDS_Interest4Trade.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CDS_Interest4Trade.h"

@implementation CDS_Interest4Trade

@synthesize accountID;
@synthesize ticket;
@synthesize splitNo;
@synthesize instrument;
@synthesize amount;
@synthesize buysell;
@synthesize openPrice;
@synthesize fromValueDay;
@synthesize toValueDay;
@synthesize rolloverTimes;

@synthesize currency;
@synthesize interest_cost;
@synthesize interest_total;
@synthesize valueDay;

@synthesize ccy1;
@synthesize interestCost4ccy1InCcy1;
@synthesize interest4ccy1InCcy1;
@synthesize interestCost4ccy1InBasicCcy;
@synthesize interest4ccy1InBasicCcy;
@synthesize ccy2;
@synthesize interestCost4ccy2InCcy2;
@synthesize interest4ccy2InCcy2;
@synthesize interestCost4ccy2InBasicCcy;
@synthesize interest4ccy2InBasicCcy;
@synthesize description4Ccy1;
@synthesize description4Ccy2;

- (id)initWithTTrade:(TTrade *)trade{
    if (self = [super init]) {
        accountID = [trade getAccount];
        ticket = [trade getTicket];
        splitNo = [trade getSplitno];
        instrument = [trade getInstrument];
        amount = [trade getAmount];
        buysell = [trade getBuysell];
        openPrice = [trade getOpenprice];
    }
    return self;
}

+ (NSString *)format:(CDS_Interest4Trade *)i4t{
    NSMutableString *tempString = [[NSMutableString alloc] init];
    [tempString stringByAppendingFormat:@"%lld", [i4t accountID]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%lld", [i4t ticket]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%d", [i4t buysell]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%@", [i4t instrument]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%f", [i4t amount]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%f", [i4t openPrice]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%f", [i4t interest_cost]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%f", [i4t interest_total]];
    [tempString stringByAppendingFormat:@";"];
    [tempString stringByAppendingFormat:@"%@", [i4t valueDay]];
    return tempString;
}
+ (CDS_Interest4Trade *)parse:(NSString *)str{
    if (str == nil) {
        return nil;
    }
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str length] == 0) {
        return nil;
    }
    
    NSArray *array = [str componentsSeparatedByString:@";"];
    CDS_Interest4Trade *i4t = [[CDS_Interest4Trade alloc] init];
    [i4t setAccountID:[[array objectAtIndex:0] longValue]];
    [i4t setTicket:[[array objectAtIndex:1] longValue]];
    [i4t setBuysell:[[array objectAtIndex:2] intValue]];
    [i4t setInstrument:[[array objectAtIndex:3] stringValue]];
    [i4t setAmount:[[array objectAtIndex:4] doubleValue]];
    [i4t setOpenPrice:[[array objectAtIndex:5] doubleValue]];
    [i4t setInterest_cost:[[array objectAtIndex:6] doubleValue]];
    [i4t setInterest_total:[[array objectAtIndex:7] doubleValue]];
    [i4t setValueDay:[[array objectAtIndex:8] stringValue]];
    return i4t;
}

@end
