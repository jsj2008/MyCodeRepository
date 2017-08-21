//
//  SearchRequest.m
//  YouCai
//
//  Created by marco on 5/18/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "SearchRequest.h"

#define SEARCH_REQUEST_URL               @"/mall_search/item"
#define SEARCH_MORE_REQUEST_URL          @"/mall_search/item"
#define SEARCH_HOT_TAGS_REQUEST_URL      @"/mall_search/hottags"
#define POINT_SEARCH_REQUEST_URL  @"/pointmall_search"


@implementation SearchRequest

+ (void)getSearchDataWithParams:(NSDictionary *)params success:(void(^)(SearchResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:SEARCH_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        SearchResultModel *resultModel = [[SearchResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getSearchMoreDataWithParams:(NSDictionary *)params success:(void(^)(SearchResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:SEARCH_MORE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        SearchResultModel *resultModel = [[SearchResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getHotTagsWithParams:(NSDictionary *)params success:(void(^)(NSArray *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:SEARCH_HOT_TAGS_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success(result[@"hotTags"]);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getMallSearchDataWithParams:(NSDictionary *)params success:(void (^)(MallResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:POINT_SEARCH_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MallResultModel *pointdetaliResult = [[MallResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(pointdetaliResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
