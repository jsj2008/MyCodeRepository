//
//  SDProvince.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDProvince : NSObject

@property (nonatomic, copy) NSString *province;

@property (nonatomic, strong) NSArray *list;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)provinceWithDict:(NSDictionary *)dict;

+ (void)getProvinceWithType:(NSString *)type finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end
