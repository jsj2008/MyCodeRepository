//
//  CartRequest.h
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"
#import "CartResultModel.h"
#import "CartSubmitResultModel.h"
#import "CTTotalPriceResultModel.h"

@interface CartRequest : BaseRequest

+ (void)getCartDataWithParams:(NSDictionary *)params success:(void(^)(CartResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCartSubmitDataWithParams:(NSDictionary *)params success:(void(^)(CartSubmitResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)addToCartWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)amountChangeWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;

+ (void)getTotalPriceWithParams:(NSDictionary *)params success:(void(^)(CTTotalPriceResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)clearInvalidItemWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure;
@end
