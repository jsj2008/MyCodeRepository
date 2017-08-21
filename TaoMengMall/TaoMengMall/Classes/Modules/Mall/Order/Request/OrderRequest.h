//
//  OrderRequest.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "OrderGenerateResultModel.h"
#import "OrderListResultModel.h"
#import "OrderResultModel.h"
#import "ODReturenPointResultModel.h"

@interface OrderRequest : BaseRequest

+ (void)orderGenerateWithParams:(NSDictionary *)params success:(void(^)(OrderGenerateResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getOrderListDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
+ (void)getOrderListMoreDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getOrderDataWithParams:(NSDictionary *)params success:(void(^)(OrderResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)receiptOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)deleteOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)cancelOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

//售后
+ (void)getAfterSaleListDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getAfterSaleListMoreDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;



+ (void)getReturenPointDataWithParams:(NSDictionary *)params success:(void(^)(ODReturenPointResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
