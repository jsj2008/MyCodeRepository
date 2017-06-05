//
//  SDDiscount.h
//  SD
//
//  Created by 余艾星 on 17/3/9.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"


@interface SDDiscount : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *discountType;

@property (nonatomic, copy) NSString *periodValidity;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, assign) CGFloat discountAmount;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)discountWithDict:(NSDictionary *)dict;



+ (void)discountWithType:(NSString *)type finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end
