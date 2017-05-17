//
//  API_IDEvent.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/14.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_IDEvent : NSObject
{ 
    NSString *eventSourceID;
    NSString *eventName;
    NSMutableArray *eventData;
    Boolean eventResult ;
    
}
-(id)init;

-(id)init:(NSString *)_eventName;

-(id)init:(NSString *)_eventName eventData:(NSMutableArray *)_eventData  eventResult:(Boolean)_eventResult  eventSourceID:(NSString *)_eventSourceID;

-(Boolean)isEventResult;

-(void)setEventResult:(Boolean)_eventResult;

-(NSString *)getEventSourceID;

-(void)setEventSourceID:(NSString *)_eventSourceID;

-(NSString *)getEventName;

-(void)setEventName:(NSString *)_eventName;

-(NSMutableArray *)getEventData;

-(void)setEventData:(NSMutableArray *)_eventData;
@end
