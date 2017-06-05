//
//  SDUserDetail.m
//  SD
//
//  Created by 余艾星 on 17/3/3.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDUserVerifyDetail.h"
#import "SDUserInfo.h"

@implementation SDUserVerifyDetail

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)userVerifyDetailWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (void)getUserVerifyDetailFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           @"userId":user.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/detail/userStatic";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        FDLog(@"认证状态 - %@",dict);
        
        SDUserVerifyDetail *userVerifyDetail = [SDUserVerifyDetail userVerifyDetailWithDict:dict];
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(userVerifyDetail);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
}

@end







