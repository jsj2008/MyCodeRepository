//
//  SDLeftNavBar.m
//  SD
//
//  Created by 余艾星 on 17/3/23.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDLeftNavBar.h"
#import "SDUserInfo.h"

@implementation SDLeftNavBar



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
    
}


//导航信息（/user/navbar）
+ (void)leftNavBarFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":userInfo.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/user/navbar" finishedBlock:^(id object) {
        
        
        FDLog(@"data - %@,msg - %@",object[@"data"],object[@"msg"]);
        
        SDLeftNavBar *spec = [SDLeftNavBar discountWithDict:object[@"data"]];
        
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(spec);
            
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
