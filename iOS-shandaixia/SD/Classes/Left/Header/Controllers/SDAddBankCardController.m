//
//  SDAddBankCardController.m
//  SD
//
//  Created by 余艾星 on 17/2/27.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDAddBankCardController.h"
#import "SDAddBankCardView.h"
#import "SDLoginButton.h"
#import "SDInputView.h"
#import "SDBankCard.h"
#import "SDAccount.h"
#import "SDImageRightButton.h"
#import "LLPayUtil.h"
#import "LLOrder.h"
#import "LLPaySdk.h"
#import "SDUserInfo.h"
#import "SDUserCenter.h"

/*
 正式环境 认证支付 或 分期付 测试商户号  201408071000001543
 MD5 key  201408071000001543test_20140812
 
 正式环境 快捷支付测试商户号  201408071000001546
 MD5 key  201408071000001546_test_20140815
 */

/*! 接入什么支付产品就改成那个支付产品的LLPayType，如快捷支付就是LLPayTypeQuick */

static LLPayType payType = LLPayTypeInstalments;

@interface SDAddBankCardController ()<UITextFieldDelegate,LLPaySdkDelegate>

@property (nonatomic, weak) SDAddBankCardView *addBankCardView;

//时间
@property (nonatomic, assign) NSInteger timeCount;

//定时器
@property (nonatomic, strong) NSTimer *timer;

//获取验证码
@property (nonatomic, weak) UIButton *sendCodeButton;

@property (nonatomic, copy) NSString *verifyCode;

@property (nonatomic, retain) NSMutableDictionary *orderDic;

@property (nonatomic, strong) NSString *resultTitle;

@property (nonatomic, strong) LLOrder *order;

@property (nonatomic, strong) NSMutableDictionary *llParaDict;

@end

