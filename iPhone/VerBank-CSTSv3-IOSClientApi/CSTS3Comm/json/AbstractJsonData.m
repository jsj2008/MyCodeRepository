//
//  AbstractJsonData.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/4/27.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AbstractJsonData.h"
#import "JEDISystem.h"
#import "JEDIJson.h"
#import "JEDIDateTime.h"

@interface AbstractJsonData()

- (id)                      getJsonObject:(id) obj;
- (NSMutableArray *)        getJsonMArray:(NSArray *) array;
- (NSMutableDictionary *)   getJsonDictionary:(NSDictionary *) dictionary;

@end


@implementation AbstractJsonData

//------------------------------------------------------------------------------------------
#pragma mark Public

//------------------------------------------------------------------------------------------
- (id)  init
{
    self = [super init];
    
    if(self != nil)
    {
        mEntryDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

//------------------------------------------------------------------------------------------
- (id)  initEmpty
{
    self = [super init];
    
    if(self != nil)
    {
        mEntryDictionary = nil;
    }
    
    return self;
}

//------------------------------------------------------------------------------------------
- (id)  initWithJsonData:(NSData *) data
{
    self = [super init];
    
    if(self != nil)
    {
        NSDictionary * dict = [JEDIJson dictionaryFromData:data];
        
        if(dict != nil){
            mEntryDictionary = [[NSMutableDictionary alloc] initWithDictionary:dict];
        }
        
        if(mEntryDictionary == nil){
            mEntryDictionary = [[NSMutableDictionary alloc] init];
        }
    }
    
    return self;
}

//------------------------------------------------------------------------------------------
- (id)  clone
{
    return nil;
}

//------------------------------------------------------------------------------------------
- (NSData *)    getJsonData
{
    //
    // create new MutaleDictionary,   change all of JsonData to MutaleDictionary.
    //
    NSMutableDictionary * jsonDictionary = [self getJsonDictionary:mEntryDictionary];
    
    //
    // get data from dictionary
    //
    return [JEDIJson dataFromMutableDictionary:jsonDictionary];
}

//------------------------------------------------------------------------------------------
- (NSString *)  getJsonString
{
    //
    // create new MutaleDictionary,   change all of JsonData to MutaleDictionary.
    //
    NSMutableDictionary * jsonDictionary = [self getJsonDictionary:mEntryDictionary];
    
    //
    // get string from dictionary
    //
    
    return [JEDIJson stringFromMutableDictionary:jsonDictionary];
}

//------------------------------------------------------------------------------------------
- (void) setEntryDictionary:(NSMutableDictionary *)entry
{
    if(mEntryDictionary != nil){
        [mEntryDictionary removeAllObjects];
    }
    
    mEntryDictionary = entry;
}

//------------------------------------------------------------------------------------------
- (NSMutableDictionary *) getEntryDictionary
{
    return mEntryDictionary;
}

//------------------------------------------------------------------------------------------
#pragma mark Protected

//------------------------------------------------------------------------------------------
- (void)        setEntry:(NSString *)key entry:(NSObject *)entry
{
    if ([entry isEqual:@"67"]) {
        //
    }
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    JEDI_SYS_Try
    {
        [mEntryDictionary setValue:entry forKey:key];
    }
    JEDI_SYS_EndTry
}

//------------------------------------------------------------------------------------------
- (NSString *)  getEntryString:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    @try
    {
        if([entry isKindOfClass:[NSNumber class]])
        {
            NSNumber *nsNumber = entry;
            return [nsNumber stringValue];
        }
        
        if([entry isKindOfClass:[NSDate class]])
        {
            NSDate *nsDate = entry;
            return [JEDIDateTime stringFromDate:nsDate];
        }
        
        if([entry isKindOfClass:[NSString class]])
        {
            NSString *nsString = entry;
            //            return [nsString copy];
            return [NSString stringWithFormat:@"%@", nsString];
            //            return [[NSString alloc] initWithString:nsString];
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryString, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryString, Error: unknown."];
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryString has exception." userInfo:nil];
    //return nil;
}

//------------------------------------------------------------------------------------------
- (double)      getEntryDouble:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    //    NSLog(@"=============== %@ %@", key, entry);
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    @try
    {
        if([entry isKindOfClass:[NSNumber class]])
        {
            NSNumber *nsNumber = entry;
            return [nsNumber doubleValue];
        }
        
        if([entry isKindOfClass:[NSString class]])
        {
            NSString *nsString = entry;
            return [nsString doubleValue];
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryDouble, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryDouble, Error: unknown."];
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryDouble has exception." userInfo:nil];
    //return 0xffffffffff;
}

//------------------------------------------------------------------------------------------
- (long)        getEntryLong:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    @try
    {
        if([entry isKindOfClass:[NSNumber class]])
        {
            NSNumber *nsNumber = entry;
            return [nsNumber longValue];
        }
        
        if([entry isKindOfClass:[NSString class]])
        {
            NSString *nsString = entry;
            return [nsString intValue];
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryLong, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryLong, Error: unknown."];
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryLong has exception." userInfo:nil];
    //return 0xffffffffff;
}

//------------------------------------------------------------------------------------------
- (long long)   getEntryLongLong:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    @try
    {
        if([entry isKindOfClass:[NSNumber class]])
        {
            NSNumber *nsNumber = entry;
            return [nsNumber longLongValue];
        }
        
        if([entry isKindOfClass:[NSString class]])
        {
            NSString *nsString = entry;
            return [nsString longLongValue];
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryLongLong, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryLongLong, Error: unknown."];
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryLongLong has exception." userInfo:nil];
    
}

//------------------------------------------------------------------------------------------
- (int)         getEntryInt:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    @try
    {
        if([entry isKindOfClass:[NSNumber class]])
        {
            NSNumber *nsNumber = entry;
            return [nsNumber intValue];
        }
        
        if([entry isKindOfClass:[NSString class]])
        {
            NSString *nsString = entry;
            return [nsString intValue];
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryInt, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryInt, Error: unknown."];
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryInt has exception." userInfo:nil];
    //return 0xffffffffff;
}

//------------------------------------------------------------------------------------------
- (BOOL)        getEntryBoolean:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    @try
    {
        if([entry isKindOfClass:[NSNumber class]])
        {
            NSNumber *nsNumber = entry;
            return [nsNumber boolValue];
        }
        
        if([entry isKindOfClass:[NSString class]])
        {
            NSString *nsString = entry;
            return [nsString boolValue];
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryBoolean, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryBoolean, Error: unknown."];
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryBoolean has exception." userInfo:nil];
    //return 0xffffffffff;
}

//------------------------------------------------------------------------------------------
- (NSDate *)    getEntryDate:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    @try
    {
        if([entry isKindOfClass:[NSDate class]])
        {
            NSDate *nsDate = entry;
            return [[NSDate alloc] initWithTimeInterval:0 sinceDate:nsDate];
        }
        
        if([entry isKindOfClass:[NSString class]])
        {
            NSString *nsString = entry;
            return [JEDIDateTime dateFromString:nsString];
        }
    }
    @catch (NSException *exception) {
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryDate, Error: " withObject:exception];
    }
    @catch (...){
        [JEDISystem log:@"JEDI_AbstractJsonData.getEntryDate, Error: unknown."];
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryDate has exception." userInfo:nil];
    //return 0xffffffffff;
}

//------------------------------------------------------------------------------------------
- (id)      getEntryObject:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    if([entry isKindOfClass:[NSObject class]]){
        return entry;
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryObject has exception." userInfo:nil];
    //return nil;
}

//------------------------------------------------------------------------------------------
- (NSMutableArray *) getEntryArray:(NSString *)key
{
    if(mEntryDictionary == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry dictionary" userInfo:nil];
    }
    
    id entry = [mEntryDictionary objectForKey:key];
    if(entry == nil){
        @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"Invalid entry for Key" userInfo:nil];
    }
    
    if([entry isKindOfClass:[NSMutableArray class]]){
        return entry;
    }
    
    @throw [[NSException alloc] initWithName:@"JEDI_AbstractJsonData" reason:@"getEntryArray has exception." userInfo:nil];
}

//------------------------------------------------------------------------------------------
- (id)                      getJsonObject:(id) obj
{
    if([obj isKindOfClass:[NSArray class]])
    {
        return [self getJsonMArray:obj];
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        return [self getJsonDictionary:obj];
    }
    
    if([obj isKindOfClass:[AbstractJsonData class]])
    {
        AbstractJsonData * jsonData = (AbstractJsonData *) obj;
        return [self getJsonDictionary:[jsonData getEntryDictionary]];
    }
    
    return obj;
}

//------------------------------------------------------------------------------------------
- (NSMutableArray *)        getJsonMArray:(NSArray *) array
{
    JEDI_SYS_Try
    {
        NSMutableArray * mutArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i<array.count; i++)
        {
            id obj = [self getJsonObject:[array objectAtIndex:i]];
            [mutArray addObject:obj];
        }
        
        return mutArray;
    }
    JEDI_SYS_EndTry
    return nil;
}

//------------------------------------------------------------------------------------------
- (NSMutableDictionary *)   getJsonDictionary:(NSDictionary *) dictionary
{
    JEDI_SYS_Try
    {
        NSMutableDictionary * mutDictionary = [[NSMutableDictionary alloc] init];
        NSEnumerator *enumerator = [dictionary keyEnumerator];
        id key;
        
        while ((key = [enumerator nextObject]))
        {
            id obj = [self getJsonObject:[dictionary objectForKey:key]];
            [mutDictionary setObject:obj forKey:key];
        }
        
        return mutDictionary;
    }
    JEDI_SYS_EndTry
    return nil;
}

//------------------------------------------------------------------------------------------

@end
