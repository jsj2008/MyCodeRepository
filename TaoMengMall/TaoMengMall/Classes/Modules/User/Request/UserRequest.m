//
//  UserRequest.m
//  HongBao
//
//  Created by Ivan on 16/3/5.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "UserRequest.h"

#define USER_LOGIN_REQUEST_URL                          @"/user_user/login"
#define USER_THIRD_LOGIN_REQUEST_URL                    @"/user_user/quick"
#define USER_REGISTER_REQUEST_URL                       @"/user_user/register"
#define USER_GET_CAPTCHA_REQUEST_URL                    @"/user_user/code"
#define USER_REGISTER_BINDING_REQUEST_URL               @"/user_user/bind"
#define USER_UPLOAD_TOKEN_REQUEST_URL                   @"/user_user/setpushtoken"

#define USER_THIRDBIND_REQUEST_URL                      @"/user_user/thirdbind"
#define USER_THIRD_INFO_REQUEST_URL                     @"/user_user/thirdinfo"

#define CHECK_USER_ISREG_URL                            @"/user_user/check"



@implementation UserRequest

+ (void)loginWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:USER_LOGIN_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        LRUserInfoResultModel *userInfoResult = [[LRUserInfoResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)thirdLoginWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:USER_THIRD_LOGIN_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        LRUserInfoResultModel *userInfoResult = [[LRUserInfoResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}


+ (void)registerWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:USER_REGISTER_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        LRUserInfoResultModel *userInfoResult = [[LRUserInfoResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)thirdBindingWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:USER_REGISTER_BINDING_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        LRUserInfoResultModel *userInfoResult = [[LRUserInfoResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(userInfoResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)thirdBindWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:USER_THIRDBIND_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)uploadPushTokenWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:USER_UPLOAD_TOKEN_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)thirdInfoWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:USER_THIRD_INFO_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:USER_GET_CAPTCHA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)checkRegisterWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure
{
    
    [[TTNetworkManager sharedInstance] getWithUrl: CHECK_USER_ISREG_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}


@end
