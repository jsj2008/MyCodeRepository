//
//  ITDetailContentModel.m
//  YouCai
//
//  Created by marco on 5/28/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "ITDetailContentModel.h"

@implementation ITDetailContentModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ( [@"ar" isEqualToString:propertyName]) {
        return YES;
    }
    return NO;
}

@end
