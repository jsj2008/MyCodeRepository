//
//  IP_TRADESERV1904.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IP_TRADESERV1904.h"

static NSString * jsonId        = @"IP_TRADESERV1904";

static NSString * operationRecords        = @"1";

@implementation IP_TRADESERV1904

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(OperationRecords, operationRecords)

@end