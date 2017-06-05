//
//  SDAccount.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/14.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDAccount.h"
#import "SDNetworkTool.h"
#import "SDUserInfo.h"
#import "OliveappDetectedFrame.h"
#import "BqsDeviceFingerPrinting.h"
#import "SDBankCard.h"
#import "SDLoan.h"
#import "SDMyLoan.h"
#import "FMDeviceManager.h"


@implementation SDAccount

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (void)getCodeWithPhone:(NSString *)phone type:(SDMassageType)type finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    
    NSDictionary *dict = @{@"phone":phone,
                           @"type":[NSString stringWithFormat:@"%@",@(type)]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    
    FDLog(@"验证码 - %@",dict);
    [manager postWithURLString:@"/sms/sendOther" finishedBlock:^(id object) {
        
        
        
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



//注册
+ (void)registWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd channelType:(NSString *)channelType userType:(NSInteger)userType finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:account forKey:@"account"];
    [dict setObject:verifCode forKey:@"verifCode"];
    [dict setObject:@"ios" forKey:@"platform"];
//    [dict setObject:@"1" forKey:@"channelType"];
    [dict setObject:[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] getTokenKey] forKey:@"tokenKey"];
    [dict setObject:[FMDeviceManager sharedManager]->getDeviceInfo() forKey:@"tongdunKey"];
    
    if (pwd) {
        
        [dict setObject:pwd forKey:@"pwd"];
        
    }
    
    if (channelType) {
        
        [dict setObject:channelType forKey:@"channelType"];
    }
    
    if (userType != 0) {
        
        [dict setObject:[NSString stringWithFormat:@"%@",@(userType)] forKey:@"userType"];
    }

    
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/user/regis" finishedBlock:^(id object) {
        
        
        
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

//登录
+ (void)loginWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd loginType:(NSInteger)loginType finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:account forKey:@"account"];
    [dict setObject:@"ios" forKey:@"platform"];
    [dict setObject:[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] getTokenKey] forKey:@"tokenKey"];
    [dict setObject:[FMDeviceManager sharedManager]->getDeviceInfo() forKey:@"tongdunKey"];
    
    
    if (verifCode) {
        
        [dict setObject:verifCode forKey:@"verifCode"];
        [dict setObject:@"2" forKey:@"userType"];
    }
    
    if (pwd) {
        
        [dict setObject:pwd forKey:@"pwd"];
    }
    
    [dict setObject:[NSString stringWithFormat:@"%@",@(loginType)] forKey:@"loginType"];
    
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/user/login" finishedBlock:^(id object) {
        
        
        
        NSDictionary *dict = object[@"data"];
        
        SDUserInfo *userInfo = [SDUserInfo userInfoWithDict:dict];
        
        
        NSString *str = object[@"msg"];
        
        
        if ([str isEqualToString:@"成功"]) {
            
            if (pwd.length) {
                
                userInfo.pwd = pwd;
                
            }
            
            [userInfo saveUserInfo];
            //保存用户名
            [FDUserDefaults setObject:account forKey:FDUserAccount];
        }
        
        FDLog(@"data - %@,image - %@",object[@"data"],userInfo.headUrl);
        
        
        
                
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

//修改密码
+ (void)changePasswordWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd oldPassword:(NSString *)oldPassword finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:account forKey:@"account"];
    [dict setObject:oldPassword forKey:@"oldPwd"];
    [dict setObject:pwd forKey:@"pwd"];
    [dict setObject:verifCode forKey:@"verifCode"];
    
    FDLog(@"dict - %@",dict);
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/user/updatePwd" finishedBlock:^(id object) {
        
        
        FDLog(@"修改密码 - msg - %@",object[@"msg"]);
        
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

//忘记密码
+ (void)forgotPasswordWithAccount:(NSString *)account verifCode:(NSString *)verifCode pwd:(NSString *)pwd finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:account forKey:@"account"];
    
    [dict setObject:pwd forKey:@"pwd"];
    [dict setObject:verifCode forKey:@"verifCode"];
    
    FDLog(@"dict - %@",dict);
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/user/forgoPwd" finishedBlock:^(id object) {
        
        
        if ([object[@"msg"] isEqualToString:@"成功"]) {
            
            [FDReminderView showWithString:@"修改密码成功"];
        }
        
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

