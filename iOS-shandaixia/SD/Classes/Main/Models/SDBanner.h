//
//  SDBanner.h
//  SD
//
//  Created by 余艾星 on 17/3/9.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDBanner : NSObject

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *httpUrl;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)bannerWithDict:(NSDictionary *)dict;


+ (void)bannerFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end
