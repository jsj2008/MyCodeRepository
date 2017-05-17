//
//  JEDISystem.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/15/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JEDISystem.h"
#import <sys/sysctl.h>
#import <mach/mach.h>


@implementation JEDISystem


#pragma mark Memory
//--------------------------------------------------------------------
+ (double)  memoryAvailable
{
    vm_statistics_data_t vmStats;//memory
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;//int
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

//--------------------------------------------------------------------
+ (double)  memoryAlreadyUsed
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}


#pragma mark Printer
//--------------------------------------------------------------------
+ (void)    printHexData:(NSData *) nsData
{
    if(nsData == nil) return;
    
    [JEDISystem printHexBytes:[nsData bytes] onSize:[nsData length]];
}


//--------------------------------------------------------------------
+ (void)    printHexBytes:(const void *) bytes onSize:(NSInteger) size
{
    if(bytes == NULL) return;
    
    NSString *nsStr = @"";
    const unsigned char* tbytes = (const unsigned char*)bytes;
    
    for (int i=0; i<size; i++) {
        nsStr = [NSString stringWithFormat:@"%@%x,", nsStr, tbytes[i]];
    }
    
    NSLog(@"Size: %d \r\n%@", (int)size, nsStr);
}


//--------------------------------------------------------------------
+ (void)    printData:(NSData *) nsData
{
    if(nsData == nil) return;
    
    [JEDISystem printBytes:[nsData bytes] onSize:[nsData length]];
}


//--------------------------------------------------------------------
+ (void)    printBytes:(const void *) bytes onSize:(NSInteger) size
{
    if(bytes == NULL) return;
    
    NSString *nsStr = @"";
    const SignedByte* tbytes = (const SignedByte*)bytes;
    
    for (int i=0; i<size; i++) {
        nsStr = [NSString stringWithFormat:@"%@%d,", nsStr, tbytes[i]];
    }
    
    NSLog(@"Size: %d \r\n%@", (int)size, nsStr);
}


#pragma mark Data Translate
//--------------------------------------------------------------------
+ (NSData *)   dataFromUTF8String:(NSString *) strData
{
    return [strData dataUsingEncoding:NSUTF8StringEncoding];
}

//--------------------------------------------------------------------
+ (NSString *) utf8StringFromData:(NSData *) nsData
{
    return [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
}

//--------------------------------------------------------------------
+ (NSData *)   dataFromObject:(NSObject *) objData
{
    if(![NSJSONSerialization isValidJSONObject:objData]){
        NSLog(@"JEDINetwork.packageObjectData, isn't valid JSONObject.");
        return nil;
    }
    
    NSError *error = nil;
    NSData *nsData = [NSJSONSerialization dataWithJSONObject:objData options:NSJSONWritingPrettyPrinted error:&error];
    return nsData;
}

//--------------------------------------------------------------------
+ (NSObject *) objectFromData:(NSData *) nsData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:nsData options:NSJSONReadingAllowFragments error:&error];
    return jsonObject;
}

//--------------------------------------------------------------------
+ (NSData *)    dataFromInt:(int) num withLength:(int) length
{
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterNoStyle];
    [numFormat setMaximumIntegerDigits:length];
    [numFormat setMinimumIntegerDigits:length];
    
    NSString * nsString = [numFormat stringFromNumber:[NSNumber numberWithInt:num]];
    return [nsString dataUsingEncoding:NSUTF8StringEncoding];
}

//--------------------------------------------------------------------
+ (int)         intFromBuffer:(const Byte *) buf withLength:(int) length
{
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterNoStyle];
    
    NSString * nsString = [[NSString alloc] initWithBytes:buf length:length encoding:NSUTF8StringEncoding];
    return [[numFormat numberFromString:nsString] intValue];
}

//--------------------------------------------------------------------
+ (NSString *)  stringFromInt:(int) num withLength:(int) length
{
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterNoStyle];
    [numFormat setMaximumIntegerDigits:length];
    [numFormat setMinimumIntegerDigits:length];
    
    NSString * nsString = [numFormat stringFromNumber:[NSNumber numberWithInt:num]];
    return nsString;
}

//--------------------------------------------------------------------
+ (NSString *)  stringFromDouble:(double)num
{
    return [JEDISystem stringFromDouble:num maxFraction:2 minFraction:2];
}

//--------------------------------------------------------------------
+ (NSString *)  stringFromDouble:(double) num maxFraction:(int) max minFraction:(int) min
{
    NSNumberFormatter * numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterNoStyle];
    [numFormat setMaximumFractionDigits:max];
    [numFormat setMinimumFractionDigits:min];
    [numFormat setMinimumIntegerDigits:1];
    
    NSString * nsString = [numFormat stringFromNumber:[NSNumber numberWithDouble:num]];
    return nsString;
}

#pragma mark UUID

+ (NSString *) getUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    // Get the string representation of CFUUID object.
    return (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
}


#pragma mark Log
//--------------------------------------------------------------------
+ (void) log:(NSString *) string
{
    NSLog(@"%@", string);
}

//--------------------------------------------------------------------
+ (void) log:(NSString *) string withObject:(NSObject *) object
{
    if(object == nil){
        return;
    }
    
    NSLog(@"%@ %@", string, [object description]);
}

@end







