//
//  JEDIDataOutput.h
//  IOSClientStation
//
//  Created by felix on 9/4/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// using Big Endian write for Java
//
@interface JEDIDataRW : NSObject

+(BOOL) isLittleEndian;

//
//
//
+(void) writeInt:(int) value toData:(NSMutableData *) data;
+(void) writeBool:(BOOL) value toData:(NSMutableData *) data;
+(void) writeDouble:(double) value toData:(NSMutableData *) data;
+(void) writeLongLong:(long long) value toData:(NSMutableData *) data;
+(void) writeU8String:(NSString *) value toData:(NSMutableData *) data;

//
//
//
+(int)          readIntFromData:(NSData *) data atIndex:(int) index;
+(BOOL)         readBoolFromData:(NSData *) data atIndex:(int) index;
+(double)       readDoubleFromData:(NSData *) data atIndex:(int) index;
+(long long)    readLongLongFromData:(NSData *) data atIndex:(int) index;
+(NSString *)   readStringFromData:(NSData *) data atIndex:(int) index bySize:(int) size;

//
//
//
+(void) testReadWrite;
@end
