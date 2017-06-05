//
//  SDGJJController.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "YPCustomNavBarController.h"
@class SDCity;

@interface SDGJJController : YPCustomNavBarController

@property (nonatomic, strong) SDCity *city;

@property (nonatomic, copy) NSString *channelType;

- (void)getData;

@end
