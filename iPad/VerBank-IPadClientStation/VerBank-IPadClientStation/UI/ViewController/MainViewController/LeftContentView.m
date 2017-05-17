//
//  LeftQuoteView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftContentView.h"
#import "CustomPageView.h"
#import "TradeContentView.h"
#import "IOSLayoutDefine.h"
#import "QuoteListView.h"
#import "LangCaptain.h"

#import "MarketTradeView.h"
#import "OrderPositionView.h"
#import "OpenOrderPositionView.h"
#import "PriceWarningView.h"
#import "MarginCallHisView.h"

#import "NewsView.h"
#import "EconomicDataView.h"
#import "ReviewView.h"
#import "MessageView.h"
#import "PushView.h"

#import "TextFieldController.h"
#import "AddOrModifyViewBuilder.h"

@interface LeftContentView()<CustomPageViewDataSourceProtocol, CustomPageViewActionProtocol> {
    AddOrModifyViewBuilder *_addOrModifyBuilder;
    
    CustomPageView  *_tradePageView;
    CustomPageView  *_newsPageView;
    CustomPageView  *_openPositionOrderPageView;
    CustomPageView  *_modifyOrderTradePageView;
    CustomPageView  *_modifyPriceWarningPageView;
    CustomPageView  *_quoteListPageView;
    CustomPageView  *_messagePageView;
    CustomPageView  *_margincallHisPageView;
    
    // quoteListPageView
    SinglePageView  *quoteListView;
    
    // tradePageView
    SinglePageView *marketTradeView;
    SinglePageView *addOrderTradeView;
    SinglePageView *priceWarningView;
    
    // newsPageView
    SinglePageView *newsView;
    SinglePageView *economicDataView;
    SinglePageView *reviewView;
    
    // openPositionOrderPageView
    SinglePageView *openPositionOrderView; // 附掛單
    
    // modifyOrderTradePageView
    SinglePageView *modifyOrderTradeView;
    
    // modifyPriceWarningPageView
    SinglePageView *modifyPriceWarningView;
    
    // _messagePageView
    SinglePageView  *messageView;
    SinglePageView  *pushView;
    
    // _margincallHisView
    SinglePageView *margincallHisView;
    
    //    ViewFunction currentFunction;
}

@end

@implementation LeftContentView

@synthesize currentViweFunction;

- (id)init {
    if (self = [super init]) {
        [self initHiddenButton];
        
        // 延时加载
        [self addMessagePageView];
        [self addLeftNewsPageView];
        [self addMarginCallHisView];;
        [self setBackgroundColor:[UIColor blackColor]];
        
    }
    return self;
}

- (MarketTradeView *)getMarketTradeView {
    return (MarketTradeView *)marketTradeView;
}

- (OrderPositionView *)getAddOrderPositionView {
    return (OrderPositionView *)addOrderTradeView;
}

- (OrderPositionView *)getModifyOrderPositionView {
    return (OrderPositionView *)modifyOrderTradeView;
}

- (OpenOrderPositionView *)getOpenOrderPositionView {
    return (OpenOrderPositionView *)openPositionOrderView;
}

- (void)addMessagePageView {
    CGRect pageRect = LeftRect;
    _messagePageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_messagePageView setSourceDelegate:self];
    [_messagePageView setActionDelegate:self];
    [self addSubview:_messagePageView];
}

- (void)addLeftTradePageView {
    CGRect pageRect = LeftRect;
    _tradePageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_tradePageView setSourceDelegate:self];
    [_tradePageView setActionDelegate:self];
    [self addSubview:_tradePageView];
}

- (void)addLeftNewsPageView {
    CGRect pageRect = LeftRect;
    _newsPageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_newsPageView setSourceDelegate:self];
    [self addSubview:_newsPageView];
}

- (void)addLeftOrderOpenPageView {
    CGRect pageRect = LeftRect;
    _openPositionOrderPageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_openPositionOrderPageView setSourceDelegate:self];
    [self addSubview:_openPositionOrderPageView];
}

