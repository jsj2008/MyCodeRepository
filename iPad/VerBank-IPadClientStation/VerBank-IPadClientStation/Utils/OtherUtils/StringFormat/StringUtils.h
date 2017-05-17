//
//  StringUtils.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSString *)convertHiddenCode:(NSString *)text;
+ (NSString *)getHiddenString:(NSString *)text;
+ (double)  numberFromString:(NSString *) str;

+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isPureFloat:(NSString*)string;
@end
