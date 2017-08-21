//
//  RefundRequest.h
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "RFHistoryResultModel.h"
#import "RFDetailResultModel.h"
#import "RFSubmitInfoModel.h"
#import "RFApplyResultModel.h"

@interface RefundRequest : BaseRequest

+ (void)getRefundApplyDataWithParams:(NSDictionary *)params success:(void(^)(RFApplyResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)submitRefundWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)cancelRefundWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getRefundHistoryWithParams:(NSDictionary *)params success:(void(^)(RFHistoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getRefundDetailWithParams:(NSDictionary *)params success:(void(^)(RFDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
