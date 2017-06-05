//
//  SDRefundOrder.m
//  SD
//
//  Created by 余艾星 on 17/3/13.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDRefundOrder.h"

@implementation SDRefundOrder

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}

+ (instancetype)refundOrderWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}


@end
