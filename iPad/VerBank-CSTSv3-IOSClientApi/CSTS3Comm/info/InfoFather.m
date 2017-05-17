//
//  InfoFather.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/4/27.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "InfoFather.h"

NSString  *infoFather_jsonId  =@"ipf";
NSString  *infoFather_id      =@"-1";
NSString  *infoFather_aeid    =@"-2";
NSString  *infoFather_infoTime=@"-3";

@implementation InfoFather

-(NSString *)getID
{
    @try {
        NSString *data=[super getEntryString:infoFather_id];
        return data;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

-(long long)getInfoTime
{
    @try {
        return [super getEntryLongLong:infoFather_infoTime];
    }
    @catch (NSException *exception) {
        return 0;
    }
}

-(NSString *)getAeid{
    @try {
        NSString *data=[super getEntryString:infoFather_aeid];
        return data;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

@end
