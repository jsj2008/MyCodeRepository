//
//  DistributorPromoteRequest.m
//  CarKeeper
//
//  Created by marco on 3/8/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DistributorPromoteRequest.h"

#pragma mark -
#define DS_DP_SHARE_DATA_URL                @"/distribute_distributor"
#define DS_DP_GET_CAPTCHA_URL               @"/distribute_distributor/getcode"
#define DS_DP_INVITE_URL                    @"/distribute_distributor/invite"
#define DS_DP_LIST_URL                      @"/distribute_distributor/distributors"

@implementation DistributorPromoteRequest

#pragma mark - Distributor Promote
+ (void)getDistributorPromoteDataWithParams:(NSDictionary *)params success:(void(^)(DSDistributorPromoteResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_DP_SHARE_DATA_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSDistributorPromoteResultModel *resultModel = [[DSDistributorPromoteResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getDistributorCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:DS_DP_GET_CAPTCHA_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)inviteDistributorWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:DS_DP_INVITE_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getDistributorListWithParams:(NSDictionary *)params success:(void(^)(DSDistributorListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_DP_LIST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSDistributorListResultModel *resultModel = [[DSDistributorListResultModel alloc] initWithDictionary:result error:&err];
        
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
