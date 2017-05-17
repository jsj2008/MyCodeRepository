//
//  APIReConnectOperator.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "APIReConnectOperator.h"

@implementation APIReConnectOperator

- (id)init
{
    self = [super init];
    if (self) {
        connectStatus=-1;
        allList=[[NSMutableArray alloc]init];
        lastList=[[NSMutableArray alloc]init];
    }
    return self;
}
-(Boolean)inited{ 
//    [[API_IDEventCaptain getInstance]addListener:self eventName:nil];
    return true;
}

-(int)getConnectStatus{
    return connectStatus;
}

-(NSMutableArray *)getAllList
{
    return [allList copy];
}

-(void)onStationEvent:(API_IDEvent * )event{
    
}
@end
