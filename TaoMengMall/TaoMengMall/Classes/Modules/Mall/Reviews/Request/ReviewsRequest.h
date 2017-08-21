//
//  ReviewsRequest.h
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "ReviewResultModel.h"

@interface ReviewsRequest : BaseRequest


+ (void)getReviewDataWithParams:(NSDictionary *)params success:(void(^)(ReviewResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


+ (void)submitReviewWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

@end
