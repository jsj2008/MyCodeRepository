//
//  KChartWebView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/7.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "KChartWebView.h"
#import "QuoteDataStore.h"
#import "ShowAlertManager.h"
#import "LangCaptain.h"
#import "KChartViewUtils.h"
#import "QuoteView.h"
#import "QuoteTouchableView.h"
#import "UIView+AutoLayout.h"
#import "APIDoc.h"

#import "LayoutCenter.h"

#import "KChartToolBar.h"
#import "TiArgumentView.h"

#import "MActivityIndicatorView.h"
#import "HistoricData.h"

#import "TiArgumentConfig.h"
#import "QuoteChartManager.h"

#import "KChartSaveData.h"
#import "KChartParamDefine.h"
#import "ParamTable.h"

#import "UIColor+CustomColor.h"
#import "MAData.h"
#import "ClientAPI.h"
#import "CommDataUtil.h"
#import "JumpDataCenter.h"
#import "IosLogic.h"

#import "DecimalUtil.h"

const static CGFloat viewEdge = 2.0f;
const static CGFloat maxMinButtonLength = 50.0f;

@interface KChartWebView()<UIWebViewDelegate, API_Event_QuoteDataStore, chooseProtocol> {
    // 状态
    Boolean _isEnlarge;// 最大化按钮
    Boolean _isShow;// 是否交易界面
    
    NSString *_instrumentName;
    
    // 控件
    UIButton *_maxMinButton;
    MActivityIndicatorView *mIndicatorView;
    KChartToolBar *_kChartToolBar;
    
    // KChart 标志
    ViewName viewName;
    Boolean isInited;
    Boolean isLoading;
    
    UITapGestureRecognizer *touchableViewGesture;
    UITapGestureRecognizer *leftViewGesture;
    UITapGestureRecognizer *rightViewGesture;
    // KChart 属性
    //    ChartCycleType _cycleTypeDefine;
    //    NSString *_instrumentName;
    
    //    TiArgumentConfig *_tiArgumentConfig;
    
    //    NSNumberFormatter *format;
    
    TiArgumentView *_tiArgumentView;
}

@property QuoteTouchableView *quoteTouchableView;



@end

@implementation KChartWebView

@synthesize quoteTouchableView;

//@synthesize instrumentName = _instrumentName;

- (void)setInstrumentName:(NSString *)instrumentName {
    _instrumentName = instrumentName;
    [[QuoteChartManager getInstance] setInstrument:instrumentName byViewName:viewName];
}

- (NSString *)getInstrumentName {
    return _instrumentName;
}

//@synthesize isNeedShow;
@synthesize webView;

- (id)initWithName:(ViewName)kChartName {
    if (self = [super init]) {
        viewName = kChartName;
        [self initComponent];
        [self addMaxMinButton];
        [self initKChartToolBar];
        [self addQuoteTouchView];
        [self initDefault];
        [self initTiArgumentView];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

-(void)initComponent {
    isInited = true;
    isLoading = false;
    [self initWebView];
}

- (void)addMaxMinButton {
    _maxMinButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, maxMinButtonLength, maxMinButtonLength)];
    [_maxMinButton setBackgroundImage:[UIImage imageNamed:@"images/kChartImage/KChartMaxMin"] forState:UIControlStateNormal];
    [_maxMinButton setBackgroundColor:[UIColor clearColor]];
    [_maxMinButton addTarget:self action:@selector(maxMinClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.webView addSubview:_maxMinButton];
    [_maxMinButton setHidden:true];
}

- (void)addQuoteTouchView {
    self.quoteTouchableView = [QuoteTouchableView newInstance];
    [self.quoteTouchableView.quoteView.instrumentLabel addGestureRecognizer:[self getTouchableViewGesture]];
    [self.quoteTouchableView.quoteView.leftSubview addGestureRecognizer:[self getLeftClickViewGesture]];
    [self.quoteTouchableView.quoteView.rightSubview addGestureRecognizer:[self getRightClickViewGesture]];
    
    [self.quoteTouchableView setFrame:CGRectMake(0, 0, 200, 60)];
    [self.webView addSubview:self.quoteTouchableView];
}

- (UIGestureRecognizer *)getTouchableViewGesture {
    if (touchableViewGesture == nil) {
        touchableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInstrument)];
    }
    return touchableViewGesture;
}

- (UIGestureRecognizer *)getLeftClickViewGesture {
    if (leftViewGesture == nil) {
        leftViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToCreateSellMarketView)];
    }
    return leftViewGesture;
}

- (UIGestureRecognizer *)getRightClickViewGesture {
    if (rightViewGesture == nil) {
        rightViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToCreateBuyMarketView)];
    }
    return rightViewGesture;
}

- (void)selectInstrument {
    [[JumpDataCenter getInstance] setKChartWebView:self];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showInstrumentPickView];
}

