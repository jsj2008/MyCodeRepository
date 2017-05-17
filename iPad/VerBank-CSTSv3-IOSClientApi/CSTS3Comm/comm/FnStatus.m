//
//  FnStatus.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "FnStatus.h"

static NSString * jsonId = @"FnStatus";

static NSString * returnCode            = @"1";
static NSString * returnMessage         = @"2";
static NSString * effectiveCANumber     = @"3";
static NSString * requestCANumber       = @"4";
static NSString * lastCASerial          = @"5";
static NSString * lastCAState           = @"6";
static NSString * csrLength             = @"7";
static NSString * previousCA            = @"8";

@implementation FnStatus

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt(ReturnCode,          returnCode)
jsonImplementionInt(ReturnMessage,       returnMessage)
jsonImplementionInt(EffectiveCANumber,   effectiveCANumber)
jsonImplementionInt(RequestCANumber,     requestCANumber)
jsonImplementionString(LastCASerial,     lastCASerial)
jsonImplementionInt(LastCAState,         lastCAState)
jsonImplementionInt(CsrLength,           csrLength)
jsonImplementionString(PreviousCA,       previousCA)

@end
