//
//  QuoteUtils.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "KChartViewUtils.h"
#import "TradeApi.h"
#import "HistoricData.h"

@implementation KChartViewUtils

+ (NSString *)queryHistoricData:(NSString *)insrtument cycle:(int)cycle {
    if (cycle == 0) {
        return @"[]";
    }
    if (insrtument == nil && [insrtument isEqualToString:@""]) {
        return @"[]";
    }
    NSArray *array = [[TradeApi getInstance] queryHisData:insrtument cycle:cycle];
    if (array == nil) {
        return @"[]";
    }
    
    NSLog(@"this array count is %lu", (unsigned long)[array count]);
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    [mutableString appendString:@"["];
    for (HistoricData *data in array) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data.getEntryDictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (mutableString.length == 1) {
            [mutableString appendString:[NSString stringWithFormat:@"%@", jsonString]];
        } else {
            [mutableString appendString:[NSString stringWithFormat:@",%@", jsonString]];
        }
    }
    [mutableString appendString:@"]"];
    return mutableString;
}

+ (NSString *)getKChartCycleInputValue:(ChartCycleType)cycle {
    switch (cycle) {
        case ChartCycleMin1:
            return @"M1";
        case ChartCycleMin5:
            return @"M5";
        case ChartCycleMin10:
            return @"M10";
        case ChartCycleMin15:
            return @"M15";
        case ChartCycleMin30:
            return @"M30";
        case ChartCycleMin60:
            return @"H1";
        case ChartCycleMin90:
            return @"M90";
        case ChartCycleMin180:
            return @"H3";
        case ChartCycleDay:
            return @"Daily";
        case ChartCycleWeek:
            return @"Weekly";
        case ChartCycleMonth:
            return @"Monthly";
        case ChartCycleYear:
            return @"Year";
        case ChartCycleHour2:
            return @"H2";
        case ChartCycleHour4:
            return @"H4";
        case ChartCycleHour6:
            return @"H6";
        case ChartCycleHour8:
            return @"H8";
        default:
            break;
    }
    return @"";
}

+ (int)getCycleValueByType:(ChartCycleType)typeDefine {
    switch (typeDefine) {
        case ChartCycleMin1:
            return 1;
        case ChartCycleMin5:
            return 5;
        case ChartCycleMin10:
            return 10;
        case ChartCycleMin15:
            return 15;
        case ChartCycleMin30:
            return 30;
        case ChartCycleMin60:
            return 60;
        case ChartCycleMin90:
            return 90;
        case ChartCycleMin180:
            return 180;
        case ChartCycleDay:
            return 24 * 60;
        case ChartCycleWeek:
            return 24 * 60 * 7;
        case ChartCycleMonth:
            // 基本不会用到 年和月， 就暂时这么表示
            return 24 * 60 * 30;
        case ChartCycleYear:
            return 24 * 60 * 365;
        case ChartCycleHour2:
            return 60 * 2;
        case ChartCycleHour4:
            return 60 * 4;
        case ChartCycleHour6:
            return 60 * 6;
        case ChartCycleHour8:
            return 60 * 8;
        default:
            break;
    }
    return 1;
}

#pragma 解析
+ (NSDictionary *)parseParam:(NSString *)argumentConfig {
    NSArray *array = [self split:@";" byString:argumentConfig];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *param in array) {
        NSArray *params = [self split:@":" byString:param];
        [dic setObject:params[1] forKey:params[0]];
    }
    
    for (NSString *key in [dic allKeys]) {
        NSDictionary *subDic = [self parseSubParam:[dic objectForKey:key]];
        [dic setObject:subDic forKey:key];
    }
    return dic;
}

+ (NSDictionary *)parseSubParam:(NSString *)subParams {
    NSArray *array = [self split:@"+" byString:subParams];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *temp in array) {
        NSArray *tempArray = [self split:@"|" byString:temp];
        id result = [[[NSNumberFormatter alloc] init] numberFromString:tempArray[1]];
        if (result) {
            [dic setObject:[NSNumber numberWithInt:[result intValue]] forKey:tempArray[0]];
        } else {
            [dic setObject:tempArray[1] forKey:tempArray[0]];
        }
    }
    return dic;
}

+ (NSArray *)split:(NSString *)split byString:(NSString *)oriString{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[oriString componentsSeparatedByString:split]];
    if ([array containsObject:@""]) {
        [array removeObject:@""];
    }
    return array;
}


@end
