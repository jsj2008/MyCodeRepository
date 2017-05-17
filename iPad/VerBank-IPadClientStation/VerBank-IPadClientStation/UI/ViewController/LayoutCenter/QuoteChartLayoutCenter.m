//
//  QuoteChartLayoutCenter.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/7.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QuoteChartLayoutCenter.h"
#import "KChartWebView.h"
#import "UIView+AutoLayout.h"
#import "DebugUtil.h"
#import "ClientSystemConfig.h"

#import "QuoteDataStore.h"

typedef NS_ENUM(NSInteger, RightScreenStatus) {
    ConstraintLayoutViewCount0      = 0x0000,
    ConstraintLayoutViewCount1      = 0x0001,
    ConstraintLayoutViewCount2      = 0x0002,
    ConstraintLayoutViewCount3      = 0x0003,
    ConstraintLayoutViewCount4      = 0x0004,
    
    
    
    ConstraintLayoutAll             = 0x000f
};

@interface QuoteChartLayoutCenter() {
    KChartWebView *_tempViewA;
    KChartWebView *_tempViewB;
    KChartWebView *_tempViewC;
    KChartWebView *_tempViewD;
    
    RightScreenStatus currentStatus;
    
//    int systemConfigKChartViewStatus;
}

@end

@implementation QuoteChartLayoutCenter

@synthesize kChartViewArray;

@synthesize kChartSuperView;

- (id)init {
    if (self = [super init]) {
//        [self setDefaultValue];
        [self initKChartWebViews];
    }
    return self;
}

- (NSInteger)getSystemConifgKChartNumber {
    // 这个参数从系统设置中读取
//    systemConfigKChartViewStatus = 4;
    return [[[ClientSystemConfig getInstance] currentKChartNumber] integerValue];
}

- (void)initKChartWebViews {
    self.kChartViewArray = [[NSMutableArray alloc] init];
    KChartWebView *webViewA = [[KChartWebView alloc] initWithName:ViewNameA];
    KChartWebView *webViewB = [[KChartWebView alloc] initWithName:ViewNameB];
    KChartWebView *webViewC = [[KChartWebView alloc] initWithName:ViewNameC];
    KChartWebView *webViewD = [[KChartWebView alloc] initWithName:ViewNameD];
    
    [webViewA setInstrumentName:[[QuoteChartManager getInstance] getInstrumentByViewName:ViewNameA]];
    [webViewB setInstrumentName:[[QuoteChartManager getInstance] getInstrumentByViewName:ViewNameB]];
    [webViewC setInstrumentName:[[QuoteChartManager getInstance] getInstrumentByViewName:ViewNameC]];
    [webViewD setInstrumentName:[[QuoteChartManager getInstance] getInstrumentByViewName:ViewNameD]];
    [self.kChartViewArray addObject:webViewA];
    [self.kChartViewArray addObject:webViewB];
    [self.kChartViewArray addObject:webViewC];
    [self.kChartViewArray addObject:webViewD];
}

- (void)updateCurrentStatus:(NSUInteger)index {
    // 如果index == NormalScreenStatus 则显示普通， 若 index ！= NormalScreestatus 则为放大这个索引的View
    currentStatus = ConstraintLayoutViewCount0;
    if (index == NormalScreenStatus) {
        currentStatus = [self getSystemConifgKChartNumber];
        [self hiddenView];
    } else {
        currentStatus = 1;
    }
}

- (void)hiddenView {
    if (currentStatus == 1) {
        [_tempViewA setHidden:false];
        [_tempViewB setHidden:true];
        [_tempViewC setHidden:true];
        [_tempViewD setHidden:true];
    }
    if (currentStatus == 2) {
        [_tempViewA setHidden:false];
        [_tempViewB setHidden:false];
        [_tempViewC setHidden:true];
        [_tempViewD setHidden:true];
    }
    if (currentStatus == 3) {
        [_tempViewA setHidden:false];
        [_tempViewB setHidden:false];
        [_tempViewC setHidden:false];
        [_tempViewD setHidden:true];
    }
    if (currentStatus == 4) {
        [_tempViewA setHidden:false];
        [_tempViewB setHidden:false];
        [_tempViewC setHidden:false];
        [_tempViewD setHidden:false];
    }
}

