//
//  MallBrandRequest.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/9.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MBOversseaResulModel.h"
#import "MBOSDetailResultModel.h"


@interface MallBrandRequest : BaseRequest

+ (void)getOversseaDataWithParams:(NSDictionary *)params success:(void(^)(MBOversseaResulModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getOverseaDetailDataWithParams:(NSDictionary *)params success:(void(^)(MBOSDetailResultModel*))success failure:(void(^)(StatusModel *status))failure;

@end
