//
//  OP_TRADESERV6102.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OP_REPORT6102.h"

static NSString *jsonId                         = @"OP_REPORT6102";

static NSString *dataList                         = @"1";

@implementation OP_REPORT6102

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObject(DataList, dataList)

@end