- (void)addLeftModifyOrderTradePageView {
    CGRect pageRect = LeftRect;
    _modifyOrderTradePageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_modifyOrderTradePageView setSourceDelegate:self];
    [self addSubview:_modifyOrderTradePageView];
}

- (void)addLeftModifyPriceWarningPageView {
    CGRect pageRect = LeftRect;
    _modifyPriceWarningPageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_modifyPriceWarningPageView setSourceDelegate:self];
    [self addSubview:_modifyPriceWarningPageView];
}

- (void)addQuoteListPageView {
    CGRect pageRect = LeftRect;
    _quoteListPageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_quoteListPageView setSourceDelegate:self];
    [self addSubview:_quoteListPageView];
}

- (void)addMarginCallHisView {
    CGRect pageRect = LeftRect;
    _margincallHisPageView = [[CustomPageView alloc] initWithFrame:pageRect];
    [_margincallHisPageView setSourceDelegate:self];
    [self addSubview:_margincallHisPageView];
}

- (void)initHiddenButton {
    self.hiddenButton = [[UIButton alloc] init];
    [self addSubview:self.hiddenButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    frame.size.width -= 15.0f;
    [_tradePageView                 setFrame:frame];
    [_newsPageView                  setFrame:frame];
    [_messagePageView               setFrame:frame];
    [_openPositionOrderPageView     setFrame:frame];
    [_modifyOrderTradePageView      setFrame:frame];
    [_quoteListPageView             setFrame:frame];
    [_margincallHisPageView         setFrame:frame];
    [_modifyPriceWarningPageView    setFrame:frame];
    [self.hiddenButton              setFrame:CGRectMake(LeftContentWidth - LeftHiddenWidth + 3, frame.size.height / 2 + 25, LeftHiddenWidth - 2, 50.0f)];
    //    WithFrame:CGRectMake(LeftContentWidth - LeftHiddenWidth, 0, LeftHiddenWidth, SCREEN_HEIGHT)
    
    [[TextFieldController getInstance] keyboardReturen];
}

- (void)setContentViewHidden:(Boolean)isHidden {
    [super setContentViewHidden:isHidden];
    if (isHidden) {
        [self.hiddenButton setBackgroundImage:[UIImage imageNamed:@"images/arrow/rightArrow.png"] forState:UIControlStateNormal];
    } else {
        [self.hiddenButton setBackgroundImage:[UIImage imageNamed:@"images/arrow/leftArrow.png"] forState:UIControlStateNormal];
    }
}

#pragma customPage delegate
- (NSArray *)arrayOfCustomPageViewAtPageView:(CustomPageView *)pageView {
    NSArray *pageArray = nil;
    if (pageView == _tradePageView) {
        pageArray = [self getTradePageViewArray];
    }
    
    if (pageView == _newsPageView) {
        pageArray = [self getNewsPageViewArray];
    }
    
    if (pageView == _openPositionOrderPageView) {
        pageArray = [self getOrderPageViewArray];
    }
    
    if (pageView == _modifyOrderTradePageView) {
        pageArray = [self getModifyOrderTradePageViewArray];
    }
    
    if (pageView == _quoteListPageView) {
        pageArray = [self getQuoteListPageViewArray];
    }
    
    if (pageView == _modifyPriceWarningPageView) {
        pageArray = [self getModifyPriceWarningPageViewArray];
    }
    
    if (pageView == _messagePageView) {
        pageArray = [self getMessagePageViewArray];
    }
    
    if (pageView == _margincallHisPageView) {
        pageArray = [self getMargincallHisPageViewArray];
    }
    
    return pageArray;
}

- (CGFloat)topTapTitleHeightAtPageView:(CustomPageView *)pageView {
    return 30.0f;
}

- (Boolean)scrollEnable {
    return false;
}

//------- getFunc ------//
- (NSArray *)getTradePageViewArray {
    marketTradeView     = [MarketTradeView      newInstance];
    addOrderTradeView   = [OrderPositionView    newInstance];
    priceWarningView    = [PriceWarningView     newInstance];
    [marketTradeView setTitle:[[LangCaptain getInstance] getLangByCode:@"MarketTrade"]];
    [addOrderTradeView setTitle:[[LangCaptain getInstance] getLangByCode:@"OrderTrade"]];
    [priceWarningView setTitle:[[LangCaptain getInstance] getLangByCode:@"PriceWarning"]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:marketTradeView, addOrderTradeView, priceWarningView, nil];
    
    [[self getAddOrModifyBuilder] buildAddOrderPositionView:(OrderPositionView *)addOrderTradeView];
    [[self getAddOrModifyBuilder] buildAddPriceWarningView:(PriceWarningView *)priceWarningView];
    
    return viewArray;
}

- (NSArray *)getNewsPageViewArray {
    newsView        = [NewsView newInstance];
    economicDataView= [EconomicDataView newInstance];
    reviewView      = [ReviewView newInstance];
    [newsView setTitle:[[LangCaptain getInstance] getLangByCode:@"News"]];
    [economicDataView setTitle:[[LangCaptain getInstance] getLangByCode:@"EconomicData"]];
    [reviewView setTitle:[[LangCaptain getInstance] getLangByCode:@"Review"]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:newsView, economicDataView, reviewView, nil];
    return viewArray;
}

// 附掛單修改
- (NSArray *)getOrderPageViewArray {
    openPositionOrderView = [OpenOrderPositionView newInstance];
    [openPositionOrderView setTitle:[[LangCaptain getInstance] getLangByCode:@""]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:openPositionOrderView, nil];
    return viewArray;
}

- (NSArray *)getModifyOrderTradePageViewArray {
    modifyOrderTradeView = [OrderPositionView newInstance];
    [modifyOrderTradeView setTitle:[[LangCaptain getInstance] getLangByCode:@"OrderModify"]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:modifyOrderTradeView, nil];
    [[self getAddOrModifyBuilder] buildModifyOrderPositionView:(OrderPositionView *)modifyOrderTradeView];
    return viewArray;
}

- (NSArray *)getModifyPriceWarningPageViewArray {
    modifyPriceWarningView = [PriceWarningView newInstance];
    [modifyPriceWarningView setTitle:[[LangCaptain getInstance] getLangByCode:@"ModifyPriceWarning"]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:modifyPriceWarningView, nil];
    [[self getAddOrModifyBuilder] buildModifyPriceWarningView:(PriceWarningView *)modifyPriceWarningView];
    return viewArray;
}

- (NSArray *)getQuoteListPageViewArray {
    quoteListView = [QuoteListView newInstance];
    [quoteListView setTitle:[[LangCaptain getInstance] getLangByCode:@"QuoteList"]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:quoteListView, nil];
    return viewArray;
}

- (NSArray *)getMessagePageViewArray {
    messageView = [MessageView newInstance];
    pushView    = [PushView newInstance];
    [messageView setTitle:[[LangCaptain getInstance] getLangByCode:@"NoticeInformation"]];
    [pushView setTitle:[[LangCaptain getInstance] getLangByCode:@"PushInformation"]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:messageView, pushView, nil];
    return viewArray;
}

- (NSArray *)getMargincallHisPageViewArray {
    margincallHisView = [MarginCallHisView newInstance];
    [margincallHisView setTitle:[[LangCaptain getInstance] getLangByCode:@"MarginCallHis"]];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:margincallHisView, nil];
    return viewArray;
}

