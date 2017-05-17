//
//  OP_TRADESERV5025.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5025.h"

static NSString *jsonId                     = @"OP_TRADESERV5025";

static NSString *orderArray                 = @"1";

@implementation OP_TRADESERV5025

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(TOrderArray, orderArray)

@end
