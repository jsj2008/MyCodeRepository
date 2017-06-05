//
//  SDLending.h
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"
@class SDBankCard;
@class SDRefundOrder;

typedef enum {

    //0待审核，1审核中，2审核失败， 3等待放款， 4放款失败， 5放款成功， 6待回款，7已逾期， 8还款成功， 9催收, 10放款中，11还款中
    SDLendingStatusPreCheck,
    SDLendingStatusChecking,
    SDLendingStatusCheckFailed,
    SDLendingStatusWaitMoney,
    SDLendingStatusLendFailed,
    SDLendingStatusLendSuccess,
    SDLendingStatusWaitRefund,
    SDLendingStatusOverdue,
    SDLendingStatusRefundSuccess,
    SDLendingStatusHurryUp,
    SDLendingStatusLoaning,
    SDLendingStatusRefunding
    
}SDLendingStatus;

@interface SDLending : NSObject


@property (nonatomic, copy) NSString *orderId;//订单号
@property (nonatomic, copy) NSString *actualReimAmount;//实际还款金额
@property (nonatomic, copy) NSString *repaymentDay;//剩余还款天数
@property (nonatomic, copy) NSString *reimDate;//还款日期
@property (nonatomic, copy) NSString *overdueDay;//逾期天数
@property (nonatomic, copy) NSString *applyNper;//贷款周期
@property (nonatomic, assign) CGFloat borrowingAmount;//借贷金额
@property (nonatomic, assign) CGFloat poundageAmount;//手续费
@property (nonatomic, assign) NSString *stillAmount;//剩余还款金额
@property (nonatomic, assign) CGFloat actualAccountAmount;//实际到帐金额
@property (nonatomic, copy) NSString *successInfo;//放款成功说明
@property (nonatomic, copy) NSString *defeatedInfo;//审核失败说明
@property (nonatomic, assign) CGFloat lateAmount;//滞纳金
@property (nonatomic, copy) NSString *appShowStatus;//APP显示状态

@property (nonatomic, assign) SDLendingStatus status;//0待审核，1审核中，2审核失败， 3等待放款， 4放款失败， 5放款成功， 6待回款，7已逾期


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)lendingWithDict:(NSDictionary *)dict;

//35、用户还款订单状态查询（/order/orderStatus）
+ (void)lendingFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//36、更新状态（/order/showStatus）

+ (void)updateLendingStatus:(SDLending *)lending finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//34、还款（/order/reimbursement）
+ (void)refundWithLending:(SDLending *)lending refund:(NSString *)refund bankCard:(SDBankCard *)bankcard verifyCode:(NSString *)verifyCode refundOrder:(SDRefundOrder *)refundOrder finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//33、用户还款验证短信（/order/sms）
+ (void)getRefundVerifyCode:(SDBankCard *)bankcard money:(NSString *)money finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//连连支付还款请求所需参数（/lianlianPay/cardBindingPara）

+ (void)llRefundInfoWith:(SDLending *)lending bankCard:(SDBankCard *)bankcard finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end
