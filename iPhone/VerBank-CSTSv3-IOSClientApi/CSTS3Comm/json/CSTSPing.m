//
//  CSTSPing.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/16/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "CSTSPing.h"
#import "JEDIDateTime.h"
#import "JEDISystem.h"


//
// Key define
//
static NSString * gs_CSTSPing_JsonId       = @"CSTSPing";
static NSString * gs_CSTSPing_StartTime    = @"1";
static NSString * gs_CSTSPing_EndTime      = @"2";
static NSString * gs_CSTSPing_ServerDelay  = @"3";
static NSString * gs_CSTSPing_ID           = @"4";


@implementation CSTSPing

//-----------------------------------------------------------------------------------------
- (id) init
{
    self = [super init];
    
    if(self)
    {
        [self setEntry:@"jsonId" entry:gs_CSTSPing_JsonId];
        [self setEntry:gs_CSTSPing_ID entry:[JEDISystem getUUID]];
        [self setEntry:gs_CSTSPing_StartTime entry:[JEDIDateTime currentTimeMillis]];
    }
    
    return self;
}

//-----------------------------------------------------------------------------------------
- (NSString *)  getID
{
    return [self getEntryString:gs_CSTSPing_ID];
}

//-----------------------------------------------------------------------------------------
- (void)        pingReturned
{
    JEDI_SYS_Try
    {
        long long endTime = [JEDIDateTime currentMillis] - [self getServerDelay];
        [self setEntry:gs_CSTSPing_EndTime entry:[NSNumber numberWithLongLong:endTime]];
    }
    JEDI_SYS_EndTry
}

//-----------------------------------------------------------------------------------------
- (long)        getPing
{
    return (long)([self getEndTime] - [self getStartTime]);
}

//-----------------------------------------------------------------------------------------
- (long long)    getStartTime
{
    return [self getEntryLongLong:gs_CSTSPing_StartTime];
}

//-----------------------------------------------------------------------------------------
- (void)        setStartTime:(long long) time
{
    [self setEntry:gs_CSTSPing_StartTime entry:[NSNumber numberWithLongLong:time]];
}

//-----------------------------------------------------------------------------------------
- (long long)    getEndTime
{
    return [self getEntryLongLong:gs_CSTSPing_EndTime];
}

//-----------------------------------------------------------------------------------------
- (long)        getServerDelay
{
    return [self getEntryLong:gs_CSTSPing_ServerDelay];
}

//-----------------------------------------------------------------------------------------
- (void)        setServerDelay:(long) delay
{
    [self setEntry:gs_CSTSPing_StartTime entry:[NSNumber numberWithLong:delay]];
}

@end
