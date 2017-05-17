//
//  API_IDEventCaptain.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "API_IDEventCaptain.h"


@implementation API_IDEventCaptain

+ (void)    addListener:(NSString *) eventName observer:(id) observer listener:(SEL) listener
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:listener name:eventName object:nil];
}

+ (void)    removeListener:(NSString *) eventName observer:(id) observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:eventName object:nil];
}

+ (void)    fireEventChanged: (NSString *)eventName eventData:(id)data
{
    if (![eventName isEqualToString:@"OTHER_ON_PING"]) {
        NSLog(@"post................. %@", eventName);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:eventName object:data];
}


@end
