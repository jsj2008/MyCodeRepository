//
//  SDBankCard.h
//  SD
//
//  Created by 余艾星 on 17/2/24.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDBankCard : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *cardNumber;

@property (nonatomic, copy) NSString *bankName;

@property (nonatomic, copy) NSString *bank;

@property (nonatomic, copy) NSString *logoUrl;

//卡类型，CC信用卡，DC储蓄卡
@property (nonatomic, copy) NSString *cardType;

//是否默认卡号,0否，1是
@property (nonatomic, assign) BOOL isDefault;

//是否开通代扣，0否，1是
@property (nonatomic, assign) BOOL isWithholding;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)bankCardWithDict:(NSDictionary *)dict;

//查询银行卡基本信息
+ (void)bankCardInfoWithCardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//添加银行卡
+ (void)addBankCard:(SDBankCard *)bankCard verifyCode:(NSString *)verifyCode finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//查询用户银行卡
+ (void)findBankCardFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//解绑银行卡（/bankCard/unbundle）
+ (void)unbundleWithCardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//29、默认银行卡（/bankCard/findDefault）
+ (void)defaultBankCardFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

// 连连支付绑定银行卡请求所需参数（/lianlianPay/cardBindingPara）
+ (void)getLLSignInfoWithCardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

+ (void)addLLBankCardWithDict:(NSDictionary *)llDict cardNumber:(NSString *)cardNumber finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;
@end
