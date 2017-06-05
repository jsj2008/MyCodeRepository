//
//  SDMyLoan.m
//  SD
//
//  Created by 余艾星 on 17/3/2.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDMyLoan.h"
#import "SDUserInfo.h"

@implementation SDMyLoan


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)myLoanWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
    
}


//我的借款（/order/borrowing）
+ (void)getMyLoanfinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":user.ID
                           
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/order/borrowing";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSArray *array = object[@"data"];
        
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            SDMyLoan *myLoan = [SDMyLoan myLoanWithDict:dict];
            [model addObject:myLoan];
            
            FDLog(@"myLoan - %@",dict);
            
            
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
