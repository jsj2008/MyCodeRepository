//
//  ItemInfoModel.m
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ItemInfoModel.h"

@implementation ItemInfoModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ( [@"isFav" isEqualToString:propertyName]) {
        return YES;
    }
    return NO;
}
@end
