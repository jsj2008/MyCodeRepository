//
//  APIReConnectOperator.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API_IDEventCaptain.h"

const static int STATUS_NET_LOST    =-1;
const static int STATUS_CONNECTING  =0;
const static int STATUS_CONNECTED   =1;

@interface APIReConnectOperator : NSObject
{
    int connectStatus;
    
    NSMutableArray *allList;
    NSMutableArray *lastList;
}



-(id)       init;

-(Boolean)  inited;

-(int)      getConnectStatus;

-(NSMutableArray *)getAllList;

 
@end
