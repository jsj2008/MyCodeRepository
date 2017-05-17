//
//  BackgroundManger.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundStatusEnum.h"

@class ClosePositionView;
@class HedgingView;

@interface BackgroundLayoutCenter : NSObject

@property (nonatomic, strong) UIView *mainBackgroundView;

- (void)showLeftScrollView;
- (void)showAccountMarginCallStatus;
//- (void)showAboutView;
- (void)showOpenFailedView;
- (void)showOpenSuccessView;

- (void)showTradeResultFailedView;
- (void)showTradeResultSuccessView;

- (void)showHedgingView;
- (void)showClosePositionView;
- (void)showCustomAmountView;
- (void)showLoginPwdView;
- (void)showPhonePinPwdView;

- (void)showCertificatePwdInputView;
- (void)showCertificateLoadView;
- (void)showCertificateUnloadView;

- (void)showRssModifyView;
- (void)showRssResourceView;

- (void)showInstrumentPickView;
- (void)showKChartNumberView;
- (void)showDatePickView;

- (void)showSystemConfigView;

- (void)showInstrumentOrderView;

- (void)resetPhonePinState;

- (void)effectiveTouchBackView;
- (void)uneffectiveTouchBackView;

- (void)leftScrollViewClickAtInde:(LeftViewSelectIndex)selectIndex;

- (void)closeAllView;

// 为了 电话密码输入
- (ClosePositionView *)getClosePositionView;
- (HedgingView *)getHedgingView;

- (void)resetLayout;

@end
