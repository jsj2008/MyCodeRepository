//
//  ItemRequest.m
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ItemRequest.h"

#define ITEM_REQUEST_URL                @"/mall_item"
#define ITEM_FOLLOW_REQUEST_URL         @"/mall_item/follow"
#define ITEM_UNFOLLOW_REQUEST_URL       @"/mall_item/unfollow"
#define ITEM_SUPPORT_REQUEST_URL        @"/zbh_service"

@implementation ItemRequest

+ (void)getItemDataWithParams:(NSDictionary *)params success:(void(^)(ItemResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:ITEM_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        ItemResultModel *itemResult = [[ItemResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)followWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:ITEM_FOLLOW_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:ITEM_UNFOLLOW_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getSupportContactWithParams:(NSDictionary *)params success:(void(^)(ITSupportContactResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:ITEM_SUPPORT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        ITSupportContactResultModel *itemResult = [[ITSupportContactResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}
@end
