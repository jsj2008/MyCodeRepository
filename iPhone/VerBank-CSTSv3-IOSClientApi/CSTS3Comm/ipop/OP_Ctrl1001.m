//
//  OP_Ctrl1001.m
//  IOSClientStation_ex02
//
//  Created by Allone on 15/6/23.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OP_Ctrl1001.h"

static NSString *jsonId               = @"OP_Ctrl1001";

static NSString *result               = @"1";
static NSString *loginTime            = @"2";
static NSString *fixedIPVector        = @"3";
static NSString *passwordNeedChange   = @"4";
static NSString *usernameNeedChange   = @"5";
static NSString *accountList          = @"6";
static NSString *certState            = @"7";
static NSString *cerstateDesc         = @"8";

@implementation OP_Ctrl1001

//----------------------------------------------------------------------
-(id)       init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionInt         (Result,              result)
jsonImplementionLongLong    (LoginTime,           loginTime)
jsonImplementionObjectVec   (FixedIPVector,       fixedIPVector)
jsonImplementionBoolean     (PasswordNeedChange,  passwordNeedChange)
jsonImplementionBoolean     (UserNameNeedChange,  usernameNeedChange)
jsonImplementionObjectVec   (AccountList,         accountList)
jsonImplementionInt         (CertState,           certState)
jsonImplementionString      (CersStateDesc,       cerstateDesc)

@end
