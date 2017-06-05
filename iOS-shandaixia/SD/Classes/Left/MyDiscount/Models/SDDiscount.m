//
//  SDDiscount.m
//  SD
//
//  Created by 余艾星 on 17/3/9.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDDiscount.h"
#import "SDUserInfo.h"
#import "SDLoan.h"

@implementation SDDiscount

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)discountWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
}

+ (void)discountWithType:(NSString *)type finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":userInfo.ID,
                           @"type":type,
                           @"pageNo":@"1",
                           @"pageSize":@"100"
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/discount/discountInfo" finishedBlock:^(id object) {
        
        
        FDLog(@"data - %@,msg - %@",object[@"data"],object[@"msg"]);
        
        NSArray *array = object[@"data"];
        
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            SDDiscount *spec = [SDDiscount discountWithDict:dict];
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
