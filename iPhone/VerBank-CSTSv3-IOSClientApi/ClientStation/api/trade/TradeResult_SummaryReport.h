//
//  TradeResult_SummaryReport.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeResult_SummaryReport : NSObject

@property Boolean succeed;
@property NSString *_errCode;
@property NSString *_errMessage;
@property NSString *operateStreamGUID;

@property NSMutableDictionary *tableMap;
@property NSMutableDictionary *summaryMap;

- (void)addTable:(int)tableId object:(NSMutableArray *)tableList;

@end
