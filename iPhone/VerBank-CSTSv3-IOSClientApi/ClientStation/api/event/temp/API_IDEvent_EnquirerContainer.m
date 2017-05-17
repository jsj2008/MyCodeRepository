////
////  API_IDEvent_EnquirerContainer.m
////  JEDIv7-CSTSv3-ClientAPI
////
////  Created by baolin on 13/5/15.
////  Copyright (c) 2013年 wangyubo. All rights reserved.
////
//
//#import "API_IDEvent_EnquirerContainer.h" 
//
//id containerLock=@"lock";
// 
//@implementation API_IDEvent_EnquirerContainer
//
//-(id)init{
//    if(self=[super init])
//    {
//        listenerListMapByEventName=[[NSMutableDictionary alloc]init];
//        eventEnquireMapByListener=[[NSMutableDictionary alloc]init];
//    }
//    return self;
//}
//
//-(NSMutableArray *)getEnquiredListeners:(NSString *)eventName{
//    @synchronized(containerLock){
//        if ([listenerListMapByEventName isEqual:eventName]) {
//            NSMutableArray *array=[[NSMutableArray alloc]init];
//            NSEnumerator * enumeratorValue = [listenerListMapByEventName objectEnumerator];
//            for (API_IDEventListener *object in enumeratorValue) {
//                [array addObject:object];
//            }
//            return array;
//        }else{
//           return [[NSMutableArray alloc]init];
//        }
//    
//    }
//}
//
//-(void)addListener:(API_IDEventListener *)listener eventName:(NSString *)eventName{
//    @synchronized(containerLock){
//        API_IDEvent_Enquirer *see=nil;
//        if ([eventEnquireMapByListener isEqual:eventName]) {
//            see=[eventEnquireMapByListener objectForKey:listener];
//        }else{
//            see=[[API_IDEvent_Enquirer alloc]init:listener];
//            [eventEnquireMapByListener setObject:see forKey:[listener copy]];
//        }
//        
//    if (![see containsEvent:eventName]) {
//        [see addEventName:eventName];
//        NSMutableArray *listenerlist=nil;
//        if ([listenerListMapByEventName isEqual:eventName]) {
//            listenerlist=[listenerListMapByEventName objectForKey:eventName];
//        }else{
//            listenerlist=[[NSMutableArray alloc]init];
//            [listenerListMapByEventName setObject:listenerlist forKey:eventName];
//        }
//        }
//    }
//}
//
//-(void)removeListener:(API_IDEventListener *)listener eventName:(NSString *)eventName{
//    @synchronized(containerLock){
//        if (![eventEnquireMapByListener isEqual:listener]) {
//            return;
//        }
//    API_IDEvent_Enquirer *see=[eventEnquireMapByListener objectForKey:listener];
//    if(![see containsEvent:eventName]){
//        return;
//    }
//    [see removeEventName:eventName];
//   [[listenerListMapByEventName objectForKey:eventName]removeObject:listener];
//}
//}
//
//-(void)removeListener:(API_IDEventListener *)listener{
//    @synchronized(containerLock){
//        if (![eventEnquireMapByListener isEqual:listener]) {
//            return;
//        }
//        API_IDEvent_Enquirer *see=[eventEnquireMapByListener objectForKey:listener];
//        [eventEnquireMapByListener removeObjectForKey:listener];
//        NSArray *eventList=[see getEventNameList];
//        for (int i=0; i<[eventList count]; i++) {
//            NSString *eventName=[eventList objectAtIndex:i];
//            [[listenerListMapByEventName objectForKey:eventName]removeObject:listener];
//        }
//    }
//}
//@end
