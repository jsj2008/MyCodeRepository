//
//  API_IDEventCaptain.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "API_IDEvent.h"
#import "API_IDEvent_NameInterface.h"
#import "SystemConfigModifyEventName.h"

@interface API_IDEventCaptain : NSObject

+ (void)    addListener:(NSString *) eventName observer:(id) observer listener:(SEL) listener;
+ (void)    removeListener:(NSString *) eventName observer:(id) observer;

+ (void)    fireEventChanged:(NSString *)eventName eventData:(id)data;

@end
