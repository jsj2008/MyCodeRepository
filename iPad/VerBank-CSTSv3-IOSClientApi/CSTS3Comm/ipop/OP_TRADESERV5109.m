//
//  OP_TRADESERV5109.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5109.h"

static NSString *jsonId                         = @"OP_TRADESERV5109";

static NSString *addPriceWarning                         = @"1";

@implementation OP_TRADESERV5109
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(AddPriceWarning, addPriceWarning)

@end
