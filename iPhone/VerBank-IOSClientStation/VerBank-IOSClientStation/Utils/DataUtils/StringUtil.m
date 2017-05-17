//
//  StringUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/14.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

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
