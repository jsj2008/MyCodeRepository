//
//  BackgroundManger.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BackgroundLayoutCenter.h"
#import "IOSLayoutDefine.h"
#import "LeftTableViewCell.h"
#import "LangCaptain.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"

#import "LeftTableView.h"
#import "AccountMarginCallStatusView.h"
#import "SystemMainConfigView.h"
#import "AboutView.h"
#import "OpenFailedView.h"
#import "OpenSuccessView.h"
#import "TradeResultFailedView.h"
#import "TradeResultSuccessView.h"
#import "HedgingView.h"
#import "ClosePositionView.h"
#import "InstrumentPickView.h"
#import "KChartNumberView.h"
#import "DatePickView.h"
#import "InstrumentConfigView.h"
#import "CustomAmountView.h"
#import "LoginPwdView.h"
#import "PhonePinPwdView.h"

#import "RssResourceView.h"
#import "RssModifyView.h"

#import "CertificateUnloadView.h"
#import "CertificateLoadView.h"
#import "CertificatePwdInputView.h"

#import "IosLogic.h"
#import "LayoutCenter.h"

#import "LeftContentView.h"
#import "ClosePositionHisBackView.h"
#import "OrderHisBackView.h"

#import "OperationRecordsSave.h"
#import "OptRecordTable.h"

@interface BackgroundLayoutCenter() {
    UIView                      *_touchableView;
    
    LeftTableView               *_leftScrollView;
    AccountMarginCallStatusView *_accountMarginCallStatusView;
    SystemMainConfigView        *_systemConfigView;
    CustomAmountView            *_customAmountView;
    AboutView                   *_abountView;
    OpenFailedView              *_openFailedView;
    OpenSuccessView             *_openSuccessView;
    TradeResultFailedView       *_tradeResultFailedView;
    TradeResultSuccessView      *_tradeResultSuccessView;
    
    HedgingView                 *_hedgingView;
    ClosePositionHisBackView    *_closePositionHisBackView;
    OrderHisBackView            *_orderHisBackView;
    
    ClosePositionView           *_closePositionView;
    InstrumentConfigView        *_instrumentOrderView;
    LoginPwdView                *_loginPwdView;
    PhonePinPwdView             *_phonePinPwdView;
    
    CertificateUnloadView       *_certificateUnloadView;
    CertificateLoadView         *_certificateLoadView;
    CertificatePwdInputView     *_certificatePwdInputView;
    
    RssModifyView               *_rssModifyView;
    RssResourceView             *_rssResourceView;
    
    InstrumentPickView          *_instrumentPickView;
    KChartNumberView            *_kchartNumberView;
    DatePickView                *_datePickView;
}

//@property UIImage       *backgroundImage;

@end

@implementation BackgroundLayoutCenter

@synthesize mainBackgroundView;

- (id)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

#pragma init
- (void)initComponent {
    [self initBackgroundView];
    [self initClosePositionHisBackView];
    [self initOrderHisBackView];
}

- (void)initBackgroundView {
    self.mainBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.mainBackgroundView setHidden:true];
    [mainBackgroundView setBackgroundColor:[UIColor colorWithRed:20.0f/255.0f
                                                          green:20.0f/255.0f
                                                           blue:20.0f/255.0f
                                                          alpha:0.7]];
    _touchableView = [[UIView alloc] initWithFrame:self.mainBackgroundView.bounds];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(closeAllView)];
    [_touchableView addGestureRecognizer:tapGesture];
    [self.mainBackgroundView addSubview:_touchableView];
}

- (void)initLeftScrollView {
    _leftScrollView = [[LeftTableView alloc] init];
    [_leftScrollView setHidden:true];
    [mainBackgroundView addSubview:_leftScrollView];
}

- (ClosePositionView *)getClosePositionView {
    return _closePositionView;
}

- (HedgingView *)getHedgingView {
    return _hedgingView;
}

- (ClosePositionHisBackView *)getClosePositionHisBackView {
    return _closePositionHisBackView;
}

