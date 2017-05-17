//
//  OP_REPORT2007.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_REPORT2007.h"

static NSString *jsonId                         = @"OP_REPORT2007";

static NSString *orderHisDetails                = @"1";

@implementation OP_REPORT2007
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(OrderHisDetails, orderHisDetails)

@end
