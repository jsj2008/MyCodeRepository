//
//  BottomTradeView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "BottomContentView.h"
#import "CustomPageView.h"
#import "IOSLayoutDefine.h"
#import "TradeContentView.h"
#import "OpenPositionTableView.h"
#import "OrderPositionTableView.h"
#import "PriceWarningTableView.h"
#import "ClosePositionTableView.h"
#import "OrderHisTableView.h"
#import "PriceWarningTableView.h"
#import "PositionSumTableView.h"
#import "LangCaptain.h"
#import "CustomPageDelegate.h"

@interface BottomContentView()<CustomPageViewDataSourceProtocol> {
    CustomPageView *_tradePageView;
}

@end

@implementation BottomContentView

- (id)init {
    if (self = [super init]) {
        CGRect tradePageRect = CGRectMake(0, 0, SCREEN_WIDTH, BottomContentHeight);
        //        _tradePageView = [[CustomPageView alloc] initWithFrame:tradePageRect];
        _tradePageView = [[CustomPageView alloc] init];
        [_tradePageView setFrame:tradePageRect];
        
        
        //        [tradePageView setPageViews:viewArray];
        [_tradePageView setSourceDelegate:self];
        [self addSubview:_tradePageView];
        [self initHiddenButton];
    }
    return self;
}

- (void)initHiddenButton {
    self.hiddenButton = [[UIButton alloc] init];
    //    [self.hiddenButton setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.hiddenButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    frame.size.height -= 15.0f;
    frame.origin.y = 15.0f;
    [_tradePageView setFrame:frame];
    [self.hiddenButton setFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, 4, 50, 12)];
}

- (void)reclickPageView {
    [_tradePageView reclickCurrentPage];
}

- (void)setContentViewHidden:(Boolean)isHidden {
    [super setContentViewHidden:isHidden];
    if (isHidden) {
        [self.hiddenButton setBackgroundImage:[UIImage imageNamed:@"images/arrow/upArrow.png"] forState:UIControlStateNormal];
    } else {
        [self.hiddenButton setBackgroundImage:[UIImage imageNamed:@"images/arrow/downArrow.png"] forState:UIControlStateNormal];
    }
}

#pragma customPage delegate
- (NSArray *)arrayOfCustomPageViewAtPageView:(CustomPageView *)pageView {
    TradeContentView *openPositionTableView     = [[OpenPositionTableView alloc] init];
    TradeContentView *orderPositionTableView    = [[OrderPositionTableView alloc] init];
    TradeContentView *positionSumTableView      = [[PositionSumTableView alloc] init];
    TradeContentView *closePositionTableView    = [[ClosePositionTableView alloc] init];
    TradeContentView *orderHisTableView         = [[OrderHisTableView alloc] init];
    TradeContentView *priceWarningTableView     = [[PriceWarningTableView alloc] init];
    
    [openPositionTableView      setBackgroundColor:[UIColor clearColor]];
    [orderPositionTableView     setBackgroundColor:[UIColor clearColor]];
    [positionSumTableView       setBackgroundColor:[UIColor clearColor]];
    [closePositionTableView     setBackgroundColor:[UIColor clearColor]];
    [orderHisTableView          setBackgroundColor:[UIColor clearColor]];
    [priceWarningTableView      setBackgroundColor:[UIColor clearColor]];
    [openPositionTableView      setTitle:[[LangCaptain getInstance] getLangByCode:@"OpenPosition"]];
    [orderPositionTableView     setTitle:[[LangCaptain getInstance] getLangByCode:@"OrderPosition"]];
    [positionSumTableView       setTitle:[[LangCaptain getInstance] getLangByCode:@"PositionSum"]];
    [closePositionTableView     setTitle:[[LangCaptain getInstance] getLangByCode:@"ClosePositionHis"]];
    [orderHisTableView          setTitle:[[LangCaptain getInstance] getLangByCode:@"OrderHis"]];
    [priceWarningTableView      setTitle:[[LangCaptain getInstance] getLangByCode:@"PriceWarning"]];
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] initWithObjects:
                                 openPositionTableView, orderPositionTableView, orderHisTableView,
                                 closePositionTableView, positionSumTableView,priceWarningTableView, nil];
    return viewArray;
}

- (CGFloat)topTapTitleHeightAtPageView:(CustomPageView *)pageView {
    return 40.0f;
}

- (Boolean)scrollEnable {
    return false;
}

#pragma publicFunc
- (void)didClickAtFunction:(ViewFunction)function {
    int index = 0;
    switch (function) {
        case Function_Bottom_OpenPosition:
            index = 0;
            break;
        case Function_Bottom_OrderPosition:
            index = 1;
            break;
        case Function_Bottom_OrderHis:
            index = 2;
            break;
        case Function_Bottom_ClosePositionHis:
            index = 3;
            break;
        case Function_Bottom_PositionSum:
            index = 4;
            break;
        case Function_Bottom_PriceWarning:
            index = 5;
            break;
        default:
            NSLog(@" ****** bottom click err! ******");
            break;
    }
    
    [_tradePageView setCurrentPage:index];
    //    [[[_tradePageView pageViewArray] objectAtIndex:index] updateSelectIndex];
}

- (void)dealloc {
    
}

@end
