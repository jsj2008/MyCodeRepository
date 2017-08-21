//
//  ODSkuInfoModel.m
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ODSkuInfoModel.h"

@implementation ODSkuInfoModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"refundStatus"] ) {
        return YES;
    }
    return NO;
}

@end
