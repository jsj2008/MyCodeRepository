//
//  DecimalUtil.m
//  IOSClientStation
//
//  Created by felix on 7/31/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "DecimalUtil.h"
#import "BasicCurrency.h"
#import "InstrumentUtil.h"
#import "APIDoc.h"

@implementation DecimalUtil

//---------------------------------------------------------------------------------------
+ (NSString *)  formatDoubleParam:(double) value digit:(int) digit
{
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    [numFormat setMaximumFractionDigits:digit];
    [numFormat setMinimumFractionDigits:digit];
    [numFormat setMinimumIntegerDigits:1];
    
    return [numFormat stringFromNumber:[NSNumber numberWithDouble:value]];
}

//---------------------------------------------------------------------------------------
+ (NSString *)  formatDoubleByNoStyle:(double) value digit:(int) digit
{
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterNoStyle];
    [numFormat setMaximumFractionDigits:digit];
    [numFormat setMinimumFractionDigits:digit];
    [numFormat setMinimumIntegerDigits:1];
    
    return [numFormat stringFromNumber:[NSNumber numberWithDouble:value]];
}

+ (NSString *)formatTimeParam:(long long)time{
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSinceNow:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    return dateString;
}

//---------------------------------------------------------------------------------------
+ (NSString *)  formatMoney:(double) money currency:(NSString *) currency
{
//    BasicCurrency * basicCurrency = [[DataDoc getInstance] getBasicCurrency:currency];
//    if(basicCurrency == nil){
//        return @"Err";
//    }
    
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
//    [numFormat setMaximumFractionDigits:[basicCurrency getDigit]];
//    [numFormat setMinimumFractionDigits:[basicCurrency getDigit]];
    
    [numFormat setMaximumFractionDigits:2];
    [numFormat setMinimumFractionDigits:2];
    
    NSString * str = [numFormat stringFromNumber:[NSNumber numberWithDouble:money]];
    return [NSString stringWithFormat:@"%@ %@", str, currency];
}

+ (NSString *)  formatMoney:(double)money digist:(int)digist{
    return [DecimalUtil formatNumber:money withDigist:digist];
}


+ (NSString *)formatZeroMoney:(double)money digist:(int)digist{
    if (money > -0.000001 && money < 0.000001) {
        return @"";
    } else {
        return [DecimalUtil formatNumber:money withDigist:digist];
    }
}

+ (NSString *)  formatNumber:(double)price {
    return [DecimalUtil formatNumber:price withDigist:0];
}

+ (NSString *)  formatNumber:(double) price withDigist:(int) digist{
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    [numFormat setMaximumFractionDigits:digist];
    [numFormat setMinimumFractionDigits:digist];
    NSString * str = [numFormat stringFromNumber:[NSNumber numberWithDouble:price]];
    return str;
}

+ (NSString *) formatPercent:(double)percent withDigist:(int)digist {
    NSNumberFormatter *percentFormat = [[NSNumberFormatter alloc] init];
    [percentFormat setNumberStyle:NSNumberFormatterPercentStyle];
    [percentFormat setMaximumFractionDigits:digist];
    [percentFormat setMinimumFractionDigits:digist];
    NSString *str = [percentFormat stringFromNumber:[NSNumber numberWithDouble:percent]];
    return str;
}

+ (NSString *)formatPrice:(double)price instrument:(NSString *)instrument {
    InstrumentUtil *util = nil;
    JEDI_SYS_Try {
        util = [APIDoc getInstrumentUtil:instrument];
    } JEDI_SYS_EndTry
    
    if (util != nil) {
        return [util formatClientPrice:price isFloor:true];
    } else {
        return [self formatClientPrice:price digist:4];
    }
}

+ (NSString *)formatClientPrice:(double)price digist:(int)digist {
    if (digist > 0) {
        digist ++;
    }
    
    NSString *priceStr = [self formatDoubleParam:price digit:digist];
    if (digist > 0) {
        priceStr = [priceStr substringWithRange:NSMakeRange(0, [priceStr length] - 1)];
    }
    return priceStr;
}

@end