- (void)updateContraints:(NSUInteger)index {
    [self removeConstraints];
    [self resetTempView:index];
    [self updateCurrentStatus:index];
    [self setUpSuperContraints];
    [self setUpViewAContraints];
    [self setUpViewBContraints];
    [self setUpViewCContraints];
    [self setUpViewDContraints];
    [UIView animateWithDuration:0.5f animations:^{
        for (UIView *view in self.kChartViewArray) {
            [view setNeedsLayout];
            [view layoutIfNeeded];
        }
    } completion:^(BOOL finished) {
    }];
}

- (void)resetTempView:(NSUInteger)index {
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[self.kChartViewArray copy]];
    if (index != NormalScreenStatus) {
        for (UIView *view in tempArray) {
            [view setHidden:true];
        }
        [tempArray exchangeObjectAtIndex:0 withObjectAtIndex:index];
    } else {
        for (UIView *view in self.kChartViewArray) {
            [view setHidden:false];
        }
    }
    
    _tempViewA = [tempArray objectAtIndex:0];
    [_tempViewA setHidden:false];
    _tempViewB = [tempArray objectAtIndex:1];
    _tempViewC = [tempArray objectAtIndex:2];
    _tempViewD = [tempArray objectAtIndex:3];
}

- (void)removeConstraints {
    //    [kChartSuperView autoRemoveConstraintsAffectingView];
    //    if ([[kChartSuperView constraints] count] != 0) {
    //        [kChartSuperView removeConstraints:kChartSuperView.constraints];
    //    }
    
    for (UIView *view in kChartViewArray) {
        [view autoRemoveConstraintsAffectingView];
        [view removeConstraints:view.constraints];
    }
}

- (void)setUpSuperContraints {
    //    [kChartSuperView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    //    [kChartSuperView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    //    [kChartSuperView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
    //    [kChartSuperView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
}

- (void)setUpViewAContraints {
    [_tempViewA autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [_tempViewA autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
    if (currentStatus == ConstraintLayoutViewCount1) {
        [_tempViewA autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:kChartSuperView withMultiplier:1.0f];
    } else {
        [_tempViewA autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:kChartSuperView withMultiplier:0.5f];
    }
    if (currentStatus == ConstraintLayoutViewCount4) {
        [_tempViewA autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:kChartSuperView withMultiplier:0.5f];
    } else {
        [_tempViewA autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:kChartSuperView withMultiplier:1.0f];
    }
}

- (void)setUpViewBContraints {
    [_tempViewB autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    if (currentStatus == ConstraintLayoutViewCount1) {
        [_tempViewB autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:-10.0f];
    } else {
        [_tempViewB autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
    }
    [_tempViewB autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_tempViewA withOffset:0.0f];
    if (currentStatus == ConstraintLayoutViewCount2 || currentStatus == ConstraintLayoutViewCount1) {
        [_tempViewB autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:kChartSuperView withMultiplier:1.0f];
    } else {
        [_tempViewB autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:kChartSuperView withMultiplier:0.5f];
    }
}

- (void)setUpViewCContraints {
    if (currentStatus == ConstraintLayoutViewCount2 || currentStatus == ConstraintLayoutViewCount1) {
        [_tempViewC autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-10.0f];
    } else {
        [_tempViewC autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    }
    [_tempViewC autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
    [_tempViewC autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tempViewB withOffset:0.0f];
    [_tempViewC autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_tempViewB withMultiplier:1.0f];
}

- (void)setUpViewDContraints {
    [_tempViewD autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tempViewA withOffset:0.0f];
    if (currentStatus == ConstraintLayoutViewCount4) {
        [_tempViewD autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    } else {
        [_tempViewD autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-10.0f];
    }
    [_tempViewD autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
    [_tempViewD autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_tempViewA];
}

#pragma pucblicFunc
- (NSUInteger)getIndexOfKchartView:(KChartWebView *)view {
    if (self.kChartViewArray == nil || [self.kChartViewArray count] == 0) {
        return -1;
    }
    
    return [self.kChartViewArray indexOfObject:view];
}

@end
