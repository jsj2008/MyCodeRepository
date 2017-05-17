
//
//  KChartView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/4.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "KChartView.h"
#import "UIColor+CustomColor.h"
#import "TradeApi.h"
#import "HistoricData.h"
#import "IosLayoutDefine.h"
#import "QuoteDataStore.h"
#import "KChartToolBar.h"
#import "ShowAlert.h"
#import "LangCaptain.h"
#import "KChartParam.h"
#import "ShowChooseView.h"
#import "ParamTable.h"
#import "TiArgumentView.h"
#import "MAContentView.h"
#import "AbstractTiContent.h"
#import "RSIContentView.h"
#import "TiArgumentConfig.h"
#import "UIColor+CustomColor.h"
#import "KDJContentView.h"
#import "MACDContentView.h"
#import "BollingerBandContentView.h"
#import "TiSaveData.h"
#import "CustomTranslate.h"
#import "IosLogic.h"
#import "QuoteListViewController.h"
#import "MAData.h"
#import "QuoteListViewController.h"
#import "FreezeTableView.h"
#import "GroupDoc.h"
#import "APIDoc.h"
#import "ClientAPI.h"
#import "DecimalUtil.h"

#define ToolBarHeigh 50
#define Unselected -1

#define TiContentViewTag 110


#define AnimationTime 0.2

const float buttonHeight = 35.0f;

@interface KChartView()<API_Event_QuoteDataStore, chooseProtocol>{
    UIButton *popButton;
    UIWebView *kChartWebView;
    Boolean isPop;
    
    UIImage *popedImage;
    UIImage *unpopedImage;
    
    UIView *backgroundView;
    
    CGRect portraitFrame;
    CGRect landscapFrame;
    CGRect backgroundRect;
    CGRect kChartRect;
    
    KChartToolBar *toolBar;
    
    ShowChooseView *chooseView;
    ShowChooseView *subChooseView;
    
    NSArray *cycleArray;
    NSArray *technologyArray;
    NSArray *drawTypeArray;
    NSArray *kChartTypeArray;
    
    NSArray *maSubChooseArray;
    
    int currentIndex;
    
    TiArgumentView *tiArgumentView;
    
    //    NSString *_defaultConfig;
    NSNumberFormatter *format;
    
    Boolean isDrawOrderLine;
}

@end

static KChartView *instance = nil;

@implementation KChartView

