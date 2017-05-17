//
//  JEDIJson.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEDIJson : NSObject

//
// get string from dictionary
//
+ (NSString *)       stringFromMutableDictionary:(NSMutableDictionary *) mutDict;


//
// get data from dictionary
//
+ (NSData *)         dataFromMutableDictionary:(NSMutableDictionary *) mutDict;

//
// get dictionary from json string
//
+ (NSDictionary *)   dictionaryFromString:(NSString *) jsonStr;

//
// get dictionary from json data
//
+ (NSDictionary *)   dictionaryFromData:(NSData *) jsonData;

@end
