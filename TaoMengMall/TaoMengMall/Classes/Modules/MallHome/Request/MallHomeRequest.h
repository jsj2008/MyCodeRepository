//
//  MallHomeRequest.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MHResultModel.h"

@interface MallHomeRequest : BaseRequest
+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCategoryDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
