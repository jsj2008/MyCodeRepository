//
//  StreetSnapRequest.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "StreetSnapResultModel.h"

@interface StreetSnapRequest : BaseRequest

+ (void)getStreetSnapDataWithParams:(NSDictionary *)params success:(void(^)(StreetSnapResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;


@end
