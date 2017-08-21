//
//  MallHomeRequest.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MallHomeRequest.h"

#define GET_HOME_DATA_REQUEST_URL                              @"/mall_index"
#define GET_CATEGORY_DATA_REQUEST_URL                              @"/mall_category"

@implementation MallHomeRequest
+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_HOME_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MHResultModel *mineResult = [[MHResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(mineResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getCategoryDataWithParams:(NSDictionary *)params success:(void(^)(MHResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
    [[TTNetworkManager sharedInstance] getWithUrl:GET_CATEGORY_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MHResultModel *mineResult = [[MHResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(mineResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}
@end
