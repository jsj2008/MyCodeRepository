//
//  CashierViewController.m
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "CashierViewController.h"

#import "CashierRequest.h"

#import "CAPointSwitchView.h"

#import "PayChannelView.h"
#import "CATotalBarView.h"

#import "WXApiManager.h"
#import "AlipayManager.h"

@interface CashierViewController () <CATotalBarDelegate, PayChannelDelegate, WXApiManagerDelegate>

@property (nonatomic, strong) CashierResultModel *resultModel;
@property (nonatomic, strong) NSString *balance;

@property (nonatomic, strong) NSString *failureLink;
@property (nonatomic, strong) NSString *successLink;

//@property (nonatomic, strong) PayChannelView *balanceView;
@property (nonatomic, strong) PayChannelView *alipayView;
@property (nonatomic, strong) PayChannelView *weixinView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) CATotalBarView *totalBarView;

@end

@implementation CashierViewController

- (void)viewDidLoad
{
    self.needBlurEffect = NO;

    [super viewDidLoad];
    [self addNavigationBar];
//    self.navigationBar.backgroundColor = Color_Red9;
//    self.navigationBar.tintColor = Color_White;
    self.view.backgroundColor = Color_Gray245;
    
    self.title = @"收银台";
    
    [WXApiManager sharedManager].delegate = self;
    
    [self initData];
}

#pragma mark - Private Methods

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    if (!IsEmptyString(self.vipPay)) {
        
        [self render];
        
    }else {
    
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];

        [params setSafeObject:self.orders forKey:@"orders"];
        [params setSafeObject:self.type forKey:@"type"];
        
        [CashierRequest getCashierDataWithParams:params success:^(CashierResultModel *resultModel) {
            
            if (resultModel) {
                self.resultModel = resultModel;
                self.totalPrice = resultModel.totalPrice;
                self.failureLink = resultModel.failLink;
                self.successLink = resultModel.successLink;
                self.payId = resultModel.payId;
    //            [self hideErrorTips];
                
                [self render];
            }
            
        } failure:^(StatusModel *status) {
            
            DBG(@"%@", status);
            
            [self showNotice:status.msg];
            
    //        [self showErrorTips];
            
        }];
    }
}

- (void)render {
    
    //[self.view addSubview:self.balanceView];
    [self.view addSubview:self.alipayView];
    [self.view addSubview:self.weixinView];
    [self.view addSubview:self.lineView];
    
//    if (!self.resultModel.showWeiXin) {
//        self.weixinView.hidden = YES;
//    }else{
        self.weixinView.hidden = ![WXApi isWXAppInstalled];
//    }
    
//
//    if ( self.canUsePoint ) {
//        [self pointSwitch:self.pointSwitchView didOn:YES];
//    }
    
    self.totalBarView = [[CATotalBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, TOTAL_BAR_VIEW_HEIGHT) totalPrice:self.totalPrice balance:self.balance canUseBalance:NO];
    self.totalBarView.bottom = self.view.height;
    self.totalBarView.delegate = self;
    [self.view addSubview:self.totalBarView];
    
}

- (void) clickback {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要退出支付？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}


- (void) payByAlipay {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setSafeObject:self.payId forKey:@"payId"];

    if (self.from) {
        [params setSafeObject:self.from forKey:@"from"];
    }
    
    [CashierRequest getAlipaySignWithParams:params success:^(ThirdPayResultModel *resultModel) {
        
        DBG(@"%@", resultModel);
        
        [AlipayManager sharedManager].completion = ^(NSDictionary *resultDic) {
            DBG(@"reslut = %@",resultDic);
            NSString *resultStatus = resultDic[@"resultStatus"];
            if ( ![@"9000" isEqualToString:resultStatus]) {
                //[self showAlert:resultDic[@"memo"]];
            } else {
                [self paySuccess];
            }
        };
        //发起支付，不再单独指定支付完成的处理
        [[AlipayManager sharedManager] payOrder:resultModel.sign callback:nil];
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
        
        DBG(@"%@", status);
        
    }];
    
}

- (void) payByWeixin {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setSafeObject:self.payId forKey:@"payId"];

    if (self.from) {
        [params setSafeObject:self.from forKey:@"from"];
    }
    
    [CashierRequest getWeixinSignWithParams:params success:^(ThirdPayResultModel *resultModel) {
        
        DBG(@"%@", resultModel);
        
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = resultModel.partnerid;
        request.prepayId= resultModel.prepayid;
        request.package = resultModel.package;;
        request.nonceStr= resultModel.noncestr;
        request.timeStamp = [resultModel.timestamp intValue];
        request.sign= resultModel.sign;
        [WXApi sendReq:request];
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
        
        DBG(@"%@", status);
        
    }];
    
}