+ (KChartView *)getInstance {
    if (instance == nil) {
        instance = [[KChartView alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        popedImage = [UIImage imageNamed:@"images/normal/poped"];
        unpopedImage = [UIImage imageNamed:@"images/normal/unpoped"];
        //        portraitFrame = CGRectMake(0, SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT - buttonHeight, SCREEN_WIDTH, 400.0f);
        //        Boolean is = SCREEN_WIDTH < SCREEN_HEIGHT;
        portraitFrame = CGRectMake(0, SCREEN_HEIGHT - buttonHeight, SCREEN_WIDTH, 400.0f);
        
        landscapFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        kChartRect = CGRectMake(0, buttonHeight, portraitFrame.size.width, portraitFrame.size.height - buttonHeight);
        isPop = false;
        [self initComponent];
        [self initData];
        [self addButtonAction];
        //        [QuoteDataStore addQuoteReceiver:self];
        [self setHidden:true];
        format = [[NSNumberFormatter alloc] init];
        isDrawOrderLine = false;
        
    }
    return self;
}

- (void)initComponent {
    [self.layer setCornerRadius:25.0f];
    backgroundRect = portraitFrame;
    backgroundRect.size.height += 30.0f;
    backgroundRect.origin.y = 0;
    backgroundView = [[UIView alloc] initWithFrame:backgroundRect];
    [backgroundView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:backgroundView];
    
    popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 4.0f, 100.0f, buttonHeight - 4.0f)];
    CGPoint centerPoint = CGPointMake(portraitFrame.size.width / 2, popButton.center.y);
    [popButton setCenter:centerPoint];
    [popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [popButton setBackgroundImage:unpopedImage forState:UIControlStateNormal];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KChart/index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    kChartWebView = [[UIWebView alloc] init];
    [kChartWebView setBackgroundColor:[UIColor blackColor]];
    
    [backgroundView addSubview:kChartWebView];
    [backgroundView addSubview:popButton];
    
    [kChartWebView loadRequest:request];
    toolBar = [[KChartToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH - ToolBarHeigh, SCREEN_HEIGHT, ToolBarHeigh)];
    [toolBar setHidden:true];
    [backgroundView addSubview:toolBar];
    
    chooseView = [[ShowChooseView alloc] init];
    subChooseView = [[ShowChooseView alloc] init];
    [self addSubview:chooseView];
    [self addSubview:subChooseView];
    
    // tiargumentview
    tiArgumentView = [TiArgumentView newInstance];
    [tiArgumentView.backButton addTarget:self
                                  action:@selector(removeTiView)
                        forControlEvents:UIControlEventTouchUpInside];
    [tiArgumentView.commitButton addTarget:self
                                    action:@selector(commitArgument)
                          forControlEvents:UIControlEventTouchUpInside];
    [tiArgumentView.resetButton addTarget:self
                                   action:@selector(resetArgument)
                         forControlEvents:UIControlEventTouchUpInside];
    [tiArgumentView setHidden:true];
    [self addSubview:tiArgumentView];
    
    [self setBackgroundColor:[UIColor blackColor]];
    [self autoPortrait];
}

- (void)initData {
    
    currentIndex = Unselected;
    //    ChartCycleMin1      = 301,
    //    ChartCycleMin5      = 302,
    //    ChartCycleMin10     = 303,
    //    ChartCycleMin15     = 304,
    //    ChartCycleMin30     = 305,
    //    ChartCycleMin60     = 306,
    //    ChartCycleMin90     = 307,
    //    ChartCycleMin180    = 308,
    //
    //    ChartCycleDay       = 309,
    //    ChartCycleWeek      = 310,
    //    ChartCycleMonth     = 311,
    //    ChartCycleYear      = 312,
    //
    //    ChartCycleHour2     = 313,
    //    ChartCycleHour4     = 314,
    //    ChartCycleHour6     = 315,
    //    ChartCycleHour8     = 316
    NSNumber *min1 = [[NSNumber alloc] initWithInt:ChartCycleMin1];
    NSNumber *min5 = [[NSNumber alloc] initWithInt:ChartCycleMin5];
    //    NSNumber *min10 = [[NSNumber alloc] initWithInt:303];
    NSNumber *min15 = [[NSNumber alloc] initWithInt:ChartCycleMin15];
    NSNumber *min30 = [[NSNumber alloc] initWithInt:ChartCycleMin30];
    NSNumber *min60 = [[NSNumber alloc] initWithInt:ChartCycleMin60];
    //    NSNumber *min90 = [[NSNumber alloc] initWithInt:ChartCycleMin90];
    //    NSNumber *min180 = [[NSNumber alloc] initWithInt:ChartCycleMin180];
    NSNumber *day = [[NSNumber alloc] initWithInt:ChartCycleDay];
    NSNumber *week = [[NSNumber alloc] initWithInt:ChartCycleWeek];
    NSNumber *month = [[NSNumber alloc] initWithInt:ChartCycleMonth];
    //    NSNumber *year = [[NSNumber alloc] initWithInt:ChartCycleYear];
    NSNumber *hour2 = [[NSNumber alloc] initWithInt:ChartCycleHour2];
    NSNumber *hour4 = [[NSNumber alloc] initWithInt:ChartCycleHour4];
    //    NSNumber *hour6 = [[NSNumber alloc] initWithInt:ChartCycleHour6];
    //    NSNumber *hour8 = [[NSNumber alloc] initWithInt:ChartCycleHour8];
    cycleArray = [[NSArray alloc] initWithObjects:
                  min1, min5, min15,
                  min30, min60,hour2,
                  hour4, day,
                  week,month,  nil];
    
    technologyArray = [[NSArray alloc] initWithObjects:
                       MA, AO, ARBR, ATR,
                       BIAS,BIASAB,BOLLINGERBAND,CCI,DMI,
                       KDJ,MACD,MTM,
                       PSY,ROC,RSI,RSISMOOTH,
                       WR, OSMA, SAR, nil];
    //    OBV, Volume, VR
    
    drawTypeArray = [[NSArray alloc] initWithObjects:
                     @"Line",@"HorizontalLine",@"PriceTangent",
                     @"Channel",@"GoldenSection",@"GoldenBands",
                     @"GoldenCircle",@"GannFan",@"LinearRegression",nil];
    
    kChartTypeArray = [[NSArray alloc] initWithObjects:CANDLESTICK, BAR, nil];
    
    // subchooseArray
    maSubChooseArray = [[NSArray alloc] initWithObjects:@"MA1",@"MA2",@"MA3",@"MA4",@"MA5", nil];
    
}

- (void)loadData:(Boolean)needRestore {
    //    UIView *webviewBack = [[UIView alloc] ini];
    [QuoteDataStore removeQuoteReceiver:instance];
    NSString *instrumentName = [[KChartParam getInstance] instrumentName];
    
    [self setHidden:false];
    [[ShowAlert getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:kChartWebView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (needRestore) {
            NSDictionary *configDic = [[[TiSaveData getInstance] tiClientMap] objectForKey:instrumentName];
            //    NSDictionary *dic = [self parseParam:json];
            [[KChartParam getInstance] setTiConfigDic:configDic];
        }
        int cycle = [[KChartParam getInstance] cycle];
        
        NSString *jsonString = [self queryHistoricData:instrumentName cycle:cycle];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ShowAlert getInstance] hidenAlertWaitView];
//            if (needRestore) {
//                NSDictionary *configDic = [[[TiSaveData getInstance] tiClientMap] objectForKey:instrumentName];
//                //    NSDictionary *dic = [self parseParam:json];
//                [[KChartParam getInstance] setTiConfigDic:configDic];
//            }
            if (jsonString == nil || [jsonString isEqualToString:@""] || [jsonString isEqualToString:@"[]"]) {
                [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
                                                    andMessage:[[LangCaptain getInstance] getLangByCode:@"LoadingFailed"]];
                [[KChartParam getInstance] setInstrumentName:[[KChartParam getInstance] lastInstrumentName]];
                return;
            }
            
            NSString *lasetInstrumentName = [[KChartParam getInstance] lastInstrumentName];
            if (lasetInstrumentName != nil) {
                [[KChartView getInstance] saveToJsonString:lasetInstrumentName];
            }
            
            if (needRestore) {
                [self restoreJsonString:instrumentName];
            }
            
            //                        NSLog(@"%@", jsonString);
            
            NSString *instrumentSummary = [NSString stringWithFormat:@"%@, %@", instrumentName, [CustomTranslate getInputValue:[[KChartParam getInstance] cycle]]];
            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"resetMockTicks(%@, %d, %d, '%@')", jsonString, [self getCycleValue], [self getCycleValue], instrumentSummary]];
            [chooseView setHidden:true];
            [subChooseView setHidden:true];
            isDrawOrderLine = false;
            [self resetOrderLineAction:false];
            [QuoteDataStore addQuoteReceiver:instance];
        });
    });
}

- (void)reloadTi {
    NSArray *tiArray = [[KChartParam getInstance] technologyArray];
    NSArray *mutableTiArray = [[KChartParam getInstance] mutableTechnologyArray];
    [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"removeAllTiAction()"]];
    for (NSString *ti in tiArray) {
        [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiAction('%@', '%@')", ti, ti]];
    }
    for (NSString *ti in mutableTiArray) {
        if (![[ti uppercaseString] isEqualToString:@"MA0"]) {
            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiAction('ma', '%@')", ti]];
        }
    }
    //    for (int i = 4; i >= 0; i--) {
    //        NSString *tiName = [mutableTiArray objectAtIndex:i];
    //        if (![tiName isEqualToString:@"MA0"]) {
    //            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiAction('ma', '%@')", tiName]];
    //        }
    //    }
    [self reloadTiArgument];
}

