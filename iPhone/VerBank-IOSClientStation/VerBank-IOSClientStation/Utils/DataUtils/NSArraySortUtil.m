//
//  NSArraySortUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "NSArraySortUtil.h"
#import "TTrade.h"

@implementation NSArraySortUtil

+ (void)sortASCStringArray:(NSMutableArray *)array sortSelector:(NSString *)selectName {
    
    if (array == nil || [array count] == 0) {
        return;
    }
    
    if (![[array objectAtIndex:0] respondsToSelector:NSSelectorFromString(selectName)]) {
        NSLog(@"selector invalied.");
        return;
    }
    
    SEL func = NSSelectorFromString(selectName);
    
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        NSString *str1 = [obj1 performSelector:func];
        NSString *str2 = [obj2 performSelector:func];
        return [str1 compare:str2];
    }];
}

+ (void)sortASCNumberArray:(NSMutableArray *)array sortSelector:(NSString *)selectName {
    if (array == nil || [array count] == 0) {
        return;
    }
    
    if (![[array objectAtIndex:0] respondsToSelector:NSSelectorFromString(selectName)]) {
        NSLog(@"selector invalied.");
        return;
    }
    
    SEL func = NSSelectorFromString(selectName);
    
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        double double1 = [[obj1 performSelector:func] doubleValue];
        double double2 = [[obj2 performSelector:func] doubleValue];
        return (double1 - double2) >= 0.00001;
    }];
}

+ (void)sortDESCStringArray:(NSMutableArray *)array sortSelector:(NSString *)selectName {
    if (array == nil || [array count] == 0) {
        return;
    }
    
    if (![[array objectAtIndex:0] respondsToSelector:NSSelectorFromString(selectName)]) {
        NSLog(@"selector invalied.");
        return;
    }
    
    SEL func = NSSelectorFromString(selectName);
    
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        NSString *str1 = [obj1 performSelector:func];
        NSString *str2 = [obj2 performSelector:func];
        return [str2 compare:str1];
    }];
}

+ (void)sortDESCNumberArray:(NSMutableArray *)array sortSelector:(NSString *)selectName {
    if (array == nil || [array count] == 0) {
        return;
    }
    
    if (![[array objectAtIndex:0] respondsToSelector:NSSelectorFromString(selectName)]) {
        NSLog(@"selector invalied.");
        return;
    }
    
    SEL func = NSSelectorFromString(selectName);
    
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        double double1 = [[obj1 performSelector:func] doubleValue];
        double double2 = [[obj2 performSelector:func] doubleValue];
        return (double2 - double1) >= 0.00001;
    }];
}


@end
