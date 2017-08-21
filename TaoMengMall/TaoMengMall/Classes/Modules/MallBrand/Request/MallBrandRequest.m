//
//  MallBrandRequest.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/9.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MallBrandRequest.h"

#define MALLBRAND_OVERSSEA_REQUEST      @""

#define MALLBRAND_OVERSSEA_DETAIL_REQUEST      @""
@implementation MallBrandRequest

+ (void)getOversseaDataWithParams:(NSDictionary *)params success:(void (^)(MBOversseaResulModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:MALLBRAND_OVERSSEA_REQUEST parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MBOversseaResulModel *categoryResult = [[MBOversseaResulModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(categoryResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getOverseaDetailDataWithParams:(NSDictionary *)params success:(void (^)(MBOSDetailResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:MALLBRAND_OVERSSEA_DETAIL_REQUEST parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MBOSDetailResultModel *categoryResult = [[MBOSDetailResultModel alloc] initWithDictionary:result error:&err];
        
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
