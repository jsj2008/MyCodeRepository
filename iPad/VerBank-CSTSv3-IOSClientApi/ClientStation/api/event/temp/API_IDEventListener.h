//
//  NSObject_API_IDEventListener.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/14.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API_IDEvent.h"
@interface API_IDEventListener: NSObject 

-(void)onStationEvent:(API_IDEvent * )event;
@end
