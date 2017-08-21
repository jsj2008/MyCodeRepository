//
//  DistributorRequest.h
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseRequest.h"
#import "DSHomeResultModel.h"

#import "DSStatisticsResultModel.h"
#import "DSRevenueDetailResultModel.h"


@interface DistributorRequest : BaseRequest

+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void(^)(DSHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)applyDistributorWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;


#pragma mark - Statistics
+ (void)getDistributorStatisticsDataWithParams:(NSDictionary *)params success:(void(^)(DSStatisticsResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getRevenueDetailDataWithParams:(NSDictionary *)params success:(void(^)(DSRevenueDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


@end
