//
//  SDMyLoanDetail.h
//  SD
//
//  Created by 余艾星 on 17/3/6.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDMyLoanDetail : NSObject

@property (nonatomic, copy) NSString *ID;

//借款金额
@property (nonatomic, copy) NSNumber *borrowingAmount;

//手续费
@property (nonatomic, copy) NSNumber *poundageAmount;

//优惠卷
@property (nonatomic, copy) NSNumber *preferentialAmount;

//应还金额
@property (nonatomic, copy) NSNumber *actualReimAmount;

//到帐金额
@property (nonatomic, copy) NSNumber *actualAccountAmount;

//滞纳金
@property (nonatomic, copy) NSNumber *lateAmount;

//已还金额
@property (nonatomic, copy) NSNumber *hasAlsoAmount;

//当前还需要还款金额
@property (nonatomic, copy) NSNumber *stillAmount;

//借款时间
@property (nonatomic, assign) NSInteger applyNper;

//订单状态,状态 -1订单关闭，0待审核，1审核中，2审核失败， 3等待放款， 4放款失败， 5放款成功， 6待回款，7已逾期， 8还款成功
@property (nonatomic, copy) NSNumber *status;

//到期时间
@property (nonatomic, copy) NSNumber *reimDate;

//放款时间
@property (nonatomic, copy) NSNumber *lendingDate;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)myLoanDetailWithDict:(NSDictionary *)dict;

//我的借款（/order/borrowing）
+ (void)getMyLoanOrderId:(NSString *)orderId detailfinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

+ (void)getMyProtocolOrderId:(NSString *)orderId detailfinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end
