//
//  TranslateUtil.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/13.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranslateUtil : NSObject

+ (NSString *)translateCloseType:(int)type reason:(int)closeReason;
+ (NSString *)translateAccStreamType:(int)accStreamType adjustType:(int)adjustType;
+ (NSString *)translateCA:(int)caState;
+ (NSString *)translatePickDate:(int)type;

@end
