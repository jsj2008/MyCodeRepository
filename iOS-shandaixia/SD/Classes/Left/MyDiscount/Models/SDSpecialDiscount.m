//
//  SDSpecialDiscount.m
//  SD
//
//  Created by 余艾星 on 17/3/14.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDSpecialDiscount.h"
#import "SDUserInfo.h"
#import "SDLoan.h"

@implementation SDSpecialDiscount


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)specialDiscountWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
}

//@"/discount/availableDiscount"
+ (void)specialDiscountWithLoan:(SDLoan *)loan finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":userInfo.ID,
                           @"cycle":[NSString stringWithFormat:@"%@",loan.day],
                           @"amount":[NSString stringWithFormat:@"%@",@(loan.price)]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/discount/availableDiscount" finishedBlock:^(id object) {
        
        
        FDLog(@"data - %@,msg - %@",object[@"data"],object[@"msg"]);
        
        NSArray *array = object[@"data"];
        
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            SDSpecialDiscount *spec = [SDSpecialDiscount specialDiscountWithDict:dict];
            [model addObject:spec];
            
            FDLog(@"dict - %@",dict);
        }
        
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(model);
            
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        
        FDLog(@"failuredBlock - msg - %@",object);
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
    
}


@end
