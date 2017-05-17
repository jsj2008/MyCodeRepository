//
//  OP_QG1001.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_QG1001.h"
static NSString *jsonId               = @"OP_QG1001";

static NSString *quoteArray               = @"1";
@implementation OP_QG1001

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(QuoteArray, quoteArray)

@end
