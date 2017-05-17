//
//  API_IDEventRunnable.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "API_IDEventRunnable.h"

@implementation API_IDEventRunnable


-(id)init:(API_IDEvent *)_event listener:(API_IDEventListener *)_listener{
    if(self=[super init]){
        event=_event;
        listener=_listener;
    }
    return self;
}

- (void)main{
    [listener onStationEvent:event];
}
@end
