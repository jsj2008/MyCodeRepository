//
//  CashierRequest.h
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"

#import "CashierResultModel.h"
#import "ThirdPayResultModel.h"
#import "WexinResultModel.h"

@interface CashierRequest : BaseRequest

+ (void)getCashierDataWithParams:(NSDictionary *)params success:(void(^)(CashierResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
+ (void)getPointCashierDataWithParams:(NSDictionary *)params success:(void(^)(CashierResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)balancePayWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getAlipaySignWithParams:(NSDictionary *)params success:(void(^)(ThirdPayResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getWeixinSignWithParams:(NSDictionary *)params success:(void(^)(ThirdPayResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)wxpayCallbackSignWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)alipayCallbackSignWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

@end
