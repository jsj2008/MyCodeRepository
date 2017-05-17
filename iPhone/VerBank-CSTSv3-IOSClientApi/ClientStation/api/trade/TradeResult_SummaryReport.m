//
//  TradeResult_SummaryReport.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TradeResult_SummaryReport.h"

@implementation TradeResult_SummaryReport

@synthesize succeed;
@synthesize _errCode;
@synthesize _errMessage;
@synthesize operateStreamGUID;

@synthesize tableMap;
@synthesize summaryMap;

- (id)init{
    if (self = [super init]) {
        succeed = false;
        _errCode = @"";
        _errMessage = @"";
        tableMap = [[NSMutableDictionary alloc] init];
        summaryMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addTable:(int)tableId object:(NSMutableArray *)tableList{
    [tableMap setObject:[@(tableId) stringValue] forKey:tableList];
}

@end
