//
//  TiSaveData.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/4.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TiSaveData : NSObject
// <instrument --> json>
@property NSMutableDictionary *tiMap;
@property NSMutableDictionary *tiClientMap;

+ (TiSaveData *)getInstance;
- (void)saveConfigData;
@end