- (void)jumpToCreateSellMarketView {
    NSString *instrumentName = quoteTouchableView.quoteView.instrumentLabel.text;
    if (instrumentName == nil || [instrumentName isEqualToString:@""]) {
        return;
    }
    
    //    if (_isEnlarge) {
    //        [self maxMinClick:nil];
    //    }
    
    [[JumpDataCenter getInstance] setCreateTradeInstrument:instrumentName];
    [[JumpDataCenter getInstance] setMarketTradeType:SELL];
    int index = (int)[[[LayoutCenter getInstance] quoteChartLayoutCenter] getIndexOfKchartView:self];
    [[JumpDataCenter getInstance] setTradeShowIndex:index];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_MarketTrade];
    [self showCurrentKChartView];
    //    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:instrumentName];
}

- (void)jumpToCreateBuyMarketView {
    NSString *instrumentName = quoteTouchableView.quoteView.instrumentLabel.text;
    if (instrumentName == nil || [instrumentName isEqualToString:@""]) {
        return;
    }
    //
    ////    if (_isEnlarge) {
    ////        [self maxMinClick:nil];
    ////    }
    
    [[JumpDataCenter getInstance] setCreateTradeInstrument:instrumentName];
    [[JumpDataCenter getInstance] setMarketTradeType:BUY];
    int index = (int)[[[LayoutCenter getInstance] quoteChartLayoutCenter] getIndexOfKchartView:self];
    [[JumpDataCenter getInstance] setTradeShowIndex:index];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_MarketTrade];
    [self showCurrentKChartView];
    //    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:instrumentName];
    //    [self showCurrentKChartView];
}

- (void)showCurrentKChartView {
    
    [_kChartToolBar setHidden:false];
    NSUInteger index = [[[LayoutCenter getInstance] quoteChartLayoutCenter] getIndexOfKchartView:self];
    [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:index];
    //    [self.quoteTouchableView setHidden:true];
    //    [_maxMinButton setHidden:true];
    //    _isEnlarge = !_isEnlarge;
}


- (void)initDefault {
    _isEnlarge = false;
    _isShow = false;
    //    _cycleTypeDefine = 301;
}

- (void)addListener {
    [self removeListener];
    [API_IDEventCaptain addListener:DATA_ON_Order_Changed observer:self listener:@selector(orderChange)];
    
}
- (void)removeListener {
    [API_IDEventCaptain removeListener:DATA_ON_Order_Changed observer:self];
    
}

- (void)initIndicatorView {
    mIndicatorView = [[MActivityIndicatorView alloc] init];
}

