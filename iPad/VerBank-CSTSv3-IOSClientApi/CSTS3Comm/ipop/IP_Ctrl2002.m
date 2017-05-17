//
//  IP_Ctrl20012.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IP_Ctrl2002.h"

static NSString * jsonId        = @"IP_Ctrl2002";

static NSString * locale    = @"1";
static NSString * keySet    = @"2";
static NSString * digist    = @"3";

@implementation IP_Ctrl2002

-(id)init{
    if (self = [super init]){
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString      (Locale,    locale)
jsonImplementionObjectVec   (KeySet,    keySet)
jsonImplementionString      (Digist,    digist)

@end
