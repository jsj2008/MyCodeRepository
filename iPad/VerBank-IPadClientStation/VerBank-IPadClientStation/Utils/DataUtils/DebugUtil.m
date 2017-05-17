//
//  DebugUtil.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/16.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "DebugUtil.h"

@implementation DebugUtil

+ (void)printCGRect:(CGRect)rect withSign:(NSString *)sign{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    NSLog(@"%@ .. x : %f; y : %f; w : %f; h : %f;", sign, x, y, width, height);
}

@end
