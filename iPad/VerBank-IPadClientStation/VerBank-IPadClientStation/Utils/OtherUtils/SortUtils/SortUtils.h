//
//  SortUtils.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortUtils : NSObject

+ (void)sortOpenPositionArray:(NSMutableArray *)array;
+ (void)sortOrderPositionArray:(NSMutableArray *)array;
+ (void)sortPositionSumArray:(NSMutableArray *)array;
+ (void)sortMessageToAccountArray:(NSMutableArray *)array;
+ (void)sortRSSMessage:(NSMutableArray *)array;
+ (void)sortPushToAccountArray:(NSMutableArray *)array;
+ (void)sortClosePositionArray:(NSMutableArray *)array;
+ (void)sortOrderHisArray:(NSMutableArray *)array;
+ (void)sortEconomicDataArray:(NSMutableArray *)array;
+ (void)sortAccountStreamDetailsArray:(NSMutableArray *)array;

@end
