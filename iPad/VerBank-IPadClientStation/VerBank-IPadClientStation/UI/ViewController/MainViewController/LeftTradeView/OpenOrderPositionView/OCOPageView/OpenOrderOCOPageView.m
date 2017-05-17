//
//  OpenOrderOCOPageView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenOrderOCOPageView.h"
#import "APIDoc.h"
#import "DecimalUtil.h"
#import "OpenOrderPositionView.h"
#import "LangCaptain.h"

@implementation OpenOrderOCOPageView

@synthesize limitView;
@synthesize stopView;
@synthesize ocoView;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self setBackgroundColor:[UIColor blackColor]];
    [self setClipsToBounds:YES];
    [self setBounces:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    
    self.limitView  = [OpenOrderLimitView newInstance];
    self.ocoView    = [OpenOrderOCOView newInstance];
    self.stopView   = [OpenOrderStopView newInstance];
    [self addSubview:self.limitView];
    [self addSubview:self.ocoView];
    [self addSubview:self.stopView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 取三个View 的最长的Height
    // 应该拿到最低端的 一个view 的frame 来设置ContentSize
    
    CGFloat maxHeight = 0.0f;
    CGFloat limitViewHeight     = self.limitView.buttonPanelView.frame.origin.y    + self.limitView.buttonPanelView.frame.size.height + 10;
    CGFloat stopViewHeight      = self.stopView.buttonPanelView.frame.origin.y     + self.stopView.buttonPanelView.frame.size.height  + 10;
    CGFloat ocoViewHeight       = self.ocoView.buttonPanelView.frame.origin.y      + self.ocoView.buttonPanelView.frame.size.height   + 10;
    [self.limitView setFrame:CGRectMake(0, 0, self.frame.size.width, limitViewHeight)];
    [self.stopView  setFrame:CGRectMake(0, 0, self.frame.size.width, stopViewHeight)];
    [self.ocoView   setFrame:CGRectMake(0, 0, self.frame.size.width, ocoViewHeight)];
    if (limitViewHeight > maxHeight) {
        maxHeight = limitViewHeight;
    }
    
    if (stopViewHeight > maxHeight) {
        maxHeight = stopViewHeight;
    }
    
    if (ocoViewHeight > maxHeight) {
        maxHeight = ocoViewHeight;
    }
    [self setContentSize:CGSizeMake(0, maxHeight)];
}

#pragma public Func
- (void)setIndex:(NSUInteger)index {
    switch (index) {
        case OCOPageIndex_Limit:
            [self.limitView setHidden:false];
            [self.stopView  setHidden:true];
            [self.ocoView   setHidden:true];
            break;
        case OCOPageIndex_Stop:
            [self.limitView setHidden:true];
            [self.stopView  setHidden:false];
            [self.ocoView   setHidden:true];
            break;
        case OCOPageIndex_OCO:
            [self.limitView setHidden:true];
            [self.stopView  setHidden:true];
            [self.ocoView   setHidden:false];
            break;
        default:
            break;
    }
}

#pragma getValue

- (double)getAmountByType:(SegmentTradeType)type {
    switch (type) {
        case TradeTypeLimitView:
            return [self getDefaultAmount:self.limitView.amountTextField.text];
        case TradeTypeStopView:
            return [self getDefaultAmount:self.stopView.amountTextField.text];
        case TradeTypeOCOView:
            return [self getDefaultAmount:self.ocoView.amountTextField.text];
        default:
            break;
    }
    return 0.0f;
}

- (double)getLimitValueByTradeType:(SegmentTradeType)type {
    switch (type) {
        case TradeTypeLimitView:
            return [self getDoubleValue:self.limitView.limitPriceTextField.text];
        case TradeTypeStopView:
            return 0.0f;
        case TradeTypeOCOView:
            return [self getDoubleValue:self.ocoView.limitPriceTextField.text];
        default:
            break;
    }
    return 0.0f;
}

- (double)getStopValueByTradeType:(SegmentTradeType)type {
    switch (type) {
        case TradeTypeLimitView:
            return 0.0f;
        case TradeTypeStopView:
            return [self getDoubleValue:self.stopView.stopPriceTextField.text];
        case TradeTypeOCOView:
            return [self getDoubleValue:self.ocoView.stopPriceTextField.text];
        default:
            break;
    }
    return 0.0f;
}

- (NSUInteger)getStopMoveValueByType:(SegmentTradeType)type {
    switch (type) {
        case TradeTypeLimitView:
            return 0;
            break;
        case TradeTypeStopView:
            return [self getIntValue:self.stopView.stopMoveTextField.text];
            break;
        case TradeTypeOCOView:
            return [self getIntValue:self.ocoView.stopMoveTextField.text];
            break;
        default:
            break;
    }
    return 0;
}

- (NSUInteger)getExpireType:(SegmentTradeType)type {
    switch (type) {
        case TradeTypeLimitView:
            return [self.limitView.valueTimeButton getDateType];
            break;
        case TradeTypeStopView:
            return [self.stopView.valueTimeButton getDateType];
            break;
        case TradeTypeOCOView:
            return [self.ocoView.valueTimeButton getDateType];
            break;
        default:
            break;
    }
    return -1;
}

- (NSString *)getExpireTime:(SegmentTradeType)type {
    switch (type) {
        case TradeTypeLimitView:
            return [self.limitView.valueTimeButton getDateValueTime];
            break;
        case TradeTypeStopView:
            return [self.stopView.valueTimeButton getDateValueTime];
            break;
        case TradeTypeOCOView:
            return [self.ocoView.valueTimeButton getDateValueTime];
            break;
        default:
            break;
    }
    return @"Uninit expireTime";
}


- (double)getDoubleValue:(NSString *)string {
    return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
}

- (int)getIntValue:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return 0;
    }
    if ([self isPureInt:string]) {
        return [[string stringByReplacingOccurrencesOfString:@"," withString:@""] intValue];
    } else {
        return -1;
    }
}