#pragma publicFuc
- (void)didClickAtFunction:(ViewFunction)function {
    [self removeOriListener];
    currentViweFunction = function;
    switch (function) {
        case Function_Left_QuoteList:
            if (_quoteListPageView == nil) {
                [self addQuoteListPageView];
            }
            [self bringSubviewToFront:_quoteListPageView];
            [_quoteListPageView setCurrentPage:0];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:false];
            
            break;
        case Function_Left_MarketTrade:
            if (_tradePageView == nil) {
                [self addLeftTradePageView];
            }
            [self bringSubviewToFront:_tradePageView];
            [_tradePageView setCurrentPage:0];
            [self updateTradeView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:true];
            break;
        case Function_Left_AddOrderTrade:
            if (_tradePageView == nil) {
                [self addLeftTradePageView];
            }
            [self bringSubviewToFront:_tradePageView];
            [_tradePageView setCurrentPage:1];
            [self updateTradeView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:true];
            break;
        case Function_Left_PriceWarnigTrade:
            if (_tradePageView == nil) {
                [self addLeftTradePageView];
            }
            [self bringSubviewToFront:_tradePageView];
            [_tradePageView setCurrentPage:2];
            [self updateTradeView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:true];
            break;
        case Function_Left_News:
            if (_newsPageView == nil) {
                [self addLeftNewsPageView];
            }
            [self bringSubviewToFront:_newsPageView];
            [_newsPageView setCurrentPage:0];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:false];
            break;
        case Function_Left_EconomicData:
            if (_newsPageView == nil) {
                [self addLeftNewsPageView];
            }
            [self bringSubviewToFront:_newsPageView];
            [_newsPageView setCurrentPage:1];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:false];
            break;
        case Function_Left_Review:
            if (_newsPageView == nil) {
                [self addLeftNewsPageView];
            }
            [self bringSubviewToFront:_newsPageView];
            [_newsPageView setCurrentPage:2];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:false];
            break;
        case Function_Left_MargincallHis:
            if (_margincallHisPageView == nil) {
                [self addMarginCallHisView];
            }
            [self bringSubviewToFront:_margincallHisPageView];
            [_margincallHisPageView setCurrentPage:0];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:false];
            break;
        case Function_Left_Message:
            if (_messagePageView == nil) {
                [self addMessagePageView];
            }
            [self bringSubviewToFront:_messagePageView];
            [_messagePageView setCurrentPage:0];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:false];
            break;
        case Function_Left_Push:
            if (_messagePageView == nil) {
                [self addMessagePageView];
            }
            [self bringSubviewToFront:_messagePageView];
            [_messagePageView setCurrentPage:1];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:false];
            break;
        case Function_Left_AddOpenPositionOrder:
            if (_openPositionOrderPageView == nil) {
                [self addLeftOrderOpenPageView];
            }
            [self bringSubviewToFront:_openPositionOrderPageView];
            [_openPositionOrderPageView setCurrentPage:0];
            [self updateAddOpenPositionOrderView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:true];
            break;
        case Function_Left_ModifyOpenPositionOrder:
            if (_openPositionOrderPageView == nil) {
                [self addLeftOrderOpenPageView];
            }
            [self bringSubviewToFront:_openPositionOrderPageView];
            [_openPositionOrderPageView setCurrentPage:0];
            [self updateModifyOpenPositionOrderView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:true];
            break;
        case Function_Left_ModifyOrderTrade:
            if (_modifyOrderTradePageView == nil) {
                [self addLeftModifyOrderTradePageView];
            }
            [self bringSubviewToFront:_modifyOrderTradePageView];
            [_modifyOrderTradePageView setCurrentPage:0];
            [self updateModifyOrderTradeView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:true];
            break;
        case Function_Left_ModifyPriceWarning:
            if (_modifyPriceWarningPageView == nil) {
                [self addLeftModifyPriceWarningPageView];
            }
            [self bringSubviewToFront:_modifyPriceWarningPageView];
            [_modifyPriceWarningPageView setCurrentPage:0];
            [self updateModifyPriceWarningView];
            [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] showTradeChratWebViewStatus:true];
            break;
        default:
            break;
    }
    [[[LayoutCenter getInstance] mainViewLayoutCenter] showLeftView];
}