- (OrderHisBackView *)getOrderHisBackView {
    return _orderHisBackView;
}

- (void)addView:(BackgoundContentView *)view withStyle:(MainViewStyle)style {
    [view setStyle:style];
    [view setHidden:true];
    [mainBackgroundView addSubview:view];
}

- (void)initAccountMarginCallView {
    _accountMarginCallStatusView = [[AccountMarginCallStatusView alloc] init];
    [self addView:_accountMarginCallStatusView withStyle:MainViewStyleMiddle];
}

- (void)initSystemConfigView {
    _systemConfigView = [[SystemMainConfigView alloc] init];
    [self addView:_systemConfigView withStyle:MainViewStyleMiddle];
}

- (void)initAboutView {
    _abountView = [[AboutView alloc] init];
    [self addView:_abountView withStyle:MainViewStyleMiddle];
}

- (void)initLoginPwdView {
    _loginPwdView = [[LoginPwdView alloc] init];
    [self addView:_loginPwdView withStyle:MainViewStyleMiddle];
}

- (void)initPhonePinPwdView {
    _phonePinPwdView = [[PhonePinPwdView alloc] init];
    [self addView:_phonePinPwdView withStyle:MainViewStyleMiddle];
}

- (void)initCustomAmountView {
    _customAmountView = [[CustomAmountView alloc] init];
    [self addView:_customAmountView withStyle:MainViewStyleSmall];
}

- (void)initInstrumentOrderView {
    _instrumentOrderView = [[InstrumentConfigView alloc] init];
    [self addView:_instrumentOrderView withStyle:MainViewStyleMiddle];
}

- (void)initOpenFailedView {
    _openFailedView = [[OpenFailedView alloc] init];
    [self addView:_openFailedView withStyle:MainViewStyleSmall];
}

- (void)initOpenSuceesView {
    _openSuccessView = [[OpenSuccessView alloc] init];
    [self addView:_openSuccessView withStyle:MainViewStyleSmall];
}

- (void)initTradeResultFailedView {
    _tradeResultFailedView = [[TradeResultFailedView alloc] init];
    [self addView:_tradeResultFailedView withStyle:MainViewStyleSmall];
}

- (void)initTradeResultSuccessView {
    _tradeResultSuccessView = [[TradeResultSuccessView alloc] init];
    [self addView:_tradeResultSuccessView withStyle:MainViewStyleSmall];
}

- (void)initHedgingView {
    _hedgingView = [[HedgingView alloc] init];
    [self addView:_hedgingView withStyle:MainViewStyleBig];
}

- (void)initClosePositionHisBackView {
    _closePositionHisBackView = [[ClosePositionHisBackView alloc] init];
    [self addView:_closePositionHisBackView withStyle:MainViewStyleFullScreen];
}

- (void)initOrderHisBackView {
    _orderHisBackView = [[OrderHisBackView alloc] init];
    [self addView:_orderHisBackView withStyle:MainViewStyleFullScreen];
}

- (void)initClosePositionView {
    _closePositionView = [[ClosePositionView alloc] init];
    [self addView:_closePositionView withStyle:MainViewStyleSmall];
}

- (void)initInstrumentPickView {
    _instrumentPickView = [[InstrumentPickView alloc] init];
    [self addView:_instrumentPickView withStyle:MainViewStyleHalf];
}

- (void)initKChartNumberView {
    _kchartNumberView = [[KChartNumberView alloc] init];
    [self addView:_kchartNumberView withStyle:MainViewStyleHalf];
}

- (void)initDatePickView {
    _datePickView = [[DatePickView alloc] init];
    [self addView:_datePickView withStyle:MainViewStyleHalf];
}

- (void)initCertificateUnloadView {
    _certificateUnloadView = [[CertificateUnloadView alloc] init];
    [self addView:_certificateUnloadView withStyle:MainViewStyleSmall];
}

- (void)initCertificateLoadView {
    _certificateLoadView = [[CertificateLoadView alloc] init];
    [self addView:_certificateLoadView withStyle:MainViewStyleMiddle];
}

