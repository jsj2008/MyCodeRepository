//
//  DistributorRequest.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DistributorRequest.h"

#define DS_HOME_DATA_URL                   @"/distribute_index"
#define DS_APPLY_DISTRIBUTOR_URL           @"/distribute_distributor/apply"


#pragma mark -Statistics
#define DS_STATISTICS_ORDER_URL             @"/distribute_metrics/orders"
#define DS_STATISTICS_REVENUE_URL           @"/distribute_metrics/earnings"

#define DS_REVENUE_DETAIL_TOTAL_URL                @"/distribute_earnings"
#define DS_REVENUE_DETAIL_DISTRIBUTE_URL           @"/distribute_earnings/distribute"



@implementation DistributorRequest

+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void(^)(DSHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_HOME_DATA_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSHomeResultModel *resultModel = [[DSHomeResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)applyDistributorWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:DS_APPLY_DISTRIBUTOR_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}



#pragma mark - Statistics
+ (void)getDistributorStatisticsDataWithParams:(NSMutableDictionary *)params success:(void(^)(DSStatisticsResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    //内路由
    NSString *xxType = params[@"xxType"];
    NSString *url = nil;
    
    if ([xxType isEqualToString:@"1"]) {
        url = DS_STATISTICS_ORDER_URL;
    }else{
        url = DS_STATISTICS_REVENUE_URL;
    }
    [params removeObjectForKey:@"xxType"];
    
    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSStatisticsResultModel *resultModel = [[DSStatisticsResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getRevenueDetailDataWithParams:(NSMutableDictionary *)params success:(void(^)(DSRevenueDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    //内路由
    NSString *xxType = params[@"xxType"];
    NSString *url = nil;
    
    if ([xxType isEqualToString:@"1"]) {
        url = DS_REVENUE_DETAIL_TOTAL_URL;
    }else{
        url = DS_REVENUE_DETAIL_DISTRIBUTE_URL;
    }
    [params removeObjectForKey:@"xxType"];
    
    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSRevenueDetailResultModel *resultModel = [[DSRevenueDetailResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
