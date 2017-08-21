//
//  ReviewsRequest.m
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "ReviewsRequest.h"

//获取评价sku信息
#define REVIEW_REQUEST_URL                            @"/mall_comment/ready"

//发表评价
#define REVIEW_SUBMIT_REQUEST_URL                     @"/mall_comment/publish"

@implementation ReviewsRequest

+ (void)getReviewDataWithParams:(NSDictionary *)params success:(void(^)(ReviewResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:REVIEW_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ReviewResultModel *reviewResult = [[ReviewResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(reviewResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}


+ (void)submitReviewWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postWithUrl:REVIEW_SUBMIT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
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
