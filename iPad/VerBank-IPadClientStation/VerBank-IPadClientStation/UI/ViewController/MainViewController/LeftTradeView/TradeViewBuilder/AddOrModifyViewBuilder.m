//
//  AddOrModifyViewBuilder.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AddOrModifyViewBuilder.h"

#import "JumpDataCenter.h"
#import "APIDoc.h"
#import "OrderPositionView.h"
#import "OpenOrderPositionView.h"
#import "PriceWarningView.h"
#import "LayoutCenter.h"
#import "LangCaptain.h"
//#import "OrderOCOPageView.h"
#import "CheckUtils.h"



@interface AddOrModifyViewBuilder() {}

@end

@implementation AddOrModifyViewBuilder

- (void)buildAddOrderPositionView:(OrderPositionView *)addOrderPositionView {
    [addOrderPositionView.ocoPageView initAddOrModify:AddType orderPositionView:addOrderPositionView];
    // 只有 Add 的時候可以修改商品名稱
    [addOrderPositionView.instrumentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:[ActionUtils getInstance]
                                                                                                       action:@selector(instrumentPick)]];
    [addOrderPositionView.quoteView setUserInteractionEnabled:true];
}

- (void)buildModifyOrderPositionView:(OrderPositionView *)modifyOrderPositionView {
    [modifyOrderPositionView.ocoPageView initAddOrModify:ModifyType orderPositionView:modifyOrderPositionView];
    [modifyOrderPositionView.quoteView setUserInteractionEnabled:false];
}

- (void)updateAddOrderPositionView:(OrderPositionView *)addOrderPositionView {
    [addOrderPositionView.ocoPageView resetInputValue];
    [addOrderPositionView setInstrumentName:[[JumpDataCenter getInstance] createTradeInstrument]];
    [addOrderPositionView setDigist:[[[APIDoc getSystemDocCaptain] getInstrument:addOrderPositionView.instrumentName] getDigits]];
    [addOrderPositionView.ocoPageView       setIndex:OCOPageIndex_Limit];
    [addOrderPositionView.segmentControl    setCurrentSelectIndex:OCOPageIndex_Limit];
    int buySellType         = [[JumpDataCenter getInstance] marketTradeType];
    if (buySellType == BUY) {
        [addOrderPositionView.quoteView setBuyStatus];
    } else {
        [addOrderPositionView.quoteView setSellStatus];
    }
    
    [addOrderPositionView updateView];
}

- (void)updateModifyOrderPositionView:(OrderPositionView *)modifyOrderPositionView {
    [modifyOrderPositionView.ocoPageView resetInputValue];
    TOrder *order = [[JumpDataCenter getInstance] modifyOrder];
    [modifyOrderPositionView setInstrumentName:[order getInstrument]];
    [modifyOrderPositionView setDigist:[[[APIDoc getSystemDocCaptain] getInstrument:[order getInstrument]] getDigits]];
    if ([order getBuysell] == BUY) {
        [modifyOrderPositionView.quoteView setBuyStatus];
    } else {
        [modifyOrderPositionView.quoteView setSellStatus];
    }
    
    UpdateType type = [CheckUtils getOCOTypeByStop:[order getCurrentStopPrice]
                                        limitPrice:[order getLimitPrice]];
    
    OCOPageIndex pageIndex = OCOPageIndex_Limit;
    switch (type) {
        case UpdateTypeLimit:
            pageIndex = OCOPageIndex_Limit;
            break;
        case UpdateTypeStop:
            pageIndex = OCOPageIndex_Stop;
            break;
        case UpdateTypeOCO:
            pageIndex = OCOPageIndex_OCO;
            break;
            
        default:
            break;
    }
    
    [modifyOrderPositionView.ocoPageView       setIndex:pageIndex];
    [modifyOrderPositionView.segmentControl    setCurrentSelectIndex:pageIndex];
    [modifyOrderPositionView.ocoPageView       initOrder:order byType:pageIndex];
    [modifyOrderPositionView updateView];
}

