//
//  API_IDEvent.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/14.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "API_IDEvent.h"

@implementation API_IDEvent

-(id)init{
    if(self=[super init]){
        return [self init:@""];
    }
    return self;
}

-(id)init:(NSString *)_eventName{
    if(self=[super init]){
        return [self init:_eventName eventData:nil eventResult:true eventSourceID:@""];
    }
    return self;
}
-(id)init:(NSString *)_eventName eventData:(NSMutableArray *)_eventData  eventResult:(Boolean)_eventResult  eventSourceID:(NSString *)_eventSourceID{
    if (self=[super init]) {
        eventSourceID=_eventSourceID;
        eventName=_eventName;
        eventData=_eventData;
        eventResult=_eventResult;
    }
    return self;
}
 
-(Boolean)isEventResult{
    return eventResult;
}

-(void)setEventResult:(Boolean)_eventResult{
    eventResult=_eventResult;
}

-(NSString *)getEventSourceID{
    return eventSourceID;
}

-(void)setEventSourceID:(NSString *)_eventSourceID{
    eventSourceID=_eventSourceID;
}

-(NSString *)getEventName{
    return eventName;
}

-(void)setEventName:(NSString *)_eventName{
    eventName=_eventName;
}

-(NSMutableArray *)getEventData{
    return eventData;
}

-(void)setEventData:(NSMutableArray *)_eventData{
    eventData=_eventData;
}
@end