- (void)initKChartToolBar {
    _kChartToolBar = [[KChartToolBar alloc] initWithFrame:CGRectZero];
    [_kChartToolBar setHidden:true];
    [_kChartToolBar.chooseView setHidden:true];
    [self addSubview:_kChartToolBar];
    [self addSubview:_kChartToolBar.chooseView];
    [self addSubview:_kChartToolBar.chooseView.subChooseView];
    [_kChartToolBar.chooseView setDelegate:self];
    [_kChartToolBar.chooseView.subChooseView setDelegate:self];
    
    [_kChartToolBar.backButton         addTarget:self action:@selector(addBackAction) forControlEvents:UIControlEventTouchUpInside];
    [_kChartToolBar.kChartTypeButton   addTarget:self action:@selector(addKChartTypeAction) forControlEvents:UIControlEventTouchUpInside];
    [_kChartToolBar.cycleTypeButton    addTarget:self action:@selector(addCycleTypeAction) forControlEvents:UIControlEventTouchUpInside];
    [_kChartToolBar.technologyTypeButton addTarget:self action:@selector(addTechnologyTypeAction) forControlEvents:UIControlEventTouchUpInside];
    [_kChartToolBar.clearAllButton     addTarget:self action:@selector(addClearAllAction) forControlEvents:UIControlEventTouchUpInside];
    [_kChartToolBar.addOrderButton     addTarget:self action:@selector(addOrderLineAction) forControlEvents:UIControlEventTouchUpInside];
    [_kChartToolBar.drawLineButton     addTarget:self action:@selector(addDrawLineAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initTiArgumentView {
    _tiArgumentView = [TiArgumentView newInstance];
    [self addSubview:_tiArgumentView];
    [_tiArgumentView setHidden:true];
    [_tiArgumentView.commitButton addTarget:self action:@selector(commitArgument) forControlEvents:UIControlEventTouchUpInside];
    [_tiArgumentView.backButton addTarget:self action:@selector(removeTiView) forControlEvents:UIControlEventTouchUpInside];
    [_tiArgumentView.resetButton addTarget:self action:@selector(resetArgument) forControlEvents:UIControlEventTouchUpInside];
}
//- (void)initTiArgumentConfig {
//    _tiArgumentConfig = [[TiArgumentConfig alloc] init];
//}

- (void)addGestureRecognizer {
    //    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick)];
    //    [self.webView addGestureRecognizer:tapG];
}

- (void)hideValueInfo {
    [self.webView stringByEvaluatingJavaScriptFromString:@"hideValueInfo()"];
}

- (void)showValueInfo {
    [self.webView stringByEvaluatingJavaScriptFromString:@"showValueInfo()"];
}

- (void)maxMinClick:(id)sender {
    [[[LayoutCenter getInstance] mainViewLayoutCenter] enlargeRightView];
    if (_isEnlarge) {
        [self hideValueInfo];
        [_kChartToolBar setHidden:true];
        [_kChartToolBar.chooseView setHidden:true];
        [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:NormalScreenStatus];
        [self saveToJsonString];
    } else {
        [self showValueInfo];
        [_kChartToolBar setHidden:false];
        NSUInteger index = [[[LayoutCenter getInstance] quoteChartLayoutCenter] getIndexOfKchartView:self];
        [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:index];
        
        NSString *instrumentName = [[JumpDataCenter getInstance] enlargeInstrumentName];
        if (instrumentName != nil && ![instrumentName isEqualToString:@""]) {
            self.instrumentName = instrumentName;
            [self loadQuoteHisData];
            [[JumpDataCenter getInstance] setEnlargeInstrumentName:nil];
        }
    }
    _isEnlarge = !_isEnlarge;
}

// 做交易时候的 View 的布局
- (void)doTradeViewStatus:(Boolean)isShow {
    
    _isShow = isShow;
    if (_isEnlarge) {
        [[[LayoutCenter getInstance] mainViewLayoutCenter] enlargeRightView];
        _isEnlarge = !_isEnlarge;
    }
    
    if (isShow) {
        //        [quoteTouchableView removeGestureRecognizer:[self getTouchableViewGesture]];
        //        _isEnlarge = true;
        [self showValueInfo];
        [quoteTouchableView setHidden:true];
        [[[LayoutCenter getInstance] mainViewLayoutCenter] tradeStatusView];
        [[[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] hiddenButton] setHidden:true];
        [_kChartToolBar setHidden:false];
        [_kChartToolBar.backButton setEnabled:false];
        [_maxMinButton setHidden:true];
        NSUInteger index = [[[LayoutCenter getInstance] quoteChartLayoutCenter] getIndexOfKchartView:self];
        [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:index];
    } else {
        [self hideValueInfo];
        //        [quoteTouchableView addGestureRecognizer:[self getTouchableViewGesture]];
        //        _isEnlarge = false;
        [quoteTouchableView setHidden:false];
        [[[LayoutCenter getInstance] mainViewLayoutCenter] showBottomView];
        [[[[[LayoutCenter getInstance] mainViewLayoutCenter] bottomContentView] hiddenButton] setHidden:false];
        [_kChartToolBar setHidden:true];
        [_kChartToolBar.chooseView setHidden:true];
        [_kChartToolBar.backButton setEnabled:true];
        [_maxMinButton setHidden:false];
        [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:NormalScreenStatus];
        [self saveToJsonString];
    }
    
}

- (void)initWebView {
    self.webView = [[UIWebView alloc] init];
    [self.webView setDelegate:self];
    [self addSubview:self.webView];
    [self refreshWebView];
}

- (void)refreshWebView {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KChart/index"
                                                     ofType:@"html"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)loadQuoteHisData {
    if (isLoading) {
        return;
    }
    isLoading = true;
    [QuoteDataStore removeQuoteReceiver:self];
    [self removeListener];
    
    //    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self.webView];
    //    __block __weak id weakInstance = self;
    
    ChartCycleType cycleType = [[[QuoteChartManager getInstance] getSaveDataByViewName:viewName instrumentName:_instrumentName] chartCycleType];
    [self showWaitView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *jsonString = [KChartViewUtils queryHistoricData:_instrumentName cycle:cycleType];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [[ShowAlertManager getInstance] hidenAlertWaitView];
            //            [mIndicatorView hideCustomAlert];
            [self hiddenWaitView];
            
            if (isInited == false) {
                isLoading = false;
                [self loadQuoteHisData];
                return;
            }
            
            if (jsonString == nil || [jsonString isEqualToString:@""] || [jsonString isEqualToString:@"[]"]) {
                if (isInited == true) {
                    [self showWaitView];
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        // 网络请求失败、
                        [NSThread sleepForTimeInterval:0.8f];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            isLoading = false;
                            [self loadQuoteHisData];
                        });
                    });
                    return;
                }
                [[ShowAlertManager getInstance] showCustomAlertViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                                  andMessage:[[LangCaptain getInstance] getLangByCode:@"LoadingFailed"]
                                                                    delegate:nil];
                isLoading = false;
                return;
            }
            
            CDS_PriceSnapShot *pss = [[QuoteDataStore getInstance] getQuoteData:_instrumentName];
            if (pss == nil) {
                isLoading = false;
                [self loadQuoteHisData];
                return;
            }
            InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:_instrumentName];
            //            [self.quoteTouchableView.quoteView.leftSubview  updateValue:[instUtil formatClientPrice:[pss getBid] isFloor:true]];
            //            [self.quoteTouchableView.quoteView.rightSubview updateValue:[instUtil formatClientPrice:[pss getAsk] isFloor:true]];
            [self.quoteTouchableView.quoteView.leftSubview updateValue:[instUtil formatClientPrice:[pss getBid]]];
            [self.quoteTouchableView.quoteView.rightSubview updateValue:[instUtil formatClientPrice:[pss getAsk]]];
            [self.quoteTouchableView.quoteView.instrumentLabel setText:_instrumentName];
            
            NSString *instrumentSummary = [NSString stringWithFormat:@"%@, %@", _instrumentName, [KChartViewUtils getKChartCycleInputValue:cycleType]];
            
            int cycleValue = [KChartViewUtils getCycleValueByType:cycleType];
            NSString *returnCode = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"resetMockTicks(%@, %d, %d, '%@')",
                                                                                         jsonString, cycleValue, cycleValue, instrumentSummary]];
            if ([returnCode isEqualToString:@"false"]) {
                isLoading = false;
                [self loadQuoteHisData];
                return;
            }
            if (_isShow || _isEnlarge) {
                [self showValueInfo];
            } else {
                [self hideValueInfo];
            }
            [self restoreJsonString];
            //            [self reloadTi];
            [QuoteDataStore addQuoteReceiver:self];
            [self addListener];
            [self removeOrderLine];
            [self drawOrderLine];
            isLoading = false;
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] saveCurrentData];
        });
    });
}

