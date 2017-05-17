//
//  TimeUtils.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

+ (NSString *)getInputValue:(int)cycle {
//    switch (cycle) {
//        case ChartCycleMin1:
//            return @"M1";
//        case ChartCycleMin5:
//            return @"M5";
//        case ChartCycleMin10:
//            return @"M10";
//        case ChartCycleMin15:
//            return @"M15";
//        case ChartCycleMin30:
//            return @"M30";
//        case ChartCycleMin60:
//            return @"H1";
//        case ChartCycleMin90:
//            return @"M90";
//        case ChartCycleMin180:
//            return @"H3";
//            
//        case ChartCycleDay:
//            return @"Daily";
//        case ChartCycleWeek:
//            return @"Weekly";
//        case ChartCycleMonth:
//            return @"Monthly";
//        case ChartCycleYear:
//            return @"Year";
//            
//        case ChartCycleHour2:
//            return @"H2";
//        case ChartCycleHour4:
//            return @"H4";
//        case ChartCycleHour6:
//            return @"H6";
//        case ChartCycleHour8:
//            return @"H8";
//        default:
//            break;
//    }
    return @"";
}

+ (NSDate *)endDayOfDate {
    NSDate *date = [NSDate date];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [cal components:unitFlags fromDate:date];
    
    comps.day += 1;
    comps.hour = 0;
    comps.minute = 0;
    comps.second = 0;
    
    NSDate *resDate  = [cal dateFromComponents:comps];
    
    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSInteger interval1 = [zone secondsFromGMTForDate: resDate];//修改时区
    NSDate *localDate1 = [resDate  dateByAddingTimeInterval:interval1];
    
    return localDate1;
}

@end
