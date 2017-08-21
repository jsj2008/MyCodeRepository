//
//  MCItemModel.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MCItemModel.h"

@implementation MCItemModel

+(BOOL)propertyIsIgnored:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"xxSelected"]) {
        return YES;
    }
    return NO;
}
@end
