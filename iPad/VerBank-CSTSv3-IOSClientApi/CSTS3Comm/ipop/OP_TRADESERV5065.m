//
//  OP_TRADESERV5065.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5065.h"

static NSString *jsonId                         = @"OP_TRADESERV5065";

static NSString *caURL                         = @"1";

@implementation OP_TRADESERV5065
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(CaURL, caURL)

@end
