////
////  API_IDEvent_Spanwser.m
////  JEDIv7-CSTSv3-ClientAPI
////
////  Created by baolin on 13/5/15.
////  Copyright (c) 2013年 wangyubo. All rights reserved.
////
//
//#import "API_IDEvent_Spanwser.h"
//
//@implementation API_IDEvent_Spanwser
//
//
//-(id)init{
//    if(self=[super init]){
//        container=[[API_IDEvent_EnquirerContainer alloc]init];
//        eventList=[[NSMutableArray alloc]init];
//    }
//    return self;
//}
//
//-(void)inited{
//    isDestroy=false;
//    [self run];
//}
//
//-(void)destroy{
//    isDestroy=true;
//}
//
//-(void)addListener:(API_IDEventListener *)listener eventName:(NSString *)eventName{
//    [container addListener:listener eventName:eventName];
//}
//
//-(void)removeListener:(API_IDEventListener *)listener eventName:(NSString *)eventName{
//    [container removeListener:listener eventName:eventName];
//}
//
//-(void) removeListener:(API_IDEventListener *)listener{
//    [container removeListener:listener];
//}
//
//-(void)fireEventChanged:(API_IDEvent *)event{
//    @synchronized(eventList)
//    {
//        [eventList addObject:event]; 
//    }
//}
//
//-(void)_notifyEvent:(API_IDEvent *)event
//{
//    NSMutableArray *list=[container getEnquiredListeners:[event getEventName]];
//    for (int i=0; i<[list count]; i++) {
//        API_IDEventListener *listener=[list objectAtIndex:i];
//        @try {
//            [[API_IDEventThreadPool getInstance]notifyEvent:listener event:event];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"Exception %@,%@ ",exception.name,exception.reason);
//        }
//        
//    }
//}
//
//-(void)run{
//    while (!isDestroy) {
//        API_IDEvent *event=nil;
//        @synchronized(eventList){
//            if (eventList ==nil||[eventList count]==0) {
//                event=[eventList objectAtIndex:[eventList count]-1];
//                [eventList removeLastObject];
//            }
//            if(event!=nil){
//                [self _notifyEvent:event];
//            }else{
//                @synchronized(eventList){
//                    @try {
//                        [NSThread sleepForTimeInterval:5];
//                    }
//                    @catch (NSException *exception) {
//                    }
//                }
//            }
//        }
//    }
//}
//@end
