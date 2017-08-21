//
//  MHHeaderTitleModel.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHHeaderTitleModel.h"

@implementation MHHeaderTitleModel
+ (BOOL)propertyIsIgnored:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"bold"]) {
        return YES;
    }
    return NO;
}
@end