- (void) payByBalance {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setSafeObject:self.payId forKey:@"orders"];
    
    [CashierRequest balancePayWithParams:params success:^{
        
        [self paySuccess];
        
    } failure:^(StatusModel *status) {
        
        [self showNotice:status.msg];
        
        DBG(@"%@", status);
        
    }];
    
}


- (void)paySuccess
{
    
    [self showNotice:@"支付成功"];

//    [self showNotice:@"支付成功"];

    if ( !IsEmptyString(self.successLink)) {
        
        weakify(self);
        
        [[[ApplicationEntrance shareEntrance] currentNavigationController] popViewControllerAnimated:NO onCompletion:^{
            
            strongify(self);
            
            [[TTNavigationService sharedService] openUrl:self.successLink];
            
        }];
        
    } else {
        
        [super clickback];
        
    }
}

#pragma mark - Getters And Setters

//- (PayChannelView *)balanceView {
//    
//    if ( !_balanceView ) {
//        
//        _balanceView = [[PayChannelView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 14, SCREEN_WIDTH, 54) iconName:@"icon_balance" channelName:@"红包余额" description:[NSString stringWithFormat:@"可用金额%@元", self.balance]];
//        _balanceView.delegate = self;
//    }
//    
//    return _balanceView;
//}

- (PayChannelView *)alipayView {
    
    if ( !_alipayView ) {
        
        _alipayView = [[PayChannelView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 14, SCREEN_WIDTH, 54) iconName:@"icon_alipay" channelName:@"支付宝支付" description:@""];
        _alipayView.delegate = self;
    }
    
    return _alipayView;
}

- (PayChannelView *)weixinView {
    
    if ( !_weixinView ) {
        
        _weixinView = [[PayChannelView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT + 68, SCREEN_WIDTH, 54) iconName:@"icon_weixin" channelName:@"微信支付" description:@""];
        _weixinView.delegate = self;
        _weixinView.hidden = NO;
    }
    
    return _weixinView;
}

- (UIView *)lineView {
    
    if ( !_lineView ) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(13, NAVBAR_HEIGHT + 68 - LINE_WIDTH, SCREEN_WIDTH - 13 * 2, LINE_WIDTH)];
        _lineView.backgroundColor = Color_Gray230;
        
    }
    
    return _lineView;
    
}

#pragma mark - CATotalBarDelegate

- (void)payButtonDidClick {
    
//    if ( self.balanceView.selected && [self.totalPrice floatValue] <= [self.balance floatValue] ) {
//        DBG(@"use balance");
//        
//        [self payByBalance];
//        
//    }
//    if (self.pointSwitchView.selected) {
//        [self payByPoint];
//    }
//    
    if ( self.alipayView.selected ) {
        DBG(@"use alipay");
        
        [self payByAlipay];
        
    } else if ( self.weixinView.selected ) {
        DBG(@"use weixin");
        
        [self payByWeixin];
        
    } else {
        
        [self showNotice:@"请选择支付方式"];
        
        DBG(@"nothing");
    }
    
}

#pragma mark - PayChannelDelegate

- (void)payChannelView:(PayChannelView *)payChannelView didSelect:(BOOL)selected {
    
    if ( selected ) {
        
        self.alipayView.selected = NO;
        self.weixinView.selected = NO;
        //self.balanceView.selected = NO;

        payChannelView.selected = selected;
        
    }

}

#pragma mark - TTErrorTipsViewDelegate

- (void)errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark - WXApiManagerDelegate

- (void)managerDidRecvPayResponse:(PayResp *)response{
    
    NSString *wexinReturnCode = [NSString stringWithFormat:@"%d",response.errCode];
    
    DBG(@"%@", response);
    
    if ( ![@"0" isEqualToString:wexinReturnCode]) {
        
        [self showNotice:response.errStr];
    
    } else {
        
        [self paySuccess];
        
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    DBG(@"%ld", (long)buttonIndex);
    
    if ( 1 == buttonIndex ) {
    
        if ( !IsEmptyString(self.failureLink)) {
            
            weakify(self);
            
            [[[ApplicationEntrance shareEntrance] currentNavigationController] popViewControllerAnimated:NO onCompletion:^{
                
                strongify(self);
                
                [[TTNavigationService sharedService] openUrl:self.failureLink];
                
            }];
        } else {
            [super clickback];
        }
        
    }
    
}
@end
