//
//  SDSSQStatus.m
//  SD
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDSSQStatus.h"
#import "SDUserInfo.h"

@implementation SDSSQStatus

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)ssqStatusWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (void)querySSQStatusFinishedBlock:(FinishedBlock)finishedBlock
                      failuredBlock:(FailuredBlock)failuredBlock {
    
    NSDictionary *dict = @{
                           @"userId":[SDUserInfo getUserInfo].ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bestsign/findBestsign" finishedBlock:^(id object) {
        
        NSString *status = object[@"data"];
        
//        NSString *str = object[@"msg"];
        
//        SDBankCard *bankCard = [SDBankCard bankCardWithDict:dict];
        
//        FDLog(@"bank data - %@,bankCard.name - %@",object[@"data"],bankCard.bankName);
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(status);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
}

// 修改上上签状态
+ (void)modifySSQStatusIsBestsign:(NSNumber *)bestsign
                    finishedBlock:(FinishedBlock)finishedBlock
                    failuredBlock:(FailuredBlock)failuredBlock {
    
    NSDictionary *dict = @{
                           @"userId":[SDUserInfo getUserInfo].ID,
                           @"isBestsign":[NSString stringWithFormat:@"%@", @([bestsign intValue])]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bestsign/updateBestsign" finishedBlock:^(id object) {
        
        NSString *status = object[@"data"];
        
        //        NSString *str = object[@"msg"];
        
        //        SDBankCard *bankCard = [SDBankCard bankCardWithDict:dict];
        
        //        FDLog(@"bank data - %@,bankCard.name - %@",object[@"data"],bankCard.bankName);
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(status);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
    
}

+ (void)getSSQSignWithLoan:(SDLoan *)loan
             finishedBlock:(FinishedBlock)finishedBlock
             failuredBlock:(FailuredBlock)failuredBlock {
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           @"userId":userInfo.ID,
                           @"cardId":loan.cardId,
                           @"principal":[NSString stringWithFormat:@"%@", @(loan.price + [loan.charge integerValue])],
                           @"serviceMoney":[NSString stringWithFormat:@"%@",@([loan.charge floatValue])],
                           @"borrowFrom":loan.borrowFrom,
                           @"borrowTo":loan.borrowTo,
                           @"refundDays":[NSString stringWithFormat:@"%@", loan.day]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/bestsign/manualBestsign" finishedBlock:^(id object) {
        
//        NSDictionary *data = object[@"data"];
//        NSString *code = data[@"code"];
//        NSString *signid = data[@"signid"];
//        //        FDLog(@"bank data - %@,bankCard.name - %@",object[@"data"],bankCard.bankName);
//        
//        if ([code isEqualToString:@"1000013"]) {
//            
//            
//        }
//        
//        FDLog(@"...... signid is %@", signid);
        
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

+ (void)getSSQPreview:(NSString *)signid
        finishedBlock:(FinishedBlock)finishedBlock
        failuredBlock:(FailuredBlock)failuredBlock {
    
    
    NSDictionary *dict = @{
                          @"signid":signid
                          };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"bestsign/getBestsignContractInfo" finishedBlock:^(id object) {
        
        NSDictionary *data = object[@"data"];
        NSString *url = data[@"url"];
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(url);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            //返回给模型
            failuredBlock(object);
        }
        
    }];
}

+ (void)getSignPageSignimagePc:(NSString *)signid
                 finishedBlock:(FinishedBlock)finishedBlock
                 failuredBlock:(FailuredBlock)failuredBlock {
    
    if (signid == nil) {
        FDLog(@"sign id is null");
        [@"获取合同单号失败，请稍后重试。" showNotice];
        return;
    }
    
    NSString *userId = [SDUserInfo getUserInfo].ID;
    NSDictionary *dict = @{
                           @"userId":userId,
                           @"signid":signid
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"bestsign/getSignPageSignimagePc" finishedBlock:^(id object) {
        
        NSDictionary *data = object[@"data"];
        NSString *url = data[@"singUrl"];

        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(url);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            //返回给模型
            failuredBlock(object);
        }
        
    }];
}

@end
