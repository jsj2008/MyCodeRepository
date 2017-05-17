//
//  JumpDataCenter.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/15.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "JumpDataCenter.h"
#import "MTP4CommDataInterface.h"
#import "IosLogic.h"

static JumpDataCenter *instance = nil;

@interface JumpDataCenter() {
    int phonePinErrTime;
}
@end

@implementation JumpDataCenter

@synthesize createTradeInstrument;
@synthesize marketTradeType;

@synthesize openFailedMessage;
@synthesize openSuccessStruct;

@synthesize openPositionOrderInstrument;

@synthesize tradeResultTitle;
@synthesize tradeResultMessage;

@synthesize modifyOrder;
@synthesize openOrderTrade;

@synthesize openOrderType;

@synthesize hedgingInstrumentName;
@synthesize closePositionTrade;

@synthesize customAmountIndex;

@synthesize fnCertState;
@synthesize fnCertResult;

@synthesize rssIndex;

@synthesize phonePin;

@synthesize kChartWebView;

@synthesize valueTimeButton;

@synthesize addNewOrderID;
@synthesize openPositionTicket;
@synthesize openPositionInstrumentName;
@synthesize closePositionHisTicketArray;

@synthesize tradeShowIndex;

@synthesize enlargeInstrumentName;

+ (JumpDataCenter *)getInstance {
    if (instance == nil) {
        instance = [[JumpDataCenter alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        createTradeInstrument = @"";
        marketTradeType = SELL;
        openFailedMessage = @"";
        openSuccessStruct = nil;
        
        openPositionOrderInstrument = @"";
        
        tradeResultTitle = @"";
        tradeResultMessage = @"";
        
        modifyOrder = nil;
        openOrderTrade = nil;
        
        hedgingInstrumentName = @"";
        closePositionTrade = nil;
        
        valueTimeButton = nil;
        phonePinErrTime = 0;
        tradeShowIndex = 0;
        
        addNewOrderID = -1;
        openPositionInstrumentName = @"";
        openPositionTicket = 0;
        closePositionHisTicketArray = [[NSArray alloc] init];
    }
    return self;
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

- (void)destroy {
    instance = nil;
}

@end
