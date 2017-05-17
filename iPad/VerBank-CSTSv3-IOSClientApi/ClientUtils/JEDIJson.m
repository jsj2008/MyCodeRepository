//
//  JEDIJson.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JEDIJson.h"
#import "JEDISystem.h"

@implementation JEDIJson


//----------------------------------------------------------------------------------------------------
+ (NSString *)  stringFromMutableDictionary:(NSMutableDictionary *) mutDict
{
    @try
    {
        if(mutDict == nil) return nil;
        
        if([NSJSONSerialization isValidJSONObject:mutDict])
        {
            NSError * nsError = nil;
            NSData * nsData = [NSJSONSerialization dataWithJSONObject:mutDict options:NSJSONWritingPrettyPrinted error:&nsError];
            
            if(nsData == nil && nsError != nil){
                [JEDISystem log:@"JEDIJson.stringFromMutableDictionary, Error: " withObject:nsError];
            }
            
            if(nsData != nil){
                return [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
            }
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDIJson.stringFromMutableDictionary, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDIJson.stringFromMutableDictionary, Error: unknow."];
    }
    
    return nil;
}

//----------------------------------------------------------------------------------------------------
+ (NSData *)    dataFromMutableDictionary:(NSMutableDictionary *) mutDict
{
    @try
    {
        if(mutDict == nil) return nil;
        
        if([NSJSONSerialization isValidJSONObject:mutDict])
        {
            NSError * nsError = nil;
            NSData * nsData = [NSJSONSerialization dataWithJSONObject:mutDict options:NSJSONWritingPrettyPrinted error:&nsError];
            
            if(nsData == nil && nsError != nil){
                [JEDISystem log:@"JEDIJson.dataFromMutableDictionary, Error: " withObject:nsError];
            }
            
            return nsData;
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDIJson.dataFromMutableDictionary, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDIJson.dataFromMutableDictionary, Error: unknow."];
    }
    
    return nil;
}

//----------------------------------------------------------------------------------------------------
+ (NSDictionary *)   dictionaryFromString:(NSString *) jsonStr
{
    @try
    {
        if(jsonStr == nil) return nil;
        
        NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError * nsError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&nsError];
        
        if(jsonObject == nil && nsError != nil){
            [JEDISystem log:@"JEDIJson.mutableDictionaryFromString, Error: " withObject:nsError];
        }
        
        if(jsonObject == nil){
            [JEDISystem log:@"JEDIJson.mutableDictionaryFromString, Error: unknow."];
            return nil;
        }
        
        if([jsonObject isKindOfClass:[NSDictionary class]]){
            return jsonObject;
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDIJson.mutableDictionaryFromString, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDIJson.mutableDictionaryFromString, Error: unknow."];
    }
    
    return nil;
}

//----------------------------------------------------------------------------------------------------
+ (NSDictionary *)  dictionaryFromData:(NSData *) jsonData
{
    @try
    {
        if(jsonData == nil) return nil;
        
        NSError * nsError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&nsError];
        
        if(jsonObject == nil && nsError != nil){
            [JEDISystem log:@"JEDIJson.mutableDictionaryFromData, Error: " withObject:nsError];
        }
        
        if(jsonObject == nil){
            [JEDISystem log:@"JEDIJson.mutableDictionaryFromData, Error: unknow."];
            return nil;
        }
        
        if([jsonObject isKindOfClass:[NSDictionary class]]){
            return jsonObject;
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDIJson.mutableDictionaryFromData, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDIJson.mutableDictionaryFromData, Error: unknow."];
    }
    
    return nil;
}

@end
