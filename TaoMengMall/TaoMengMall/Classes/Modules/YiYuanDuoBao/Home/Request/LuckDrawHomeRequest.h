//
//  HomeRequest.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LuckDrawHomeResultModel.h"

@interface LuckDrawHomeRequest : BaseRequest

+ (void)getHomeDataWithParams:(NSMutableDictionary *)params success:(void(^)(LuckDrawHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


//+ (void)getHomeLatestDataWithParams:(NSDictionary *)params success:(void(^)(HomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
//+ (void)getHomeProgressDataWithParams:(NSDictionary *)params success:(void(^)(HomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
