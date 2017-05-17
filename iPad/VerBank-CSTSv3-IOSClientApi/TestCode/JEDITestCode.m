//
//  JEDITestCode.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/15/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JEDITestCode.h"

#import <CommonCrypto/CommonDigest.h>

#import <openssl/rsa.h>
#import <openssl/md5.h>
#import "JEDISecret.h"
#import "JEDITranslater.h"
#import "JEDIZip.h"

#import "JEDISystem.h"
#import "CSTSProxyTest.h"
#import "CSTSLoginTest.h"

#import "JEDIDateTime.h"

@implementation JEDITestCode

//-----------------------------------------------------------------------------------
#pragma mark Secret Test Code

+ (void) RSATestCode
{
    NSString *test = @"This is test for Felix.";
    
    NSData *nsData = [[JEDISecret defaultSecret] encryptDataWithRSA:test];
    NSData *rlData = [[JEDISecret defaultSecret] decryptDataWithRSA:nsData];
    
    NSLog(@"\r\n%@ \r\n%@", test, [[NSString alloc] initWithData:rlData encoding:NSUTF8StringEncoding]);
    
    NSInteger esNum = [nsData length];
    NSString *esStr = @"";
    const unsigned char* bytes = (const unsigned char*)[nsData bytes];
    for (int i=0; i<esNum; i++) {
        esStr = [NSString stringWithFormat:@"%@%02x", esStr, bytes[i]];
    }
    
    NSLog(@"\r\n%d \r\n%@", (int)esNum, esStr);
    
    NSLog(@"%@", [[JEDISecret defaultSecret] getRSAPublicKey]);
    return;
}

//-----------------------------------------------------------------------------------
+ (void) AESTestCode
{
}

//-----------------------------------------------------------------------------------
+ (void) ZIPTestCode
{
    //
    // test code for Felix
    //
    //NSString *strTest = @"This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.This is test about Zip/Unzip function if is valid for us. Edit by Felix on 14-07-2013.";
    
    NSString *strTest = @"Felix曹建国Test日期加盟andTest压缩和解压缩Felix曹建国Test日期加盟andTest压缩和解压缩Felix曹建国Test日期加盟andTest压缩和解压缩Felix曹建国Test日期加盟andTest压缩和解压缩Felix曹建国Test日期加盟andTest压缩和解压缩";
    
    NSData* zipData   = [JEDIZip zipDataFromData:[strTest dataUsingEncoding:NSUTF8StringEncoding]];
    NSData* unzipData = [JEDIZip dataFromZipData:zipData];
    
    NSString *desTest = [[NSString alloc] initWithData:unzipData encoding:NSUTF8StringEncoding];
    
    NSString* strResult = [NSString stringWithFormat:@"Test Result: --> %@ %d:%d"
                           , [strTest isEqualToString:desTest] ? @"OK" : @"ERROR", [zipData length], (int)[unzipData length]];
    
    NSLog(@"%@", strTest);
    NSLog(@"%@", desTest);
    NSLog(@"%@", strResult);
}

