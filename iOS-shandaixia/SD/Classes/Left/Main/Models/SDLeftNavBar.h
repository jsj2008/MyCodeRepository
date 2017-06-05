//
//  SDLeftNavBar.h
//  SD
//
//  Created by 余艾星 on 17/3/23.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDLeftNavBar : NSObject

@property (nonatomic, copy) NSNumber *borrowingAmountSum;

@property (nonatomic, copy) NSNumber *passSum;

@property (nonatomic, copy) NSNumber *discountSum;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)discountWithDict:(NSDictionary *)dict;



+ (void)leftNavBarFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;


@end
