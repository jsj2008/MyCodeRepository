//
//  MHResultModel.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHModuleModel.h"

@implementation MHModuleModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"type"]) {
        return YES;
    }
    return NO;
}
@end