- (void)reloadTiArgument {
    // ma
    NSMutableArray *maArray = [[TiArgumentConfig getInstance] maDataArray];
    for (int i = 0; i < 5; i++) {
        MAData *data = [maArray objectAtIndex:i];
        [self addTiArgument:[NSString stringWithFormat:@"MA%d", i+1] argument:@"period" value:[data maPeriod]];
        [self addTiArgument:[NSString stringWithFormat:@"MA%d", i+1] argument:@"maLineWidth" value:[data maWidth]];
        [self addTiArgument:[NSString stringWithFormat:@"MA%d", i+1] argument:@"maLineColorRgba" value:[data maColor]];
    }
    //    [self addTiArgument:@"ma" argument:@"period" value:[[TiArgumentConfig getInstance] maPeriod]];
    //    [self addTiArgument:@"ma" argument:@"maLineWidth" value:[[TiArgumentConfig getInstance] maWidth]];
    //    //    NSLog(@"width is ....... %@", [[TiArgumentConfig getInstance] maWidth]);
    //    [self addTiArgument:@"ma" argument:@"maLineColorRgba" value:[[TiArgumentConfig getInstance] maColor]];
    
    // rsi
    [self addTiArgument:@"rsi" argument:@"shortPeriod" value:[[TiArgumentConfig getInstance] rsiShortPeriod]];
    [self addTiArgument:@"rsi" argument:@"rsiShortLineWidth" value:[[TiArgumentConfig getInstance] rsiShortWidth]];
    [self addTiArgument:@"rsi" argument:@"rsiShortLineColorRgba" value:[[TiArgumentConfig getInstance] rsiShortColor]];
    [self addTiArgument:@"rsi" argument:@"longPeriod" value:[[TiArgumentConfig getInstance] rsiLongPeriod]];
    [self addTiArgument:@"rsi" argument:@"rsiLongLineWidth" value:[[TiArgumentConfig getInstance] rsiLongWidth]];
    [self addTiArgument:@"rsi" argument:@"rsiLongLineColorRgba" value:[[TiArgumentConfig getInstance] rsiLongColor]];
    
    // kdj
    [self addTiArgument:@"kdj" argument:@"period" value:[[TiArgumentConfig getInstance] kdjPeriod]];
    [self addTiArgument:@"kdj" argument:@"kLineWidth" value:[[TiArgumentConfig getInstance] kLineWidth]];
    [self addTiArgument:@"kdj" argument:@"kLineColorRgba" value:[[TiArgumentConfig getInstance] kLineColor]];
    [self addTiArgument:@"kdj" argument:@"dLineWidth" value:[[TiArgumentConfig getInstance] dLineWidth]];
    [self addTiArgument:@"kdj" argument:@"dLineColorRgba" value:[[TiArgumentConfig getInstance] dLineColor]];
    [self addTiArgument:@"kdj" argument:@"jLineWidth" value:[[TiArgumentConfig getInstance] jLineWidth]];
    [self addTiArgument:@"kdj" argument:@"jLineColorRgba" value:[[TiArgumentConfig getInstance] jLineColor]];
    
    // macd
    [self addTiArgument:@"macd" argument:@"shortPeriod" value:[[TiArgumentConfig getInstance] macdShortPeriod]];
    [self addTiArgument:@"macd" argument:@"longPeriod" value:[[TiArgumentConfig getInstance] macdLongPeriod]];
    [self addTiArgument:@"macd" argument:@"periodSignal" value:[[TiArgumentConfig getInstance] macdPeriodSignal]];
    [self addTiArgument:@"macd" argument:@"diffLineWidth" value:[[TiArgumentConfig getInstance] macdDiffLineWidth]];
    [self addTiArgument:@"macd" argument:@"diffLineColorRgba" value:[[TiArgumentConfig getInstance] macdDiffLineColor]];
    [self addTiArgument:@"macd" argument:@"demLineWidth" value:[[TiArgumentConfig getInstance] macdDemLineWidth]];
    [self addTiArgument:@"macd" argument:@"demLineColorRgba" value:[[TiArgumentConfig getInstance] macdDemLineColor]];
    [self addTiArgument:@"macd" argument:@"macdPositiveColorRgba" value:[[TiArgumentConfig getInstance] macdPositiveColor]];
    [self addTiArgument:@"macd" argument:@"macdNegativeColorRgba" value:[[TiArgumentConfig getInstance] macdNegativeColor]];
    
    // bolling
    [self addTiArgument:@"bollingerBand" argument:@"period" value:[[TiArgumentConfig getInstance] bollingerBandPeriod]];
    [self addTiArgument:@"bollingerBand" argument:@"k" value:[[TiArgumentConfig getInstance] bollingerBandK]];
    [self addTiArgument:@"bollingerBand" argument:@"lineWidth" value:[[TiArgumentConfig getInstance] bollingerBandLineWidth]];
    [self addTiArgument:@"bollingerBand" argument:@"lineColorRgba" value:[[TiArgumentConfig getInstance] bollingerBandLineColor]];
    [self addTiArgument:@"bollingerBand" argument:@"fillColorRgba" value:[[TiArgumentConfig getInstance] bollingerBandFillColor]];
    [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"represent()"]];
}

- (void)addTiArgument:(NSString *)ti argument:(NSString *)argument value:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiArgument('%@', '%@', %d)", ti, argument, [number intValue]]];
    }
    
    if ([value isKindOfClass:[UIColor class]]) {
        UIColor *color = (UIColor *)value;
        NSDictionary *colorDic = [UIColor getRGBDictionaryByColor:color];
        int r = [colorDic[@"R"] floatValue] * 255;
        int g = [colorDic[@"G"] floatValue] * 255;
        int b = [colorDic[@"B"] floatValue] * 255;
        int a = [colorDic[@"A"] floatValue] * 255;
        [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiArgument('%@', '%@', %d, %d, %d, %d)", ti, argument, a, r, g, b]];
    }
}

