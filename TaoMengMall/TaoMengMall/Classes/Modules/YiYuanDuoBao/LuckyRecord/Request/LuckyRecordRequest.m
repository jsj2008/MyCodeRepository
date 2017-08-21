//
//  LuckyRecordRequest.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckyRecordRequest.h"
#define GET_RECORD_LIST_URL                                  @"/mall_treasure_award/lucky"
#define GET_HISTORY_RECORD_LIST_URL                                  @"/mall_treasure_activity/history_prizes"
#define GET_CONFIRM_INFO_DATA_URL                                  @"/mall_treasure_activity/confirm_pending"
#define CONFIRM_INFO_REQUEST_URL                                  @"/mall_treasure_activity/confirm_submit"
#define GET_RECORD_DETAIL_REQUEST_URL                                  @"/mall_treasure_award/award"
#define RECEIVE_ITEM_REQUEST_URL                                @"/mall_treasure_award/receive"

@implementation LuckyRecordRequest
+ (void)getRecordListWithParams:(NSDictionary *)params success:(void(^)(LuckyRecordResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_RECORD_LIST_URL parameters:params success:^(NSDictionary *result) {
        
        LuckyRecordResultModel *itemResult = [[LuckyRecordResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)getHistoryRecordListWithParams:(NSDictionary *)params success:(void(^)(LuckyHistoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_HISTORY_RECORD_LIST_URL parameters:params success:^(NSDictionary *result) {
        
        LuckyHistoryResultModel *itemResult = [[LuckyHistoryResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)getConfirmInfoDataWithParams:(NSDictionary *)params success:(void(^)(LuckyConfirmResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_CONFIRM_INFO_DATA_URL parameters:params success:^(NSDictionary *result) {
        
        LuckyConfirmResultModel *itemResult = [[LuckyConfirmResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(itemResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}
+ (void)confirmWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:CONFIRM_INFO_REQUEST_URL parameters:params success:^(NSDictionary *result) {
    
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getRecordDetailWithParams:(NSDictionary *)params success:(void(^)(LukcyRecordDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_RECORD_DETAIL_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        LukcyRecordDetailResultModel *resultModel = [[LukcyRecordDetailResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)receiveWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:RECEIVE_ITEM_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        
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
