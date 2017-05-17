//
//  OP_TRADESERV5101.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_TRADESERV5101.h"

static NSString *jsonId                         = @"OP_TRADESERV5101";

static NSString *mktPriceChanged                            = @"1";
static NSString *newMKTPrice                                = @"2";
static NSString *orderHis                                   = @"3";

@implementation OP_TRADESERV5101
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionBoolean(MktPriceChanged, mktPriceChanged)
jsonImplementionDouble(NewMKTPrice, newMKTPrice)
jsonImplementionObject(OrderHis, orderHis)

@end
