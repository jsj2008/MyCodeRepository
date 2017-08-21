//
//  VersionRequest.h
//  ZhenBaoHui
//
//  Created by marco on 8/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseRequest.h"
#import "VersionResultModel.h"

@interface VersionRequest : BaseRequest


+ (void)getVersionWithParams:(NSDictionary *)params success:(void(^)(VersionResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


@end
