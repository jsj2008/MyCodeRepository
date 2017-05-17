//
//  JEDIDataOutput.m
//  IOSClientStation
//
//  Created by felix on 9/4/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "JEDIDataRW.h"
#import "JEDISystem.h"

BOOL gsIsLittleTested = NO;
BOOL gsIsLittleEndian = NO;

/*
 Big Endian (0xB4（10110100)
 msb                                                         lsb
 ---------------------------------------------->
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |   1  |   0  |   1  |   1  |   0  |   1  |   0  |   0  |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 
 Little Endian
 
 lsb                                                         msb
 ---------------------------------------------->
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 |   0  |   0  |   1  |   0  |   1  |   1  |   0  |   1  |
 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 */

@implementation JEDIDataRW

//
//---------------------------------------------------------------------------------
//
+(BOOL) isLittleEndian
{
    if(gsIsLittleTested){
        return gsIsLittleEndian;
    }
    
    unsigned short bigTest = 0x1133;
    //unsigned char  bigChar = *((unsigned char*)&bigTest);
    
    gsIsLittleEndian = (*((unsigned char*)&bigTest) == 0x33);
    gsIsLittleTested = YES;
    
    return gsIsLittleEndian;
}

//
//---------------------------------------------------------------------------------
//
+(void) writeInt:(int) value toData:(NSMutableData *) data
{
    if([JEDIDataRW isLittleEndian])
    {
        int size = sizeof(value);
        for(size -=1; size>=0; size--)
        {
            UInt8 * endPnt = (UInt8 *)((UInt8 *)(&value) + size);
            [data appendBytes:endPnt length:1];
        }
    }
    else
    {
        [data appendBytes:&value length:sizeof(value)];
    }
}

//---------------------------------------------------------------------------------
+(void) writeBool:(BOOL) value toData:(NSMutableData *) data
{
    UInt8 bByte = (value == YES) ? 1 : 0;
    [data appendBytes:&bByte length:sizeof(bByte)];
}

//---------------------------------------------------------------------------------
+(void) writeDouble:(double) value toData:(NSMutableData *) data
{
    if([JEDIDataRW isLittleEndian])
    {
        int size = sizeof(value);
        for(size -=1; size>=0; size--)
        {
            UInt8 * endPnt = (UInt8 *)((UInt8 *)(&value) + size);
            [data appendBytes:endPnt length:1];
        }
    }
    else
    {
        [data appendBytes:&value length:sizeof(value)];
    }
}

//---------------------------------------------------------------------------------
+(void) writeLongLong:(long long) value toData:(NSMutableData *) data
{
    if([JEDIDataRW isLittleEndian])
    {
        int size = sizeof(value);
        for(size -=1; size>=0; size--)
        {
            UInt8 * endPnt = (UInt8 *)((UInt8 *)(&value) + size);
            [data appendBytes:endPnt length:1];
        }
    }
    else
    {
        [data appendBytes:&value length:sizeof(value)];
    }
}

//---------------------------------------------------------------------------------
+(void) writeU8String:(NSString *) value toData:(NSMutableData *) data
{
    NSData * strData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [data appendData:strData];
}

//
//---------------------------------------------------------------------------------
//
+(int)          readIntFromData:(NSData *) data atIndex:(int) index;
{
    int rlt = 0;
    
    if([JEDIDataRW isLittleEndian])
    {
        int nSize = sizeof(rlt);
        UInt8 buff[nSize];
        
        int i=0;
        NSRange range = NSMakeRange(index, 1);
        
        for(nSize-=1; nSize>=0; nSize--, i++)
        {
            range.location = index + nSize;
            [data getBytes:(void *)(buff+i) range:range];
        }

        rlt = *(int *)buff;
    }
    else
    {
        [data getBytes:&rlt range:NSMakeRange(index, sizeof(rlt))];
    }
    
    return rlt;
}

//---------------------------------------------------------------------------------
+(BOOL)         readBoolFromData:(NSData *) data atIndex:(int) index;
{
    UInt8 buf = 0;
    [data getBytes:&buf range:NSMakeRange(index, sizeof(buf))];
    return (buf == 1) ? YES : NO;
}

//---------------------------------------------------------------------------------
+(double)       readDoubleFromData:(NSData *) data atIndex:(int) index;
{
    double rlt = 0;
    
    if([JEDIDataRW isLittleEndian])
    {
        int nSize = sizeof(rlt);
        UInt8 buff[nSize];
        
        int i=0;
        NSRange range = NSMakeRange(index, 1);
        
        for(nSize -=1; nSize>=0; nSize--, i++)
        {
            range.location = index + nSize;
            [data getBytes:(void *)(buff+i) range:range];
        }
        
        rlt = *(double *)buff;
    }
    else
    {
        [data getBytes:&rlt range:NSMakeRange(index, sizeof(rlt))];
    }
    
    return rlt;
}

//---------------------------------------------------------------------------------
+(long long)    readLongLongFromData:(NSData *) data atIndex:(int) index;
{
    long long rlt = 0;
    
    if([JEDIDataRW isLittleEndian])
    {
        int nSize = sizeof(rlt);
        UInt8 buff[nSize];
        
        int i=0;
        NSRange range = NSMakeRange(index, 1);
        
        for(nSize -=1; nSize>=0; nSize--, i++)
        {
            range.location = index + nSize;
            [data getBytes:(void *)(buff+i) range:range];
        }
        
        rlt = *(long long *)buff;
    }
    else
    {
        [data getBytes:&rlt range:NSMakeRange(index, sizeof(rlt))];
    }
    
    return rlt;
}

//---------------------------------------------------------------------------------
+(NSString *)   readStringFromData:(NSData *) data atIndex:(int) index bySize:(int) size
{
    UInt8 buff[size+1];
    memset(buff, 0, size+1);
    
    [data getBytes:buff range:NSMakeRange(index, size)];
    return [NSString stringWithUTF8String:(const char*)buff];
}

//
//---------------------------------------------------------------------------------
//
+(void) testReadWrite
{
    int         srcInt = 4568;
    double      srcDouble = 123.5678011;
    long long   srcLonglong = 0x099991111800;
    BOOL        srcBool = YES;
    
    NSMutableData * muData = [[NSMutableData alloc] init];
    
    [JEDIDataRW writeInt:srcInt toData:muData];
    [JEDIDataRW writeBool:srcBool toData:muData];
    [JEDIDataRW writeDouble:srcDouble toData:muData];
    [JEDIDataRW writeLongLong:srcLonglong toData:muData];
    
    [JEDISystem printHexData:muData];
    
    int         desInt = [JEDIDataRW readIntFromData:muData atIndex:0];
    BOOL        desBool = [JEDIDataRW readBoolFromData:muData atIndex:0 + 4];
    double      desDouble = [JEDIDataRW readDoubleFromData:muData atIndex:0 + 4 + 1];
    long long   desLonglong = [JEDIDataRW readLongLongFromData:muData atIndex:0 + 4 + 1 + 8];
    
    NSLog(@"%d, %f, %lld, %d", srcInt, srcDouble, srcLonglong, srcBool);
    NSLog(@"%d, %f, %lld, %d", desInt, desDouble, desLonglong, desBool);
}

@end