- (void)showWaitView {
    if (mIndicatorView == nil) {
        [self initIndicatorView];
    }
    [mIndicatorView showCustomAlertViewOnView:self.webView
                                    withTitle:[[LangCaptain getInstance] getLangByCode:@"IsLoading"]
                                     withType:CustomAlertTypeWaiting];
}

- (void)hiddenWaitView {
    [mIndicatorView hideCustomAlert];
    mIndicatorView = nil;
}

#pragma data save store
- (void)restoreJsonString {
    // 还原技术指标
    KChartSaveData *saveData = [[QuoteChartManager getInstance] getSaveDataByViewName:viewName instrumentName:_instrumentName];
    [_kChartToolBar.chooseView setSaveData:saveData];
    [_kChartToolBar.chooseView.subChooseView setSaveData:saveData];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"doRevert()"]];
    if (_instrumentName != nil && ![_instrumentName isEqualToString:@""]) {
        NSString *json = [_kChartToolBar.chooseView.saveData tiJsonString];
        if (json == nil || [json isEqualToString:@""]) {
            json = [[LangCaptain getInstance] getLangByCode:@"DefaultConfig"];
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"restoreFromString('%@')", json]];
        } else {
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"restoreFromString('%@')", json]];
        }
    }
}

- (void)saveToJsonString {
    //    KChartSaveData *saveData = [[QuoteChartManager getInstance] getSaveDataByViewName:viewName instrumentName:_instrumentName];
    if (_instrumentName != nil && ![_instrumentName isEqualToString:@""]) {
        
        NSString *json = [self.webView stringByEvaluatingJavaScriptFromString:@"saveToString()"];
        if (json == nil || [json isEqualToString:@""]) {
            return;
        }
        [_kChartToolBar.chooseView.saveData setTiJsonString:json];
        
        // 從js 解析的參數 保存
        NSString *config = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getTiArgumentConfigList()"]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[KChartViewUtils parseParam:config]];
        [_kChartToolBar.chooseView.saveData setTiDictionary:dic];
        [_kChartToolBar.chooseView.saveData setInstrumentName:_instrumentName];
        
        [[QuoteChartManager getInstance] saveConfigData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect quoteViewRect = self.quoteTouchableView.frame;
    quoteViewRect.origin.x = 0.0f;
    quoteViewRect.origin.y = 0.0f;
    [self.quoteTouchableView setFrame:quoteViewRect];
    
    CGFloat toolbarHeight = 0.0f;
    if (![_kChartToolBar isHidden]) {
        toolbarHeight = KChartToolBarHeight;
    }
    
    CGRect webRect = self.bounds;
    webRect.origin.x = viewEdge;
    webRect.origin.y = viewEdge;
    webRect.size.width -= viewEdge;
    webRect.size.height -= (viewEdge + toolbarHeight);
    
    [self.webView setFrame:webRect];
    
    CGRect buttonRect = _maxMinButton.bounds;
    buttonRect.origin.x = self.webView.bounds.size.width - buttonRect.size.width;
    [_maxMinButton setFrame:buttonRect];
    
    CGRect toolBarRect = self.bounds;
    toolBarRect.origin.x = viewEdge;
    toolBarRect.origin.y = webRect.size.height;
    toolBarRect.size.width -= viewEdge;
    toolBarRect.size.height = KChartToolBarHeight;
    [_kChartToolBar setFrame:toolBarRect];
    [_kChartToolBar.chooseView setHidden:true];
    
    [_tiArgumentView setFrame:self.bounds];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"fouctOnLast()"];
}

#pragma WebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
    //    [NSThread detachNewThreadSelector:@selector(loadQuoteHisData) toTarget:self withObject:nil];
    __block __weak id weakInstance = self;
    if (_instrumentName != nil && ![_instrumentName isEqualToString:@""]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 留时间给 html5初始化、
            [NSThread sleepForTimeInterval:0.8f];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isInited == true) {
                    [weakInstance loadQuoteHisData];
                    [_maxMinButton setHidden:false];
                }
            });
        });
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
}

