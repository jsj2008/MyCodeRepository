//
//  ConsigneeRequest.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ConsigneeRequest.h"

#define CONSIGNEE_REQUEST_URL                       @"/mall_consignee"
#define CONSIGNEE_ADD_REQUEST_URL                   @"/mall_consignee/add"
#define CONSIGNEE_EDIT_REQUEST_URL                  @"/mall_consignee/edit"
#define CONSIGNEE_LIST_REQUEST_URL                  @"/mall_consignee/list"
#define CONSIGNEE_LIST_MORE_REQUEST_URL             @"/mall_consignee"
#define CONSIGNEE_DEFAULT_REQUEST_URL               @"/mall_consignee/setdefault"
#define CONSIGNEE_DELETE_REQUEST_URL                @"/mall_consignee/delete"

#define CONSIGNEE_REGION_REQUEST_UR                 @"/utils_region"

@implementation ConsigneeRequest

+ (void)addConsigneeWithParams:(NSDictionary *)params success:(void(^)(ConsigneeAddResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CONSIGNEE_ADD_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ConsigneeAddResultModel *consigneeAddResult = [[ConsigneeAddResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(consigneeAddResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)editConsigneeWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CONSIGNEE_EDIT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getConsigneeWithParams:(NSDictionary *)params success:(void(^)(ConsigneeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CONSIGNEE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ConsigneeResultModel *consigneeResult = [[ConsigneeResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(consigneeResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getConsigneeListWithParams:(NSDictionary *)params success:(void(^)(ConsigneeListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CONSIGNEE_LIST_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ConsigneeListResultModel *consigneeListResult = [[ConsigneeListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(consigneeListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getConsigneeListMoreWithParams:(NSDictionary *)params success:(void(^)(ConsigneeListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CONSIGNEE_LIST_MORE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ConsigneeListResultModel *consigneeListResult = [[ConsigneeListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(consigneeListResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)setDefaultWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CONSIGNEE_DEFAULT_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)deleteWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CONSIGNEE_DELETE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}


+ (void)getRegionWithParams:(NSDictionary *)params success:(void(^)(CityListModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:CONSIGNEE_REGION_REQUEST_UR parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        CityListModel *citysResult = [[CityListModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(citysResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}
@end
