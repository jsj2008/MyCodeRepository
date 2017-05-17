//
//  JEDIDateTime.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JEDIDateTime.h"
#import "JEDISystem.h"

@implementation JEDIDateTime

//------------------------------------------------------------------------------
+ (long long)       currentMillis
{
    NSTimeInterval nsTime = [[NSDate date] timeIntervalSince1970];
    return (long long)(nsTime * 1000.0);
}

//------------------------------------------------------------------------------
+ (NSNumber *)      currentTimeMillis
{
    return [NSNumber numberWithLongLong:[JEDIDateTime currentMillis]];
}

//------------------------------------------------------------------------------
+ (NSTimeInterval)  currentTimeIntervalSince1970
{
    return [[NSDate date] timeIntervalSince1970];
}

//------------------------------------------------------------------------------
+ (long long)       getTimeMillisForDate:(NSDate *) date
{
    NSTimeInterval nsTime = [date timeIntervalSince1970];
    return (long long)(nsTime * 1000.0);
}

//------------------------------------------------------------------------------
+ (NSNumber *)      getTimeMillisNumberForDate:(NSDate *) date
{
    return [NSNumber numberWithLongLong:[JEDIDateTime getTimeMillisForDate:date]];
}

//------------------------------------------------------------------------------
+ (NSString *) stringFromDate:(NSDate *) date
{
    return [JEDIDateTime stringFromDate:date withFormat:@"yyyyMMddHHmmssSSS"];
}

+ (NSString *)stringUIFromDate:(NSDate *)date{
    return [JEDIDateTime stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)stringOrderHisFromDate:(NSDate *)date{
    return [JEDIDateTime stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)stringUIFromTime:(NSDate *)date{
    return [JEDIDateTime stringFromDate:date withFormat:@"HH:mm:ss"];
}

+ (NSString *)stringUIFromyMd:(NSDate *)date{
    return [JEDIDateTime stringFromDate:date withFormat:@"yyyy-MM-dd"];
}

//------------------------------------------------------------------------------
+ (NSString *) stringFromDate:(NSDate *) date withFormat:(NSString *) format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}

//------------------------------------------------------------------------------
+ (NSString *) timeStringFromDate:(NSDate *) date
{
    return [JEDIDateTime stringFromDate:date withFormat:@"HH:mm:ss"];
}


//------------------------------------------------------------------------------
+ (NSDate *)   dateFromMillis:(long long) ms
{
    NSTimeInterval interval = (double)ms / 1000.0;
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

//------------------------------------------------------------------------------
+ (NSDate *)   dateFromString:(NSString *) str
{
    return [JEDIDateTime dateFromString:str withFormat:@"yyyyMMddHHmmssSSS"];
}

//------------------------------------------------------------------------------
+ (NSDate *)   dateFromString:(NSString *) str withFormat:(NSString *) format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter dateFromString:str];
}

+ (NSDate *)dateFromQuoteDay:(NSString *)quoteDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [dateFormatter dateFromString:quoteDay];
}

//------------------------------------------------------------------------------
+ (NSDate *)        firstDayOfMonthForDate:(NSDate *) date
{
    NSDateComponents * comps = nil;
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    
    [comps setDay:1];
    return [gregorian dateFromComponents:comps];
}

//------------------------------------------------------------------------------
+ (NSDate *)        lastDayOfMonthForDate:(NSDate *) date
{
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    NSDateComponents * comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:range.length];
    
    return [gregorian dateFromComponents:comps];
}

//------------------------------------------------------------------------------
+ (NSDate *)        dayOfWeek:(JEDIWeekDays) weekDay forDate:(NSDate *) date
{
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:1]; // 1, 周日为第一天； 2, 周一为第一天；
    
    NSDate * weekDate = nil;
    NSTimeInterval timeRange = 0.0;
    
    BOOL bResult = [gregorian rangeOfUnit:NSWeekCalendarUnit startDate:&weekDate interval:&timeRange forDate:date];
    if(bResult == NO){
        [JEDISystem log:@"JEDIDateTime.dayOfWeek, Error -> rangeOfUnit:NSWeekCalendarUnit false!"];
        return date;
    }
    
    NSDateComponents * weekComp = [[NSDateComponents alloc] init];
    [weekComp setDay:weekDay];
    
    return [gregorian dateByAddingComponents:weekComp toDate:weekDate options:0];
}

//-----
+ (NSString *)getCertificateTimeString:(long long)time {
    NSNumber *longlongTime = [NSNumber numberWithLongLong:time];
    NSString *timeString = [longlongTime stringValue];
    NSString *yyyyString = [timeString substringWithRange:NSMakeRange(0, 4)];
    NSString *MMString = [timeString substringWithRange:NSMakeRange(4, 2)];
    NSString *ddString = [timeString substringWithRange:NSMakeRange(6, 2)];
    NSString *HHString = [timeString substringWithRange:NSMakeRange(8, 2)];
    NSString *mmString = [timeString substringWithRange:NSMakeRange(10, 2)];
    NSString *ssString = [timeString substringWithRange:NSMakeRange(12, 2)];
    //    yyy-MM-dd HH:mm:ss
    NSString *formatString = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@", yyyyString, MMString, ddString, HHString, mmString, ssString];
    return formatString;
}

//------------------------------------------------------------------------------
+ (void) testAboutDayGetting
{
    //NSDate * curreDate = [NSDate date];
    NSDate * curreDate = [JEDIDateTime dateFromString:@"2014-01-01 00:00" withFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate * firstOfMonth = [JEDIDateTime firstDayOfMonthForDate:curreDate];
    NSDate * lastOfMonth  = [JEDIDateTime lastDayOfMonthForDate:curreDate];
    
    NSDate * monday  = [JEDIDateTime dayOfWeek:JEDIWeekMonday forDate:curreDate];
    NSDate * friday  = [JEDIDateTime dayOfWeek:JEDIWeekFriday forDate:curreDate];
    
    NSLog(@" 0, %@", [JEDIDateTime stringFromDate:curreDate withFormat:@"yyyy-MM-dd HH:mm:ss"]);
    
    NSLog(@" 1, %@", [JEDIDateTime stringFromDate:firstOfMonth withFormat:@"yyyy-MM-dd HH:mm:ss"]);
    NSLog(@" 2, %@", [JEDIDateTime stringFromDate:lastOfMonth withFormat:@"yyyy-MM-dd HH:mm:ss"]);
    
    NSLog(@" 3, %@", [JEDIDateTime stringFromDate:monday withFormat:@"yyyy-MM-dd HH:mm:ss"]);
    NSLog(@" 4, %@", [JEDIDateTime stringFromDate:friday withFormat:@"yyyy-MM-dd HH:mm:ss"]);
}

@end