#pragma QuoteListener
- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:_instrumentName]) {
            HistoricData *data = [[HistoricData alloc] init];
            
            InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:[snapshot instrumentName]];
            // string 转double 没做判断
            //            double middlePrice = [[instUtil formatClientPrice:([snapshot getAsk] + [snapshot getBid]) / 2 isFloor:true] doubleValue];
            double middlePrice = [[instUtil formatClientPrice:([snapshot getAsk] + [snapshot getBid]) / 2] doubleValue];
            [data setHighPrice:middlePrice];
            [data setLowPrice:middlePrice];
            [data setOpenPrice:middlePrice];
            [data setClosePrice:middlePrice];
            
            NSDate *currentDate = [JEDIDateTime dateFromQuoteDay:[snapshot quoteDay]];
            
            int cycleValue = [KChartViewUtils getCycleValueByType:_kChartToolBar.chooseView.saveData.chartCycleType];
            long long time = [snapshot snapshotTime];
            
            switch (_kChartToolBar.chooseView.saveData.chartCycleType) {
                case ChartCycleDay:
                    time = [JEDIDateTime getTimeMillisForDate:currentDate];
                    break;
                case ChartCycleWeek:
                    time = [JEDIDateTime getTimeMillisForDate:[JEDIDateTime dayOfWeek:6 forDate:currentDate]];
                    break;
                case ChartCycleMonth:
                    time = [JEDIDateTime getTimeMillisForDate:currentDate];
                    break;
                case ChartCycleMin1:
                case ChartCycleMin5:
                case ChartCycleMin10:
                case ChartCycleMin15:
                case ChartCycleMin30:
                case ChartCycleMin60:
                case ChartCycleMin90:
                case ChartCycleMin180:
                case ChartCycleHour2:
                case ChartCycleHour4:
                case ChartCycleHour6:
                case ChartCycleHour8:
                    time = ceil((double)time / (double)(cycleValue * 60 * 1000)) * (cycleValue * 60 * 1000);
                    break;
                default:
                    break;
            }
            [data setDataTime:time];
            
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addMockTicks(%@, %d, %d)",
                                                                  [data getJsonString], cycleValue, [[instUtil getInstrumentNode] getDigits]]];
            
            //            [self.quoteTouchableView.quoteView.leftSubview  updateValue:[instUtil formatClientPrice:[snapshot getBid] isFloor:true]];
            //            [self.quoteTouchableView.quoteView.rightSubview updateValue:[instUtil formatClientPrice:[snapshot getAsk] isFloor:true]];
            
            [self.quoteTouchableView.quoteView.leftSubview  updateValue:[instUtil formatClientPrice:[snapshot getBid] ]];
            [self.quoteTouchableView.quoteView.rightSubview updateValue:[instUtil formatClientPrice:[snapshot getAsk] ]];
            
            //            [self.quoteTouchableView.quoteView.leftSubview updateValue:@"1.3400"];
            //            [self.quoteTouchableView.quoteView.rightSubview updateValue:@"14.0140"];
        }
    });
}

#pragma buttonAction
- (void)addBackAction {
    [self maxMinClick:nil];
}

- (void)addKChartTypeAction {
    if ([_kChartToolBar.chooseView isHidden]) {
        [_kChartToolBar.chooseView showWithType:ChooseTypeCandleStickType];
    } else {
        [_kChartToolBar.chooseView      setHidden:true];
    }
}

- (void)addCycleTypeAction {
    if ([_kChartToolBar.chooseView isHidden]) {
        [_kChartToolBar.chooseView showWithType:ChooseTypeCycleChooseType];
    } else {
        [_kChartToolBar.chooseView      setHidden:true];
    }
}

- (void)addTechnologyTypeAction {
    if ([_kChartToolBar.chooseView isHidden]) {
        [_kChartToolBar.chooseView showWithType:ChooseTypeTechnologyType];
    } else {
        [_kChartToolBar.chooseView      setHidden:true];
    }
}

- (void)addClearAllAction {
    [self removeOrderLine];
    [self.webView stringByEvaluatingJavaScriptFromString:@"removeAllDrawers()"];
}

- (void)addDrawLineAction {
    if ([_kChartToolBar.chooseView isHidden]) {
        [_kChartToolBar.chooseView showWithType:ChooseTypeDrawType];
    } else {
        [_kChartToolBar.chooseView      setHidden:true];
    }
}

