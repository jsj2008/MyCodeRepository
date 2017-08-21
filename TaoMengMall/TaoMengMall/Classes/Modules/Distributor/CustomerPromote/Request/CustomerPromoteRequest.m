//
//  CustomerPromoteRequest.m
//  CarKeeper
//
//  Created by marco on 3/8/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "CustomerPromoteRequest.h"

#pragma mark -
#define DS_CP_SHARE_DATA_URL                @"/distribute_client"
#define DS_CP_GET_CAPTCHA_URL               @"/distribute_client/getcode"
#define DS_CP_INVITE_URL                    @"/distribute_client/invite"
#define DS_CP_LIST_URL                      @"/distribute_client/clients"

@implementation CustomerPromoteRequest

#pragma mark - Customer Promote
+ (void)getCustomerPromoteDataWithParams:(NSDictionary *)params success:(void(^)(DSCustomerPromoteResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_CP_SHARE_DATA_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSCustomerPromoteResultModel *resultModel = [[DSCustomerPromoteResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getCustomerCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:DS_CP_GET_CAPTCHA_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)inviteCustomerWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:DS_CP_INVITE_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getCustomerListWithParams:(NSDictionary *)params success:(void(^)(DSCustomerListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_CP_LIST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSCustomerListResultModel *resultModel = [[DSCustomerListResultModel alloc] initWithDictionary:result error:&err];
        
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
