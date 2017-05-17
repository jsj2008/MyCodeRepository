//
//  TranslateUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranslateUtil : NSObject

+ (NSString *)translateCloseType:(int)type reason:(int)closeReason;
+ (NSString *)translateAccStreamType:(int)accStreamType adjustType:(int)adjustType;
+ (NSString *)translateCA:(int)caState;
+ (NSString *)translatePickDate:(int)type;

@end
