//
//  CIDetailContentModel.m
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "CIDetailContentModel.h"

@implementation CIDetailContentModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ar"]) {
        return YES;
    }
    return NO;
}
@end
