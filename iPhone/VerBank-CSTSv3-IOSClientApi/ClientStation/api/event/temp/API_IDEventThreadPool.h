//
//  API_IDEventThreadPool.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/15.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API_IDEventListener.h"
#import "API_IDEventRunnable.h"

@interface API_IDEventThreadPool : NSObject
{
    NSOperationQueue* threadPool ;
}

-(id)init;

+(API_IDEventThreadPool *)getInstance;
 
-(void)notifyEvent:(API_IDEventListener * )listener event:(API_IDEvent *)event;

@end
