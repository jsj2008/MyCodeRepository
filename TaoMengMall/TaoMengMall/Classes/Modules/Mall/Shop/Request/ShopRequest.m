//
//  ShopRequest.m
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ShopRequest.h"

#define SHOP_REQUEST_URL                        @"/mall_shop"
#define SHOP_MORE_REQUEST_URL                   @"/mall_shop"
#define SHOP_FOLLOW_REQUEST_URL                   @"/mall_shop/follow"
#define SHOP_UNFOLLOW_REQUEST_URL                   @"/mall_shop/unfollow"

@implementation ShopRequest

+ (void)getShopDataWithParams:(NSDictionary *)params success:(void(^)(ShopResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:SHOP_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ShopResultModel *shopResult = [[ShopResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(shopResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getShopMoreDataWithParams:(NSDictionary *)params success:(void(^)(ShopResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:SHOP_MORE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ShopResultModel *shopResult = [[ShopResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(shopResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)followWithParams:(NSDictionary *)params success:(void(^)(ShopFollowResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:SHOP_FOLLOW_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        ShopFollowResultModel *followResult = [[ShopFollowResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(followResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)(ShopFollowResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:SHOP_UNFOLLOW_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        ShopFollowResultModel *unfollowResult = [[ShopFollowResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(unfollowResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

@end
