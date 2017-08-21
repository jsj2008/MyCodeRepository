//
//  ItemRequest.m
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CIItemRequest.h"

#define ITEM_REQUEST_URL                 @"/mall_treasure_activity"
#define ITEM_BUY_REQUEST_URL             @"/mall_treasure_participant/participant"
#define GET_PAY_RESULT_REQUEST_URL       @"/mall_treasure_participant/success"
#define CI_ITEM_PRIZE_DETAIL_URL         @"/mall_treasure_activity/prize_detail"

@implementation CIItemRequest

+ (void)getItemDataWithParams:(NSDictionary *)params success:(void(^)(CIItemResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:ITEM_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        CIItemResultModel *itemResult = [[CIItemResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)buyItemWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure {
    [[TTNetworkManager sharedInstance] getWithUrl:ITEM_BUY_REQUEST_URL parameters:params success:^(NSDictionary *result) {
      
        if (success) {
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getPayResultDataWithParams:(NSDictionary *)params success:(void(^)(CIPayResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_PAY_RESULT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        CIPayResultModel *itemResult = [[CIPayResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)getPrizeDetailWithParams:(NSDictionary *)params success:(void(^)(CIPrizeDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:CI_ITEM_PRIZE_DETAIL_URL parameters:params success:^(NSDictionary *result) {
        
        CIPrizeDetailResultModel *itemResult = [[CIPrizeDetailResultModel alloc] initWithDictionary:result error:nil];
        
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
