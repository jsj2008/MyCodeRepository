//
//  MallCategoryRequest.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/9.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MCCategoryResultModel.h"

@interface MallCategoryRequest : BaseRequest

+ (void)getMCCategoryDataWithParams:(NSDictionary *)params success:(void(^)(MCCategoryResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
