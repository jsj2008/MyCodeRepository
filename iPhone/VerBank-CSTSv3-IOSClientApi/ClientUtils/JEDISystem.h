//
//  JEDISystem.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/15/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifndef JEDI_SYS_DEBUGGING
#define JEDI_SYS_DEBUGGING
//#define JEDI_DIGEST_DEBUGGING
//#define JEDI_LOGIN_DEBUGGING
#endif

#ifndef JEDI_SYS_Try

#define JEDI_SYS_Try             @try{
#define JEDI_SYS_EndTry              }   \
    @catch (NSException *exception) {    \
        NSString * nsStr = [NSString stringWithFormat:@" --> Error: %s, %d", __FILE__, __LINE__];       \
        [JEDISystem log:nsStr withObject:exception];                                                    \
    }                                                                                                   \
    @catch (...){                                                                                       \
        NSString * lsStr = [NSString stringWithFormat:@" --> Error: %s, %d", __FILE__, __LINE__];       \
        [JEDISystem log:lsStr];                                                                         \
    }                                                                                                   \

#endif



//---------------------------------------------------------------------------------------
//
//---------------------------------------------------------------------------------------
@interface JEDISystem : NSObject

#pragma mark Memory
//
// 获取当前设备可用的内存, 单位:M
//
+ (double)      memoryAvailable;
//
// 获取当前程序使用掉的内存, 单位:M
//
+ (double)      memoryAlreadyUsed;

#pragma mark Printer
//
// 输出十六进制数据
//
+ (void)        printHexData:(NSData *) nsData;
+ (void)        printHexBytes:(const void *) bytes onSize:(NSInteger) size;

//
// 输出有符号的十进制数据
//
+ (void)        printData:(NSData *) nsData;
+ (void)        printBytes:(const void *) bytes onSize:(NSInteger) size;


#pragma mark Data Translate
//
// UTF8String <--> Data
//
+ (NSData *)    dataFromUTF8String:(NSString *) strData;
+ (NSString *)  utf8StringFromData:(NSData *) nsData;

//
// Object     <--> Data
//
+ (NSData *)    dataFromObject:(NSObject *) objData;
+ (NSObject *)  objectFromData:(NSData *) nsData;

//
// int        <--> Data
//
+ (NSData *)    dataFromInt:(int) num withLength:(int) length;
+ (int)         intFromBuffer:(const Byte *) buf withLength:(int) length;

+ (NSString *)  stringFromInt:(int) num withLength:(int) length;

+ (NSString *)  stringFromDouble:(double) num;
+ (NSString *)  stringFromDouble:(double) num maxFraction:(int) max minFraction:(int) min;


#pragma mark UUID

+ (NSString *)  getUUID;


#pragma mark Log
//
// Using the same function to log message for debugging.
//
+ (void)        log:(NSString *) string;
+ (void)        log:(NSString *) string withObject:(NSObject *) object;

@end
