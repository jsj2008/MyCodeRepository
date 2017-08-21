//
//  CreditTradeRequest.h
//  YouCai
//
//  Created by marco on 5/19/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseRequest.h"
//#import "ProductDetailResultModel.h"
#import "ProductListResultModel.h"

//#import "OrderGenerateResultModel.h"
//#import "PMCartSubmitResultModel.h"

//#import "PMOrderListResultModel.h"
//#import "PMOrderResultModel.h"
#import "PointDetailResultModel.h"
#import "PMCategoryResultModel.h"

@interface PointMallRequest : BaseRequest

+ (void)getProductListDataWithParams:(NSDictionary *)params success:(void(^)(ProductListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getProductMoreDataWithParams:(NSDictionary *)params success:(void(^)(ProductListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


//积分兑换
//+ (void)orderGenerateWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;

//积分兑换列表


//积分订单详情

//积分订单删除
//+ (void)deleteOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

//积分订单确认收货
//+ (void)receiptOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;


// 积分明细
+ (void)getPointDetailWithParams:(NSDictionary *)params success:(void(^)(PointDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


+ (void)getPointMallCategoryWithParams:(NSDictionary *)params success:(void(^)(PMCategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


+ (void)getSearchDataWithParams:(NSDictionary *)params success:(void(^)(PMCategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
