//
//  ItemRequest.h
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "CIItemResultModel.h"
#import "CIPayResultModel.h"
#import "CIPrizeDetailResultModel.h"

@interface CIItemRequest : BaseRequest

+ (void)getItemDataWithParams:(NSDictionary *)params success:(void(^)(CIItemResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)buyItemWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *result))success failure:(void(^)(StatusModel *status))failure;

+ (void)getPayResultDataWithParams:(NSDictionary *)params success:(void(^)(CIPayResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getPrizeDetailWithParams:(NSDictionary *)params success:(void(^)(CIPrizeDetailResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
