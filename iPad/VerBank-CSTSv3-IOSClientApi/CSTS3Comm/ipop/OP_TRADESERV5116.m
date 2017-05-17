//
//  OP_TRADESERV5116.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5116.h"

static NSString *jsonId                         = @"OP_TRADESERV5116";

@implementation OP_TRADESERV5116
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
@end
