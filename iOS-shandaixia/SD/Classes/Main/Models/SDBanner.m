//
//  SDBanner.m
//  SD
//
//  Created by 余艾星 on 17/3/9.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDBanner.h"

@implementation SDBanner

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)bannerWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (void)bannerFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{
                           @"type":@"2"
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/banner/bannerInfo" finishedBlock:^(id object) {
        
        FDLog(@"data - %@,msg - %@",object[@"data"],object[@"msg"]);
        
        NSArray *array = object[@"data"];
        
        NSMutableArray *model = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            SDBanner *spec = [SDBanner bannerWithDict:dict];
            [model addObject:spec];
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




