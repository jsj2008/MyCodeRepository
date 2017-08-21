//
//  ItemRequest.h
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "ItemResultModel.h"
#import "ITSupportContactResultModel.h"

@interface ItemRequest : BaseRequest

+ (void)getItemDataWithParams:(NSDictionary *)params success:(void(^)(ItemResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)followWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)unfollowWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getSupportContactWithParams:(NSDictionary *)params success:(void(^)(ITSupportContactResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
