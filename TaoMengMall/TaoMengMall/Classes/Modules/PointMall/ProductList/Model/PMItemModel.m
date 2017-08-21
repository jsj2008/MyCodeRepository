//
//  PMItemModel.m
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import "PMItemModel.h"

@implementation PMItemModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"ar"] ||[propertyName isEqualToString:@"isEnd"]) {
        return YES;
    }
    return NO;
}
@end