- (void)popKChartViewWithAnimation:(Boolean)animation {
    
    // 去掉animation
    if (!isPop) {
        [self portraitAdjust:PortraitPoped];
        isPop = true;
        
        if (![[[IosLogic getInstance] getWindow].rootViewController isKindOfClass:[QuoteListViewController class]]) {
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
                SEL selector = NSSelectorFromString(@"setOrientation:");
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                [invocation setSelector:selector];
                [invocation setTarget:[UIDevice currentDevice]];
                int val = [[UIDevice currentDevice] orientation];
                [invocation setArgument:&val atIndex:2];
                [invocation invoke];
            }
        }
        
        if (animation) {
            [popButton setEnabled:false];
            [UIView transitionWithView:self
                              duration:AnimationTime
                               options:UIViewAnimationOptionTransitionNone
                            animations:^{
                                CGRect rect = self.frame;
                                if (IsPortrait) {
                                    rect.origin.y -= self.frame.size.height - buttonHeight;
                                } else {
                                    rect = landscapFrame;
                                }
                                self.frame = rect;
                            }
                            completion:^(BOOL finished){
                                [popButton setEnabled:true];
                                [popButton setBackgroundImage:popedImage forState:UIControlStateNormal];
                            }];
        } else {
            CGRect rect = self.frame;
            //            rect.origin.y -= self.frame.size.height - buttonHeight;
            if (IsPortrait) {
                rect.origin.y -= self.frame.size.height - buttonHeight;
            } else {
                rect = landscapFrame;
            }
            self.frame = rect;
            self.frame = rect;
            [popButton setBackgroundImage:popedImage forState:UIControlStateNormal];
        }
    }
}

- (void)addKChartViewWithAnimation:(Boolean)animation {
    isPop = false;
    if (animation) {
        [popButton setEnabled:false];
        [UIView transitionWithView:self
                          duration:AnimationTime
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            CGRect rect = self.frame;
                            //                            rect.origin.y -= self.frame.size.height - buttonHeight;
                            self.frame = rect;
                        }
                        completion:^(BOOL finished){
                            [popButton setEnabled:true];
                            [popButton setBackgroundImage:unpopedImage forState:UIControlStateNormal];
                        }];
    } else {
        CGRect rect = self.frame;
        //        rect.origin.y -= self.frame.size.height - buttonHeight;
        self.frame = rect;
        [popButton setBackgroundImage:unpopedImage forState:UIControlStateNormal];
    }
}

- (void)portraitAdjust:(int) state{
    UIViewController *viewController = [[[IosLogic getInstance] getWindow] rootViewController];
    if ([viewController isKindOfClass:[QuoteListViewController class]]) {
        [[((QuoteListViewController *)viewController) getQuoteListView] portrait:state];
    }
}

- (void)popAction {
    if (isPop) {
        [self portraitAdjust:PortraitNormal];
        [popButton setEnabled:false];
        isPop = !isPop;
        [UIView transitionWithView:self
                          duration:AnimationTime
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            CGRect rect = self.frame;
                            rect.origin.y += self.frame.size.height - buttonHeight;
                            self.frame = rect;
                        }
                        completion:^(BOOL finished){
                            
                            [popButton setEnabled:true];
                            [popButton setBackgroundImage:unpopedImage forState:UIControlStateNormal];
                            // 为了保存 暂时这么写
                            [[KChartParam getInstance] setInstrumentName:[[KChartParam getInstance] instrumentName]];
                            if ([[KChartParam getInstance] lastInstrumentName] != nil) {
                                [[KChartView getInstance] saveToJsonString:[[KChartParam getInstance] lastInstrumentName]];
                            }
                        }];
    } else {
        [self portraitAdjust:PortraitPoped];
        [popButton setEnabled:false];
        isPop = !isPop;
        [UIView transitionWithView:self
                          duration:AnimationTime
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            CGRect rect = self.frame;
                            rect.origin.y -= self.frame.size.height - buttonHeight;
                            self.frame = rect;
                        }
                        completion:^(BOOL finished){
                            [popButton setEnabled:true];
                            [popButton setBackgroundImage:popedImage forState:UIControlStateNormal];
                        }];
    }
}

- (void)layoutSubviews {
    //    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft ||
    //        [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
    //        // 横屏
    //        [self autoLandscape];
    //        //        [kChartWebView];
    //    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait){
    //        // 竖屏
    //        [self autoPortrait];
    //    }
    if (IsPortrait) {
        [self autoPortrait];
    } else {
        [self autoLandscape];
    }
}