@implementation SDAddBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.llParaDict = [NSMutableDictionary dictionary];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    
    [self createNavBarWithTitle:@"添加银行卡"];
    
    [self addConent];
    
    [SDNotificationCenter addObserver:self selector:@selector(bankCardInput:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    
    
}


- (void)bankCardInput:(NSNotification *)notification{

    UITextField *textField=[notification object];
    
    if (textField == _addBankCardView.bankCardView.inputTextField) {
        
        NSString *newString = [self getBlankString:textField.text];
        
        [textField setText:newString];
    }
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *card = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(card.length > 10){
        
        [self getBankCardInfoWithCardNumber:card];
        
    }
}

- (NSString *)getBlankString:(NSString *)str{

    NSString *text = str;
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([text length] >= 21) {
        
    }
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    return newString;
    
}

- (void)addConent{

    SDAddBankCardView *addBankCardView = [[SDAddBankCardView alloc] initWithFrame:CGRectMake(0, 64 + 20 * SCALE, SCREENWIDTH, 220 * SCALE)];
    addBankCardView.bankCardView.inputTextField.delegate = self;
    [self.view addSubview:addBankCardView];
    self.addBankCardView = addBankCardView;
    [addBankCardView.districtView.chooseButton addTarget:self action:@selector(chooseButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_addBankCardView.phoneView.titlesButton addTarget:self action:@selector(getCodeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //提交按钮
    CGFloat x = 20 * SCALE;
    CGFloat height = 100 * SCALE;
    CGFloat y = CGRectGetMaxY(addBankCardView.frame) + 60 * SCALE;
    SDLoginButton *submitButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(x, y, SCREENWIDTH - 2 * x, height)];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    //提醒文本
    UIImageView *noteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank_noticeLabel"]];
    [noteImageView sizeToFit];
    noteImageView.x = x;
    noteImageView.y = CGRectGetMaxY(submitButton.frame) + 60 * SCALE;
    
    [self.view addSubview:noteImageView];
    
}

- (void)getBankCardInfoWithCardNumber:(NSString *)card{
    
    
    [SDBankCard getLLSignInfoWithCardNumber:card finishedBlock:^(id object) {
        
        FDLog(@"ll --- %@",object[@"msg"]);
        
        FDLog(@"data - %@",object[@"data"]);
        
        if ([object[@"msg"] isEqualToString:@"成功"]) {
            
            NSDictionary *d = object[@"data"];
            
            [self.llParaDict addEntriesFromDictionary:d[@"paramInfo"]];
            
            FDLog(@"self.llParaDict -- %@",self.llParaDict);
            
            self.bankCard = [SDBankCard bankCardWithDict:d[@"cardInfo"]];
            self.bankCard.cardNumber = card;
            
            self.addBankCardView.bankCard = self.bankCard;
            

        }else{
        
            [FDReminderView showWithString:object[@"msg"]];
        
        }
        
    } failuredBlock:^(id object) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_addBankCardView.bankCardView.inputTextField endEditing:YES];
    
    [self.addBankCardView.bankCardView.inputTextField endEditing:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_addBankCardView.bankCardView.inputTextField endEditing:YES];
    
    return YES;
    
}


#pragma mark - 点击获取验证码
- (void)getCodeButtonDidClicked{

    self.timeCount = 60;
    
    
    
    [SDAccount getCodeWithPhone:[FDUserDefaults objectForKey:FDUserAccount] type:4 finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        NSString *code = dict[@"verifCode"];
        
        FDLog(@"验证码 - %@,msg - %@",code,object[@"msg"]);
        
        if (code.length > 0) {
            
            self.verifyCode = code;
            
            [FDReminderView showWithString:[NSString stringWithFormat:@"验证码已发送至%@",[FDUserDefaults objectForKey:FDUserAccount]]];
            
            _addBankCardView.phoneView.titlesButton.enabled = NO;
            
            [self addTimer];
            
        }else{
            
            [FDReminderView showWithString:object[@"msg"]];
            
        }
        
        
        
        
    } failuredBlock:^(id object) {
        
        [FDReminderView showWithString:@"验证码发送失败"];
        
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self removeTimer];
    
}

// 添加定时器
- (void)addTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonTitle) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer=timer;
}
// 删除定时器
- (void)removeTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeButtonTitle{
    
    self.timeCount --;
    
    if (self.timeCount == 0) {
        
        [self removeTimer];
        
        _addBankCardView.phoneView.titlesButton.enabled = YES;
        
        [_addBankCardView.phoneView.titlesButton setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        
    }else{
        
        [_addBankCardView.phoneView.titlesButton setTitle:[NSString stringWithFormat:@"重新获取(%@)",@(self.timeCount)] forState:UIControlStateNormal];
    }
    
}



- (void)submitButtonDidClicked{
    
    
    SDBankCard *bankCard = self.bankCard;
    
    FDLog(@"default - %@",@(self.bankCard.isDefault));
    
    if (!self.addBankCardView.bankCardView.inputTextField.text.length) {
        
        [@"请输入银行卡号" showNotice];
        
        return;
    }
    
    if ([bankCard.cardType isEqualToString:@"CC"]) {
        
        [@"暂不支持信用卡" showNotice];
        
        return;
    }
    
    if (!bankCard.bankName) {
        
        NSString *card = [self.addBankCardView.bankCardView.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if(card.length > 10){
            
            [self getBankCardInfoWithCardNumber:card];
            
            return;
            
        }else{
        
            [@"卡号输入有误" showNotice];
            
            return;
        }
    }
    
    
    [self sign];
    
    return;

    
    
    
    
    
    
    
    if (bankCard != nil) {
        
        NSString *code = self.addBankCardView.verifyCodeView.inputTextField.text;
        
        if (![self.verifyCode isEqualToString:code]) {
            
            [FDReminderView showWithString:@"验证码错误"];
            
            return;
        }
        
        if (code.length > 0) {
            
            [SDBankCard addBankCard:bankCard verifyCode:code finishedBlock:^(id object) {
                
                if ([object[@"msg"] containsString:@"成功"]) {
                    
                    [SVProgressHUD showImage:[UIImage imageNamed:@"icon_OK"] status:@"绑定成功"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [SVProgressHUD dismiss];
                    });
                    
                    [SDNotificationCenter postNotificationName:SDBankCardChangedNotification object:nil];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                
//                    [FDReminderView showWithString:@"添加失败, 请重试"];
                    
                    [FDReminderView showWithString:object[@"msg"]];
                }
                
            } failuredBlock:^(id object) {
                
                [FDReminderView showWithString:@"添加失败, 请重试"];
            }];
            
        }else{
        
            [@"请输入验证码" showNotice];
        }
    }
    
}

- (void)chooseButtonDidClicked:(UIButton *)button{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择是否设为默认银行卡" preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置popover指向的item
    alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        self.addBankCardView.districtView.chooseButton.titles.text = @"   是";
        
        self.bankCard.isDefault = 1;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        self.addBankCardView.districtView.chooseButton.titles.text = @"   否";
        self.bankCard.isDefault = 0;
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)sign{
    self.resultTitle = @"签约结果";
    self.orderDic = [[_order tradeInfoForSign] mutableCopy];
    
    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    payUtil.signKeyArray = @[
                             @"acct_name",
                             @"card_no",
                             @"id_no",
                             @"oid_partner",
                             @"risk_item",
                             @"sign_type",
                             @"user_id"
                             ];
    
    BOOL isInstalmentsPay = payType == LLPayTypeInstalments;
    
    if (isInstalmentsPay) { //如果是分期付，那么repayment_plan/repayment_no/sms_param需要参与签名
        payUtil.signKeyArray = @[
                                 @"acct_name",
                                 @"card_no",
                                 @"id_no",
                                 @"oid_partner",
                                 @"risk_item",
                                 @"sign_type",
                                 @"user_id"
                                 //            @"repayment_plan",
                                 //            @"repayment_no",
                                 //            @"sms_param"
                                 ];
    }
    
    [LLPaySdk sharedSdk].sdkDelegate = self;
    
    FDLog(@"ll - %@",self.llParaDict);
    
    [[LLPaySdk sharedSdk] presentLLPaySignInViewController:self
                                               withPayType:payType
                                             andTraderInfo:self.llParaDict];
}

#pragma - mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
// TODO: 开发人员需要根据实际业务调整逻辑
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic {
    
    FDLog(@"dic - %@",dic);
    
    
    
    
    
    NSString *msg = @"异常";
    switch (resultCode) {
        case kLLPayResultSuccess: {
            {
                
                [SVProgressHUD showWithStatus:@"正在添加,请稍候"];
            
                [SDBankCard addLLBankCardWithDict:dic cardNumber:self.bankCard.cardNumber finishedBlock:^(id object) {
                    
                    [SVProgressHUD dismiss];
                    
                    if ([object[@"msg"] isEqualToString:@"状态更新完成"]) {
                        
                        [SVProgressHUD showImage:[UIImage imageNamed:@"icon_OK"] status:@"绑定成功"];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [SVProgressHUD dismiss];
                        });
                        
                        [SDNotificationCenter postNotificationName:SDBankCardChangedNotification object:nil];
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                    
                         [FDReminderView showWithString:object[@"msg"]];
                    }
                    
                } failuredBlock:^(id object) {
                    
                    [FDReminderView showWithString:object[@"msg"]];
                    
                    [SVProgressHUD dismiss];
                    
                }];
            }
        } break;
        case kLLPayResultFail: {
            
            [FDReminderView showWithString:@"添加失败"];
            msg = @"失败";
        } break;
        case kLLPayResultCancel: {
            msg = @"取消";
        } break;
        case kLLPayResultInitError: {
            msg = @"sdk初始化异常";
        } break;
        case kLLPayResultInitParamError: {
            msg = dic[@"ret_msg"];
            
            [FDReminderView showWithString:@"添加失败"];
        } break;
        default:
            break;
    }
    
//    NSString *showMsg = [msg stringByAppendingString:[LLPayUtil jsonStringOfObj:dic]];
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.resultTitle
//                                                                   message:showMsg
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"确认"
//                                              style:UIAlertActionStyleDefault
//                                            handler:nil]];
//    [self presentViewController:alert animated:YES completion:nil];
}


@end
