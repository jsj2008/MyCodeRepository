//
//  WithdrawRequest.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSWithdrawHomeResultModel.h"
#import "DSWithdrawHistoryResultModel.h"
#import "DSWithdrawDetailResultModel.h"

@interface WithdrawRequest : BaseRequest

+ (void)getWithdrawHomeDataWithParams:(NSDictionary *)params success:(void(^)(DSWithdrawHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getAccountCaptchaWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)bindAccountWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)applyWithdrawWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getWithdrawHistoryWithParams:(NSDictionary *)params success:(void(^)(DSWithdrawHistoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getWithdrawDetailWithParams:(NSDictionary *)params success:(void(^)(DSWithdrawDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
