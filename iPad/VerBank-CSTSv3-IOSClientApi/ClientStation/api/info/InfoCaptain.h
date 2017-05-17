//
//  InfoCaptain.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/10.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//
#import "InfoFather.h"

@interface InfoCaptain : NSObject

+(InfoCaptain *)getInstance;

-(id)           init;

-(void)         initOperator;

-(Boolean)      onInfo:(InfoFather * )info;

@end