- (void)addOrderLineAction {
    if ([_kChartToolBar.chooseView.saveData.isOrderLineDraw isEqualToString:@"true"]) {
        [self removeOrderLine];
    } else {
        [self drawOrderLine];
    }
}

- (void)removeOrderLine {
    NSMutableArray *orderGuidArray = _kChartToolBar.chooseView.saveData.orderLineCUIDArray;
    for (NSString *orderGuid in orderGuidArray) {
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"removeHorizontalForOrder('%@')", orderGuid]];
    }
    [orderGuidArray removeAllObjects];
    [self restoreJsonString];
    [_kChartToolBar.chooseView.saveData setIsOrderLineDraw:@"false"];
}

- (void)drawOrderLine {
    NSMutableArray *orderGuidArray = _kChartToolBar.chooseView.saveData.orderLineCUIDArray;
    if (orderGuidArray != nil && [orderGuidArray count] != 0) {
        // 不应该有值
        NSLog(@"err! orderGuidArray should be nill");
        [self removeOrderLine];
        //        return;
    }
    
    GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] accountID]];
    if (groupDoc != nil) {
        OrderDoc *orderDoc = [groupDoc getOrderDoc];
        NSMutableArray *tempArray = [[orderDoc getTOrderByAccountList:[[ClientAPI getInstance] accountID]] mutableCopy];
        if (tempArray == nil || [tempArray count] == 0) {
            return;
        }
        for (int i = 0; i < [tempArray count]; i++) {
            TOrder *order = [tempArray objectAtIndex:i];
            if ([[order getInstrument] isEqualToString:_instrumentName]) {
                if (order.getLimitPrice > 0.000001f) {
                    NSString *guid = [CommDataUtil createGUID];
                    [orderGuidArray addObject:guid];
                    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addHorizontalForLimitOrder(%f, '%@')", order.getLimitPrice, guid]];
                }
                
                if (order.getCurrentStopPrice > 0.000001f) {
                    NSString *guid = [CommDataUtil createGUID];
                    [orderGuidArray addObject:guid];
                    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addHorizontalForStopOrder(%f, '%@')", order.getCurrentStopPrice, guid]];
                }
            }
        }
    }
    
    [_kChartToolBar.chooseView.saveData setIsOrderLineDraw:@"true"];
}

- (void)addTiSubChooseView {
    if ([_kChartToolBar.chooseView.subChooseView isHidden]) {
        [_kChartToolBar.chooseView.subChooseView showWithType:ChooseTypeMaSubArrayType];
    } else {
        [_kChartToolBar.chooseView.subChooseView setHidden:true];
    }
}

#pragma choose delegate
- (void)didSelectAtIndex:(int)index value:(id)value type:(ChooseType)type {
    switch (type) {
        case ChooseTypeCycleChooseType:
            [self dealWithCycleValue:value];
            break;
        case ChooseTypeTechnologyType:
            [self dealWithValue:(id)value TiIndex:index];
            break;
        case ChooseTypeDrawType:
            [self dealWithDrawIndex:index];
            break;
        case ChooseTypeCandleStickType:
            [self dealWithKChartValue:value];
            break;
        case ChooseTypeMaSubArrayType:
            [self dealWithMaSubIndex:index];
            break;
            //            [self];
        default:
            break;
    }
}

- (void)dealWithCycleValue:(NSNumber *)value {
    [_kChartToolBar.chooseView.saveData setChartCycleType:[value intValue]];
    [self loadQuoteHisData];
    [_kChartToolBar.chooseView      setHidden:true];
}

- (void)dealWithValue:(id)value TiIndex:(int)index {
    
    if (![value isEqualToString:@"ma"]) {
        [_kChartToolBar.chooseView setHidden:true];
        NSArray *array = [[NSArray alloc] initWithObjects:@"ma", @"rsi", @"kdj", @"macd", @"bollingerBand", nil];
        NSMutableArray *technologyNameArray = [_kChartToolBar.chooseView.saveData technologyNameArray];
        
        if ([technologyNameArray containsObject:value]) {
            [technologyNameArray removeObject:value];
        } else {
            
            if ([array containsObject:value]) {
                // 如果是 需要自定义的参数
                [self showArgumentView:value withIndex:index];
                return;
            } else {
                // 如果不是自定义的参数
                if ([technologyNameArray count] >= 2) {
                    [technologyNameArray removeObjectAtIndex:0];
                }
                [technologyNameArray addObject:value];
            }
        }
        [self reloadTi];
    } else {
        [self addTiSubChooseView];
    }
}

- (void)showArgumentView:(id)type withIndex:(int)index{
    [_tiArgumentView showTiArgumentViewWithType:type withTiArgumentConfig:[_kChartToolBar.chooseView.saveData tiArgumentConfig] withIndex:index];
}