//-----------------------------------------------------------------------------------
+ (void) MD5TestCode
{
    NSString * strData = @"FelixTest1FelixTest2FelixTest3FelixTest4FelixTest5";
    NSData * data = [strData dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[16];
    
    MD5((const unsigned char *) [data bytes], [data length], buffer);
    [JEDISystem printHexBytes:buffer onSize:16];
    
    CC_MD5([data bytes], [data length], buffer);
    [JEDISystem printHexBytes:buffer onSize:16];
    
    [JEDISystem log:[JEDITranslater stringFromInt:-56 radix:36]];
    [JEDISystem log:[JEDITranslater stringFromInt:56 radix:36]];
    
    [JEDISystem log:[JEDITranslater stringFromBuffer:buffer size:16 radix:36 unsign:true]];
    [JEDISystem log:[JEDITranslater stringFromBuffer:buffer size:16 radix:16 unsign:true]];
    
    [JEDISystem log:[JEDITranslater stringFromBuffer:buffer size:16 radix:36 unsign:false]];
}

//-----------------------------------------------------------------------------------
+ (void) JSONTestCode
{
    //
    // NSDictionary
    //
    NSDictionary *empty = [[NSDictionary alloc] init];
    
    NSNumber *value1 = [NSNumber numberWithDouble:123.3211234123411];
    NSNumber *value2 = [NSNumber numberWithBool:YES];
    
    NSMutableArray *nsArray = [NSMutableArray arrayWithObjects:value1, value2, nil];
    
    NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                           value1, @"key1", value2, @"key2", nsArray, @"key3", nil];
    
    NSInteger N_ENTRIES = 6;
    NSString *keyArray[N_ENTRIES];
    NSNumber *valueArray[N_ENTRIES];
    
    for (NSInteger i = 0; i < N_ENTRIES; i++){
        char charValue = 'a' + i;
        keyArray[i] = [NSString stringWithFormat:@"%c", charValue];
        valueArray[i] = [NSNumber numberWithChar:charValue];
    }
    
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:(id *)valueArray
                                                      forKeys:(id *)keyArray count:N_ENTRIES];
    
    //
    // empty dictionary
    //
    NSError * nsError = nil;
    if([NSJSONSerialization isValidJSONObject:empty]){
        NSLog(@"empty is valid JSON object!");
        
        NSData *emptyData = [NSJSONSerialization dataWithJSONObject:empty options:NSJSONWritingPrettyPrinted error:&nsError];
        
        NSString* emptyStr = [[NSString alloc] initWithData:emptyData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", emptyStr);
    }
    
    //
    // dict1 dictionary
    //
    if([NSJSONSerialization isValidJSONObject:dict1]){
        NSLog(@"dict1 is valid JSON object!");
        
        NSData *emptyData = [NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:&nsError];
        
        NSString* emptyStr = [[NSString alloc] initWithData:emptyData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", emptyStr);
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:emptyData options:NSJSONReadingAllowFragments error:&nsError];
        
        if([jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * jsonDict = jsonObject;
            NSNumber *jv1 = [jsonObject valueForKey:@"key1"];
            NSNumber *jv2 = [jsonObject valueForKey:@"key2"];
            NSMutableArray *ja3 = [jsonObject valueForKey:@"key3"];
            
            NSLog(@"%f, %@ \r\n%@ \r\r%@", [jv1 doubleValue], ([jv2 boolValue] ? @"YES" : @"NO"), ja3, jsonDict);
        }
        
        if([jsonObject isKindOfClass:[NSArray class]])
        {
            NSArray * jsonArr = jsonObject;
            NSLog(@"%@", jsonArr);
        }
        
        NSLog(@"%@", jsonObject);
        
    }
    
    //
    // dict2 dictionary
    //
    if([NSJSONSerialization isValidJSONObject:dict2]){
        NSLog(@"dict2 is valid JSON object!");
        
        NSData *emptyData = [NSJSONSerialization dataWithJSONObject:dict2 options:NSJSONWritingPrettyPrinted error:&nsError];
        
        NSString* emptyStr = [[NSString alloc] initWithData:emptyData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", emptyStr);
    }
    
    //
    // NSMutableDictionary
    //
    NSMutableDictionary* mutDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    value1, @"key1", value2, @"key2", nsArray, @"key3", nil];
    
    [mutDict addEntriesFromDictionary:dict2];
    [mutDict setObject:[NSNumber numberWithLong:230L] forKey:@"key4"];
    
    if([NSJSONSerialization isValidJSONObject:mutDict]){
        NSLog(@"mutDict is valid JSON object!");
        
        NSData *mutData = [NSJSONSerialization dataWithJSONObject:mutDict options:NSJSONWritingPrettyPrinted error:&nsError];
        
        NSString* emptyStr = [[NSString alloc] initWithData:mutData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", emptyStr);
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:mutData options:NSJSONReadingAllowFragments error:&nsError];
        
        if([jsonObject isKindOfClass:[NSMutableDictionary class]])
        {
            NSMutableDictionary * jsonDict = jsonObject;
            NSNumber *jv1 = [jsonObject valueForKey:@"key1"];
            NSNumber *jv2 = [jsonObject valueForKey:@"key2"];
            NSMutableArray *ja3 = [jsonObject valueForKey:@"key3"];
            
            [jsonDict setObject:[NSNumber numberWithDouble:98.023] forKey:@"key10"];
            
            NSLog(@"%f, %@ \r\n%@ \r\r%@", [jv1 doubleValue], ([jv2 boolValue] ? @"YES" : @"NO"), ja3, jsonDict);
        }
        
        NSLog(@"%@", jsonObject);
    }
}


//-----------------------------------------------------------------------------------
+ (void) RSATestCodeOpenssl
{
    RSA *myRsa = RSA_generate_key(1024, RSA_F4, NULL, NULL);
    RSA *priRsa = RSAPrivateKey_dup(myRsa);
    RSA *pubRsa = RSAPublicKey_dup(myRsa);
    
    int rsaSize = RSA_size(myRsa);
    NSLog(@"%d, %d", rsaSize, myRsa->n->dmax);
    
    NSLog(@"%d", pubRsa->n->dmax);
    NSString *nsStr = @"";
    
    for(NSInteger i=pubRsa->n->dmax-1; i>=0; i--){
        nsStr = [NSString stringWithFormat:@"%@%08x", nsStr, pubRsa->n->d[i]];
    }
    
    NSLog(@"%@", nsStr);
    NSLog(@"%d", pubRsa->e->dmax);
    NSString *esStr = @"";
    
    for(NSInteger i=0; i < pubRsa->e->dmax; i++){
        esStr = [NSString stringWithFormat:@"%@%08x", esStr, pubRsa->e->d[i]];
    }
    
    NSLog(@"%@", esStr);
    NSLog(@"%d", priRsa->d->dmax);
    NSString *dsStr = @"";
    
    for(NSInteger i=priRsa->d->dmax-1; i>=0; i--){
        dsStr = [NSString stringWithFormat:@"%@%08x", dsStr, myRsa->d->d[i]];
    }
    
    NSLog(@"%@", dsStr);
    RSA_print_fp(stdout, myRsa, 0);
}

//-----------------------------------------------------------------------------------
+ (void) HandleServerData:(NSData *)nsData
{
    // decrypt data
    NSData *deData = [[JEDISecret defaultSecret] decryptDataWithAES:nsData];
    // unzip data
    double avlidMem = [JEDISystem memoryAvailable];
    double usedMem  = [JEDISystem memoryAlreadyUsed];
    NSLog(@"%f, %f", avlidMem, usedMem);
    
    NSData *unZipData = [JEDIZip dataFromZipData:deData];
    
    NSString *deString = [[NSString alloc] initWithData:unZipData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", deString);
    
    NSData *zipData = [JEDIZip zipDataFromData:unZipData];
    NSData *enData  = [[JEDISecret defaultSecret] encryptDataWithAES:zipData];
    
    
    if([nsData isEqualToData:enData])
    {
        NSLog(@"The data from server is equal to local data.");
    }else{
        [JEDISystem printHexData:nsData];
        [JEDISystem printHexData:enData];
    }
}

//-----------------------------------------------------------------------------------
CSTSProxyTest * gsProxyTest = nil;
+ (void) TestCSTSProxy
{
    gsProxyTest = [[CSTSProxyTest alloc] initToTest];
    
    if(gsProxyTest == nil){
        [JEDISystem log:@"--------------- Proxy Test ---------------"];
    }else{
        
    }
}

//-----------------------------------------------------------------------------------
CSTSLoginTest * gsLoginTest = nil;
+ (void)    TestCSTSLogin
{
    gsLoginTest = [[CSTSLoginTest alloc] init];
    
    [gsLoginTest test];
}

//-----------------------------------------------------------------------------------
+ (void) TestTimeInterval
{
    NSLock * nsLock = [[NSLock alloc] init];
    [nsLock lock];
    
    //获取精确的时间，但单位是秒
    NSTimeInterval startTime = [JEDIDateTime currentTimeIntervalSince1970];
    
    //单位是（秒）
    [NSThread sleepForTimeInterval:132/1000.0];
    
    if(![nsLock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:3.870]]){
        NSLog(@"TestTimeInterval, don't get the lock....");
    }
    
    NSTimeInterval endTime = [JEDIDateTime currentTimeIntervalSince1970];
    
    NSTimeInterval subTime = endTime - startTime;
    
    NSLog(@"TestTimeInterval, startTime = %f, endTime = %f", startTime, endTime);
    NSLog(@"TestTimeInterval, startTime = %ld, endTime = %ld", (long)(startTime), (long)(endTime));
    
    //使用 long 保存毫秒，会溢出
    NSLog(@"TestTimeInterval, startTime = %ld, endTime = %ld", (long)(startTime * 1000.0), (long)(endTime * 1000.0));
    
    NSLog(@"TestTimeInterval, subTime = %f", subTime);
    NSLog(@"TestTimeInterval, subTime = %ld", (long)(subTime * 1000.0));
}




@end
