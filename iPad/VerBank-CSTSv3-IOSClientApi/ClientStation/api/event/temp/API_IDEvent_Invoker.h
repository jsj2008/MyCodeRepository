//
//  NSObject_API_IDEvent_Invoker.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "API_IDEventListener.h"
#import "API_IDEvent.h"

@protocol API_IDEvent_Invoker <NSObject> 

-(void)     addListener:(API_IDEventListener *)listener eventName:(NSString *)eventName;
 
-(void)     removeListener:(API_IDEventListener *)listener eventName:(NSString *)eventName;
-(void)     removeListener:(API_IDEventListener *)listener;

-(void)     fireEventChanged:(API_IDEvent *)event;

@end