- (void)didUpdateCurrentViewFunction {
    [self didClickAtFunction:currentViweFunction];
}

// 刪除隱藏 監聽
- (void)removeOriListener {
    switch (currentViweFunction) {
        case Function_Left_QuoteList:
            [_quoteListPageView removeAllListener];
            break;
        case Function_Left_MarketTrade:
        case Function_Left_AddOrderTrade:
        case Function_Left_PriceWarnigTrade:
            [_tradePageView removeAllListener];
            break;
        case Function_Left_News:
        case Function_Left_EconomicData:
        case Function_Left_Review:
            [_newsPageView removeAllListener];
            break;
        case Function_Left_MargincallHis:
            [_margincallHisPageView removeAllListener];
            break;
        case Function_Left_Message:
        case Function_Left_Push:
            [_messagePageView removeAllListener];
            break;
        case Function_Left_AddOpenPositionOrder:
        case Function_Left_ModifyOpenPositionOrder:
            [_openPositionOrderPageView removeAllListener];
            break;
        case Function_Left_ModifyOrderTrade:
            [_modifyOrderTradePageView removeAllListener];
            break;
        case Function_Left_ModifyPriceWarning:
            [_modifyPriceWarningPageView removeAllListener];
            break;
        default:
            break;
    }
}

- (void)updateTradeView {
    [marketTradeView updateView];
    [[self getAddOrModifyBuilder] updateAddOrderPositionView:(OrderPositionView *)addOrderTradeView];
    [[self getAddOrModifyBuilder] updateAddPriceWarningView:(PriceWarningView *)priceWarningView];
}

