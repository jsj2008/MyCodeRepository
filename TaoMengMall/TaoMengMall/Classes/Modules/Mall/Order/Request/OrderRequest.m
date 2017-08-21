//
//  OrderRequest.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "OrderRequest.h"

//生成订单
#define ORDER_GENERATE_REQUEST_URL                     @"/mall_order/generate"

//订单列表
#define ORDER_LIST_REQUEST_URL                         @"/mall_order/list"

//订单列表更多
#define ORDER_LIST_MORE_REQUEST_URL                     @"/mall_order/list"

//订单详情
#define ORDER_REQUEST_URL                               @"/mall_order"

//订单确认收货
#define ORDER_RECEIPT_REQUEST_URL                          @"/mall_order/receive"

//订单删除
#define ORDER_DELETE_REQUEST_URL                           @"/mall_order/delete"

//订单取消
#define ORDER_CANCEL_REQUEST_URL                           @"/mall_order/cancel"

//售后
#define AFTER_SALE_LIST_REQUEST_URL                        @"/mall_refund/list"
#define AFTER_SALE_LIST_MORE_REQUEST_URL                   @"/mall_refund/more"

//购物车提交确认订单列表
//#define BMALL_CART_SUBMIT_REQUEST_URL                     @"/bmall_order/confirm"
#define ORDER_POINT_RETURN_REQUEST_URL  @"/mall_cashback"

@implementation OrderRequest

+ (void)orderGenerateWithParams:(NSDictionary *)params success:(void(^)(OrderGenerateResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:ORDER_GENERATE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        OrderGenerateResultModel *orderGenerateResult = [[OrderGenerateResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(orderGenerateResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getOrderListDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:ORDER_LIST_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        OrderListResultModel *orderListResult = [[OrderListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(orderListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getOrderListMoreDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:ORDER_LIST_MORE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        OrderListResultModel *orderListResult = [[OrderListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(orderListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getOrderDataWithParams:(NSDictionary *)params success:(void(^)(OrderResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    
    [[TTNetworkManager sharedInstance] getWithUrl:ORDER_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        OrderResultModel *orderResult = [[OrderResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(orderResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)receiptOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:ORDER_RECEIPT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)deleteOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:ORDER_DELETE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)cancelOrderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:ORDER_CANCEL_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}


+ (void)getAfterSaleListDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:AFTER_SALE_LIST_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        OrderListResultModel *orderListResult = [[OrderListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(orderListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getAfterSaleListMoreDataWithParams:(NSDictionary *)params success:(void(^)(OrderListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:AFTER_SALE_LIST_MORE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        OrderListResultModel *orderListResult = [[OrderListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(orderListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getReturenPointDataWithParams:(NSDictionary *)params success:(void (^)(ODReturenPointResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:ORDER_POINT_RETURN_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ODReturenPointResultModel *orderListResult = [[ODReturenPointResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(orderListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
