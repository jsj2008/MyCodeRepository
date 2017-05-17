//
//  TiSaveData.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/4.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TiSaveDataCaptain : NSObject

@property NSMutableDictionary *saveDataNodeA;
@property NSMutableDictionary *saveDataNodeB;
@property NSMutableDictionary *saveDataNodeC;
@property NSMutableDictionary *saveDataNodeD;

@property NSString *instrumentA;
@property NSString *instrumentB;
@property NSString *instrumentC;
@property NSString *instrumentD;

+ (TiSaveDataCaptain *)getInstance;
- (void)saveConfigData;

@end
