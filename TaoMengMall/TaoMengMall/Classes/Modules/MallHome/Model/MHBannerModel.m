//
//  MHBannerModel.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHBannerModel.h"

@implementation MHBannerModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"ar"]) {
        return YES;
    }
    return NO;
}


@end
