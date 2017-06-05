//
//  SDLoan.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/25.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoan.h"
#import "SDUserInfo.h"
#import "SDSpecialDiscount.h"
#import "BqsDeviceFingerPrinting.h"
#import "FMDeviceManager.h"

@implementation SDLoan

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)loanWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

//添加订单，借款（/order/addOrder）
+ (void)updateLoan:(SDLoan *)loan specialDisCount:(SDSpecialDiscount *)specialDisCount finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    [SVProgressHUD showWithStatus:@"正在提交借款"];

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
//    loan.price = loan.price/100;
    
    loan.refund = @(loan.price + [loan.charge floatValue] - specialDisCount.discountAmount);
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    NSDictionary *dict = @{
                           @"userId":user.ID,
                           @"cardId":loan.cardId,
                           @"borrowingAmount":[NSString stringWithFormat:@"%@",@(loan.price + [loan.charge floatValue])],
                           @"applyNper":[NSString stringWithFormat:@"%@",loan.day],
                           @"poundageAmount":[NSString stringWithFormat:@"%@",loan.charge],
                           @"preferentialAmount":[NSString stringWithFormat:@"%@",loan.discount],
                           @"actualReimAmount":[NSString stringWithFormat:@"%@",loan.refund],
                           @"actualAccountAmount":[NSString stringWithFormat:@"%@",@(loan.price)],
                           @"tongdunKey":[FMDeviceManager sharedManager]->getDeviceInfo(),
                           @"tokenKey":[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] getTokenKey],
                           @"platform":@"ios"
                           
                           };
    
    [mutableDict addEntriesFromDictionary:dict];
    
    if (specialDisCount) {
        
        [mutableDict setObject:specialDisCount.ID forKey:@"discountId"];
        
        [mutableDict setObject:[NSString stringWithFormat:@"%@",@(specialDisCount.discountAmount)] forKey:@"preferentialAmount"];
    }
    
    
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:mutableDict];
    
    NSString *urlString = @"/order/addOrder";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        if ([object[@"msg"] isEqualToString:@"成功"]) {
            
            [FDReminderView showWithString:@"提交申请成功"];
            
        }else{
        
            [object[@"msg"] showNotice];
        }
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(object);
            
        }
        
    } parameters:mutableDict failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
    
}

+ (void)updateLoan:(SDLoan *)loan specialDIscount:(SDSpecialDiscount *)specialDisCount signid:(NSString *)signid isBestsign:(NSNumber *)isBestsign finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock {
    [SVProgressHUD showWithStatus:@"正在提交借款"];
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    //    loan.price = loan.price/100;
    
    loan.refund = @(loan.price + [loan.charge floatValue] - specialDisCount.discountAmount);
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    NSDictionary *dict = @{
                           @"userId":user.ID,
                           @"cardId":loan.cardId,
                           @"borrowingAmount":[NSString stringWithFormat:@"%@",@(loan.price + [loan.charge floatValue])],
                           @"applyNper":[NSString stringWithFormat:@"%@",loan.day],
                           @"poundageAmount":[NSString stringWithFormat:@"%@",loan.charge],
                           @"preferentialAmount":[NSString stringWithFormat:@"%@",loan.discount],
                           @"actualReimAmount":[NSString stringWithFormat:@"%@",loan.refund],
                           @"actualAccountAmount":[NSString stringWithFormat:@"%@",@(loan.price)],
                           @"tongdunKey":[FMDeviceManager sharedManager]->getDeviceInfo(),
                           @"tokenKey":[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] getTokenKey],
                           @"platform":@"ios",
                           @"isBestsign":[NSString stringWithFormat:@"%@", @(isBestsign.intValue)],
                           @"signid":signid
                           
                           };
    
    [mutableDict addEntriesFromDictionary:dict];
    
    if (specialDisCount) {
        
        [mutableDict setObject:specialDisCount.ID forKey:@"discountId"];
        
        [mutableDict setObject:[NSString stringWithFormat:@"%@",@(specialDisCount.discountAmount)] forKey:@"preferentialAmount"];
    }
    
    
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:mutableDict];
    
    NSString *urlString = @"/order/addOrder";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        if ([object[@"msg"] isEqualToString:@"成功"]) {
            
            [FDReminderView showWithString:@"提交申请成功"];
            
        }else{
            
            [object[@"msg"] showNotice];
        }
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(object);
            
        }
        
    } parameters:mutableDict failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
}

@end

















