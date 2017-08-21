//
//  ConsigneeRequest.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "ConsigneeAddResultModel.h"
#import "ConsigneeListResultModel.h"
#import "ConsigneeResultModel.h"
#import "CityListModel.h"

@interface ConsigneeRequest : BaseRequest

+ (void)addConsigneeWithParams:(NSDictionary *)params success:(void(^)(ConsigneeAddResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)editConsigneeWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getConsigneeWithParams:(NSDictionary *)params success:(void(^)(ConsigneeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getConsigneeListWithParams:(NSDictionary *)params success:(void(^)(ConsigneeListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getConsigneeListMoreWithParams:(NSDictionary *)params success:(void(^)(ConsigneeListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)setDefaultWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)deleteWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getRegionWithParams:(NSDictionary *)params success:(void(^)(CityListModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
