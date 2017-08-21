//
//  LotteryRecordRequest.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LotteryRecordsResultModel.h"
#import "LRDetailResultModel.h"
#import "LotteryRefundResultModel.h"

@interface LotteryRecordRequest : BaseRequest
+ (void)getRecordsDataWithParams:(NSDictionary *)params success:(void(^)(LotteryRecordsResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getRecordDetailDataWithParams:(NSDictionary *)params success:(void(^)(LRDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getRecordDetailNunmberDataWithParams:(NSDictionary *)params success:(void(^)(LRDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getRefundDetailNunmberDataWithParams:(NSDictionary *)params success:(void(^)(LotteryRefundResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)buyItemWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;
@end
