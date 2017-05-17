//
//  IP_Ctrl5001.m
//  VerBank-IOSClientStation
//
//  Created by ZhangLei on 2016/10/27.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IP_Ctrl5001.h"

static NSString * jsonId        = @"IP_Ctrl5001";

static NSString * singnatureData    = @"1";
static NSString * originalData      = @"2";

@implementation IP_Ctrl5001

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (SingnatureData,    singnatureData)
jsonImplementionString  (OriginalData,      originalData)
@end
