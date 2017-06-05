//
//  SDLending.m
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDLending.h"
#import "SDUserInfo.h"
#import "SDBankCard.h"
#import "SDRefundOrder.h"

#define oid_partner @"201608101001022519"
#define MD5key @"201608101001022519_test_20160810"
#define sign_type @""

@implementation SDLending

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)lendingWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

//35、用户还款订单状态查询（/order/orderStatus）
+ (void)lendingFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           @"userId":user.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    
    [manager setManeger:manager dict:dict];
    
    FDLog(@"/order/orderStatus - userId - %@",user.ID);
    
    [manager postWithURLString:@"/order/orderStatus" finishedBlock:^(id object) {
        
        
        NSDictionary *dict = object[@"data"];
        
        
        SDLending *notice = [SDLending lendingWithDict:dict];
        
        NSLog(@"/order/orderStatus - %@",object);
        
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(notice);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
    
}

//36、更新状态（/order/showStatus）

+ (void)updateLendingStatus:(SDLending *)lending finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    
    NSDictionary *dict = @{
                           @"orderId":lending.orderId,
                           @"status":[NSString stringWithFormat:@"%@",@(lending.status)]
                           };
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/order/showStatus" finishedBlock:^(id object) {
        
        FDLog(@"/order/showStatus - %@",object[@"msg"]);
        
        if (finishedBlock) {
            
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

//34、还款（/order/reimbursement）
+ (void)refundWithLending:(SDLending *)lending refund:(NSString *)refund bankCard:(SDBankCard *)bankcard verifyCode:(NSString *)verifyCode refundOrder:(SDRefundOrder *)refundOrder finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSString *time;
    
    if (refundOrder.txnTime) {
        
        time = [NSString stringWithFormat:@"%@",refundOrder.txnTime];
    }else{
    
        time = @"";
    }
    
    NSString *numberId;
    if (refundOrder.merOrderNo) {
        
        numberId = [NSString stringWithFormat:@"%@",refundOrder.merOrderNo];
    }else{
    
        numberId = @"";
    }
    
    
    
    NSDictionary *dict = @{
                           @"userId":user.ID,//用户id
                           @"cardId":bankcard.ID,//银行卡id
                           @"hasAlsoAmount":refund,//借款金额
                           @"orderId":lending.orderId,//orderId
                           @"merOrderNo":numberId,//商户订单号
                           @"txnTime":time//返回的交易时间
                           
                           
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    
    
    NSString *urlString = @"/order/reimbursement";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSString *str = object[@"msg"];
        
        FDLog(@"还款 - %@",str);
        
        if ([str containsString:@"成功"]) {
            
//            [FDReminderView showWithString:@"还款成功"];
            
        }else{
            
            [FDReminderView showWithString:object[@"msg"]];
        }
        
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

//33、用户还款验证短信（/order/sms）
+ (void)getRefundVerifyCode:(SDBankCard *)bankcard money:(NSString *)money finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           @"userId":user.ID,//用户id
                           @"cardId":bankcard.ID,//银行卡id
                           @"hasAlsoAmount":money//借款金额
                           
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/order/sms";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        SDRefundOrder *refund = [SDRefundOrder refundOrderWithDict:dict];
        
        FDLog(@"/order/sms - %@,txnTime - %@",dict,dict[@"txnTime"]);
        
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(refund);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
    
}

//连连支付还款请求所需参数（/lianlianPay/cardBindingPara）

+ (void)llRefundInfoWith:(SDLending *)lending bankCard:(SDBankCard *)bankcard finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    
    
    NSDictionary *dict = @{
                           @"userId":user.ID,//用户id
                           @"cardNo":bankcard.cardNumber,//银行卡id
                           @"moneyOrder":[NSString stringWithFormat:@"%@",lending.stillAmount]//借款金额
                           
                           
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/lianlianPay/cardBindingParat";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSString *str = object[@"msg"];
        
        FDLog(@"还款 - %@",str);
        
        if ([str containsString:@"成功"]) {
            
            [FDReminderView showWithString:@"还款成功"];
            
        }else{
            
            [FDReminderView showWithString:object[@"msg"]];
        }
        
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
