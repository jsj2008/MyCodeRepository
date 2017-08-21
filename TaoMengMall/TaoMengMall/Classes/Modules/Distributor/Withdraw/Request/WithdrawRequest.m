//
//  WithdrawRequest.m
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "WithdrawRequest.h"

#define DS_WITHDRAW_HOME_URL                       @"/distribute_withdraw/accounts"
#define DS_WITHDRAW_GET_CAPTCHA_URL                @"/distribute_withdraw/getcode"
#define DS_WITHDRAW_BIND_ACCOUNT_URL               @"/distribute_withdraw/bind"
#define DS_WITHDRAW_APPLY_URL                      @"/distribute_withdraw/apply"
#define DS_WITHDRAW_HISTORY_LIST_URL               @"/distribute_withdraw/history"
#define DS_WITHDRAW_HISTORY_DETAIL_URL             @"/distribute_withdraw/detail"


@implementation WithdrawRequest

+ (void)getWithdrawHomeDataWithParams:(NSDictionary *)params success:(void(^)(DSWithdrawHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_WITHDRAW_HOME_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSWithdrawHomeResultModel *resultModel = [[DSWithdrawHomeResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getAccountCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_WITHDRAW_GET_CAPTCHA_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)bindAccountWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_WITHDRAW_BIND_ACCOUNT_URL parameters:params success:^(NSDictionary *result) {
        
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)applyWithdrawWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_WITHDRAW_APPLY_URL parameters:params success:^(NSDictionary *result) {
        
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getWithdrawHistoryWithParams:(NSDictionary *)params success:(void(^)(DSWithdrawHistoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_WITHDRAW_HISTORY_LIST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSWithdrawHistoryResultModel *resultModel = [[DSWithdrawHistoryResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getWithdrawDetailWithParams:(NSDictionary *)params success:(void(^)(DSWithdrawDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_WITHDRAW_HISTORY_DETAIL_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSWithdrawDetailResultModel *resultModel = [[DSWithdrawDetailResultModel alloc] initWithDictionary:result error:&err];
        
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
