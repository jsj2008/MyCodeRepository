//
//  feedsItemModel.m
//  BabyDaily
//
//  Created by bingo on 16/8/23.
//  Copyright © 2016年 marco. All rights reserved.
//

#import "LuckDrawHomeItemModel.h"

@implementation LuckDrawHomeItemModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"showBuy"]) {
        return YES;
    }
    return NO;
}
@end