- (void)initCertificatePwdInputView {
    _certificatePwdInputView = [[CertificatePwdInputView alloc] init];
    [self addView:_certificatePwdInputView withStyle:MainViewStyleMiddle];
}

- (void)initRssModifyView {
    _rssModifyView = [[RssModifyView alloc] init];
    [self addView:_rssModifyView withStyle:MainViewStyleSmall];
}

- (void)initRssResourceView {
    _rssResourceView = [[RssResourceView alloc] init];
    [self addView:_rssResourceView withStyle:MainViewStyleMiddle];
}

#pragma action
- (void)closeAllView {
    for (UIView *subView in [mainBackgroundView subviews]) {
        if ([subView isKindOfClass:[BackgoundContentView class]]) {
            [self closeView:(BackgoundContentView *)subView];
        }
    }
}

- (void)showLeftScrollView {
    if (_leftScrollView == nil) {
        [self initLeftScrollView];
    }
    [self openView:_leftScrollView];
}

- (void)showAccountMarginCallStatus {
    
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ACCOUNT subType:APP_OPT_TYPE_NONE];
    
    if (_accountMarginCallStatusView == nil) {
        [self initAccountMarginCallView];
    }
    [self openView:_accountMarginCallStatusView];
}

- (void)showSystemConfigView {
    if (_systemConfigView == nil) {
        [self initSystemConfigView];
    }
    [self openView:_systemConfigView];
}

- (void)showAboutView {
    if (_abountView == nil) {
        [self initAboutView];
    }
    [self openView:_abountView];
}

- (void)showLoginPwdView {
    if (_loginPwdView == nil) {
        [self initLoginPwdView];
    }
    [self openView:_loginPwdView];
}

- (void)showPhonePinPwdView {
    if (_phonePinPwdView == nil) {
        [self initPhonePinPwdView];
    }
    [self openView:_phonePinPwdView];
}

- (void)showCertificatePwdInputView {
    if (_certificatePwdInputView == nil) {
        [self initCertificatePwdInputView];
    }
    [self openView:_certificatePwdInputView];
}

- (void)showCertificateLoadView {
    if (_certificateLoadView == nil) {
        [self initCertificateLoadView];
    }
    [self openView:_certificateLoadView];
}

- (void)showCertificateUnloadView {
    if (_certificateUnloadView == nil) {
        [self initCertificateUnloadView];
    }
    [self openView:_certificateUnloadView];
}

- (void)showRssModifyView {
    if (_rssModifyView == nil) {
        [self initRssModifyView];
    }
    [self openView:_rssModifyView];
}

- (void)showRssResourceView {
    if (_rssResourceView == nil) {
        [self initRssResourceView];
    }
    [self openView:_rssResourceView];
}

- (void)showCustomAmountView {
    if (_customAmountView == nil) {
        [self initCustomAmountView];
    }
    [self openView:_customAmountView];
}

- (void)showInstrumentOrderView {
    if (_instrumentOrderView == nil) {
        [self initInstrumentOrderView];
    }
    [self openView:_instrumentOrderView];
}

- (void)showOpenFailedView {
    if (_openFailedView == nil) {
        [self initOpenFailedView];
    }
    [self openView:_openFailedView];
}

- (void)showOpenSuccessView {
    if (_openSuccessView == nil) {
        [self initOpenSuceesView];
    }
    [self openView:_openSuccessView];
}

- (void)showTradeResultFailedView {
    if (_tradeResultFailedView == nil) {
        [self initTradeResultFailedView];
    }
    [self openView:_tradeResultFailedView];
}

- (void)showTradeResultSuccessView {
    if (_tradeResultSuccessView == nil) {
        [self initTradeResultSuccessView];
    }
    [self openView:_tradeResultSuccessView];
}

- (void)showHedgingView {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_OPEN subType:APP_OPT_TYPE_OPEN_ITEM_5];
    if (_hedgingView == nil) {
        [self initHedgingView];
    }
    [self openView:_hedgingView];
}

