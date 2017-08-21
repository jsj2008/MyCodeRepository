//
//  MineRequest.h
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"

#import "MineResultModel.h"
#import "MIChangeAvatarResultModel.h"
#import "VipResultModel.h"


@interface MineRequest : BaseRequest

+ (void)getMineDataWithParams:(NSDictionary *)params success:(void(^)(MineResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)changeAvatarWithParams:(NSDictionary *)params image:(UIImage *)image success:(void(^)(MIChangeAvatarResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)changeNameWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)changeGenderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getVipDataWithParams:(NSDictionary *)params success:(void(^)(VipResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)becomeMemberWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;
@end
