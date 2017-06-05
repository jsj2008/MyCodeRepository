//
//  SDProvince.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDProvince.h"
#import "SDCity.h"

@implementation SDProvince

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *specModel = [NSMutableArray array];
        for (NSDictionary *dict in self.list) {
            
            SDCity *spec = [SDCity cityWithDict:dict];
            [specModel addObject:spec];
        }
        
        self.list = specModel;
    }
    
    return self;
}

+ (instancetype)provinceWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (void)getProvinceWithType:(NSString *)type finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{
                           @"channelType":type
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/loanAndSocial/intProvinceCity" finishedBlock:^(id object) {
        
        NSArray *array = object[@"data"];
        
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            SDProvince *spec = [SDProvince provinceWithDict:dict];
            [model addObject:spec];
        }
        
        FDLog(@"province - %@",model);
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(model);
            
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
    
    
}

@end
