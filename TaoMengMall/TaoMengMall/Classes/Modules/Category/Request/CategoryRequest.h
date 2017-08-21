//
//  CategoryRequest.h
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "CategoryResultModel.h"

@interface CategoryRequest : BaseRequest

+ (void)getCategoryDataWithParams:(NSDictionary *)params success:(void(^)(CategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCategoryMoreDataWithParams:(NSDictionary *)params success:(void(^)(CategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
