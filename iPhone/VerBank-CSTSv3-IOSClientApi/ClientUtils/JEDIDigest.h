//
//  JEDIDigest.h
//  IOSClientStation
//
//  Created by felix on 8/1/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEDIDigest : NSObject

+ (NSData *)    digestDataFromData:(NSData *) data;
+ (NSData *)    digestDataFromString:(NSString *) string;
+ (NSData *)    digestDataFromBuffer:(const void*) buffer size:(int) size;

+ (NSString *)  digestStringFromData:(NSData *) data;
+ (NSString *)  digestStringFromString:(NSString *) string;

+ (NSString *)  digestStringFromData:(NSData *)data radix:(int) radix;
+ (NSString *)  digestStringFromString:(NSString *) string radix:(int) radix;

+ (NSString *)  digestStringFromDigestData:(NSData *) data radix:(int) radix;

@end
