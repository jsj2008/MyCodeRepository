//
//  TopUpRequest.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "TopUpResultModel.h"
#import "TopUpRecordResultModel.h"

@interface TopUpRequest : BaseRequest
+ (void)getTopUpDataWithParams:(NSDictionary *)params success:(void(^)(TopUpResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
+ (void)topUpWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;
+ (void)getTopUpRecordListWithParams:(NSDictionary *)params success:(void(^)(TopUpRecordResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