- (void)reloadTi {
    NSArray *tiArray = [_kChartToolBar.chooseView.saveData technologyNameArray];
    NSArray *mutableTiArray = [_kChartToolBar.chooseView.saveData maNameArray];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"removeAllTiAction()"]];
    for (NSString *ti in tiArray) {
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiAction('%@', '%@')", ti, ti]];
    }
    for (NSString *ti in mutableTiArray) {
        if (![[ti uppercaseString] isEqualToString:@"MA0"]) {
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiAction('ma', '%@')", ti]];
        }
    }
    
    [self reloadTiArgument];
}

- (void)reloadTiArgument {
    TiArgumentConfig *config = [_kChartToolBar.chooseView.saveData tiArgumentConfig];
    
    // ma
    NSMutableArray *maArray = [config maDataArray];
    for (int i = 0; i < 5; i++) {
        MAData *data = [maArray objectAtIndex:i];
        [self addTiArgument:[NSString stringWithFormat:@"MA%d", i+1] argument:@"period" value:[data maPeriod]];
        [self addTiArgument:[NSString stringWithFormat:@"MA%d", i+1] argument:@"maLineWidth" value:[data maWidth]];
        [self addTiArgument:[NSString stringWithFormat:@"MA%d", i+1] argument:@"maLineColorRgba" value:[data maColor]];
    }
    
    // rsi
    [self addTiArgument:@"rsi" argument:@"shortPeriod" value:[config rsiShortPeriod]];
    [self addTiArgument:@"rsi" argument:@"rsiShortLineWidth" value:[config rsiShortWidth]];
    [self addTiArgument:@"rsi" argument:@"rsiShortLineColorRgba" value:[config rsiShortColor]];
    [self addTiArgument:@"rsi" argument:@"longPeriod" value:[config rsiLongPeriod]];
    [self addTiArgument:@"rsi" argument:@"rsiLongLineWidth" value:[config rsiLongWidth]];
    [self addTiArgument:@"rsi" argument:@"rsiLongLineColorRgba" value:[config rsiLongColor]];
    
    // kdj
    [self addTiArgument:@"kdj" argument:@"period" value:[config kdjPeriod]];
    [self addTiArgument:@"kdj" argument:@"kLineWidth" value:[config kLineWidth]];
    [self addTiArgument:@"kdj" argument:@"kLineColorRgba" value:[config kLineColor]];
    [self addTiArgument:@"kdj" argument:@"dLineWidth" value:[config dLineWidth]];
    [self addTiArgument:@"kdj" argument:@"dLineColorRgba" value:[config dLineColor]];
    [self addTiArgument:@"kdj" argument:@"jLineWidth" value:[config jLineWidth]];
    [self addTiArgument:@"kdj" argument:@"jLineColorRgba" value:[config jLineColor]];
    
    // macd
    [self addTiArgument:@"macd" argument:@"shortPeriod" value:[config macdShortPeriod]];
    [self addTiArgument:@"macd" argument:@"longPeriod" value:[config macdLongPeriod]];
    [self addTiArgument:@"macd" argument:@"periodSignal" value:[config macdPeriodSignal]];
    [self addTiArgument:@"macd" argument:@"diffLineWidth" value:[config macdDiffLineWidth]];
    [self addTiArgument:@"macd" argument:@"diffLineColorRgba" value:[config macdDiffLineColor]];
    [self addTiArgument:@"macd" argument:@"demLineWidth" value:[config macdDemLineWidth]];
    [self addTiArgument:@"macd" argument:@"demLineColorRgba" value:[config macdDemLineColor]];
    [self addTiArgument:@"macd" argument:@"macdPositiveColorRgba" value:[config macdPositiveColor]];
    [self addTiArgument:@"macd" argument:@"macdNegativeColorRgba" value:[config macdNegativeColor]];
    
    // bolling
    [self addTiArgument:@"bollingerBand" argument:@"period" value:[config bollingerBandPeriod]];
    [self addTiArgument:@"bollingerBand" argument:@"k" value:[config bollingerBandK]];
    [self addTiArgument:@"bollingerBand" argument:@"lineWidth" value:[config bollingerBandLineWidth]];
    [self addTiArgument:@"bollingerBand" argument:@"lineColorRgba" value:[config bollingerBandLineColor]];
    [self addTiArgument:@"bollingerBand" argument:@"fillColorRgba" value:[config bollingerBandFillColor]];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"represent()"]];
    
    [self saveToJsonString];
}

- (void)addTiArgument:(NSString *)ti argument:(NSString *)argument value:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiArgument('%@', '%@', %d)", ti, argument, [number intValue]]];
    }
    
    if ([value isKindOfClass:[UIColor class]]) {
        UIColor *color = (UIColor *)value;
        NSDictionary *colorDic = [UIColor getRGBDictionaryByColor:color];
        int r = [colorDic[@"R"] floatValue] * 255;
        int g = [colorDic[@"G"] floatValue] * 255;
        int b = [colorDic[@"B"] floatValue] * 255;
        int a = [colorDic[@"A"] floatValue] * 255;
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiArgument('%@', '%@', %d, %d, %d, %d)", ti, argument, a, r, g, b]];
    }
}

