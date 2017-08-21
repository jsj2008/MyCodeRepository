//
//  RevenueRequest.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

#import "DSRevenueHomeResultModel.h"
#import "DSUnavailableResultModel.h"
#import "DSReceiptPaymentResultModel.h"
#import "DSSettlementResultModel.h"

@interface RevenueRequest : BaseRequest

#pragma mark - Revenue
+ (void)getRevenueHomeDataWithParams:(NSDictionary *)params success:(void(^)(DSRevenueHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getUnavailableDataWithParams:(NSDictionary *)params success:(void(^)(DSUnavailableResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getSettlementDataWithParams:(NSDictionary *)params success:(void(^)(DSSettlementResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getReceiptPaymentDataWithParams:(NSDictionary *)params success:(void(^)(DSReceiptPaymentResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
