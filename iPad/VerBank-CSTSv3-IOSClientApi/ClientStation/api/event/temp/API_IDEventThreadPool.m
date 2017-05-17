//
//  API_IDEventThreadPool.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "API_IDEventThreadPool.h"

API_IDEventThreadPool *threadPool_instance;
NSOperationQueue* threadPool ;

@implementation API_IDEventThreadPool

-(id)init{
    if(self=[super init]){
        threadPool_instance=[[API_IDEventThreadPool alloc]init];
         threadPool = [[NSOperationQueue alloc] init]; 
        [threadPool setMaxConcurrentOperationCount:20];
        
    }
    return self;
}

+(API_IDEventThreadPool *)getInstance{
    return threadPool_instance;
}
 
-(void)notifyEvent:(API_IDEventListener * )listener event:(API_IDEvent *)event{
    [threadPool addOperation:[[API_IDEventRunnable alloc] init:event listener:listener]];
}
@end