- (void)removeTiView {
    [_tiArgumentView setHidden:true];
}

- (void)commitArgument {
    [_tiArgumentView.contentView commitArgument];
    //    [self showArgumentView:_tiArgumentView.contentView.config withIndex:_tiArgumentView.contentView.index];
    //    [self tiArgumentChanged:_tiArgumentView.viewType withIndex:_tiArgumentView.contentView.index];
    //    NSMutableArray *technologyNameArray = [_kChartToolBar.chooseView.saveData technologyNameArray];
    NSString *type = [_tiArgumentView viewType];
    if ([type isEqualToString:@"ma"]) {
        NSMutableArray *maNameArray = [_kChartToolBar.chooseView.saveData maNameArray];
        if (maNameArray) {
            int index = _tiArgumentView.contentView.index;
            [maNameArray replaceObjectAtIndex:index withObject:[[NSString alloc] initWithFormat:@"MA%d", index + 1]];
        }
    } else {
        NSMutableArray *technologyNameArray = [_kChartToolBar.chooseView.saveData technologyNameArray];
        if ([technologyNameArray count] >= 2) {
            [technologyNameArray removeObjectAtIndex:0];
        }
        [technologyNameArray addObject:type];
        
    }
    [self reloadTi];
    [self reloadTiArgument];
    [self saveToJsonString];
    [_tiArgumentView setHidden:true];
}

- (void)resetArgument {
    [_tiArgumentView.contentView resetArgument];
}

- (void)dealWithDrawIndex:(int)index {
    NSString *functionName = @"";
    switch (index) {
        case 0:
            functionName = @"drawLine()";
            break;
        case 1:
            functionName = @"drawHorizontalLine()";
            break;
        case 2:
            functionName = @"drawPriceTangent()";
            break;
        case 3:
            functionName = @"drawChannel()";
            break;
        case 4:
            functionName = @"drawGoldenSection()";
            break;
        case 5:
            functionName = @"drawGoldenBands()";
            break;
        case 6:
            functionName = @"drawGoldenCircle()";
            break;
        case 7:
            functionName = @"drawGannFan()";
            break;
        case 8:
            functionName = @"drawLinearRegression()";
            break;
            
        default:
            break;
    }
    [self.webView stringByEvaluatingJavaScriptFromString:functionName];
    [_kChartToolBar.chooseView      setHidden:true];
}

- (void)dealWithKChartValue:(id)value {
    [_kChartToolBar.chooseView.saveData setChartType:value];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"chooseOhlcBarType('%@')", value]];
    [_kChartToolBar.chooseView      setHidden:true];
}

- (void)dealWithMaSubIndex:(int)index {
    NSMutableArray *maNameArray = [_kChartToolBar.chooseView.saveData maNameArray];
    if ([[maNameArray objectAtIndex:index] isEqualToString:@"MA0"]) {
        [self showArgumentView:@"ma" withIndex:index];
    } else {
        [maNameArray replaceObjectAtIndex:index withObject:@"MA0"];
        [self reloadTi];
    }
    
    [_kChartToolBar.chooseView      setHidden:true];
}

- (void)orderChange {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"................. orderchange");
        [self drawOrderLine];
    });
}

//#pragma WebView NavicationDelegate
//
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
//    NSLog(@"didStartProvisionalNavigation");
//    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//}
//
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    NSLog(@"didCommitNavigation");
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
//    NSLog(@"didFinishNavigation");
//    //    [self resetControl];
//    //    if (webView.title.length > 0) {
//    //        self.title = webView.title;
//    //    }
//    [self loadQuoteHisData];
//
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    // 类似 UIWebView 的- webView:didFailLoadWithError:
//
//    NSLog(@"didFailProvisionalNavigation");
//
//}
//
////------------------
//
//// 接收到服务器的响应头
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//
//    //    // 如果响应的地址是百度，则允许跳转
//    //    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
//    //
//    //        // 允许跳转
//    //        decisionHandler(WKNavigationResponsePolicyAllow);
//    //        return;
//    //    }
//    //    // 不允许跳转
//    //    decisionHandler(WKNavigationResponsePolicyCancel);
//
//    NSLog(@"decidePolicyForNavigationResponse");
//    decisionHandler(WKNavigationResponsePolicyAllow);
//}
//
//// 发送请求
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
//    //    NSLog(@"4.%@",navigationAction.request);
//    //    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"decidePolicyForNavigationAction");
//    decisionHandler(WKNavigationActionPolicyAllow);
//
//}
//
//// 接收到服务器跳转请求之后
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
//}
//
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
//    NSLog(@"didReceiveAuthenticationChallenge");
//}
//
//#pragma WebView UIDelegate
////- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {}
//
////- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0) {}
//
////- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
////}
//
////- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{}
//
////- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{}
//
//#pragma WebView ScriptDelegate
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//
//}

- (void)dealloc {
    isInited = false;
    [self removeListener];
}

@end
