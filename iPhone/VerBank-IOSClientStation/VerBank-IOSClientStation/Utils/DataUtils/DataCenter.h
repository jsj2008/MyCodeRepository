//
//  DataCenter.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOrder.h"
#import "TTrade.h"
#import "PriceWarning.h"
#import "FnCertState.h"

@interface DataCenter : NSObject

// priceWarning
@property NSArray *priceWarningArray;

//priceWarning addOrModify
@property PriceWarning *priceWarning;
@property NSString *priceWarningInstrument;

//order open addOrModify
@property TOrder *order;
@property NSString *orderInstrument;

//
@property NSArray *reportList;
@property NSMutableArray *pushList;

// OrderOpenAddOrModifyPosition
@property TTrade *trade;

@property NSString *phonePin;
@property NSDate *phonePinTime;

@property FnCertState *fnCertState;
@property NSString *fnCertResult;

@property Boolean isNeedShowCertificateEndTime;

+ (DataCenter *)getInstance;

- (Boolean)queryPriceWarning;
- (Boolean)queryReportList;
- (Boolean)messageIsAllRead;

- (Boolean)queryPushMessage;

- (void)clearData;

- (void)phonePinErr;
- (void)resetPhonePinErr;

@end
