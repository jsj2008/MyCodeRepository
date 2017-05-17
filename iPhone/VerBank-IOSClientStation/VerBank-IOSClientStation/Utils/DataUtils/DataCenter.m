//
//  DataCenter.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/16.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "DataCenter.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "IosLogic.h"
#import "PushFromSystem.h"

static DataCenter *instance = nil;

@interface DataCenter() {
    int phonePinErrTime;
}

@end

@implementation DataCenter

@synthesize priceWarningArray;

//priceWarning addOrModify
@synthesize priceWarning;
@synthesize priceWarningInstrument;

//order addOrModify
@synthesize order;
@synthesize orderInstrument;

@synthesize reportList;
@synthesize pushList;

@synthesize phonePin;
@synthesize phonePinTime;

@synthesize fnCertState;
@synthesize fnCertResult;

@synthesize isNeedShowCertificateEndTime;

+ (DataCenter *)getInstance {
    if (instance == nil) {
        instance = [[DataCenter alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        phonePinErrTime = 0;
    }
    return self;
}

- (Boolean)queryPriceWarning {
    NSArray *allWarningArray = [[TradeApi getInstance] queryPriceWarning];
    NSMutableArray *accountArray = [[NSMutableArray alloc] init];
    for (PriceWarning *pw in allWarningArray) {
        if ([pw getAccount] == [[ClientAPI getInstance] accountID]) {
            [accountArray addObject:pw];
        }
    }
    priceWarningArray = [[NSArray alloc] initWithArray:accountArray];
    return true;
}

- (Boolean)queryReportList {
    NSString *clientAeid = [[ClientAPI getInstance] aeid];
    TradeResult_SimpleReport *result = [[TradeApi getInstance] report_MessageToAccount:clientAeid];
    
    if (![result succeed]) {
        return false;
    }
    
    reportList = [result reportList];
    return true;
}

- (Boolean)queryPushMessage {
    NSString *clientAeid = [[ClientAPI getInstance] aeid];
    TradeResult_SimpleReport *result = [[TradeApi getInstance] report_PushFromSystemAll:clientAeid];
    
    if (![result succeed]) {
        return false;
    }
    
    if (pushList == nil || [pushList count] == 0) {
        pushList = [result reportList];
        
    } else {
        
        NSMutableArray *guidArray = [[NSMutableArray alloc] init];
        for (PushFromSystem *push in pushList) {
            [guidArray addObject:[push getGuid]];
        }
        
        for (PushFromSystem *push in [result reportList]) {
            if (![guidArray containsObject:[push getGuid]]) {
                [pushList addObject:push];
            }
        }
    }
    return true;
}

- (Boolean)messageIsAllRead {
    [self queryReportList];
    if (reportList == nil || [reportList count] == 0) {
        return true;
    }
    
    NSDate *monthBeforDate = [NSDate dateWithTimeInterval:-24 * 60 *60 * 30 sinceDate:[NSDate date]];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (MessageToAccount *ma in  reportList) {
        if ([[ma getTime] compare:monthBeforDate] == NSOrderedDescending) {
            [tempArray addObject:ma];
        }
    }
    
    if (tempArray == nil || [tempArray count] == 0) {
        return true;
    }
    
    for (MessageToAccount *ma in tempArray) {
        if ([ma getIsRead] != _TRUE) {
            return false;
        }
    }
    return true;
}

- (void)resetPhonePinErr {
    phonePinErrTime = 0;
}

- (void)phonePinErr {
    phonePinErrTime ++;
    NSLog(@"Phone ping err %d", phonePinErrTime);
    if (phonePinErrTime >= 5) {
        [[IosLogic getInstance] logoutFromServer];
    }
}

- (void)clearData {
    self.priceWarningArray = nil;
    
    //priceWarning addOrModify
    self.priceWarning = nil;
    self.priceWarningInstrument = nil;
    
    //order addOrModify
    self.order = nil;
    self.orderInstrument = nil;
    
    self.reportList = nil;
    self.pushList = nil;
    
    self.phonePin = nil;
    self.phonePinTime = nil;
    
    self.fnCertState = nil;
    self.fnCertResult = nil;
    phonePinErrTime = 0;
}

@end
