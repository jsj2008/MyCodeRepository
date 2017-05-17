//
//  KickOutNode.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AbstractJsonData.h"

@interface KickOutNode : AbstractJsonData

- (id) init;

- (NSString *)  getKickerIp;
- (void)        setKickerIp:(NSString *)kickerIp;

@end
