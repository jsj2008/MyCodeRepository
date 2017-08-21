//
//  CategoryRequest.m
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CategoryRequest.h"

#define CATEGORY_REQUEST_URL                             @"/mall_wall_catewall"
#define CATEGORY_MORE_REQUEST_URL                        @"/mall_wall_catewall/more"

@implementation CategoryRequest

+ (void)getCategoryDataWithParams:(NSDictionary *)params success:(void(^)(CategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CATEGORY_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        CategoryResultModel *categoryResult = [[CategoryResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(categoryResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getCategoryMoreDataWithParams:(NSDictionary *)params success:(void(^)(CategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CATEGORY_MORE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        CategoryResultModel *categoryResult = [[CategoryResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(categoryResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

@end
