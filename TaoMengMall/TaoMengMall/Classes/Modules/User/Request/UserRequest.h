//
//  UserRequest.h
//  HongBao
//
//  Created by Ivan on 16/3/5.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "LRUserInfoResultModel.h"


@interface UserRequest : BaseRequest

//登录注册相关
+ (void)loginWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)thirdLoginWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


+ (void)registerWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)thirdBindingWithParams:(NSDictionary *)params success:(void(^)(LRUserInfoResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)thirdBindWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;
+ (void)thirdInfoWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;

+ (void)uploadPushTokenWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;


+ (void)checkRegisterWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;

@end
