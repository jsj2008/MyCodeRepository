//
//  OP_REPORT2023.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_REPORT2023.h"

static NSString *jsonId                         = @"OP_REPORT2023";

static NSString *dataList                       = @"1";

@implementation OP_REPORT2023
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionObjectVec(DataList, dataList)

@end
