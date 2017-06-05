//
//  SDRefundController.m
//  SD
//
//  Created by 余艾星 on 17/3/13.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDRefundController.h"
#import "SDInputView.h"
#import "SDLoginButton.h"
#import "SDAccount.h"
#import "SDRefundCardView.h"
#import "SDLending.h"
#import "SDRefundOrder.h"
#import "SDLoanProcedureBankCardController.h"
#import "SDBankCard.h"
#import "SDAlipayView.h"
#import "LLPayUtil.h"
#import "LLOrder.h"
#import "LLPaySdk.h"

static LLPayType payType = LLPayTypeInstalments;

@interface SDRefundController ()<SDLoanProcedureBankCardControllerDelegate,LLPaySdkDelegate>

@property (nonatomic, weak) SDInputView *phoneView;
@property (nonatomic, weak) SDInputView *verifyCodeView;

@property (nonatomic, weak) SDRefundCardView *refundCardView;

//时间
@property (nonatomic, assign) NSInteger timeCount;

//定时器
@property (nonatomic, strong) NSTimer *timer;

//获取验证码
@property (nonatomic, weak) UIButton *sendCodeButton;

@property (nonatomic, copy) NSString *verifyCode;

//银行返回的信息
@property (nonatomic, strong) SDRefundOrder *refundOrder;

@property (nonatomic, strong) SDLoanProcedureBankCardController *bcCon;

@property (nonatomic, retain) NSMutableDictionary *orderDic;

@property (nonatomic, strong) NSString *resultTitle;

@property (nonatomic, strong) LLOrder *order;


@end

@implementation SDRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getBankCard];
    
//    [self createNavBarWithTitle:@"立即还款"];
    
    [self createNavBarWithTitle:@"立即还款" titleColor:SDBlackColor backImageNamed:@"icon_white_move_normal" backGroundColor:[UIColor clearColor]];
//    self.navBarContainer.backgroundColor = [UIColor clearColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    headerView.backgroundColor = SDWhiteColor;
    [self.view addSubview:headerView];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    
    [self addUI];
    
    [SDNotificationCenter addObserver:self selector:@selector(getBankCard) name:SDBankCardChangedNotification object:nil];
    
    [self loadLending];
    
}

