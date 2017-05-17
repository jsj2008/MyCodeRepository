//
//  InfoCaptain.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/10.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "InfoCaptain.h"
#import "JEDISystem.h"
#import "InfoOperator.h"

#import "InfoOperator_TRADESERV1003.h"
#import "InfoOperator_TRADESERV1004.h"
#import "InfoOperator_TRADESERV1005.h"
#import "InfoOperator_TRADESERV1006.h"
#import "InfoOperator_TRADESERV1007.h"
#import "InfoOperator_TRADESERV1008.h"
#import "InfoOperator_TRADESERV1010.h"
#import "InfoOperator_TRADESERV1011.h"
#import "InfoOperator_TRADESERV1012.h"
#import "InfoOperator_TRADESERV1013.h"
#import "InfoOperator_TRADESERV1014.h"
#import "InfoOperator_TRADESERV1015.h"
#import "InfoOperator_TRADESERV1016.h"

static InfoCaptain * gs_InfoCaptain_Instance = nil;

@interface InfoCaptain() {
    NSMutableDictionary * mInfoOperators;
}

@end

@implementation InfoCaptain

//----------------------------------------------------------------------------------
+(InfoCaptain *) getInstance
{
    @synchronized(gs_InfoCaptain_Instance)
    {
        if(gs_InfoCaptain_Instance == nil){
            gs_InfoCaptain_Instance = [[InfoCaptain alloc] init];
        }
    }
    
    return gs_InfoCaptain_Instance;
}

//----------------------------------------------------------------------------------
-(id)           init
{
    self = [super init];
    
    if (self != nil)
    {
        mInfoOperators = [[NSMutableDictionary alloc] init];
        [self initOperator];
    }
    
    return self;
}

//----------------------------------------------------------------------------------
- (void) dealloc
{
    if(mInfoOperators != nil)
    {
        [mInfoOperators removeAllObjects];
        mInfoOperators = nil;
    }
}


//----------------------------------------------------------------------------------
-(void)         initOperator
{
    if(mInfoOperators == nil){
        [JEDISystem log:@"InfoCaptain.initOperator, Error, the mInfoOperators == nil."];
        return;
    }
    
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1003 alloc]init] forKey:@"TRADESERV1003"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1004 alloc]init] forKey:@"TRADESERV1004"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1005 alloc]init] forKey:@"TRADESERV1005"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1006 alloc]init] forKey:@"TRADESERV1006"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1007 alloc]init] forKey:@"TRADESERV1007"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1008 alloc]init] forKey:@"TRADESERV1008"];
    
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1010 alloc]init] forKey:@"TRADESERV1010"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1011 alloc]init] forKey:@"TRADESERV1011"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1012 alloc]init] forKey:@"TRADESERV1012"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1013 alloc]init] forKey:@"TRADESERV1013"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1014 alloc]init] forKey:@"TRADESERV1014"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1015 alloc]init] forKey:@"TRADESERV1015"];
    [mInfoOperators setObject:[[InfoOperator_TRADESERV1016 alloc]init] forKey:@"TRADESERV1016"];
}


//----------------------------------------------------------------------------------
-(Boolean)      onInfo:(InfoFather *)info
{
    if(mInfoOperators == nil){
        [JEDISystem log:@"InfoCaptain.onInfo, Error, the mInfoOperators == nil."];
        return false;
    }
    
    InfoOperator * infoOperator = [mInfoOperators objectForKey:[info getID]];
    if(infoOperator == nil){
        [JEDISystem log:@"InfoCaptain.onInfo, Error, inforOperator == nil, the name :" withObject:[info getID]];
        return false;
    }
    
    [infoOperator onInfo:info];
    return true;
}

@end
