//
//  MyCollectionRequest.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MyCollectionRequest.h"
#define MY_COLLECTION_ITEMS_URL         @"/mall_collection/item"
#define MY_COLLECTION_SHOPS_URL         @"/mall_collection/shop"
#define MY_COLLECTION_DELETE_ITEMS_URL  @"/mall_collection/itemdel"
@implementation MyCollectionRequest

+ (void)getMyCollectionItemsDataWithParams:(NSDictionary *)params success:(void (^)(MCItemResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:MY_COLLECTION_ITEMS_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MCItemResultModel *categoryResult = [[MCItemResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(categoryResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getMyCollectionShopsDataWithParams:(NSDictionary *)params success:(void (^)(MCShopResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:MY_COLLECTION_SHOPS_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MCShopResultModel *categoryResult = [[MCShopResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(categoryResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)deleteCollectionItemsWithParams:(NSDictionary *)params success:(void (^)())success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:MY_COLLECTION_DELETE_ITEMS_URL parameters:params success:^(NSDictionary *result) {
        
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