- (void)updateAddOpenOrderPositionView:(OpenOrderPositionView *)addOpenOrderPositionView {
    [addOpenOrderPositionView setTitle:[[LangCaptain getInstance] getLangByCode:@"AddOpenOrder"]];
    [addOpenOrderPositionView.ocoPageView initAddOrModify:AddType orderPositionView:addOpenOrderPositionView];
    [addOpenOrderPositionView.ocoPageView resetInputValue];
    [addOpenOrderPositionView setInstrumentName:[[JumpDataCenter getInstance] createTradeInstrument]];
    [addOpenOrderPositionView setDigist:[[[APIDoc getSystemDocCaptain] getInstrument:addOpenOrderPositionView.instrumentName] getDigits]];
    [addOpenOrderPositionView.ocoPageView       setIndex:OCOPageIndex_Limit];
    [addOpenOrderPositionView.segmentControl    setCurrentSelectIndex:OCOPageIndex_Limit];
    int buySellType         = [[JumpDataCenter getInstance] marketTradeType];
    AddNewOpenOrderType orderType = [[JumpDataCenter getInstance] openOrderType];
    if (buySellType == BUY) {
        [addOpenOrderPositionView.quoteView setBuyStatus];
    } else {
        [addOpenOrderPositionView.quoteView setSellStatus];
    }
    
    [addOpenOrderPositionView.ocoPageView       setIndex:orderType];
    [addOpenOrderPositionView.segmentControl    setCurrentSelectIndex:orderType];
    
    [addOpenOrderPositionView updateView];
}

- (void)updateModifyOpenOrderPositionView:(OpenOrderPositionView *)modifyOpenOrderPositionView {
    [modifyOpenOrderPositionView setTitle:[[LangCaptain getInstance] getLangByCode:@"ModifyOpenOrder"]];
    [modifyOpenOrderPositionView.ocoPageView initAddOrModify:ModifyType orderPositionView:modifyOpenOrderPositionView];
    [modifyOpenOrderPositionView.ocoPageView resetInputValue];
    TOrder *order = [[JumpDataCenter getInstance] modifyOrder];
    [modifyOpenOrderPositionView setInstrumentName:[order getInstrument]];
    [modifyOpenOrderPositionView setDigist:[[[APIDoc getSystemDocCaptain] getInstrument:[order getInstrument]] getDigits]];
    if ([order getBuysell] == BUY) {
        [modifyOpenOrderPositionView.quoteView setBuyStatus];
    } else {
        [modifyOpenOrderPositionView.quoteView setSellStatus];
    }
    
    UpdateType type = [CheckUtils getOCOTypeByStop:[order getCurrentStopPrice] limitPrice:[order getLimitPrice]];
    
    OCOPageIndex pageIndex = OCOPageIndex_Limit;
    switch (type) {
        case UpdateTypeLimit:
            pageIndex = OCOPageIndex_Limit;
            break;
        case UpdateTypeStop:
            pageIndex = OCOPageIndex_Stop;
            break;
        case UpdateTypeOCO:
            pageIndex = OCOPageIndex_OCO;
            break;
            
        default:
            break;
    }
    
    [modifyOpenOrderPositionView.ocoPageView       setIndex:pageIndex];
    [modifyOpenOrderPositionView.segmentControl    setCurrentSelectIndex:pageIndex];
    [modifyOpenOrderPositionView.ocoPageView       initOrder:order byType:pageIndex];
    [modifyOpenOrderPositionView updateView];
}

- (void)buildAddPriceWarningView:(PriceWarningView *)addPriceWarningView {
    [addPriceWarningView initAddOrModify:AddType ];
    // 只有 Add 的時候可以修改商品名稱
    [addPriceWarningView.instrumentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:[ActionUtils getInstance]
                                                                                                      action:@selector(instrumentPick)]];
}

- (void)buildModifyPriceWarningView:(PriceWarningView *)modifyPriceWarningView {
    [modifyPriceWarningView initAddOrModify:ModifyType];
}

- (void)updateAddPriceWarningView:(PriceWarningView *)addPriceWarningView {
    [addPriceWarningView resetInputValue];
    [addPriceWarningView setInstrumentName:[[JumpDataCenter getInstance] createTradeInstrument]];
    [addPriceWarningView setDigist:[[[APIDoc getSystemDocCaptain] getInstrument:addPriceWarningView.instrumentName] getDigits]];
    [addPriceWarningView updateView];
}

- (void)updateModifyPriceWarningView:(PriceWarningView *)modifyPriceWarningView {
    [modifyPriceWarningView resetInputValue];
    PriceWarning *priceWarning = [[JumpDataCenter getInstance] priceWarning];
    [modifyPriceWarningView setInstrumentName:[priceWarning getInstrument]];
    [modifyPriceWarningView setDigist:[[[APIDoc getSystemDocCaptain] getInstrument:[priceWarning getInstrument]] getDigits]];
    [modifyPriceWarningView initWithPriceWarning:priceWarning];
    
    [modifyPriceWarningView updateView];
}

@end
