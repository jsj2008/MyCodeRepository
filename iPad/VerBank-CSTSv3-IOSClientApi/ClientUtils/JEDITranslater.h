//
//  JEDITranslater.h
//  IOSClientStation
//
//  Created by felix on 8/1/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEDITranslater : NSObject

//
// NOTE: unsign = false 的情况下，其处理结果不同与 Java 中的处理结果，请谨慎使用！
//

+ (NSString *)  stringFromData:(NSData *) data radix:(int) radix unsign:(Boolean) unsign;

+ (NSString *)  stringFromBuffer:(const void*) buffer size:(int) size radix:(int) radix unsign:(Boolean) unsign;

+ (NSString *)  stringFromInt:(int) value radix:(int) radix;

@end
