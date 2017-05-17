//
//  IPFather.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/6.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "IPFather.h"
#import "JEDIDateTime.h"
#import "JEDISystem.h"

static NSString * gs_ipFather_jsonId    = @"ipf";
static NSString * gs_ipFather_id        = @"-1";
static NSString * gs_ipFather_operateId = @"-2";
static NSString * gs_ipFather_userName  = @"-3";
static NSString * gs_ipFather_createTime= @"-4";
static NSString * gs_ipFather_signature = @"-5";
static NSString * gs_ipFather_oriSignature = @"-6";

@implementation IPFather

//-------------------------------------------------------------
+(NSString *)   getIpFatherId
{
    return gs_ipFather_id;
}

//-------------------------------------------------------------
-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        [self setEntry:@"jsonId" entry:gs_ipFather_jsonId];
        [self setEntry:gs_ipFather_operateId entry:[JEDISystem getUUID]];
        [self setEntry:gs_ipFather_createTime entry:[JEDIDateTime currentTimeMillis]];
        
        NSString * className = NSStringFromClass([self class]);
        //[JEDISystem log:@"IPFather.init --> class name = @" withObject:className];
        
        NSRange nsRange = [className rangeOfString:@"_"];
        if(nsRange.location == NSNotFound)
        {
            [self setEntry:gs_ipFather_id entry:@"IPFather"];
        }else{
            NSString * ipId = [className substringFromIndex:(nsRange.location + nsRange.length)];
            [self setEntry:gs_ipFather_id entry:ipId];
        }
    }
    
    return self;
}

//-------------------------------------------------------------
-(NSString *) getID
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_ipFather_id];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//-------------------------------------------------------------
-(NSString *) getOperateId
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_ipFather_operateId];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//-------------------------------------------------------------
-(NSString *) getUserName
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_ipFather_userName];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//-------------------------------------------------------------
-(void) setUserName:(NSString *)userName
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_ipFather_userName entry:userName];
    }
    JEDI_SYS_EndTry
}

//-------------------------------------------------------------
-(long long) getCreateTime
{
    JEDI_SYS_Try
    {
        return [super getEntryLongLong:gs_ipFather_createTime];
    }
    JEDI_SYS_EndTry
    
    return 0;
}

//----------
-(NSString *) getSignature
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_ipFather_signature];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//-------------------------------------------------------------
-(void) setSignature:(NSString *)signature
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_ipFather_signature entry:signature];
    }
    JEDI_SYS_EndTry
}

//----------
-(NSString *) getOriSignature
{
    JEDI_SYS_Try
    {
        return [super getEntryString:gs_ipFather_oriSignature];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//-------------------------------------------------------------
-(void) setOriSignature:(NSString *)oriSignature
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_ipFather_oriSignature entry:oriSignature];
    }
    JEDI_SYS_EndTry
}


@end
