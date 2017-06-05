//
//  SDSpecialDiscount.h
//  SD
//
//  Created by 余艾星 on 17/3/14.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "SDNetworkTool.h"
@class SDLoan;

@interface SDSpecialDiscount : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *pushType;



@property (nonatomic, copy) NSString *cycle;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *periodValidity;

@property (nonatomic, assign) CGFloat discountAmount;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)specialDiscountWithDict:(NSDictionary *)dict;


+ (void)specialDiscountWithLoan:(SDLoan *)loan finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end
