//
//  StringUtils.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSString *)convertHiddenCode:(NSString *)text {
    if (text == nil || [text length] == 0) {
        return @"";
    }
    
    int length = (int)[text length];
    
    if (length <= 5) {
        return text;
    }
    
    int sublength = length - 4;
    
    int beginLength = round(sublength / 2);
    int endLength = sublength - beginLength;
    NSString *beginText = [text substringWithRange:NSMakeRange(0, beginLength)];
    NSString *endText = [text substringWithRange:NSMakeRange(beginLength + 4, endLength)];
    
    NSString *returnString = [beginText stringByAppendingString:@"****"];
    returnString = [returnString stringByAppendingString:endText];
    return returnString;
}

+ (NSString *)getHiddenString:(NSString *)text {
    if (text == nil || [text length] == 0) {
        return @"";
    }
    
    int length = (int)[text length];
    
    if (length <= 5) {
        return text;
    }
    
    int sublength = length - 4;
    int beginLength = round(sublength / 2);
    
    return [text substringWithRange:NSMakeRange(beginLength, 4)];
}

+ (double)  numberFromString:(NSString *) str
{
    if(str == nil || str.length == 0){
        return 0.0;
    }
    
    NSMutableString * strMutable = [NSMutableString stringWithString:str];
    
    NSRange range = NSMakeRange(0, strMutable.length);
    [strMutable replaceOccurrencesOfString:@"," withString:@"" options:NSLiteralSearch range:range];
    
    return [strMutable doubleValue];
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end
