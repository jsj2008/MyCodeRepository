//
//  CDS_Interest4Trade.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"
#import "TTrade.h"

@interface CDS_Interest4Trade : CommDocBasicStruct

@property long long accountID;
@property long long ticket;
@property int splitNo;
@property NSString* instrument;
@property double amount;
@property int buysell;
@property double openPrice;
@property NSString* fromValueDay;
@property NSString* toValueDay;
@property int rolloverTimes;

@property NSString* currency;
@property double interest_cost;
@property double interest_total;
@property NSString* valueDay;

@property NSString* ccy1;
@property double interestCost4ccy1InCcy1;
@property double interest4ccy1InCcy1;
@property double interestCost4ccy1InBasicCcy;
@property double interest4ccy1InBasicCcy;
@property NSString* ccy2;
@property double interestCost4ccy2InCcy2;
@property double interest4ccy2InCcy2;
@property double interestCost4ccy2InBasicCcy;
@property double interest4ccy2InBasicCcy;
@property NSString* description4Ccy1;
@property NSString* description4Ccy2;

- (id)initWithTTrade:(TTrade *)trade;
+ (NSString *)format:(CDS_Interest4Trade *)i4t;
+ (CDS_Interest4Trade *)parse:(NSString *)str;

@end
