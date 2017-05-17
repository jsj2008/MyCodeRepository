//
//  PhonePinChecker.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PhonePinChecker.h"
#import "LayoutCenter.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "JumpDataCenter.h"

static const int Min30 = 1800;

static PhonePinChecker *instance = nil;

static Boolean isTouchTime              = true;

@interface PhonePinChecker() {
    Boolean isNeedResetTimer;
    
    long long _corssTime;
    Boolean isDestroy;
}

@end

@implementation PhonePinChecker

+ (PhonePinChecker *)getInstance {
    if (instance == nil) {
        instance = [[PhonePinChecker alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        isNeedResetTimer = false;
        _corssTime = 0;
        isDestroy = false;
    }
    return self;
}

- (void)destroy {
    isDestroy = true;
    instance = nil;
}

// 每次交易需要检查
- (Boolean)checkPhonePinByValidate {
    
    // 若 phonePin 为空， 则需要输入
    NSString *phonePin = [[JumpDataCenter getInstance] phonePin];
    if (phonePin == nil || [phonePin length] == 0) {
        return false;
    }
    
    // 若 时间 已经超过， 则需要输入
    if (isTouchTime) {
        return false;
    }
    
    long long account = [[ClientAPI getInstance] accountID];
    int checkType = [[TradeApi getInstance] checkAccount:account
                                                phonePin:phonePin];
    // 若 原始密码 不对， 则需要输入。 包括 密码不对， 后台密码修改， 网络错误。
    // 若 成功 重置密码时间
    if (checkType != CA_TRADE_SUCCEED) {
        isTouchTime = true;
        return false;
    } else {
        [self resetTimeTick];
    }
    
    return true;
}

// 用来显示 状态
- (Boolean)checkIsneedputPhonePin {
    return isTouchTime;
}

- (void)resetTimeTick {
    if (isTouchTime) {
        [self startTimeTick];
    } else {
        isNeedResetTimer = true;
    }
}

- (void)resetByTime:(long long)crossTime {
    if (!isTouchTime) {
        _corssTime = crossTime;
    }
}

- (void)startTimeTick {
    __block int timeout = Min30; //倒计时时间
    isTouchTime = false;
    [self resetViewState];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            isTouchTime = true;
            [self resetViewState];
        } else {
            if (isTouchTime) {
                timeout = 0;
            }
            NSLog(@"%d", timeout);
            if (isNeedResetTimer) {
                timeout = Min30;
                isNeedResetTimer = false;
                [self resetViewState];
            }
            timeout--;
            if (_corssTime != 0) {
                timeout -= _corssTime;
                _corssTime = 0;
            }
            
            if (isDestroy) {
                timeout = 0;
            }
        }
    });
    
    dispatch_resume(_timer);
}

- (void)resetViewState {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[[LayoutCenter getInstance] mainViewLayoutCenter] topContentView] resetPhonePinState];
        [[[LayoutCenter getInstance] backgroundLayoutCenter] resetPhonePinState];
    });
}

@end
