//
//  JEDITranslater.m
//  IOSClientStation
//
//  Created by felix on 8/1/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "JEDITranslater.h"

#define JEDI_MIN_RADIX 2
#define JEDI_MAX_RADIX 36

static const char JediDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                                  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                                  'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                                  'u', 'v', 'w', 'x', 'y', 'z'};

@implementation JEDITranslater

//----------------------------------------------------------------------------------------------------------
+ (NSString *)  stringFromData:(NSData *) data radix:(int) radix unsign:(Boolean) unsign
{
    if(data == nil) return nil;
    return [JEDITranslater stringFromBuffer:[data bytes] size:(int)[data length] radix:radix unsign:unsign];
}

//----------------------------------------------------------------------------------------------------------
+ (NSString *)  stringFromBuffer:(const void*) buffer size:(int) size radix:(int) radix unsign:(Boolean) unsign
{
    if(buffer == nil) return nil;
    
    NSMutableString * strResult = [[NSMutableString alloc] init];
    
    for(int i=0; i<size; i++)
    {
        int value = (unsign) ? (*(unsigned char*)(buffer+i)) : (*(char *)(buffer+i));
        [strResult appendString:[JEDITranslater stringFromInt:value radix:radix]];
    }
    
    return strResult;
}

//----------------------------------------------------------------------------------------------------------
+ (NSString *)  stringFromInt:(int) value radix:(int) radix
{
    if(radix < JEDI_MIN_RADIX || radix > JEDI_MAX_RADIX){
        radix = 10;
    }
    
    NSString * strResult = nil;
    
    if(radix == 10){
        strResult = [NSMutableString stringWithFormat:@"%d", value];
    }else{
        char buffer[33];
        Boolean negative = (value < 0);
        int charPos = 32;
        
        if(!negative){
            value = -value;
        }
        
        while(value <= -radix){
            buffer[charPos --] = JediDigits[-(value % radix)];
            value = value / radix;
        }
        
        buffer[charPos] = JediDigits[-value];
        if(negative){
            buffer[--charPos] = '-';
        }

        strResult = [[NSString alloc] initWithBytes:(buffer + charPos) length:(33-charPos) encoding:NSUTF8StringEncoding];
    }
    
    strResult = [strResult uppercaseString];
    return strResult;
}

@end
