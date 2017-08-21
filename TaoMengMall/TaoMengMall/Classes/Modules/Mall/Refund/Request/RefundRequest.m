//
//  RefundRequest.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "RefundRequest.h"
#define REFUND_APPLY_REQUEST_URL                         @"/mall_refund/apply"
#define REFUND_SUBMIT_REQUEST_URL                        @"/mall_refund/submit"
#define REFUND_CANCEL_REQUEST_URL                        @"/mall_refund/cancel"
#define REFUND_HISTORY_REQUEST_URL                       @"/mall_refund/history"
#define REFUND_DETAIL_REQUEST_URL                        @"/mall_refund/detail"

@implementation RefundRequest

+ (void)getRefundApplyDataWithParams:(NSDictionary *)params success:(void(^)(RFApplyResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:REFUND_APPLY_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        RFApplyResultModel *applyResult = [[RFApplyResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(applyResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)submitRefundWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:REFUND_SUBMIT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}


+ (void)cancelRefundWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:REFUND_CANCEL_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}


+ (void)getRefundHistoryWithParams:(NSDictionary *)params success:(void(^)(RFHistoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:REFUND_HISTORY_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        RFHistoryResultModel *historyResult = [[RFHistoryResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(historyResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}


+ (void)getRefundDetailWithParams:(NSDictionary *)params success:(void(^)(RFDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:REFUND_DETAIL_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        RFDetailResultModel *detailResult = [[RFDetailResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(detailResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}
@end