//获取身份证信息
+ (void)idCardInfoWithCardTypeFront:(NSString *)cardTypeFront cardTypeBack:(NSString *)cardTypeBack finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":user.ID,
                           @"cardTypeFront":cardTypeFront,
                           @"cardTypeBack":cardTypeBack
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/real/authen" finishedBlock:^(id object) {
        
        
        
        NSDictionary *dict = object[@"data"];
        
        FDLog(@"idCard - %@",dict[@"idCard"]);
        SDUserInfo *userInfo = [SDUserInfo userInfoWithDict:dict];
        
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(userInfo);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
    
}

//检测活体
+ (void)testUserWithOliveappDetectedFrame:(OliveappDetectedFrame *)oliveappDetectedFrame finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":user.ID,
                           @"verificationPackage":[oliveappDetectedFrame.verificationData base64EncodedStringWithOptions:0],
                           @"verificationPackageFull":[oliveappDetectedFrame.verificationDataFull base64EncodedStringWithOptions:0],
                           @"verificationPackageWithFanpaiFull":[oliveappDetectedFrame.verificationDataFullWithFanpai base64EncodedStringWithOptions:0]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/real/livingCheck" finishedBlock:^(id object) {
        
        
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

//上传用户联系人
+ (void)updateContacts:(NSArray *)contacts society:(NSArray *)society finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSString *jsonSociety=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:society options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    NSString *jsonContacts=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:contacts options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":user.ID,
                           @"contacts":jsonContacts,
                           @"society":jsonSociety
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/contacts/addContacts" finishedBlock:^(id object) {
        
        
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

//检测运营商授权
+ (void)testOperatorAuthWithPassword:(NSString *)password finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

//    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        
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

///common/agreement
+ (void)getAgreementWith:(SDLoan *)loan bankCard:(SDBankCard *)bankCard finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

//    NSDictionary *dict = @{@"cardId":bankCard.ID,
//                           @"principal":[NSString stringWithFormat:@"%@",@(loan.price)],
//                           @"serviceMoney":[NSString stringWithFormat:@"%@",loan.charge],
//                           @"borrowFrom":loan.borrowFrom,
//                           @"borrowTo":loan.borrowTo,
//                           @"refundDays":[NSString stringWithFormat:@"%@",loan.day]
//                           };
//    
    NSString *urlString = [NSString stringWithFormat:@"%@/common/agreement?cardId=%@&principal=%@&serviceMoney=%@&borrowFrom=%@&borrowTo=%@&refundDays=%@",BaseURLString,bankCard.ID,[NSString stringWithFormat:@"%@",@(loan.price + [loan.charge integerValue])],[NSString stringWithFormat:@"%@",loan.charge],loan.borrowFrom,loan.borrowTo,[NSString stringWithFormat:@"%@",loan.day]];
    
    
  
    if (finishedBlock) {
        
        finishedBlock(urlString);
    }
    
    
    
}

//33、用户还款验证短信（/order/sms）
+ (void)getRefundSms:(SDMyLoan *)myLoan bankCard:(SDBankCard *)bankCard finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{@"userId":user.ID,
                           @"cardId":bankCard.ID,
                           @"hasAlsoAmount":[NSString stringWithFormat:@"%@",myLoan.borrowingAmount]
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/order/sms" finishedBlock:^(id object) {
        
        
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

//个推Client_Id更新（/user/getui）
+ (void)registGeTui:(NSString *)clientId{

    SDUserInfo *user = [SDUserInfo getUserInfo];

    if (!user.ID.length) return;
    
    NSDictionary *dict = @{@"userId":user.ID,
                           @"clientId":clientId
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/user/getui";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        
        
    } parameters:dict failuredBlock:^(id object) {
        
        
    }];

}

+ (void)getAlipayAccountFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = [[NSDictionary alloc] init];
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"alipay/alipayNumber" finishedBlock:^(id object) {
        
        
        
        
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


