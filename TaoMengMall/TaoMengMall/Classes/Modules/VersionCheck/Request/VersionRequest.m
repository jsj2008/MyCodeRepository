//
//  VersionRequest.m
//  ZhenBaoHui
//
//  Created by marco on 8/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "VersionRequest.h"

#define VERSION_CHECK_REQUEST_URL           @"/version"

@implementation VersionRequest

+ (void)getVersionWithParams:(NSDictionary *)params success:(void(^)(VersionResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:VERSION_CHECK_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        VersionResultModel *versionResult = [[VersionResultModel alloc] initWithDictionary:result error:nil];
        
        if (success) {
            success(versionResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}
@end
