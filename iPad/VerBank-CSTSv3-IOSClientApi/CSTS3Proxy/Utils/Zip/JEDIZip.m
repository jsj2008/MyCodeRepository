//
//  ZipDataReadWrite.m
//  Objective-Zip
//
//  Created by felix on 7/14/13.
//
//

#import "JEDIZip.h"

#import <zlib.h>

#define BUFFER_SIZE_FOR_UNZIP 5120000 // 500 K

Byte gBufferForUnZip[BUFFER_SIZE_FOR_UNZIP];

@implementation JEDIZip

+ (NSData *) zipDataFromData:(NSData *) data
{
    if(data == nil) return nil;
    
    uLong destSize = compressBound([data length]);
    uLong destLength = destSize;
    
    Byte destBuff[destSize];
    memset(destBuff, 0, destSize);
    
    //
    //compress returns Z_OK if success, Z_MEM_ERROR if there was not enough memory, 
    //  Z_BUF_ERROR if there was not enough room in the output buffer.
    //
    int zipResult = compress(destBuff, &destLength, (const Bytef *)[data bytes], [data length]);

    if(zipResult != Z_OK){
        NSLog(@"ZipDataReadWrite.zipDataFromData, Error: %d", zipResult);
        return nil;
    }
    
    NSData *rltData = [NSData dataWithBytes:destBuff length:destLength];
    return rltData;
}


+ (NSData *) dataFromZipData:(NSData *) zipData
{
    if(zipData == nil) return nil;
//    NSLog(@"===================%lu", (unsigned long)[zipData length]);
    //
    //uncompress returns Z_OK if success, Z_MEM_ERROR if there was not
    //  enough memory, Z_BUF_ERROR if there was not enough room in the output
    //  buffer, or Z_DATA_ERROR if the input data was corrupted or incomplete.
    //
    uLong destLength = BUFFER_SIZE_FOR_UNZIP;
    int unzipResult = uncompress(gBufferForUnZip, &destLength, (const Bytef *)[zipData bytes], [zipData length]);
    
    if(unzipResult != Z_OK){
        NSLog(@"ZipDataReadWrite.dataFromZipData, Error: %d", unzipResult);
        return nil;
    }
    
    NSData *rltData = [NSData dataWithBytes:gBufferForUnZip length:destLength];
    return rltData;
}
                      
@end
