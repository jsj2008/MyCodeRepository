//
//  DecimalUtil.h
//  IOSClientStation
//
//  Created by felix on 7/31/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecimalUtil : NSObject

//
// format with kCFNumberFormatterDecimalStyle
//
+ (NSString *)  formatDoubleParam:(double) value digit:(NSUInteger) digit;

+ (NSString *)  formatTimeParam:(long long)time;

//
// format with kCFNumberFormatterNoStyle
//
+ (NSString *)  formatDoubleByNoStyle:(double) value digit:(NSUInteger) digit;

//+ (NSString *)  formatMoney:(double) money currency:(NSString *) currency;

//+ (NSString *)  formatNumber:(double) price withDigist:(int) digist;
+ (NSString *)  formatMoney:(double)money digist:(NSUInteger)digist;
+ (NSString *)  formatNumber:(double)price;

+ (NSString *)formatZeroMoney:(double)money digist:(NSUInteger)digist;

+ (NSString *) formatPercent:(double)percent withDigist:(NSUInteger)digist;

+ (NSString *)formatPrice:(double)price instrument:(NSString *)instrument;

@end
