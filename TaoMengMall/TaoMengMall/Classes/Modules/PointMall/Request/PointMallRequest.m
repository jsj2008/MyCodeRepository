//
//  CreditTradeRequest.m
//  YouCai
//
//  Created by marco on 5/19/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "PointMallRequest.h"


#define CREDIT_REQUEST_URL             @"/pointmall_index"
#define CREDIT_REQUEST_MORE_URL        @"/pointmall_wall"
#define CREDIT_REQUEST_DETAIL_URL      @"/pointmall_item"

#define CREDIT_ORDER_GENERATE_REQUEST_URL    @"/mall_order/generate"
#define CREDIT_CART_SUBMIT_REQUEST_URL     @"/mall_order/confirm"

#define PMORDER_LIST_REQUEST_URL                         @"/pointmall_order/list"
#define PMORDER_LIST_MORE_REQUEST_URL                    @"/pointmall_order/listmore"

#define PMORDER_DETAIL_REQUEST_URL                       @"/pointmall_order"
//订单确认收货
#define PMORDER_RECEIPT_REQUEST_URL                           @"/pointmall_order/receive"

//订单删除
#define PMORDER_DELETE_REQUEST_URL                           @"/pointmall_order/delete"

#define POINT_DETAIL_REQUEST_URL                          @"/pointmall_point/details"

#define POINT_CATEGORY_REQUEST_URL  @"/pointmall_category"
#define POINT_SEARCH_REQUEST_URL  @"/pointmall_search"


@implementation PointMallRequest

+ (void)getProductListDataWithParams:(NSDictionary *)params success:(void(^)(ProductListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CREDIT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ProductListResultModel *productListResult = [[ProductListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(productListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getProductMoreDataWithParams:(NSDictionary *)params success:(void(^)(ProductListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CREDIT_REQUEST_MORE_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ProductListResultModel *productListResult = [[ProductListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(productListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}



+ (void)orderGenerateWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CREDIT_ORDER_GENERATE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        if (success) {
            
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

//积分订单删除
+ (void)deleteOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:PMORDER_DELETE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

//积分订单确认收货
+ (void)receiptOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:PMORDER_RECEIPT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getPointDetailWithParams:(NSDictionary *)params success:(void (^)(PointDetailResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:POINT_DETAIL_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        PointDetailResultModel *pointdetaliResult = [[PointDetailResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(pointdetaliResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getPointMallCategoryWithParams:(NSDictionary *)params success:(void (^)(PMCategoryResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:POINT_CATEGORY_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        PMCategoryResultModel *pointdetaliResult = [[PMCategoryResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(pointdetaliResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}


+ (void)getSearchDataWithParams:(NSDictionary *)params success:(void (^)(PMCategoryResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:POINT_SEARCH_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        PMCategoryResultModel *pointdetaliResult = [[PMCategoryResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(pointdetaliResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}
@end
