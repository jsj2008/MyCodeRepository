//
//  TopUpRequest.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "TopUpRequest.h"

#define GET_TOPUP_DATA_REQUEST_URL       @"/mall_treasure_charge/index"
#define TOP_UP_REQUEST_URL               @"/mall_treasure_charge/confirm"
#define GET_TOPUP_HISTORY_LIST_REQUEST_URL       @"/mall_treasure_charge/records"
#define GET_TOP_UP_RECORD_LIST_REQUEST_URL       @"/mall_treasure_charge/records"


@implementation TopUpRequest
+ (void)getTopUpDataWithParams:(NSDictionary *)params success:(void(^)(TopUpResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_TOPUP_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        TopUpResultModel *itemResult = [[TopUpResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)topUpWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:TOP_UP_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        
        
        if (success) {
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getTopUpRecordListWithParams:(NSDictionary *)params success:(void(^)(TopUpRecordResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_TOP_UP_RECORD_LIST_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        TopUpRecordResultModel *itemResult = [[TopUpRecordResultModel alloc] initWithDictionary:result error:nil];
        
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
