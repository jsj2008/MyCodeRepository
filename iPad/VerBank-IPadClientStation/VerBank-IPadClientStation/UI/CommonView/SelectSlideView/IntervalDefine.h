//
//  IntervalDefine.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#ifndef IntervalDefine_h
#define IntervalDefine_h

typedef NS_ENUM(NSUInteger, SecIntervalType) {
    SecIntervalWeek1    = 0,
    SecIntervalWeek2    = 1,
    SecIntervalMonth1   = 2,
    SecIntervalMonth2   = 3,
    SecIntervalMonth3   = 4,
    SecIntervalMonth4   = 5,
    SecIntervalMonth5   = 6,
    SecIntervalMonth6   = 7,
};

#define WeekSecInterval 7 * 24 * 60 * 60
#define MonthSecInterval 30 * 24 * 60 *60

#endif /* IntervalDefine_h */
