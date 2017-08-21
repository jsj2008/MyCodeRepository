//
//  HomeRequest.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckDrawHomeRequest.h"

#define GET_HOME_DATA_REQUEST_URL                              @"/index/index"
#define GET_HOME_PROGRESS_DATA_REQUEST_URL                     @"/index/progress"
#define GET_HOME_LATEST_DATA_REQUEST_URL                       @"/index/latest"


@implementation LuckDrawHomeRequest

+ (void)getHomeDataWithParams:(NSMutableDictionary *)params success:(void(^)(LuckDrawHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    NSInteger type = [[params objectForKey:@"type"] integerValue];
    NSString *url = nil;
    if (type == 0) {
        url = GET_HOME_DATA_REQUEST_URL;
    }else if (type == 1) {
        url = GET_HOME_PROGRESS_DATA_REQUEST_URL;
    }else if (type == 2) {
        url = GET_HOME_LATEST_DATA_REQUEST_URL;
    }
    
    [params removeObjectForKey:@"type"];

    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        LuckDrawHomeResultModel *mineResult = [[LuckDrawHomeResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(mineResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

//+ (void)getHomeLatestDataWithParams:(NSDictionary *)params success:(void(^)(HomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
//    [[TTNetworkManager sharedInstance] getWithUrl:GET_HOME_LATEST_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//        
//        NSError *err = [[NSError alloc] init];
//        
//        HomeResultModel *mineResult = [[HomeResultModel alloc] initWithDictionary:result error:&err];
//        
//        if (success) {
//            success(mineResult);
//        }
//        
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//}
//
//+ (void)getHomeProgressDataWithParams:(NSDictionary *)params success:(void(^)(HomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure{
//    [[TTNetworkManager sharedInstance] getWithUrl:GET_HOME_PROGRESS_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
//        
//        NSError *err = [[NSError alloc] init];
//        
//        HomeResultModel *mineResult = [[HomeResultModel alloc] initWithDictionary:result error:&err];
//        
//        if (success) {
//            success(mineResult);
//        }
//        
//    } failure:^(StatusModel *status) {
//        if (failure) {
//            failure(status);
//        }
//    }];
//}
@end
