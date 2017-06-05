//
//  SDUserCenter.m
//  SD
//
//  Created by 余艾星 on 17/3/6.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDUserCenter.h"
#import "SDUserInfo.h"

@implementation SDUserCenter

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)userCenterWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}


+ (void)getUserCenterFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           @"userId":user.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/detail/personageCentre";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        SDUserCenter *userCenter = [SDUserCenter userCenterWithDict:dict];
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(userCenter);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
}

@end















