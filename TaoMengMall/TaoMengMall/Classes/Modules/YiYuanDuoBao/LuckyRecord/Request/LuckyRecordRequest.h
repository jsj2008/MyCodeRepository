//
//  LuckyRecordRequest.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LuckyRecordResultModel.h"
#import "LuckyHistoryResultModel.h"
#import "LuckyConfirmResultModel.h"
#import "LukcyRecordDetailResultModel.h"

@interface LuckyRecordRequest : BaseRequest
+ (void)getRecordListWithParams:(NSDictionary *)params success:(void(^)(LuckyRecordResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getHistoryRecordListWithParams:(NSDictionary *)params success:(void(^)(LuckyHistoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getConfirmInfoDataWithParams:(NSDictionary *)params success:(void(^)(LuckyConfirmResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)confirmWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getRecordDetailWithParams:(NSDictionary *)params success:(void(^)(LukcyRecordDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)receiveWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;
@end
