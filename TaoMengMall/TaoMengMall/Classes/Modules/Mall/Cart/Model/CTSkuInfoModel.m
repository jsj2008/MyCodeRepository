//
//  CTSkuInfoModel.m
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CTSkuInfoModel.h"

@implementation CTSkuInfoModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"quantity"] ) {
        return YES;
    }
    return NO;
}

@end
