//
//  CustomerPromoteRequest.h
//  CarKeeper
//
//  Created by marco on 3/8/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

#import "DSCustomerPromoteResultModel.h"
#import "DSCustomerListResultModel.h"

@interface CustomerPromoteRequest : BaseRequest

#pragma mark - Customer Promote
+ (void)getCustomerPromoteDataWithParams:(NSDictionary *)params success:(void(^)(DSCustomerPromoteResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCustomerCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)inviteCustomerWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getCustomerListWithParams:(NSDictionary *)params success:(void(^)(DSCustomerListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
