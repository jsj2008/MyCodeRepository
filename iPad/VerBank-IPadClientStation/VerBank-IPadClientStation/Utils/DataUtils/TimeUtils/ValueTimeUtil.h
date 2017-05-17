//
//  ValueTimeUtil.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/7/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValueTimeUtil : NSObject

+ (NSDate *)parseExpireTypeToDate:(int)expireType;
+ (NSDate *)getCurrentDayTradeDayTime:(NSString *)tradeDay interval:(long)millis;
+ (NSDate *)getCurrentWeekTradeDayTime:(NSString *)tradeDay interval:(long)millis;

@end
