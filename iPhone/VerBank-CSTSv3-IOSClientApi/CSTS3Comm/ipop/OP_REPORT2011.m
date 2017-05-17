//
//  OP_REPORT2011.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "OP_REPORT2011.h"

static NSString *jsonId                         = @"OP_REPORT2011";

static NSString *dataList                       = @"1";

@implementation OP_REPORT2011

-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(DataList, dataList)

@end
