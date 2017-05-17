////
////  API_IDEvent_Enquirer.m
////  JEDIv7-CSTSv3-ClientAPI
////
////  Created by baolin on 13/5/14.
////  Copyright (c) 2013年 wangyubo. All rights reserved.
////
//
//#import "API_IDEvent_Enquirer.h"
//
//@implementation API_IDEvent_Enquirer
//
//-(id)init:(API_IDEventListener *)_listener{
//    if(self=[super init]){
//         listener=_listener;
//        enquiredEventNameSet=[[NSMutableArray alloc]init];
//    }
//    return self;
//}
//
//-(API_IDEventListener *)getListener{
//    return listener;
//}
//
//-(void)addEventName:(NSString *)eventName{
//    @synchronized(enquiredEventNameSet){
//        //[enquiredEventNameSet setValue:eventName];
//    }
//}
//
//-(void)removeEventName:(NSString *)eventName
//{
//    @synchronized(enquiredEventNameSet){
//        [enquiredEventNameSet removeObserver:eventName forKeyPath:nil];
//    }
//}
//
//-(Boolean)containsEvent:(NSString *)eventName{
//    @synchronized(enquiredEventNameSet){
//        return [enquiredEventNameSet containsObject:eventName];
//    }
//}
//
//-(int)eventSize{
//    @synchronized(enquiredEventNameSet){
//        return (int)[enquiredEventNameSet count];
//    }
//}
//-(NSArray *)getEventNameList{
//    @synchronized(enquiredEventNameSet){
//        NSArray *list=[[NSArray alloc]init];
//        for (int i=0; i<[enquiredEventNameSet count]; i++) {
//            //[list setValue:[enquiredEventNameSet objectAtIndex:i]];
//        }
//        return list;
//    }
//}
//
//
//@end
