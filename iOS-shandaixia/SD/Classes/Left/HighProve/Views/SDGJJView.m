//
//  SDGJJView.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDGJJView.h"
#import "SDGJJ.h"
#import "SDFields.h"
#import "SDPasswordLoginView.h"
#import "SDLoginButton.h"
#import "SDCity.h"

@interface SDGJJView ()

//账号 密码
@property (nonatomic, weak) SDPasswordLoginView *passwordView;

@property (nonatomic, weak) UITextField *codeTextField;

@property (nonatomic, weak) UITextField *thirdTextField;

//虚线1
@property (nonatomic, weak) UIImageView *lineOne;



//虚线2
@property (nonatomic, weak) UIImageView *lineTwo;

//账号
@property (nonatomic, weak) UITextField *accountTextField;

//显示密码
@property (nonatomic, weak) UIButton *showPasswordButton;

//发送验证码
@property (nonatomic, weak) UIButton *sendCodeButton;

//垂直的虚线
@property (nonatomic, weak) UIImageView *verticalImageView;

//密码
@property (nonatomic, weak) UITextField *passwordTextField;


@property (nonatomic, weak) UIImageView *codeImageView;
@end

@implementation SDGJJView



- (instancetype)initWithFrame:(CGRect)frame gjj:(SDGJJ *)gjj
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.gjj = gjj;
        
        
        
        
        if (gjj.fields.count >= 2){
            
            SDFields *fields0 = gjj.fields[0];
            SDFields *fields1 = gjj.fields[1];
            
            //账号
            UITextField *accountTextField = [[UITextField alloc] init];
            accountTextField.placeholder = [NSString stringWithFormat:@"请输入%@",fields0.label];
            self.accountTextField = accountTextField;
            [self addSubview:accountTextField];
            
            //虚线1
            UIImageView *lineOne = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
            
            self.lineOne = lineOne;
            [self addSubview:lineOne];
            
            //密码
            UITextField *passwordTextField = [[UITextField alloc] init];
            passwordTextField.placeholder = [NSString stringWithFormat:@"请输入%@",fields1.label];
            self.passwordTextField = passwordTextField;
            [self addSubview:passwordTextField];
            passwordTextField.secureTextEntry = YES;
            
            accountTextField.font = passwordTextField.font = [UIFont systemFontOfSize:30 * SCALE];
            
            //虚线2
            UIImageView *lineTwo = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
            
            self.lineTwo = lineTwo;
            [self addSubview:lineTwo];
        }
        
        
        
        
        CGFloat lineX = 40 * SCALE;
        CGFloat lineW = SCREENWIDTH - 2 * lineX;
        CGFloat lineY = 100 * SCALE;
        
        self.lineOne.frame = CGRectMake(lineX, lineY, lineW, 1 * SCALE);
        self.lineTwo.frame = self.lineOne.frame;
        self.lineTwo.y = lineY + 100 * SCALE;
        
        CGFloat accountH = 30 * SCALE;
        CGFloat accountY = (lineY - accountH)/2;
        self.accountTextField.frame = CGRectMake(lineX, accountY, lineW, accountH);
        self.passwordTextField.frame = self.accountTextField.frame;
        self.passwordTextField.centerY = 150 * SCALE;
        
        
        CGFloat maxY = CGRectGetMaxY(self.lineTwo.frame);
        
        CGFloat width = SCREENWIDTH - lineX * 2;
        
        if (gjj.fields.count == 3) {
            
            SDFields *fields = gjj.fields[2];
            //账号
            UITextField *thirdTextField = [[UITextField alloc] init];
            thirdTextField.placeholder = [NSString stringWithFormat:@"请输入%@",fields.label];
            thirdTextField.frame = CGRectMake(lineX, 200 * SCALE, width, accountH);
            thirdTextField.centerY = 250 * SCALE;
            self.thirdTextField = thirdTextField;
            [self addSubview:thirdTextField];
            
            maxY += 100 * SCALE;
            
            //虚线3
            UIImageView *lineThree = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
            
            lineThree.frame = CGRectMake(lineX, maxY, width, 1 * SCALE);
            
            [self addSubview:lineThree];
            
            
        }
        
        if (gjj.captcha == 1) {
            
            //验证码
            UITextField *codeTextField = [[UITextField alloc] init];
            codeTextField.placeholder = [NSString stringWithFormat:@"请输入验证码"];
            
            self.codeTextField = codeTextField;
            [self addSubview:codeTextField];
            codeTextField.font = [UIFont systemFontOfSize:30 * SCALE];
            
            //获取验证码
            UIButton *sendCodeButton = [UIButton buttonWithTitle:@"获取验证码" titleColor:FDColor(178, 178, 178) titleFont:26 * SCALE];
            self.sendCodeButton = sendCodeButton;
            [self addSubview:sendCodeButton];
            [sendCodeButton setTitleColor:FDColor(178, 178, 178) forState:UIControlStateDisabled];
            
            self.codeTextField.frame = self.accountTextField.frame;
            self.codeTextField.centerY = maxY + 50 * SCALE;
            self.codeTextField.width = self.width * 0.5;
            
            maxY += 100 * SCALE;
            
            //虚线3
            UIImageView *lineThree = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(211, 211, 211)]];
            
            lineThree.frame = CGRectMake(lineX, maxY, width, 1 * SCALE);
            
            [self addSubview:lineThree];
            
            CGFloat codeW = [@"重重新获取(60))" sizeOfMaxScreenSizeInFont:26 * SCALE].width;
            
            CGFloat codeX = CGRectGetMaxX(self.lineOne.frame) - codeW;
            self.sendCodeButton.frame = CGRectMake(codeX, 0, codeW, 100 * SCALE);
            self.sendCodeButton.centerY = self.codeTextField.centerY;
            
            
            [sendCodeButton addTarget:self action:@selector(sendCodeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        
        
        
        CGFloat buttonX = 30 * SCALE;
        CGFloat buttonH = 100 * SCALE;
        SDLoginButton *submitButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(buttonX, maxY + 60 * SCALE, SCREENWIDTH - 2 * buttonX, buttonH)];
        
        [self addSubview:submitButton];
        
        [submitButton addTarget:self action:@selector(submitButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    
}

- (void)sendCodeButtonDidClicked:(UIButton *)button{
    
    button.enabled = NO;
    
    [SDGJJ getGJJVerifyCodeWithChannelType:self.channelType channelCode:self.city.code taskId:self.taskId finishedBlock:^(id object) {
        
        NSString *dict = object[@"data"];
        
        NSData *nsdataFromBase64String = [[NSData alloc]
                                          initWithBase64EncodedString:dict options:0];
        UIImage *image = [UIImage imageWithData:nsdataFromBase64String];
        
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setTitle:@"" forState:UIControlStateNormal];
        
        button.enabled = YES;
        
    } failuredBlock:^(id object) {
        
        button.enabled = YES;
        
    }];
    
}

- (void)submitButtonDidClicked:(UIButton *)button{

    self.userInteractionEnabled = NO;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    
    FDLog(@"code - %@",self.city.code);
    
    if (![self.city.code isEqualToString:@"000000"]) {
        
        [dict setObject:self.gjj.value forKey:@"login_type"];
    }

    for (NSInteger i = 0 ; i < self.gjj.fields.count; i ++) {
        
        SDFields *fields = self.gjj.fields[i];
        
        switch (i) {
            case 0:
                [dict setObject:self.accountTextField.text forKey:fields.name];
                
//                FDLog(@"%@ - %@",fields.name,self.accountTextField.text);
                break;
            case 1:
                [dict setObject:self.passwordTextField.text forKey:fields.name];
//                FDLog(@"%@ - %@",fields.name,self.passwordTextField.text);
                break;
            case 2:
                [dict setObject:self.thirdTextField.text forKey:fields.name];
//                FDLog(@"%@ - %@",fields.name,self.thirdTextField.text);
                break;
                
            default:
                break;
        }
        
    }
    
    FDLog(@"dict- %@",dict);
    
    NSString *inputElementStr=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    
    
    [SDGJJ submitGJJInfoWithChannelType:self.channelType channelCode:self.city.code taskId:self.taskId verifyCode:self.codeTextField.text inputElementStr:inputElementStr finishedBlock:^(id object) {
        
        self.userInteractionEnabled = YES;
        NSString *str = object[@"msg"];
        NSString *status;
        if ([str containsString:@"成功"]) {
            
            [FDReminderView showWithString:@"认证成功"];
            status = @"1";
            
            NSString *speedCount;
            
            if ([self.channelType isEqualToString:@"CHSI"]) {
                
                speedCount = @"20";
                
                
            }else{
            
                
                speedCount = @"10";
            }
            
            [SDNotificationCenter postNotificationName:SDHighProveSuccessNotification object:nil userInfo:@{SDHighProveSpeedCount:speedCount}];
            
        }else{
        
            [FDReminderView showWithString:str];
            
            status = @"0";
        }
        
        if ([self.delegate respondsToSelector:@selector(gjjViewVerifyStatus:)]) {
            
            [self.delegate gjjViewVerifyStatus:status];
        }
        
        
    } failuredBlock:^(id object) {
        
//        self.userInteractionEnabled = YES;
//        NSString *str = object[@"msg"];
//        
//        [FDReminderView showWithString:str];
        
        if ([self.delegate respondsToSelector:@selector(gjjViewVerifyStatus:)]) {
            
            [self.delegate gjjViewVerifyStatus:@"0"];
        }
        
    }];
}

@end
