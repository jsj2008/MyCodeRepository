//
//  SDMyLoan.h
//  SD
//
//  Created by 余艾星 on 17/3/2.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

typedef enum {
    SDMyLoanStatusClose = -1,
    SDMyLoanStatusPreCheck,
    SDMyLoanStatusChecking,
    SDMyLoanStatusFailed,
    SDMyLoanStatusLending,
    SDMyLoanStatusLendFailed,
    SDMyLoanStatusLendSuccess,
    SDMyLoanStatusWaitRefund,
    SDMyLoanStatusOverdue,
    SDMyLoanStatusRufundSuccess
    
}SDMyLoanStatus;

#define SDMyLoanStatusCloseColor FDColor(153, 153, 153)
#define SDMyLoanStatusPreCheckColor FDColor(255, 144, 0)
#define SDMyLoanStatusCheckingColor FDColor(255, 144, 0)
#define SDMyLoanStatusFailedColor FDColor(255, 87, 87)
#define SDMyLoanStatusLendingColor FDColor(67, 182, 86)
#define SDMyLoanStatusLendFailedColor FDColor(255, 87, 87)

#define SDMyLoanStatusLendSuccessColor FDColor(67, 182, 86)
#define SDMyLoanStatusWaitRefundColor FDColor(255, 144, 0)
#define SDMyLoanStatusOverdueColor FDColor(255, 87, 87)
#define SDMyLoanStatusRufundSuccessColor FDColor(153, 153, 153)

@interface SDMyLoan : NSObject

@property (nonatomic, copy) NSString *ID;

//借款金额
@property (nonatomic, copy) NSNumber *borrowingAmount;

//订单状态,状态 -1订单关闭，0待审核，1审核中，2审核失败， 3等待放款， 4放款失败， 5放款成功， 6待回款，7已逾期， 8还款成功
@property (nonatomic, copy) NSNumber *status;

//到期时间
@property (nonatomic, copy) NSString *reimDate;

//放款时间
@property (nonatomic, copy) NSString *lendingDate;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)myLoanWithDict:(NSDictionary *)dict;

//我的借款（/order/borrowing）
+ (void)getMyLoanfinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;


@end
