//
//  SDMyLoanDetail.m
//  SD
//
//  Created by 余艾星 on 17/3/6.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDMyLoanDetail.h"

@implementation SDMyLoanDetail


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)myLoanDetailWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
    
}


//我的借款（/order/borrowing）
+ (void)getMyLoanOrderId:(NSString *)orderId detailfinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    NSDictionary *dict = @{@"orderId":orderId
                           
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/order/orderInfo";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        SDMyLoanDetail *myLoan = [SDMyLoanDetail myLoanDetailWithDict:dict];
        
        FDLog(@"data - %@",object[@"data"]);
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(myLoan);
            
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
    
}

+ (void)getMyProtocolOrderId:(NSString *)orderId
         detailfinishedBlock:(FinishedBlock)finishedBlock
               failuredBlock:(FailuredBlock)failuredBlock {
    NSDictionary *dict = @{
                           @"orderId":orderId
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/bestsign/findContractByOrderId";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
//        NSDictionary *dict = object[@"data"];
//        NSString *url = dict[@"contractUrl"];
        
//        FDLog(@"contractUrl - %@",dict[@"contractUrl"]);
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(object);
            
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
}


@end
