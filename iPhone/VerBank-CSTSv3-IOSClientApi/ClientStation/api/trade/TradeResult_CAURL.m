//
//  TradeResult_CAURL.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TradeResult_CAURL.h"

@implementation TradeResult_CAURL

@synthesize succeed;
@synthesize _errCode;
@synthesize _errMessage;
@synthesize caURL;

- (id)init{
    if (self = [super init]) {
        succeed = false;
        _errCode = @"";
        _errMessage = @"";
    }
    return self;
}

@end
