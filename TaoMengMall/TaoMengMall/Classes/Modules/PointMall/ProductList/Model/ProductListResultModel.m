//
//  CategoryResultModel.m
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ProductListResultModel.h"

@implementation ProductListResultModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"isEnd"]) {
        return YES;
    }
    return NO;
}


@end
