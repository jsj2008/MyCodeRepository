//
//  FnCertState.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "FnCertState.h"

static NSString * jsonId = @"FnCertState";

static NSString * returnCode            = @"1";
static NSString * requestID             = @"2";
static NSString * caSerial              = @"3";
static NSString * caState               = @"4";
static NSString * cn                    = @"5";
static NSString * beginValidTime        = @"6";
static NSString * endValidTime          = @"7";

@implementation FnCertState

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(ReturnCode,             returnCode)
jsonImplementionInt(RequestID,              requestID)
jsonImplementionString(CaSerial,            caSerial)
jsonImplementionInt(CaState,                caState)
jsonImplementionString(Cn,                  cn)
jsonImplementionLongLong(BeginValidTime,    beginValidTime)
jsonImplementionLongLong(EndValidTime,      endValidTime)

@end
