//
//  AccountStreamDetails.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "AccountStreamDetails.h"

static NSString * jsonId = @"AccountStreamDetails";

static NSString * aeid                  = @"1";
static NSString * balance               = @"2";


@implementation AccountStreamDetails

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid,        aeid)
jsonImplementionDouble(Balance,     balance)

@end
