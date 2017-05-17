//
//  InfoFather.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/4/27.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import "AbstractJsonData.h"

@interface InfoFather : AbstractJsonData

-(NSString *)   getID;

-(long long)    getInfoTime;

-(NSString *)   getAeid;

@end
