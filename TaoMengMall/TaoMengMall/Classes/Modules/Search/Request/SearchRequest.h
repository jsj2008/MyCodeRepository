//
//  SearchRequest.h
//  YouCai
//
//  Created by marco on 5/18/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseRequest.h"
#import "SearchResultModel.h"
#import "MallResultModel.h"

@interface SearchRequest : BaseRequest

+ (void)getSearchDataWithParams:(NSDictionary *)params success:(void(^)(SearchResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getSearchMoreDataWithParams:(NSDictionary *)params success:(void(^)(SearchResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getHotTagsWithParams:(NSDictionary *)params success:(void(^)(NSArray *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getMallSearchDataWithParams:(NSDictionary *)params success:(void(^)(MallResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;
@end
