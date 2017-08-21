//
//  CashierResultModel.m
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CashierResultModel.h"

@implementation CashierResultModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"totalDeposit"]||[propertyName isEqualToString:@"showWeiXin"]) {
        return YES;
    }
    return NO;
}
@end
