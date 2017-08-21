//
//  CashierRequest.m
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CashierRequest.h"

//收银台
#define CASHIER_REQUEST_URL                          @"/pay_cashier"
#define POINT_CASHIER_REQUEST_URL                       @"/pay_cashier/point"

#define CASHIER_BALANCE_PAY_REQUEST_URL               @"/cashier/balancepay"

//阿里支付
#define CASHIER_ALIPAY_SIGN_URL                      @"/pay_cashier/alipaysign"

//微信支付[废弃]
#define CASHIER_WEIXIN_SIGN_URL                      @"/pay_cashier/wxpaysign"

//
#define CASHIER_ALIPAY_CALLBACK_URL                      @"/alipay/return"

#define CASHIER_WEIXIN_CALLBACK_URL                      @"/wechatpay/return"

@implementation CashierRequest

+ (void)getCashierDataWithParams:(NSDictionary *)params success:(void(^)(CashierResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CASHIER_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        CashierResultModel *cashierResult = [[CashierResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(cashierResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)balancePayWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CASHIER_BALANCE_PAY_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getAlipaySignWithParams:(NSDictionary *)params success:(void(^)(ThirdPayResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CASHIER_ALIPAY_SIGN_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ThirdPayResultModel *signResult = [[ThirdPayResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(signResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getWeixinSignWithParams:(NSDictionary *)params success:(void(^)(ThirdPayResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:CASHIER_WEIXIN_SIGN_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        WexinResultModel *signResult = [[WexinResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(signResult.sign);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)wxpayCallbackSignWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CASHIER_WEIXIN_CALLBACK_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)alipayCallbackSignWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:CASHIER_ALIPAY_CALLBACK_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}

+ (void)getPointCashierDataWithParams:(NSDictionary *)params success:(void(^)(CashierResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:POINT_CASHIER_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        CashierResultModel *cashierResult = [[CashierResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(cashierResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

@end