- (void)showClosePositionHisBackView {
    if (_closePositionHisBackView == nil) {
        [self initClosePositionHisBackView];
    }
    [self openView:_closePositionHisBackView];
}

- (void)showOrderHisBackView {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_ORDERHIS subType:APP_OPT_TYPE_ORDERHIS_ITEM_1];
    if (_orderHisBackView == nil) {
        [self initOrderHisBackView];
    }
    [self openView:_orderHisBackView];
}

- (void)showClosePositionView {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_CLOSEHIS subType:APP_OPT_TYPE_CLOSEHIS_ITEM_1];
    if (_closePositionView == nil) {
        [self initClosePositionView];
    }
    [self openView:_closePositionView];
}

- (void)showInstrumentPickView {
    if (_instrumentPickView == nil) {
        [self initInstrumentPickView];
    }
    [self openView:_instrumentPickView];
}

- (void)showKChartNumberView {
    if (_kchartNumberView == nil) {
        [self initKChartNumberView];
    }
    [self openView:_kchartNumberView];
}

- (void)showDatePickView {
    if (_datePickView == nil) {
        [self initDatePickView];
    }
    [self openView:_datePickView];
}

//-------
- (void)closeView:(BackgoundContentView *)view {
    if (view.status == Opened) {
        [view closeView];
    }
}

- (void)openView:(BackgoundContentView *)view {
    //    if (view.status == Closed) {
    [view openView];
    //    }
    
    //    if (view.status == Opened) {
    //        // 如果是對衝界面， 則刷新， 先這麼寫
    //        if ([view isKindOfClass:[HedgingView class]]) {
    //            [view openView];
    //        }
    //    }
}

#pragma jump

- (void)leftScrollViewClickAtInde:(LeftViewSelectIndex)selectIndex {
    switch (selectIndex) {
        case EQuoteListView://000
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_QuoteList];
            break;
        case EOpenPositionView://001
            [[[LayoutCenter getInstance] mainViewLayoutCenter] showBottomView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OpenPosition];
            break;
        case EOrderPositionView://002
            [[[LayoutCenter getInstance] mainViewLayoutCenter] showBottomView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OrderPosition];
            break;
        case EOrderHisView://003
            [[[LayoutCenter getInstance] mainViewLayoutCenter] showBottomView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_OrderHis];
            [self showOrderHisBackView];
            break;
        case EClosePositionView://004
            [[[LayoutCenter getInstance] mainViewLayoutCenter] showBottomView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_ClosePositionHis];
            [self showClosePositionHisBackView];
            break;
        case EPositionSumView://005
            [[[LayoutCenter getInstance] mainViewLayoutCenter] showBottomView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_PositionSum];
            break;
        case EPriceWarningView://006
            [[[LayoutCenter getInstance] mainViewLayoutCenter] showBottomView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] didClickAtFunction:Function_Bottom_PriceWarning];
            break;
        case EForexNewsView://100
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_News];
            break;
        case EMarginCallView://101
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_MargincallHis];
            break;
        case EMessageView://200
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_Message];
            break;
        case ESystemConfigView://201
            [self showSystemConfigView];
            break;
        case EAbountView://202
            [self showAboutView];
            break;
        case ELogoutFromServer://203
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] saveCurrentData];
            [[IosLogic getInstance] logoutFromServer];
            break;
        default:
            break;
    }
}

#pragma public func
- (void)effectiveTouchBackView {
    [_touchableView setHidden:false];
}

- (void)uneffectiveTouchBackView {
    [_touchableView setHidden:true];
}

- (void)resetPhonePinState {
    if (_accountMarginCallStatusView == nil) {
        [self initAccountMarginCallView];
    }
    [_accountMarginCallStatusView resetPhonePinState];
}

- (void)resetLayout {
    [mainBackgroundView setNeedsLayout];
    [mainBackgroundView layoutIfNeeded];
    for (UIView *view in [mainBackgroundView subviews]) {
        [view setNeedsLayout];
        [view layoutIfNeeded];
    }
}

@end