- (void)addUI{
    
    CGFloat cardH = 280 * SCALE;
    CGFloat cardY = 64 + 20 * SCALE;
    
    SDRefundCardView *refundCardView = [[SDRefundCardView alloc] initWithFrame:CGRectMake(0, cardY, SCREENWIDTH, cardH)];
    self.refundCardView = refundCardView;
    [self.view addSubview:refundCardView];
    
    refundCardView.bankCard = self.defaultBankCard;
    refundCardView.lending = self.lending;
    
    CGFloat height = 100 * SCALE;
    
    
    
//    //手机号
//    CGFloat phoneY = 20 * SCALE + cardY + cardH;
//    SDInputView *phoneView = [[SDInputView alloc] initWithFrame:CGRectMake(0, phoneY, SCREENWIDTH, height) title:@"手机号" placeholder:@""];
//    phoneView.inputTextField.text = [FDUserDefaults objectForKey:FDUserAccount];
//    phoneView.inputTextField.enabled = NO;
//    //small_white_image
//    phoneView.titlesButton.hidden = NO;
//    
//    [phoneView.titlesButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [phoneView.titlesButton setTitleColor:FDColor(153, 153, 153) forState:UIControlStateDisabled];
//    [phoneView.titlesButton setTitleColor:FDColor(70, 153, 253) forState:UIControlStateNormal];
//    
//    
//    self.phoneView = phoneView;
//    [self.view addSubview:phoneView];
//    
//    //验证码
//    SDInputView *verifyCodeView = [[SDInputView alloc] initWithFrame:CGRectMake(0, phoneY + height, SCREENWIDTH, height) title:@"验证码" placeholder:@"短信验证码"];
//    self.verifyCodeView = verifyCodeView;
//    [self.view addSubview:verifyCodeView];
//    verifyCodeView.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
//    //提交按钮
    CGFloat x = 20 * SCALE;
    
    CGFloat submitY = CGRectGetMaxY(refundCardView.frame) + 60 * SCALE;
    SDLoginButton *submitButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(x, submitY, SCREENWIDTH - 2 * x, height)];
    [submitButton setTitle:@"立即还款" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    UIButton *addBankButton = [[UIButton alloc] initWithFrame:CGRectMake(0, cardY, SCREENWIDTH, 120 * SCALE)];
    [self.view addSubview:addBankButton];
    [addBankButton addTarget:self action:@selector(addBankController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *alipayButton = [UIButton buttonWithImage:@"alipay_btn" backImageNamed:nil];
    [alipayButton addTarget:self action:@selector(alipayButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [alipayButton sizeToFit];
    alipayButton.centerX = SCREENWIDTH/2;
    alipayButton.y = SCREENHEIGHT - 50 * SCALE - alipayButton.height;
    [self.view addSubview:alipayButton];
    
}

- (void)alipayButtonDidClicked{

    [SDAlipayView showWithLending:self.lending];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [_verifyCodeView.inputTextField endEditing:YES];
    
    [self.refundCardView.refundTextField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_verifyCodeView.inputTextField endEditing:YES];
    
    return YES;
    
}


#pragma mark - 点击获取验证码
- (void)getCodeButtonDidClicked{
    
    NSString *price = self.refundCardView.refundTextField.text;
    
    if ([price isEqualToString:@"0"] || !price.length) {
        
        [@"请输入还款金额" showNotice];
        
        return;
    }
 
    self.timeCount = 60;
    self.phoneView.titlesButton.enabled = NO;
    
    
    [SDLending getRefundVerifyCode:self.defaultBankCard money:self.refundCardView.refundTextField.text finishedBlock:^(id object) {
        
        self.refundOrder = object;
        if (self.refundOrder) {
            
            [FDReminderView showWithString:[NSString stringWithFormat:@"验证码已发送至%@",[FDUserDefaults objectForKey:FDUserAccount]]];
            
            
            
            self.refundOrder = object;
            [self addTimer];
            
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
    
    FDLog(@"addtimer - -----------");
    
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
        
        self.phoneView.titlesButton.enabled = YES;
        
        [self.phoneView.titlesButton setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        
        
    }else{
        
        [self.phoneView.titlesButton setTitle:[NSString stringWithFormat:@"重新获取(%@)",@(self.timeCount)] forState:UIControlStateNormal];
    }
    
    
}

- (NSMutableArray *)cardArray{
    
    if (_cardArray == nil) {
        
        _cardArray = [NSMutableArray array];
    }
    
    return _cardArray;
}

- (void)getBankCard{
    
    [SDBankCard findBankCardFinishedBlock:^(id object) {
        
        [self.cardArray removeAllObjects];
        self.cardArray = object;
        
        
        self.bcCon.cardArray = object;
        [self.bcCon.tableView reloadData];
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)addBankController:(UIButton *)button{
 
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    
    if (self.bcCon) {
        
        [self.bcCon showWithParentController:self];
        
        
    }else{
    
        SDLoanProcedureBankCardController *bcCon = [[SDLoanProcedureBankCardController alloc] init];
        
        bcCon.cardArray = self.cardArray;
        bcCon.delegate = self;
        self.bcCon = bcCon;
        
        [bcCon showWithParentController:self];
        
    }
    
}

- (void)loanProcedureBankCardDidClicked:(SDBankCard *)bankCard{
    
    self.defaultBankCard = bankCard;
    
    self.refundCardView.bankCard = bankCard;
    
    
}


- (void)loadLending{
    
    
    [SDLending lendingFinishedBlock:^(id object) {
        
        self.lending = object;
        
        self.refundCardView.lending = self.lending;
        
    } failuredBlock:^(id object) {
        
        
    }];
}


- (void)submitButtonDidClicked:(UIButton *)button{
    
    if (!self.refundCardView.refundTextField.text.length) {
        
        [@"请输入还款金额" showNotice];
        return;
    }
//    
//    if (!self.verifyCodeView.inputTextField.text.length) {
//        
//        [@"请输入验证码" showNotice];
//        return;
//        
//    }
//    
//    
//    
    
    
    
    [self.refundCardView.refundTextField endEditing:YES];
    
    button.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        button.enabled = YES;
    });
    
    //    self.lending
    
    
    [SDLending refundWithLending:self.lending refund:self.refundCardView.refundTextField.text bankCard:self.defaultBankCard verifyCode:@""refundOrder:self.refundOrder finishedBlock:^(id object) {
        
        
        NSString *str = object[@"msg"];
        
        if ([str containsString:@"成功"]) {
            
            NSDictionary *dict = object[@"data"];
            
            FDLog(@"dict - %@",dict);
            
//            NSMutableDictionary *m = [NSMutableDictionary dictionary];
//            
//            [m addEntriesFromDictionary:dict];
//            
//            NSDictionary *d = dict[@"risk_item"];
//            
//            
//            [m removeObjectForKey:@"risk_item"];
//
//            [m setValue:[LLOrder llJsonStringOfObj:d] forKey:@"risk_item"];
//            
//            FDLog(@"m - %@",m);
//            
            
            [self payWithDict:dict];
            

            
        }else{
            
            [FDReminderView showWithString:str];
        }
        
    } failuredBlock:^(id object) {
        
        
        
    }];
    
    
//    [SDLending llRefundInfoWith:self.lending bankCard:self.defaultBankCard finishedBlock:^(id object) {
//        
//        if ([object[@"msg"] isEqualToString:@"成功"]) {
//            
//            [self payWithDict:object[@"data"]];
//        }
//        
//    } failuredBlock:^(id object) {
//        
//    }];
}

#pragma - mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
// TODO: 开发人员需要根据实际业务调整逻辑
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic {
    
    NSString *msg = @"异常";
    switch (resultCode) {
        case kLLPayResultSuccess: {
            msg = @"成功";
            
            [FDReminderView showWithString:@"还款成功"];
            
            [SDNotificationCenter postNotificationName:SDSubmitRefundNotification object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            

            
            
            
        } break;
        case kLLPayResultFail: {
            msg = @"失败";
            
            [FDReminderView showWithString:@"还款失败"];
        } break;
        case kLLPayResultCancel: {
            msg = @"取消";
            [FDReminderView showWithString:@"还款失败"];
        } break;
        case kLLPayResultInitError: {
            msg = @"sdk初始化异常";
            [FDReminderView showWithString:@"还款失败"];
        } break;
        case kLLPayResultInitParamError: {
            msg = dic[@"ret_msg"];
            [FDReminderView showWithString:@"还款失败"];
        } break;
        default:
            break;
    }
    
    NSString *showMsg = [msg stringByAppendingString:[LLPayUtil jsonStringOfObj:dic]];
    showMsg = msg;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.resultTitle
                                                                   message:showMsg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确认"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)payWithDict:(NSDictionary *)dict{

    self.resultTitle = @"支付结果";
//    self.orderDic = [[_order tradeInfoForPayment] mutableCopy];
    
    
    [LLPaySdk sharedSdk].sdkDelegate = self;
    
    //接入什么产品就传什么LLPayType
    [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:self
                                              withPayType:payType
                                            andTraderInfo:dict];
    
    
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}


@end