- (void)autoLandscape{
    if (isPop) {
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    } else {
        [self setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    [kChartWebView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - ToolBarHeigh)];
    [popButton setHidden:true];
    [toolBar setHidden:false];
    [backgroundView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [backgroundView.layer setCornerRadius:0.0f];
    [backgroundView.layer setBorderWidth:0.0f];
    [self foucsToLast];
}

- (void)autoPortrait{
    if (isPop) {
        CGRect frame = portraitFrame;
        //        frame.origin.y = SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT -  self.frame.size.height;
        frame.origin.y = SCREEN_HEIGHT -  self.frame.size.height;
        
        [self setFrame:frame];
    } else {
        CGRect frame = portraitFrame;
        //        frame.origin.y = SCREEN_HEIGHT - SCREEN_STATUS_BAR - SCREEN_TOPST_HEIGHT -  self.frame.size.height;
        frame.origin.y -= FIXHOTTOPIC_HEIGHT;
        
        [self setFrame:frame];
    }
//    kChartRect.size.height -= FIXHOTTOPIC_HEIGHT;
    kChartRect = CGRectMake(0, buttonHeight, portraitFrame.size.width, portraitFrame.size.height - buttonHeight - FIXHOTTOPIC_HEIGHT);
    [kChartWebView setFrame:kChartRect];
    
    [popButton setHidden:false];
    [toolBar setHidden:true];
    [backgroundView setFrame:backgroundRect];
    [backgroundView.layer setCornerRadius:25.0f];
    [backgroundView.layer setBorderColor:[UIColor blueButtonColor].CGColor];
    [backgroundView.layer setBorderWidth:2.0f];
    [chooseView setHidden:true];
    [subChooseView setHidden:true];
    [self removeTiView];
    [self foucsToLast];
}

- (void)foucsToLast {
    [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"focusToLast()"]];
}

- (NSString *)queryHistoricData:(NSString *)insrtument cycle:(int)cycle {
    if (cycle == 0) {
        //        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"QueryCycleIsNil"]];
        return @"[]";
    }
    if (insrtument == nil && [insrtument isEqualToString:@""]) {
        //        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"QueryInstrumentIsNil"]];
        return @"[]";
    }
    NSArray *array = [[TradeApi getInstance] queryHisData:insrtument cycle:cycle];
    if (array == nil) {
        //        [[ShowAlert getInstance] showAlerViewWithTitle:[[LangCaptain getInstance] getLangByCode:@"ErrNotice"]
        //                                            andMessage:[[LangCaptain getInstance] getLangByCode:@"QueryHistoricDataFailed"]];
        return @"[]";
    }
    
    NSLog(@"this array count is %lu", (unsigned long)[array count]);
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    [mutableString appendString:@"["];
    for (HistoricData *data in array) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data.getEntryDictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (mutableString.length == 1) {
            [mutableString appendString:[NSString stringWithFormat:@"%@", jsonString]];
        } else {
            [mutableString appendString:[NSString stringWithFormat:@",%@", jsonString]];
        }
    }
    [mutableString appendString:@"]"];
    return mutableString;
}

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[snapshot instrumentName] isEqualToString:[[KChartParam getInstance] instrumentName]]) {
            HistoricData *data = [[HistoricData alloc] init];
            
            InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:[snapshot instrumentName]];
            // string 转double 没做判断
            double middlePrice = [[instUtil formatClientPrice:([snapshot getAsk] + [snapshot getBid]) / 2] doubleValue];
            [data setHighPrice:middlePrice];
            [data setLowPrice:middlePrice];
            [data setOpenPrice:middlePrice];
            [data setClosePrice:middlePrice];
            
            NSDate *currentDate = [JEDIDateTime dateFromQuoteDay:[snapshot quoteDay]];
            
            
            long long time = [snapshot snapshotTime];
            if ([self getCycleValue] < 24 * 60) {
                long long gap = [self getCycleValue] * 60 * 1000;
                time = ceil((double)time / (double)gap) * gap;
            } else if([self getCycleValue] ==  24 * 60) {
                //            NSString * = [snapshot quoteDay];
                time = [JEDIDateTime getTimeMillisForDate:currentDate];
                NSLog(@"Day %@", currentDate);
            } else if ([self getCycleValue] == 24 * 60 * 7) {
                NSDate *day = [JEDIDateTime dayOfWeek:6 forDate:currentDate];
                time = [JEDIDateTime getTimeMillisForDate:day];
                NSLog(@"Week %@", day);
                
            } else if ([self getCycleValue] == 24 * 60 * 30) {
                //            NSDate *date = [JEDIDateTime firstDayOfMonthForDate:currentDate];
                time = [JEDIDateTime getTimeMillisForDate:currentDate];
                NSLog(@"Month %@", currentDate);
            }
            [data setDataTime:time];
            
            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addMockTicks(%@, %d, %d)", [data getJsonString], [self getCycleValue], [[instUtil getInstrumentNode] getDigits]]];
        }
    });
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [self loadData];
//}

- (void)addButtonAction {
    [toolBar.backButton         addTarget:self action:@selector(addBackAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar.kChartTypeButton   addTarget:self action:@selector(addKChartTypeAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar.cycleTypeButton    addTarget:self action:@selector(addCycleTypeAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar.technologyTypeButton addTarget:self action:@selector(addTechnologyTypeAction) forControlEvents:UIControlEventTouchUpInside];
    //    [toolBar.unknowButton       addTarget:self action:@selector(addBackAction) forControlEvents:UIControlEventTouchUpInside];
    //    [toolBar.assistantTypeButton addTarget:self action:@selector(addBackAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar.clearAllButton     addTarget:self action:@selector(addClearAllAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar.addOrderButton     addTarget:self action:@selector(addOrderLineAction) forControlEvents:UIControlEventTouchUpInside];
    [toolBar.drawLineButton     addTarget:self action:@selector(addDrawLineAction) forControlEvents:UIControlEventTouchUpInside];
    //    [toolBar.shareButton        addTarget:self action:@selector(addBackAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addOrderLineAction {
    //    NSString *lineName = @"'test'";
    [self resetOrderLineAction:false];
    if (!isDrawOrderLine) {
        //        [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"removeHorizontalForOrder(%@)", lineName]];
        //        [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addHorizontalForOrder(%f, %@)", 0.7200, lineName]];
        //        [self resetOrderLineAction:false];
        [self resetOrderLineAction:true];
    }
    isDrawOrderLine = !isDrawOrderLine;
}

- (void)resetOrderLineAction:(Boolean)isAdd {
    if (!isAdd) {
        for (int i = 0; i < 50; i++) {
            //            NSString *lineName = @"'test'";
            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"removeHorizontalForOrder('L%d')", i]];
            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"removeHorizontalForOrder('S%d')", i]];
        }
    } else {
        GroupDoc *groupDoc = [[APIDoc getUserDocCaptain] getGroupDocByAccount:[[ClientAPI getInstance] getAccount]];
        if (groupDoc != nil) {
            OrderDoc *orderDoc = [groupDoc getOrderDoc];
            NSMutableArray *tempArray = [[orderDoc getTOrderByAccountList:[[ClientAPI getInstance] getAccount]] mutableCopy];
            if (tempArray == nil || [tempArray count] == 0) {
                return;
            }
            //            for (TOrder *order in tempArray) {
            for (int i = 0; i < [tempArray count]; i++) {
                TOrder *order = [tempArray objectAtIndex:i];
//                if ([order getType] == ORDERTYPE_NORMAL) {
                    //                    NSString *lineName = @"'test'";
                    if (order.getLimitPrice > 0.000001f) {
                        [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addHorizontalForLimitOrder(%f, 'L%d')", order.getLimitPrice, i]];
                    }
                    
                    if (order.getCurrentStopPrice > 0.000001f) {
                        [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addHorizontalForStopOrder(%f, 'S%d')", order.getCurrentStopPrice, i]];
                    }
//                }
            }
        }
    }
}

- (void)addBackAction {
    isPop = false;
    [UIView transitionWithView:self
                      duration:AnimationTime
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        CGRect rect = self.frame;
                        //                        rect.origin.x = SCREEN_WIDTH;
                        rect.origin.y = SCREEN_HEIGHT;
                        self.frame = rect;
                    }
                    completion:^(BOOL finished){
                        [popButton setBackgroundImage:unpopedImage forState:UIControlStateNormal];
                    }];
}

