//
//  AbstractJsonData.h
//  VerBank-CSTSv3-ClientAPI
//
//  Created by baolin on 13/4/27.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonDataDefine.h"

@interface AbstractJsonData : NSObject
{
@private
    NSMutableDictionary * mEntryDictionary;
}

//------------------------------------------------------------------------------------------
#pragma mark Public

- (id)                      init;
- (id)                      initEmpty;
- (id)                      initWithJsonData:(NSData *) data;

- (id)                      clone;

- (NSData *)                getJsonData;
- (NSString *)              getJsonString;

- (void)                    setEntryDictionary:(NSMutableDictionary *)entry;
- (NSMutableDictionary *)   getEntryDictionary;

//------------------------------------------------------------------------------------------
#pragma mark Protected

- (void)                    setEntry:(NSString *)key entry:(NSObject *)entry;

- (NSString *)              getEntryString:(NSString *)key;
- (double)                  getEntryDouble:(NSString *)key;
- (long)                    getEntryLong:(NSString *)key;
- (long long)               getEntryLongLong:(NSString *)key;

- (int)                     getEntryInt:(NSString *)key;
- (BOOL)                    getEntryBoolean:(NSString *)key;

- (NSDate *)                getEntryDate:(NSString *)key;
- (id)                      getEntryObject:(NSString *)key;

- (NSMutableArray *)        getEntryArray:(NSString *)key;

@end
