//
//  OPFather.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/6.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "OPFather.h"
#import "JEDISystem.h"
#import "JEDIDateTime.h"

//static NSString * gs_opFather_jsonId    = @"opf";
static NSString * gs_opFather_id        = @"-1";
static NSString * gs_opFather_operateId = @"-2";
static NSString * gs_opFather_succeed   = @"-3";
static NSString * gs_opFather_errCode   = @"-4";
static NSString * gs_opFather_errMessage= @"-5";
static NSString * gs_opFather_usedTime  = @"-6";

@implementation OPFather

//------------------------------------------------------------------
-(id) init
{
    self = [super init];
    return self;
}

//------------------------------------------------------------------
-(id) initWithIp:(IPFather *)ip
{
    self = [super init];
    
    if (self != nil)
    {
        [super setEntry:gs_opFather_id entry:[ip getID]];
        [super setEntry:gs_opFather_operateId entry:[ip getOperateId]];
    }
    
    return self;
}

//------------------------------------------------------------------
-(NSString *) getID
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_opFather_id];
    }
    JEDI_SYS_EndTry
 
    return nil;
}

//------------------------------------------------------------------
-(NSString *) getOperateId
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_opFather_operateId];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//------------------------------------------------------------------
-(NSString *) getErrCode
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_opFather_errCode];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//------------------------------------------------------------------
-(void) setErrCode:(NSString *)errCode
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_opFather_errCode entry:errCode];
    }
    JEDI_SYS_EndTry
}

//------------------------------------------------------------------
-(NSString *) getErrMessage
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_opFather_errMessage];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//------------------------------------------------------------------
-(void) setErrMessage:(NSString *)errMessage
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_opFather_errMessage entry:errMessage];
    }
    JEDI_SYS_EndTry
}

//------------------------------------------------------------------
-(Boolean) isSuccessed
{
    JEDI_SYS_Try
    {
        return [super getEntryBoolean:gs_opFather_succeed];
    }
    JEDI_SYS_EndTry
    
    return false;
}

//------------------------------------------------------------------
-(void) setSuccess:(Boolean)successed
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_opFather_succeed entry:[NSNumber numberWithBool:successed]];
    }
    JEDI_SYS_EndTry
}

//------------------------------------------------------------------
-(int) getUsedTime
{
    JEDI_SYS_Try
    {
        return [super getEntryInt:gs_opFather_usedTime];
    }
    JEDI_SYS_EndTry
    
    return 0;
}

//------------------------------------------------------------------
-(void) setUsedTime:(int)usedTime
{    
    JEDI_SYS_Try
    {
        [super setEntry:gs_opFather_usedTime entry:[NSNumber numberWithInt:usedTime]];
    }
    JEDI_SYS_EndTry
}

@end
