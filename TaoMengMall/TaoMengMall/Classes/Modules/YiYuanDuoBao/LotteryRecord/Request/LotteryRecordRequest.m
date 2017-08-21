//
//  LotteryRecordRequest.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LotteryRecordRequest.h"
#define GET_RECORDS_DATA_REQUEST_URL       @"/mall_treasure_participant/history"
#define GET_RECORD_DETAIL_DATA_REQUEST_URL       @"/mall_treasure_participant/activity"
#define GET_RECORD_DETAIL_NUMBER_DATA_REQUEST_URL       @"/mall_treasure_participant/detail"
#define ITEM_BUY_REQUEST_URL       @"/mall_treasure_participant/participant"
#define GET_REFUND_DETAIL_DATA_REQUEST_URL       @"/mall_treasure_participant/refund"

@implementation LotteryRecordRequest
+ (void)getRecordsDataWithParams:(NSDictionary *)params success:(void(^)(LotteryRecordsResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_RECORDS_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        LotteryRecordsResultModel *itemResult = [[LotteryRecordsResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)getRecordDetailDataWithParams:(NSDictionary *)params success:(void(^)(LRDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    
    [[TTNetworkManager sharedInstance] getWithUrl:GET_RECORD_DETAIL_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        LRDetailResultModel *itemResult = [[LRDetailResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getRecordDetailNunmberDataWithParams:(NSDictionary *)params success:(void(^)(LRDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_RECORD_DETAIL_NUMBER_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        LRDetailResultModel *itemResult = [[LRDetailResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getRefundDetailNunmberDataWithParams:(NSDictionary *)params success:(void(^)(LotteryRefundResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_REFUND_DETAIL_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        LotteryRefundResultModel *itemResult = [[LotteryRefundResultModel alloc] initWithDictionary:result error:nil];
        
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

@end
