//
//  StreetSnapRequest.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "StreetSnapRequest.h"

#define STREETSNAP_LIST_REQUEST_URL     @""

@implementation StreetSnapRequest

+ (void)getStreetSnapDataWithParams:(NSDictionary *)params success:(void (^)(StreetSnapResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:STREETSNAP_LIST_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        StreetSnapResultModel *categoryResult = [[StreetSnapResultModel alloc] initWithDictionary:result error:&err];
        
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