- (Boolean)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (double)getDefaultAmount:(NSString *)amountString {
    if (amountString == nil || [amountString isEqualToString:@""]) {
        // 若为默认， 则返回0
        return 0.0f;
    } else {
        return [self getDoubleValue:amountString];
    }
}

- (void)resetInputValue {
    for (UIView *view in [self subviews]) {
        for (UIView *subview in [view subviews]) {
            if ([subview isKindOfClass:[UITextField class]]) {
                [(UITextField *)subview setText:@""];
            }
            if ([subview isKindOfClass:[ValueTimeButton class]]) {
                [(ValueTimeButton *)subview setDateType:ORDER_EXPIRE_TYPE_GTC];
            }
        }
    }
}

#pragma initValue
- (void)initOrder:(TOrder *)order byType:(OCOPageIndex)type {
    switch (type) {
        case OCOPageIndex_Limit:
            [self initLimitByOrder:order];
            break;
        case OCOPageIndex_Stop:
            [self initStopByOrder:order];
            break;
        case OCOPageIndex_OCO:
            [self initOCOByOrder:order];
            break;
        default:
            break;
    }
}

- (void)initLimitByOrder:(TOrder *)order {
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[order getInstrument]] getDigits];
    
    [self.limitView.limitPriceTextField     setText:[DecimalUtil formatDoubleByNoStyle:[order getLimitPrice] digit:digist]];
    [self.limitView.amountTextField         setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [self.ocoView.limitPriceTextField     setText:[DecimalUtil formatDoubleByNoStyle:[order getLimitPrice] digit:digist]];
    [self.ocoView.amountTextField         setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [self.limitView.valueTimeButton setDateType:[order getExpireType]];
    [self.limitView.valueTimeButton setDateValueTime:[order getExpiryTime]];
    
    [self.stopView.valueTimeButton setDateType:[order getExpireType]];
    [self.stopView.valueTimeButton setDateValueTime:[order getExpiryTime]];
    
    [self.ocoView.valueTimeButton setDateType:[order getExpireType]];
    [self.ocoView.valueTimeButton setDateValueTime:[order getExpiryTime]];
}

- (void)initStopByOrder:(TOrder *)order {
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[order getInstrument]] getDigits];
    if ([order getStopMoveGap] > 0.00001) {
        [self.stopView.stopMoveTextField setText:[@([order getStopMoveGap]) stringValue]];
    }
    
    [self.stopView.stopPriceTextField   setText:[DecimalUtil formatDoubleByNoStyle:[order getCurrentStopPrice] digit:digist]];
    [self.stopView.amountTextField      setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [self.ocoView.stopPriceTextField   setText:[DecimalUtil formatDoubleByNoStyle:[order getCurrentStopPrice] digit:digist]];
    [self.ocoView.amountTextField      setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [self.stopView.valueTimeButton setDateType:[order getExpireType]];
    [self.stopView.valueTimeButton setDateValueTime:[order getExpiryTime]];
    
    [self.limitView.valueTimeButton setDateType:[order getExpireType]];
    [self.limitView.valueTimeButton setDateValueTime:[order getExpiryTime]];
    
    [self.ocoView.valueTimeButton setDateType:[order getExpireType]];
    [self.ocoView.valueTimeButton setDateValueTime:[order getExpiryTime]];
}

- (void)initOCOByOrder:(TOrder *)order {
    int digist = [[[APIDoc getSystemDocCaptain] getInstrument:[order getInstrument]] getDigits];
    if ([order getStopMoveGap] > 0.00001) {
        [self.ocoView.stopMoveTextField setText:[@([order getStopMoveGap]) stringValue]];
    }
    
    [self.ocoView.stopPriceTextField    setText:[DecimalUtil formatDoubleByNoStyle:[order getCurrentStopPrice] digit:digist]];
    [self.ocoView.limitPriceTextField   setText:[DecimalUtil formatDoubleByNoStyle:[order getLimitPrice] digit:digist]];
    [self.ocoView.amountTextField       setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [self.limitView.limitPriceTextField   setText:[DecimalUtil formatDoubleByNoStyle:[order getLimitPrice] digit:digist]];
    [self.limitView.amountTextField       setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [self.stopView.stopPriceTextField    setText:[DecimalUtil formatDoubleByNoStyle:[order getCurrentStopPrice] digit:digist]];
    [self.stopView.amountTextField       setText:[DecimalUtil formatNumber:[order getAmount]]];
    
    [self.limitView.valueTimeButton setDateType:[order getExpireType]];
    [self.limitView.valueTimeButton setDateValueTime:[order getExpiryTime]];
    
    [self.stopView.valueTimeButton setDateType:[order getExpireType]];
    [self.stopView.valueTimeButton setDateValueTime:[order getExpiryTime]];
    
    [self.ocoView.valueTimeButton setDateType:[order getExpireType]];
    [self.ocoView.valueTimeButton setDateValueTime:[order getExpiryTime]];
}

- (void)initStopMoveGap:(NSString *)instrumentName {
    NSString *stopMove = [NSString stringWithFormat:@"%@(>=%d):", [[LangCaptain getInstance] getLangByCode:@"StopMovePrice"], [[[APIDoc getSystemDocCaptain] getInstrument:instrumentName] getMoveStopMinGap]];
    
    [self.ocoView.stopMoveLabel         setText:stopMove];
    [self.stopView.stopMoveLabel        setText:stopMove];
}

- (void)initAddOrModify:(AddOrModifyType)type orderPositionView:(id)orderPositionView{
    switch (type) {
        case AddType:
            [self typeAddWithOrderPosition:orderPositionView];
            break;
        case ModifyType:
            [self typeModifyWithOrderPosition:orderPositionView];
            break;
        default:
            break;
    }
}

- (void)typeAddWithOrderPosition:(id)orderPosition {
    
    [self setPanelHidden:true];
    [self.limitView.buttonPanelView.addCommitButton addTarget:orderPosition
                                                       action:@selector(doTrade:)
                                             forControlEvents:UIControlEventTouchUpInside];
    [self.stopView.buttonPanelView.addCommitButton addTarget:orderPosition
                                                      action:@selector(doTrade:)
                                            forControlEvents:UIControlEventTouchUpInside];
    [self.ocoView.buttonPanelView.addCommitButton addTarget:orderPosition
                                                     action:@selector(doTrade:)
                                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.limitView.buttonPanelView.addCancelButton addTarget:orderPosition
                                                       action:@selector(doCancel)
                                             forControlEvents:UIControlEventTouchUpInside];
    [self.stopView.buttonPanelView.addCancelButton addTarget:orderPosition
                                                      action:@selector(doCancel)
                                            forControlEvents:UIControlEventTouchUpInside];
    [self.ocoView.buttonPanelView.addCancelButton addTarget:orderPosition
                                                     action:@selector(doCancel)
                                           forControlEvents:UIControlEventTouchUpInside];
}

- (void)typeModifyWithOrderPosition:(id)orderPosition {
    [self setPanelHidden:false];
    [self.limitView.buttonPanelView.modifyCommitButton addTarget:orderPosition
                                                          action:@selector(doTrade:)
                                                forControlEvents:UIControlEventTouchUpInside];
    [self.stopView.buttonPanelView.modifyCommitButton addTarget:orderPosition
                                                         action:@selector(doTrade:)
                                               forControlEvents:UIControlEventTouchUpInside];
    [self.ocoView.buttonPanelView.modifyCommitButton addTarget:orderPosition
                                                        action:@selector(doTrade:)
                                              forControlEvents:UIControlEventTouchUpInside];
    
    [self.limitView.buttonPanelView.modifyCancelButton addTarget:orderPosition
                                                          action:@selector(doCancel)
                                                forControlEvents:UIControlEventTouchUpInside];
    [self.stopView.buttonPanelView.modifyCancelButton addTarget:orderPosition
                                                         action:@selector(doCancel)
                                               forControlEvents:UIControlEventTouchUpInside];
    [self.ocoView.buttonPanelView.modifyCancelButton addTarget:orderPosition
                                                        action:@selector(doCancel)
                                              forControlEvents:UIControlEventTouchUpInside];
    
    [self.limitView.buttonPanelView.modifyDeleteButton addTarget:orderPosition
                                                          action:@selector(doDelete)
                                                forControlEvents:UIControlEventTouchUpInside];
    [self.stopView.buttonPanelView.modifyDeleteButton addTarget:orderPosition
                                                         action:@selector(doDelete)
                                               forControlEvents:UIControlEventTouchUpInside];
    [self.ocoView.buttonPanelView.modifyDeleteButton addTarget:orderPosition
                                                        action:@selector(doDelete)
                                              forControlEvents:UIControlEventTouchUpInside];
}

- (void)setPanelHidden:(Boolean)isAddPanel {
    [self.limitView.buttonPanelView.modifyButtonPanel   setHidden:isAddPanel];
    [self.stopView.buttonPanelView.modifyButtonPanel    setHidden:isAddPanel];
    [self.ocoView.buttonPanelView.modifyButtonPanel     setHidden:isAddPanel];
    [self.limitView.buttonPanelView.addButtonPanel      setHidden:!isAddPanel];
    [self.stopView.buttonPanelView.addButtonPanel       setHidden:!isAddPanel];
    [self.ocoView.buttonPanelView.addButtonPanel        setHidden:!isAddPanel];
}

@end
