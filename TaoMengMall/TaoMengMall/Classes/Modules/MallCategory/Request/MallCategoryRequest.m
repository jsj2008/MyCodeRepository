//
//  MallCategoryRequest.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/9.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MallCategoryRequest.h"
#define MC_CATEGORY_LIST_URL         @"/mall_wall_siftwall"

@implementation MallCategoryRequest
+ (void)getMCCategoryDataWithParams:(NSDictionary *)params success:(void (^)(MCCategoryResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:MC_CATEGORY_LIST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MCCategoryResultModel *categoryResult = [[MCCategoryResultModel alloc] initWithDictionary:result error:&err];
        
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
