//
//  Info_TRADESERV1015.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "Info_TRADESERV1015.h"

static NSString * jsonId        = @"Info_TRADESERV1015";

static NSString * priceWarning    = @"1";

@implementation Info_TRADESERV1015

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(PriceWarning, priceWarning)

@end
