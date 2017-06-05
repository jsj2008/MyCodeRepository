//
//  SDBankCard.m
//  SD
//
//  Created by 余艾星 on 17/2/24.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDBankCard.h"
#import "SDUserInfo.h"

@implementation SDBankCard

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)bankCardWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]){
        
        _ID = value;
    }
    
}

+ (void)bankCardInfoWithCardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    NSDictionary *dict = @{@"cardNumber":cardNumber
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bankCard/lianPaybankCardBin" finishedBlock:^(id object) {
        
        
        
        NSDictionary *dict = object[@"data"];
        
        NSString *str = object[@"msg"];
        
        SDBankCard *bankCard = [SDBankCard bankCardWithDict:dict];
        
        FDLog(@"bank data - %@,bankCard.name - %@",object[@"data"],bankCard.bankName);
        
        if (bankCard.bank.length) {
            
            if ([bankCard.cardType isEqualToString:@"CC"]) {
            
                [FDReminderView showWithString:@"暂不支持信用卡"];
            }
            
            bankCard.isDefault = 0;
            
        }else{
            
            
            if (str.length) {
                
                [FDReminderView showWithString:str];
            }else{
            
                [FDReminderView showWithString:@"卡号输入有误"];
            }
            
            
            
        }
        
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(bankCard);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
    
    
}

+ (void)addBankCard:(SDBankCard *)bankCard verifyCode:(NSString *)verifyCode finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    FDLog(@"user.ID- %@,bankCard.cardNumber - %@,bankCard.bankName - %@,bankCard.bank - %@,bankCard.cardType - %@",user.ID,bankCard.cardNumber,bankCard.bankName,bankCard.bank,bankCard.cardType);
    
    NSString *isDefault;
    
    if (bankCard.isDefault) {
        
        isDefault = @"1";
    }else{
    
        isDefault = @"0";
    }
    NSDictionary *dict = @{@"userId":user.ID,
                           @"cardNumber":bankCard.cardNumber,
                           @"bankName":bankCard.bankName,
                           @"bank":bankCard.bank,
                           @"cardType":bankCard.cardType,
                           @"phone":[FDUserDefaults objectForKey:FDUserAccount],
                           @"verifCode":verifyCode,
                           @"isDefault":isDefault
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bankCard/addBankCard" finishedBlock:^(id object) {
        
        
        
        FDLog(@"msg - %@",object[@"msg"]);
        
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

+ (void)findBankCardFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":user.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bankCard/findBankCard" finishedBlock:^(id object) {
        
        
        NSArray *array = object[@"data"];
        
        
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            SDBankCard *bankCard = [SDBankCard bankCardWithDict:dict];
            
            [model addObject:bankCard];
            
            FDLog(@"bank dict - %@,bankCard.name - %@",dict,bankCard.bankName);
        }

        
        if (finishedBlock) {
            
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

//29、默认银行卡（/bankCard/findDefault）
+ (void)defaultBankCardFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":user.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bankCard/findDefault" finishedBlock:^(id object) {
        
        
        NSDictionary *dict = object[@"data"];
        
        
        SDBankCard *bankCard = [SDBankCard bankCardWithDict:dict];
        
        
        FDLog(@"bank data - %@,bankCard.name - %@",object[@"data"],bankCard.bankName);
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(bankCard);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
}

+ (void)unbundleWithCardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{@"id":cardNumber
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bankCard/unbundle" finishedBlock:^(id object) {
        
        
        
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

// 连连支付绑定银行卡请求所需参数（/lianlianPay/cardBindingPara）
+ (void)getLLSignInfoWithCardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{@"userId":[SDUserInfo getUserInfo].ID,
                           @"cardNo":cardNumber,
                           @"phone":[FDUserDefaults objectForKey:FDUserAccount]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/lianlianPay/cardBindingPara" finishedBlock:^(id object) {
        
        
        
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


+ (void)addLLBankCardWithDict:(NSDictionary *)llDict cardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{@"userId":[SDUserInfo getUserInfo].ID,
                           @"cardNo":cardNumber,
                           @"code":llDict[@"ret_code"],
                           @"msg":llDict[@"ret_msg"]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"lianlianPay/cardBindingCallBack" finishedBlock:^(id object) {
        
        FDLog(@"msg - %@",object[@"msg"]);
        
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
@end







