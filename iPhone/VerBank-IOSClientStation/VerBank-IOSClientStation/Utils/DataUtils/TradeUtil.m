//
//  TradeUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TradeUtil.h"
#import "TTrade.h"
#import "ToCloseTradeNode.h"
#import "APIDoc.h"
#import "LangCaptain.h"



@implementation TradeUtil

+ (Boolean)isLegalTradeAmount:(double)amount {
    if (amount - round(amount) > 0.000001) {
        return false;
    }
    return true;
}

+ (int)isHeadgeTradeAmountValiedBuyTicket:(NSArray *)toCloseBuyTickes sellNodes:(NSArray *)toCloseSellTickes{
    double buyCloseAmt = 0.0f;
    double sellCloseAmt = 0.0f;
    for (ToCloseTradeNode *node in toCloseBuyTickes) {
        TTrade *tradeNode = [[APIDoc getUserDocCaptain] getTrade:[node getTicket]];
        if ([tradeNode getAmount] < [node getAmount] - 0.0000001) {
            return CheckCode_CloseAmtMoreThanOrderAmt;
        }
        buyCloseAmt += [node getAmount];
    }
    
    for (ToCloseTradeNode *node in toCloseSellTickes) {
        TTrade *tradeNode = [[APIDoc getUserDocCaptain] getTrade:[node getTicket]];
        if ([tradeNode getAmount] < [node getAmount] - 0.0000001) {
            return CheckCode_CloseAmtMoreThanOrderAmt;
        }
        sellCloseAmt += [node getAmount];
    }
    
    if (fabs(buyCloseAmt - sellCloseAmt) > 0.00001) {
        return CheckCode_BuySellAmtNotMatch;
    }
    return CheckCode_Valid;
}

+ (NSString *)transCheckCode:(int)code {
    switch (code) {
        case CheckCode_CloseAmtMoreThanOrderAmt:
            return [[LangCaptain getInstance] getLangByCode:@"CheckCode_CloseAmtMoreThanOrderAmt"];
        case CheckCode_BuySellAmtNotMatch:
            return [[LangCaptain getInstance] getLangByCode:@"CheckCode_BuySellAmtNotMatch"];
        default:
            break;
    }
    return @"";
}

@end
