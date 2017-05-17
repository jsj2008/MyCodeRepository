//
//  TOrderHisDetails.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TOrderHisDetails.h"

static NSString * jsonId = @"TOrderHisDetails";

static NSString * aeid = @"101";

@implementation TOrderHisDetails

- (id)init{
    if(self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid, aeid)

@end
