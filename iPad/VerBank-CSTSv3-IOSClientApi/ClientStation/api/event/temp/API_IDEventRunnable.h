//
//  API_IDEventRunnable.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API_IDEventListener.h"
#import "API_IDEvent.h"

@interface API_IDEventRunnable : NSOperation
{
    API_IDEventListener *listener;
    API_IDEvent *event;
}

-(id)init:(API_IDEvent *)_event listener:(API_IDEventListener *)_listener;

@end