- (void)addKChartTypeAction {
    if (currentIndex != CandleStickType || [chooseView isHidden]) {
        currentIndex = CandleStickType;
        [chooseView setHidden:false];
        [chooseView setChooseArray:kChartTypeArray];
        [chooseView setCenter:toolBar.kChartTypeButton.center];
        CGRect frame = chooseView.frame;
        //    frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.y = self.frame.size.height - frame.size.height - toolBar.frame.size.height;
        chooseView.frame = frame;
        [chooseView setDelegate:self];
        [chooseView setType:CandleStickType];
        [chooseView reloadData];
        
    } else {
        [chooseView setHidden:true];
        [subChooseView setHidden:true];
        currentIndex = Unselected;
    }
    
}

- (void)addCycleTypeAction {
    if (currentIndex != CycleChooseType || [chooseView isHidden]) {
        currentIndex = CycleChooseType;
        [chooseView setHidden:false];
        [chooseView setChooseArray:cycleArray];
        [chooseView setCenter:toolBar.cycleTypeButton.center];
        CGRect frame = chooseView.frame;
        //    frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.y = self.frame.size.height - frame.size.height - toolBar.frame.size.height;
        chooseView.frame = frame;
        [chooseView setDelegate:self];
        [chooseView setType:CycleChooseType];
        [chooseView reloadData];
    } else {
        [chooseView setHidden:true];
        [subChooseView setHidden:true];
        currentIndex = Unselected;
    }
}

- (void)reloadHistoricData {
    [self loadData:true];
}

- (void)addTechnologyTypeAction {
    //    [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"addTiAction('ma1')"]];
    if (currentIndex != TechnologyType || [chooseView isHidden]) {
        currentIndex = TechnologyType;
        [chooseView setHidden:false];
        [chooseView setChooseArray:technologyArray];
        [chooseView setCenter:toolBar.technologyTypeButton.center];
        CGRect frame = chooseView.frame;
        //    frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.y = self.frame.size.height - frame.size.height - toolBar.frame.size.height;
        chooseView.frame = frame;
        [chooseView setDelegate:self];
        [chooseView setType:TechnologyType];
        [chooseView reloadData];
        
    } else {
        [chooseView setHidden:true];
        [subChooseView setHidden:true];
        currentIndex = Unselected;
    }
}

- (void)addClearAllAction {
    [kChartWebView stringByEvaluatingJavaScriptFromString:@"removeAllDrawers()"];
}

- (void)addDrawLineAction {
    //    [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"drawHorizontalLine()"]];
    if (currentIndex != DrawType || [chooseView isHidden]) {
        currentIndex = DrawType;
        [chooseView setHidden:false];
        [chooseView setChooseArray:drawTypeArray];
        [chooseView setCenter:toolBar.drawLineButton.center];
        CGRect frame = chooseView.frame;
        //    frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.y = self.frame.size.height - frame.size.height - toolBar.frame.size.height;
        chooseView.frame = frame;
        [chooseView setDelegate:self];
        [chooseView setType:DrawType];
        [chooseView reloadData];
        
    } else {
        [chooseView setHidden:true];
        [subChooseView setHidden:true];
        currentIndex = Unselected;
    }
}

- (void)addTiSubChooseView {
    if ([subChooseView isHidden]) {
        [subChooseView setHidden:false];
        [subChooseView setChooseArray:maSubChooseArray];
        CGRect frame = chooseView.frame;
        frame.origin.x -= frame.size.width;
        [subChooseView setFrame:frame];
        [subChooseView setDelegate:self];
        [subChooseView setType:MaSubArrayType];
        [chooseView setSubChooseView:subChooseView];
        [subChooseView reloadData];
    } else {
        [subChooseView setHidden:true];
        [chooseView setHidden:true];
        currentIndex = Unselected;
    }
}

- (void)didSelectAtIndex:(int)index type:(int)type {
    Boolean isHidden= true;
    switch (type) {
        case CycleChooseType:
            [self dealWithCycleIndex:index];
            break;
        case TechnologyType:
            isHidden = [self dealWithTiIndex:index];
            break;
        case DrawType:
            [self dealWithDrawIndex:index];
            break;
        case CandleStickType:
            [self dealWithKChartIndex:index];
            break;
        case MaSubArrayType:
            [self dealWithMaSubIndex:index];
            break;
            //            [self];
        default:
            break;
    }
    [chooseView setHidden:isHidden];
}

- (void)dealWithCycleIndex:(int)index {
    [[KChartParam getInstance] setCycle:[[cycleArray objectAtIndex:index] intValue]];
    [self saveToJsonString:[[KChartParam getInstance] instrumentName]];
    [self loadData:false];
}

