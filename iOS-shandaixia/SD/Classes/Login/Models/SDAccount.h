//
//  SDAccount.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/14.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"
@class OliveappDetectedFrame;
@class SDLoan;
@class SDBankCard;
@class SDMyLoan;

typedef enum {
    SDMassageTypeRegist,
    SDMassageTypeLogin,
    SDMassageTypeForgotPassword,
    SDMassageTypeChangePassword
    
}SDMassageType;


@interface SDAccount : NSObject

//注册
@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *verifCode;

@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *oldPwd;

@property (nonatomic, copy) NSString *channelType;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, copy) NSString *loginType;

//登录
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger type;

//返回参数
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray *data;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

//获取验证码
+ (void)getCodeWithPhone:(NSString *)phone type:(SDMassageType)type finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//注册
+ (void)registWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd channelType:(NSString *)channelType userType:(NSInteger)userType finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//登录
+ (void)loginWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd loginType:(NSInteger)loginType finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//修改密码
+ (void)changePasswordWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd oldPassword:(NSString *)oldPassword finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//忘记密码
+ (void)forgotPasswordWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;


//获取身份证信息
+ (void)idCardInfoWithCardTypeFront:(NSString *)cardTypeFront cardTypeBack:(NSString *)cardTypeBack finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//检测活体
+ (void)testUserWithOliveappDetectedFrame:(OliveappDetectedFrame *)oliveappDetectedFrame finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//上传用户联系人
+ (void)updateContacts:(NSArray *)array society:(NSArray *)society finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//检测运营商授权
+ (void)testOperatorAuthWithPassword:(NSString *)password finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

///common/agreement
+ (void)getAgreementWith:(SDLoan *)loan bankCard:(SDBankCard *)bankCard finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//33、用户还款验证短信（/order/sms）
+ (void)getRefundSms:(SDMyLoan *)myLoan bankCard:(SDBankCard *)bankCard finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;
//34、还款（/order/reimbursement）
+ (void)refundWith:(SDMyLoan *)myLoan bankCard:(SDBankCard *)bankCard finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//个推Client_Id更新（/user/getui）
+ (void)registGeTui:(NSString *)clientId;

+ (void)getAlipayAccountFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;


@end






