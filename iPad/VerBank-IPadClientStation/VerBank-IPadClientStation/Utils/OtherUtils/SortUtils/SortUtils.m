//
//  SortUtils.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "SortUtils.h"
#import "ClientSystemConfig.h"
#import "NSArraySortUtil.h"

#import "TTrade.h"
#import "TOrder.h"
#import "PositionSumItem.h"
#import "MessageToAccount.h"
#import "PushFromSystem.h"
#import "ClosePositionDetails.h"
#import "TOrderHis.h"
#import "EconomicData.h"
#import "IDNFeedParser.h"
#import "AccountStreamDetails.h"

@implementation SortUtils

+ (void)sortOpenPositionArray:(NSMutableArray *)array {
    switch ([[[ClientSystemConfig getInstance] openPositionSortType] intValue]) {
        case OpenPositionSortInstrument:
            // 多字段 排序 嵌套比較麻煩 ， 這樣比較方面 但效率低， 效率要求不高， 暫時這麼寫
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade getOpenprice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TTrade *trade in array) {
                [trade setSortTag:[trade getInstrument]];
            }
            [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
            break;
        case OpenPositionSortOpenPrice:
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade getOpenprice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        case OpenPositionSortFloatPL:
            for (TTrade *trade in array) {
                [trade setSortTag:[@([trade floatPL]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        case OpenPositionSortTradeTime:
            for (TTrade *trade in array) {
                [trade setSortTag:[JEDIDateTime stringUIFromDate:[trade getOpenTime]]];
            }
            [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
            break;
        default:
            break;
    }
}

+ (void)sortOrderPositionArray:(NSMutableArray *)array {
    switch ([[[ClientSystemConfig getInstance] orderSortType] intValue]) {
        case OrderSortInstrument:
            for (TOrder *order in array) {
                [order setSortTag:[@([order getCurrentStopPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getLimitPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            
            for (TOrder *order in array) {
                [order setSortTag:[@([order getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[order getInstrument]];
            }
            [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
            break;
        case OrderSortDESC:
            for (TOrder *order in array) {
                [order setSortTag:[@([order getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getCurrentStopPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getLimitPrice]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        case OrderSortASC:
            for (TOrder *order in array) {
                [order setSortTag:[@([order getBuysell]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                [order setSortTag:[@([order getCurrentStopPrice]) stringValue]];
            }
            [NSArraySortUtil sortASCNumberArray:array sortSelector:@"sortTag"];
            for (TOrder *order in array) {
                if ([order getLimitPrice] <= 0.0f) {
                    [order setSortTag:[@(INTMAX_MAX) stringValue]];
                } else {
                    [order setSortTag:[@([order getLimitPrice]) stringValue]];
                }
            }
            [NSArraySortUtil sortASCNumberArray:array sortSelector:@"sortTag"];
            break;
        default:
            break;
    }

}

+ (void)sortPositionSumArray:(NSMutableArray *)array {
    switch ([[[ClientSystemConfig getInstance] positionSumSortType] intValue]) {
        case PositionSumSortInstrument:
            for (PositionSumItem *item in array) {
                [item setSortTag:[item instrument]];
            }
            [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
            break;
        case PositionSumSortASC:
            for (PositionSumItem *item in array) {
                [item setSortTag:[@([item sumFloatPL]) stringValue]];
            }
            [NSArraySortUtil sortDESCNumberArray:array sortSelector:@"sortTag"];
            break;
        default:
            break;
    }
}

+ (void)sortMessageToAccountArray:(NSMutableArray *)array {
    for (MessageToAccount *ma in array) {
        [ma setSortTag:[JEDIDateTime stringUIFromDate:[ma getTime]]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}

+ (void)sortRSSMessage:(NSMutableArray *)array {
    for (IDNFeedItem *item in array) {
        [item setSortTag:[JEDIDateTime stringUIFromDate:[item date]]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}

+ (void)sortPushToAccountArray:(NSMutableArray *)array {
    for (PushFromSystem *push in array) {
        [push setSortTag:[JEDIDateTime stringUIFromDate:[push getTime]]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}

+ (void)sortClosePositionArray:(NSMutableArray *)array {
    for (ClosePositionDetails *cpd in array) {
        [cpd setSortTag:[JEDIDateTime stringUIFromDate:[cpd getCloseTime]]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}

+ (void)sortOrderHisArray:(NSMutableArray *)array {
    for (TOrderHis *orderHis in array) {
        [orderHis setSortTag:[JEDIDateTime stringUIFromDate:[orderHis getcloseTime]]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}

+ (void)sortEconomicDataArray:(NSMutableArray *)array {
    for (EconomicData *data in array) {
        NSString *time = @"";
        if ([[data getTime]isEqualToString:@""] || [data getTime] == nil) {
            time = @"00:00";
        } else {
            time = [data getTime];
        }
        NSString *timeString = [NSString stringWithFormat:@"%@%@", [data getDate], time];
        
        NSDate *date = [JEDIDateTime dateFromString:timeString withFormat:@"yyyy-MM-ddHH:mm"];
//        NSDate *date = [JEDIDateTime dateFromString:[data getDate] withFormat:@"yyyy-MM-dd"];
        [data setSortTag:[JEDIDateTime stringUIFromDate:date]];
    }
    [NSArraySortUtil sortASCStringArray:array sortSelector:@"sortTag"];
}

+ (void)sortAccountStreamDetailsArray:(NSMutableArray *)array {
    for (AccountStreamDetails *asd in array) {
        [asd setSortTag:[JEDIDateTime stringUIFromDate:[asd getValueTime]]];
    }
    [NSArraySortUtil sortDESCStringArray:array sortSelector:@"sortTag"];
}

@end