- (Boolean)dealWithTiIndex:(int)index {
    
    Boolean isHidden = true;
    NSString *ti = [technologyArray objectAtIndex:index];
    NSMutableArray *addedTiArray = [[KChartParam getInstance] technologyArray];
    NSMutableArray *addedMuTiArray = [[KChartParam getInstance] mutableTechnologyArray];
    if (addedTiArray == nil) {
        addedTiArray = [[NSMutableArray alloc] init];
    }
    if (addedMuTiArray == nil) {
        addedMuTiArray = [[NSMutableArray alloc] initWithObjects:@"MA0", @"MA0", @"MA0", @"MA0", @"MA0", nil];
    }
    
    if ([[[KChartParam getInstance] staticMutableTiArray] containsObject:[ti uppercaseString]]) {
        //                [addedMuTiArray addObject:ti];
        [self addTiSubChooseView];
        isHidden = false;
    } else {
        if ([addedTiArray containsObject:ti]) {
            [addedTiArray removeObject:ti];
        } else {
            if ([addedTiArray count] >= 2) {
                [addedTiArray removeObjectAtIndex:0];
            }
            [addedTiArray addObject:ti];
            [self addTiView:ti withIndex:index];
        }
        [[KChartParam getInstance] setTechnologyArray:addedTiArray];
        [[KChartParam getInstance] setMutableTechnologyArray:addedMuTiArray];
        [self reloadTi];
    }
    
    return isHidden;
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
    //    functionName = @"drawLineAction()";
    [kChartWebView stringByEvaluatingJavaScriptFromString:functionName];
    //    NSString *json = [kChartWebView stringByEvaluatingJavaScriptFromString:@"saveToString()"];
    //    NSLog(@"%@", json);
}

- (void)dealWithKChartIndex:(int)index {
    NSString *type = [kChartTypeArray objectAtIndex:index];
    [[KChartParam getInstance] setKChartType:type];
    [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"chooseOhlcBarType('%@')", type]];
    [[ShowAlert getInstance] hidenAlertWaitView];
}

- (void)dealWithMaSubIndex:(int)index {
    NSMutableArray *addedMuTiArray = [[KChartParam getInstance] mutableTechnologyArray];
    if (addedMuTiArray == nil) {
        addedMuTiArray = [[NSMutableArray alloc] initWithObjects:@"MA0", @"MA0", @"MA0", @"MA0", @"MA0",nil];
    }
    
    if ([[[addedMuTiArray objectAtIndex:index] uppercaseString] isEqualToString:@"MA0"]) {
        [addedMuTiArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"MA%d", index + 1]];
        [self addTiView:MA withIndex:index];
    } else {
        [addedMuTiArray replaceObjectAtIndex:index withObject:@"MA0"];
    }
    
    [[KChartParam getInstance] setMutableTechnologyArray:addedMuTiArray];
    [self reloadTi];
}

- (int)getCycleValue {
    //    ChartCycleMin1      = 301,
    //    ChartCycleMin5      = 302,
    //    ChartCycleMin10     = 303,
    //    ChartCycleMin15     = 304,
    //    ChartCycleMin30     = 305,
    //    ChartCycleMin60     = 306,
    //    ChartCycleMin90     = 307,
    //    ChartCycleMin180    = 308,
    //
    //    ChartCycleDay       = 309,
    //    ChartCycleWeek      = 310,
    //    ChartCycleMonth     = 311,
    //    ChartCycleYear      = 312,
    //
    //    ChartCycleHour2     = 313,
    //    ChartCycleHour4     = 314,
    //    ChartCycleHour6     = 315,
    //    ChartCycleHour8     = 316
    int cycle = [[KChartParam getInstance] cycle];
    switch (cycle) {
        case ChartCycleMin1:
            return 1;
        case ChartCycleMin5:
            return 5;
        case ChartCycleMin10:
            return 10;
        case ChartCycleMin15:
            return 15;
        case ChartCycleMin30:
            return 30;
        case ChartCycleMin60:
            return 60;
        case ChartCycleMin90:
            return 90;
        case ChartCycleMin180:
            return 180;
        case ChartCycleDay:
            return 24 * 60;
        case ChartCycleWeek:
            return 24 * 60 * 7;
        case ChartCycleMonth:
            // 基本不会用到 年和月， 就暂时这么表示
            return 24 * 60 * 30;
        case ChartCycleYear:
            return 24 * 60 * 365;
        case ChartCycleHour2:
            return 60 * 2;
        case ChartCycleHour4:
            return 60 * 4;
        case ChartCycleHour6:
            return 60 * 6;
        case ChartCycleHour8:
            return 60 * 8;
        default:
            break;
    }
    return 1;
}

//- (void)reset {
//
//    [QuoteDataStore removeQuoteReceiver:instance];
//    popedImage = nil;
//    unpopedImage = nil;
//    [chooseView removeFromSuperview];
//    chooseView = nil;
//    [kChartWebView removeFromSuperview];
//    kChartWebView = nil;
//    [[KChartParam getInstance] resetInstrument];
//    [toolBar removeFromSuperview];
//    toolBar = nil;
//    [instance removeFromSuperview];
//    instance = nil;
//}

- (void)reset {
    if (instance != nil) {
        isPop = false;
        [self autoPortrait];
    }
}

//- (void)dealloc {
//    [QuoteDataStore removeQuoteReceiver:self];
//}

#pragma addMATiArgument

- (void)addTiView:(NSString *)type withIndex:(int)index{
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"ma", @"rsi", @"kdj", @"macd", @"bollingerBand", nil];
    if (![array containsObject:type]) {
        return;
    }
    
    UIView *contentView = nil;
    [tiArgumentView setUserInteractionEnabled:false];
    [tiArgumentView setHidden:false];
    CGRect rect = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [tiArgumentView setFrame:rect];
    [UIView transitionWithView:self
                      duration:AnimationTime
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        CGRect rect = tiArgumentView.frame;
                        rect.origin.x = 0;
                        tiArgumentView.frame = rect;
                    }
                    completion:^(BOOL finished){
                        [tiArgumentView setUserInteractionEnabled:true];
                    }];
    
    if ([type isEqualToString:@"ma"]) {
        contentView = [MAContentView newInstanceWithIndex:index];
    }
    
    if ([type isEqualToString:@"rsi"]) {
        contentView = [RSIContentView newInstance];
    }
    
    if ([type isEqualToString:@"kdj"]) {
        contentView = [KDJContentView newInstance];
    }
    
    if ([type isEqualToString:@"macd"]) {
        contentView = [MACDContentView newInstance];
    }
    
    if ([type isEqualToString:@"bollingerBand"]) {
        contentView = [BollingerBandContentView newInstance];
    }
    
    if (contentView != nil) {
        [contentView setTag:TiContentViewTag];
        [tiArgumentView addSubview:contentView];
    }
    
    
}

