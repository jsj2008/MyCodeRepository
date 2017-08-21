//
//  CSPlatformCouponModel.m
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSPlatformCouponModel.h"

@implementation CSPlatformCouponModel


+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"selected"]) {
        return YES;
    }
    return NO;
}
@end
