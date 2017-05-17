//
//  NSArraySortUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/10.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArraySortUtil : NSObject

+ (void)sortASCStringArray:(NSMutableArray *)array sortSelector:(NSString *)selectName;
+ (void)sortASCNumberArray:(NSMutableArray *)array sortSelector:(NSString *)selectName;

+ (void)sortDESCStringArray:(NSMutableArray *)array sortSelector:(NSString *)selectName;
+ (void)sortDESCNumberArray:(NSMutableArray *)array sortSelector:(NSString *)selectName;

@end
