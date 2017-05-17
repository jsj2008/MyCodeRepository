//
//  JsonFactory.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonFactory : NSObject

//
// public static function
//
#pragma mark Public

+ (void)    initAllJsonClass;
+ (void)    clearAllJonsClass;

+ (id)      parseWithJsonString:(NSString *) strJson;
+ (id)      parseWithJsonData:(NSData *) dataJson;

+ (id)      newInstanceWithJsonId:(NSString *)jsonId;

@end
