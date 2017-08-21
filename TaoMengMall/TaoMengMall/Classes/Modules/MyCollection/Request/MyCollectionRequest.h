//
//  MyCollectionRequest.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MCItemResultModel.h"
#import "MCShopResultModel.h"
@interface MyCollectionRequest : BaseRequest

+ (void)getMyCollectionItemsDataWithParams:(NSDictionary *)params success:(void(^)(MCItemResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getMyCollectionShopsDataWithParams:(NSDictionary *)params success:(void(^)(MCShopResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)deleteCollectionItemsWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

@end