- (void)removeTiView {
    UIView *contentView = [tiArgumentView viewWithTag:TiContentViewTag];
    //    [tiArgumentView removeFromSuperview];
    //    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [tiArgumentView setUserInteractionEnabled:false];
    [UIView transitionWithView:self
                      duration:AnimationTime
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        CGRect rect = tiArgumentView.frame;
                        rect.origin.x = -SCREEN_HEIGHT-SCREEN_WIDTH;
                        tiArgumentView.frame = rect;
                    }
                    completion:^(BOOL finished){
                        [contentView removeFromSuperview];
                        [tiArgumentView setHidden:true];
                    }];
}

- (void)commitArgument {
    UIView *contentView = [tiArgumentView viewWithTag:TiContentViewTag];
    if ([contentView respondsToSelector:@selector(commitTiArgument)]) {
        //        [contentView commitTiArgument:kChartWebView];
        [contentView performSelector:@selector(commitTiArgument) withObject:nil];
        //        [self restoreJsonString:[[KChartParam getInstance] instrumentName]];
        [self reloadTiArgument];
        [[KChartView getInstance] saveToJsonString:[[KChartParam getInstance] instrumentName]];
        //        NSDictionary *configDic = [[[TiSaveData getInstance] tiClientMap] objectForKey:[[KChartParam getInstance] instrumentName]];
        ////        //    NSDictionary *dic = [self parseParam:json];
        //        [[KChartParam getInstance] setTiConfigDic:configDic];
    }
    [self removeTiView];
}

- (void)resetArgument {
    UIView *contentView = [tiArgumentView viewWithTag:TiContentViewTag];
    if ([contentView respondsToSelector:@selector(resetTiArgument)]) {
        [contentView performSelector:@selector(resetTiArgument) withObject:nil];
    }
}

- (void)saveToJsonString:(NSString *)instrumentName {
    if (instrumentName != nil && ![instrumentName isEqualToString:@""]) {
        NSMutableDictionary *tiDic = [[TiSaveData getInstance] tiMap];
        NSString *json = [kChartWebView stringByEvaluatingJavaScriptFromString:@"saveToString()"];
        // 保存的是jason字符串
        [tiDic setObject:json forKey:instrumentName];
        //        [tiDic setObject:[[NSNumber alloc] initWithInt:[[KChartParam getInstance] cycle]]
        //                  forKey:[NSString stringWithFormat:@"%@Cycle", instrumentName]];
        [[TiSaveData getInstance] setTiMap:tiDic];
        
        // 從js 解析的參數 保存
        NSMutableDictionary *tiClientDic = [[TiSaveData getInstance] tiClientMap];
        NSString *config = [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getTiArgumentConfigList()"]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self parseParam:config]];
        [dic setObject:[[NSNumber alloc] initWithInt:[[KChartParam getInstance] cycle]]
                forKey:[NSString stringWithFormat:@"%@Cycle", instrumentName]];
        [tiClientDic setObject:dic forKey:instrumentName];
        
        //        [[TiSaveData getInstance] setTiClientMap:tiClientDic];
        
        [[TiSaveData getInstance] saveConfigData];
    }
}

- (void)restoreJsonString:(NSString *)instrumentName {
    
    // 还原技术指标
    [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"doRevert()"]];
    if (instrumentName != nil && ![instrumentName isEqualToString:@""]) {
        NSMutableDictionary *dic = [[TiSaveData getInstance] tiMap];
        NSString *json = [dic objectForKey:instrumentName];
        if (json == nil || [json isEqualToString:@""]) {
            //            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"restoreFromString('%@')", json]];
            json = [[LangCaptain getInstance] getLangByCode:@"DefaultConfig"];
            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"restoreFromString('%@')", json]];
            [self saveToJsonString:instrumentName];
        }
        else {
            [kChartWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"restoreFromString('%@')", json]];
            
        }
    }
    NSDictionary *configDic = [[[TiSaveData getInstance] tiClientMap] objectForKey:instrumentName];
    //    NSDictionary *dic = [self parseParam:json];
    [[KChartParam getInstance] setTiConfigDic:configDic];
}

- (NSDictionary *)parseParam:(NSString *)argumentConfig {
    NSArray *array = [self split:@";" byString:argumentConfig];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *param in array) {
        NSArray *params = [self split:@":" byString:param];
        [dic setObject:params[1] forKey:params[0]];
    }
    
    for (NSString *key in [dic allKeys]) {
        NSDictionary *subDic = [self parseSubParam:[dic objectForKey:key]];
        [dic setObject:subDic forKey:key];
    }
    return dic;
}

- (NSDictionary *)parseSubParam:(NSString *)subParams {
    NSArray *array = [self split:@"+" byString:subParams];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *temp in array) {
        NSArray *tempArray = [self split:@"|" byString:temp];
        id result = [format numberFromString:tempArray[1]];
        if (result) {
            [dic setObject:[NSNumber numberWithInt:[result intValue]] forKey:tempArray[0]];
        } else {
            [dic setObject:tempArray[1] forKey:tempArray[0]];
        }
    }
    return dic;
}

- (NSArray *)split:(NSString *)split byString:(NSString *)oriString{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[oriString componentsSeparatedByString:split]];
    if ([array containsObject:@""]) {
        [array removeObject:@""];
    }
    return array;
}

- (void)disableBackButton {
    [toolBar.backButton setEnabled:false];
}

- (void)ableBackButton {
    [toolBar.backButton setEnabled:true];
}

- (Boolean)isPoped {
    return isPop;
}

@end
