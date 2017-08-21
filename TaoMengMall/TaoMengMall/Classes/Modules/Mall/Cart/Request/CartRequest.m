//
//  CartRequest.m
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CartRequest.h"

#define CART_ADD_REQUEST_URL                        @"/mall_cart/add"
#define CART_REQUEST_URL                            @"/mall_cart/index"
#define CART_SUBMIT_REQUEST_URL                     @"/mall_order/confirm"
#define CART_CHANGE_REQUEST_URL                        @"/mall_cart/change"

//购物车算价格
#define CART_TOTAL_PRICE_REQUEST_URL                   @"/mall_cart/totalprice"

#define CART_CLEAR_INVALID_REQUEST_URL               @"mall_cart/clear_invalid"

@implementation CartRequest

+ (void)getCartDataWithParams:(NSDictionary *)params success:(void(^)(CartResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CART_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        CartResultModel *cartResult = [[CartResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(cartResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getCartSubmitDataWithParams:(NSDictionary *)params success:(void(^)(CartSubmitResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CART_SUBMIT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        CartSubmitResultModel *cartResult = [[CartSubmitResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(cartResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)addToCartWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:CART_ADD_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
       if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)amountChangeWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CART_CHANGE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getTotalPriceWithParams:(NSDictionary *)params success:(void(^)(CTTotalPriceResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:CART_TOTAL_PRICE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err;
        
        CTTotalPriceResultModel *priceResult = [[CTTotalPriceResultModel alloc] initWithDictionary:result error:&err];
        if (success) {
            success(priceResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)clearInvalidItemWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CART_CLEAR_INVALID_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

@end
