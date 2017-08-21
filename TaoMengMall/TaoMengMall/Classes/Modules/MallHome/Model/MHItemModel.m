//
//  MHItemModel.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHItemModel.h"

@implementation MHItemModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"ar"]) {
        return YES;
    }
    return NO;
}

-(float)ar{
    if (_ar == 0) {
        return 1;
    }
    return _ar;
}

@end
