//
//  RevenueRequest.m
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "RevenueRequest.h"

#pragma mark -Revenue
#define DS_REVENUE_HOME_URL                 @"/distribute_dashboard"

#define DS_UNAVAILABLE_SUM_URL             @"/distribute_dashboard/disable"

#define DS_RP_TOTAL_URL                     @"/distribute_bills"
#define DS_RP_BILLS_URL                     @"/distribute_bills/bill"
#define DS_RP_FACTORAGE_URL                 @"/distribute_bills/poundage"


#define DS_SETTLED_INCOMES_URL                 @"/distribute_incomes/settled"
#define DS_UNSETTLED_INCOMES_URL               @"/distribute_incomes/unsettled"

@implementation RevenueRequest


#pragma mark - Revenue
+ (void)getRevenueHomeDataWithParams:(NSDictionary *)params success:(void(^)(DSRevenueHomeResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_REVENUE_HOME_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSRevenueHomeResultModel *resultModel = [[DSRevenueHomeResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getUnavailableDataWithParams:(NSDictionary *)params success:(void(^)(DSUnavailableResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:DS_UNAVAILABLE_SUM_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSUnavailableResultModel *resultModel = [[DSUnavailableResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getSettlementDataWithParams:(NSMutableDictionary *)params success:(void(^)(DSSettlementResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    //内路由
    NSString *xxType = params[@"xxType"];
    NSString *url = nil;
    
    if ([xxType isEqualToString:@"1"]) {
        url = DS_UNSETTLED_INCOMES_URL;
    }else{
        url = DS_SETTLED_INCOMES_URL;
    }
    [params removeObjectForKey:@"xxType"];
    
    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSSettlementResultModel *resultModel = [[DSSettlementResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getReceiptPaymentDataWithParams:(NSMutableDictionary *)params success:(void(^)(DSReceiptPaymentResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    //内路由
    NSString *xxType = params[@"xxType"];
    NSString *url = nil;
    
    if ([xxType isEqualToString:@"1"]) {
        url = DS_RP_TOTAL_URL;
    }else if ([xxType isEqualToString:@"2"]){
        url = DS_RP_BILLS_URL;
    }else if ([xxType isEqualToString:@"3"]){
        url = DS_RP_FACTORAGE_URL;
    }
    [params removeObjectForKey:@"xxType"];
    
    [[TTNetworkManager sharedInstance] getWithUrl:url parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        DSReceiptPaymentResultModel *resultModel = [[DSReceiptPaymentResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(resultModel);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

@end
