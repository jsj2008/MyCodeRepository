//
//  ValueTimeUtil.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/7/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ValueTimeUtil.h"
#import "SystemConfig.h"
#import "APIDoc.h"
#import "MTP4CommDataInterface.h"
#import "JEDIDateTime.h"

@implementation ValueTimeUtil

+ (NSDate *)parseExpireTypeToDate:(int)expireType {
    NSDate *eTime = nil;
    SystemConfig *config = [[APIDoc getSystemDocCaptain] systemConfig];
    switch (expireType) {
        case ORDER_EXPIRE_TYPE_WEEK:
            eTime = [self getCurrentWeekTradeDayTime:[config getTradeDay] interval:[config getNycCloseTimeInMil] / 1000];
            break;
        case ORDER_EXPIRE_TYPE_DAY:
            eTime = [self getCurrentDayTradeDayTime:[config getTradeDay] interval:[config getNycCloseTimeInMil] / 1000];
            break;
            
        default:
            break;
    }
    return eTime;
}

+ (NSDate *)getCurrentDayTradeDayTime:(NSString *)tradeDay interval:(long)millis {
    int dayGap = 24 * 60 * 60;
    int closeTime = (int)MAX(millis, 0);
    //    NSDateFormatter *formatther= [[NSFormatter alloc] i];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *day = [dateFormat dateFromString:tradeDay];
    //    day = [day initWithTimeIntervalSinceNow:closeTime];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:day];
    
    int openTime = (int)millis;
    if (openTime < dayGap / 2) {
        comps.day += 1;
    } else {
        comps.day = 0;
    }
    
//    return [[calendar dateFromComponents:comps] initWithTimeIntervalSinceNow:closeTime];
    NSDate *resDate = [NSDate dateWithTimeInterval:closeTime sinceDate:[calendar dateFromComponents:comps]];
//    return [self getLoaction:resDate];
    return resDate;
}

+ (NSDate *)getCurrentWeekTradeDayTime:(NSString *)tradeDay interval:(long)millis {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *day = [dateFormat dateFromString:tradeDay];
    int dayGap = 24 * 60 * 60;
    int closeTime = (int)MAX(millis, 0);
    
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
//    NSDateComponents *comps = [calendar components:unitFlags fromDate:day];
    
    NSDate *date;
    
    int openTime = (int)millis;
    if (openTime < dayGap / 2) {
        date = [JEDIDateTime dayOfWeek:JEDIWeekSaturday forDate:day];
    } else {
        date = [JEDIDateTime dayOfWeek:JEDIWeekFriday forDate:day];
    }
//    return [date initWithTimeIntervalSinceNow:closeTime];
    NSDate *resDate = [NSDate dateWithTimeInterval:closeTime sinceDate:date];
    return resDate;
//    return [self getLoaction:resDate];

}

+ (NSDate *)getLoaction:(NSDate *)resDate {
    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSInteger interval1 = [zone secondsFromGMTForDate: resDate];//修改时区
    return [resDate  dateByAddingTimeInterval:interval1];
}

@end