- (void)updateAddOpenPositionOrderView {
    [[self getAddOrModifyBuilder] updateAddOpenOrderPositionView:(OpenOrderPositionView *)openPositionOrderView];
}

- (void)updateModifyOpenPositionOrderView {
    [[self getAddOrModifyBuilder] updateModifyOpenOrderPositionView:(OpenOrderPositionView *)openPositionOrderView];
}

- (void)updateModifyOrderTradeView {
    [[self getAddOrModifyBuilder] updateModifyOrderPositionView:(OrderPositionView *)modifyOrderTradeView];
}

- (void)updateModifyPriceWarningView {
    [[self getAddOrModifyBuilder] updateModifyPriceWarningView:(PriceWarningView *)modifyPriceWarningView];
}

- (AddOrModifyViewBuilder *)getAddOrModifyBuilder {
    if (_addOrModifyBuilder == nil) {
        _addOrModifyBuilder = [[AddOrModifyViewBuilder alloc] init];
    }
    return _addOrModifyBuilder;
}

#pragma customPageAction delegate
- (void)pageView:(CustomPageView *)pageView didChangePageAtIndex:(NSUInteger)index {
    [[TextFieldController getInstance] keyboardReturen];
    currentViweFunction = Function_Unknow;
    
    if (pageView == _tradePageView) {
        switch (index) {
            case 0:
                currentViweFunction = Function_Left_MarketTrade;
                break;
            case 1:
                currentViweFunction = Function_Left_AddOrderTrade;
                break;
            case 2:
                currentViweFunction = Function_Left_PriceWarnigTrade;
                break;
            default:
                break;
        }
    }
    
    if (pageView == _quoteListPageView) {
        currentViweFunction = Function_Left_QuoteList;
    }
    
    if (pageView == _newsPageView) {
        switch (index) {
            case 0:
                currentViweFunction = Function_Left_News;
                break;
            case 1:
                currentViweFunction = Function_Left_EconomicData;
                break;
            case 2:
                currentViweFunction = Function_Left_Review;
                break;
            default:
                break;
        }
    }
    
    if (pageView == _openPositionOrderPageView) {
        currentViweFunction = Function_Left_AddOpenPositionOrder;
    }
    
    if (pageView == _modifyOrderTradePageView) {
        currentViweFunction = Function_Left_ModifyOrderTrade;
    }
    
    if (pageView == _modifyPriceWarningPageView) {
        currentViweFunction = Function_Left_ModifyPriceWarning;
    }
    
    if (pageView == _messagePageView) {
        switch (index) {
            case 0:
                currentViweFunction = Function_Left_Message;
                break;
            case 1:
                currentViweFunction = Function_Left_Push;
                break;
            default:
                break;
        }
    }
    
    if (pageView == _margincallHisPageView) {
        currentViweFunction = Function_Left_MargincallHis;
    }
}

- (void)dealloc {
    
}

@end
