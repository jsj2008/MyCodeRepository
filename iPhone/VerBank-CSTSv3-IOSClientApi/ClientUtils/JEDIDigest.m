//
//  JEDIDigest.m
//  IOSClientStation
//
//  Created by felix on 8/1/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "JEDIDigest.h"
#import "JEDITranslater.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JEDIDigest


//----------------------------------------------------------------------------------
+ (NSData *)    digestDataFromData:(NSData *) data
{
    if(data == nil) return nil;
    
    return [JEDIDigest digestDataFromBuffer:[data bytes] size:[data length]];
}

//----------------------------------------------------------------------------------
+ (NSData *)    digestDataFromString:(NSString *) string
{
    if(string == nil) return nil;
    
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [JEDIDigest digestDataFromData:data];
}

//----------------------------------------------------------------------------------
+ (NSData *)    digestDataFromBuffer:(const void*) buffer size:(int) size
{
    if(buffer == nil || size <= 0) return nil;
    
    unsigned char md_result[16];
    CC_MD5(buffer, size, md_result);

    return [NSData dataWithBytes:md_result length:16];
}


//----------------------------------------------------------------------------------
+ (NSString *)  digestStringFromData:(NSData *) data
{
    return [JEDIDigest digestStringFromData:data radix:16];
}

//----------------------------------------------------------------------------------
+ (NSString *)  digestStringFromString:(NSString *) string
{
    return [JEDIDigest digestStringFromString:string radix:16];
}


//----------------------------------------------------------------------------------
+ (NSString *)  digestStringFromData:(NSData *)data radix:(int) radix
{
    if(data == nil) return nil;
    
    NSData * digestData = [JEDIDigest digestDataFromData:data];
    return [JEDITranslater stringFromData:digestData radix:radix unsign:true];
}

//----------------------------------------------------------------------------------
+ (NSString *)  digestStringFromString:(NSString *) string radix:(int) radix
{
    if(string == nil) return nil;
    
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [JEDIDigest digestStringFromData:data radix:radix];
}

//----------------------------------------------------------------------------------
+ (NSString *)  digestStringFromDigestData:(NSData *) data radix:(int) radix
{
    if(data == nil) return nil;
    
    return [JEDITranslater stringFromData:data radix:radix unsign:true];
}


@end
