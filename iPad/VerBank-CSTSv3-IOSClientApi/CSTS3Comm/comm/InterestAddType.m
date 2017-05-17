//
//  InterestAddType.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "InterestAddType.h"

static NSString * jsonId = @"InterestAddType";

// private String typeId;
// private String CurrencyName;
// private String typeName;
// private double interestBuyAdd;
// private double interestSellAdd;

static NSString * TypeId = @"1";
static NSString * CurrencyName = @"2";
static NSString * TypeName = @"3";
static NSString * InterestBuyAdd = @"4";
static NSString * InterestSellAdd = @"5";

@implementation InterestAddType
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(TypeId,          TypeId)
jsonImplementionString(CurrencyName,    CurrencyName)
jsonImplementionString(TypeName,        TypeName)
jsonImplementionDouble(InterestBuyAdd,  InterestBuyAdd)
jsonImplementionDouble(InterestSellAdd, InterestSellAdd)
@end
