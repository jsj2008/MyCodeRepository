//
//  DistributorPromoteRequest.h
//  CarKeeper
//
//  Created by marco on 3/8/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseRequest.h"

#import "DSDistributorPromoteResultModel.h"
#import "DSDistributorListResultModel.h"


@interface DistributorPromoteRequest : BaseRequest

#pragma mark - Distributor Promote
+ (void)getDistributorPromoteDataWithParams:(NSDictionary *)params success:(void(^)(DSDistributorPromoteResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getDistributorCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)inviteDistributorWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getDistributorListWithParams:(NSDictionary *)params success:(void(^)(DSDistributorListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
