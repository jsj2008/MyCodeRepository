//
//  ShopRequest.h
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "ShopResultModel.h"
#import "ShopFollowResultModel.h"

@interface ShopRequest : BaseRequest

+ (void)getShopDataWithParams:(NSDictionary *)params success:(void(^)(ShopResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getShopMoreDataWithParams:(NSDictionary *)params success:(void(^)(ShopResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)followWithParams:(NSDictionary *)params success:(void(^)(ShopFollowResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)(ShopFollowResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
