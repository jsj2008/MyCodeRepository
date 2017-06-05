//
//  SDLoan.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/25.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"
@class SDSpecialDiscount;

@interface SDLoan : NSObject


@property (nonatomic, assign) CGFloat price;



//到期应还
@property (nonatomic, copy) NSNumber *refund;

@property (nonatomic, copy) NSNumber *discount;


//借款时间
@property (nonatomic, copy) NSNumber *day;

//借款金额
@property (nonatomic, copy) NSNumber *loan;

//到账金额
@property (nonatomic, copy) NSNumber *received;

//手续费用
@property (nonatomic, copy) NSNumber *charge;

//cardId
@property (nonatomic, copy) NSString *cardId;

//借款起息日（yyyy-MM-dd）
@property (nonatomic, copy) NSString *borrowFrom;

//到期日（yyyy-MM-dd）
@property (nonatomic, copy) NSString *borrowTo;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)loanWithDict:(NSDictionary *)dict;



+ (void)updateLoan:(SDLoan *)loan specialDisCount:(SDSpecialDiscount *)specialDisCount finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

// 自动 和 手动签署
+ (void)updateLoan:(SDLoan *)loan
   specialDIscount:(SDSpecialDiscount *)specialDiscount
            signid:(NSString *)signid
        isBestsign:(NSNumber *)isBestsign
     finishedBlock:(FinishedBlock)finishedBlock
     failuredBlock:(FailuredBlock)failuredBlock;


@end
