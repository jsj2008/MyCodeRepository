//
//  SDShared.m
//  SD
//
//  Created by 余艾星 on 17/3/2.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDShared.h"
#import "SDUserInfo.h"

@implementation SDShared

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)sharedWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (void)getSharedfinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           @"userId":user.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/share/userShare";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSArray *array = object[@"data"];
        
        NSMutableArray *model = [NSMutableArray array];
        
        if (array.count) {
            
            
            for (NSDictionary *dict in array) {
                
                SDShared *spec = [SDShared sharedWithDict:dict];
                [model addObject:spec];
                
                FDLog(@"/share/userShare - %@",dict);
            }
            
        }
        
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
