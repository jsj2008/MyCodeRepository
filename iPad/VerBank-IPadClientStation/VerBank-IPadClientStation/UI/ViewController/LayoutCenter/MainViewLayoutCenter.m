//
//  LayoutCenter.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MainViewLayoutCenter.h"
#import "IOSLayoutDefine.h"
#import "BackgroundLayoutCenter.h"
#import "UIColor+CustomColor.h"
#import "LayoutCenter.h"

#import "TextFieldController.h"
#import "PhonePinBackgroundView.h"

const CGFloat contentViewEadge = 4.0f;

typedef NS_ENUM(NSInteger, ConstraintLayoutState) {
    ConstraintLayoutNone            = 0x0000,
    ConstraintLayoutTop             = 0x0001,
    ConstraintLayoutBottom          = 0x0002,
    ConstraintLayoutLeft            = 0x0004,
    ConstraintLayoutRight           = 0x0008,
    ConstraintLayoutUnknow          = 0x00ff,
    
    ConstraintLayoutLeftRightTop    = 0x000d,
    ConstraintLayoutLeftBottomTop   = 0x0007,// 这个状态没有
    ConstraintLayoutRightTop        = 0x0009,
    ConstraintLayoutRightBottomTop  = 0x000b,
    
    ConstraintLayoutEnlarge         = 0x0010,
    ConstraintLayoutAll             = 0x000f
};

@interface MainViewLayoutCenter() {
    int currentLayoutState;
    
    Boolean _isTapAction;
    
    PhonePinBackgroundView *_phonePinBackgroundView;
    
    CGFloat bottomHeight;
}

@end


@implementation MainViewLayoutCenter

@synthesize topContentView;
@synthesize leftContentView;
@synthesize rightContentView;
@synthesize bottomContentView;
@synthesize containerView;

- (id)init {
    if (self = [super init]) {
        [self setDefault];
        [self setUpViews];
        //        [self setUpConstraints];
        [self changeState];
        [self addGesture];
        [self addSubAction];
    }
    return self;
}

#pragma initFunc

- (void)setDefault {
    _isTapAction = false;
    bottomHeight = BottomContentHeight;
}

- (void)setUpViews {
    self.containerView      = [[UIView alloc] init];
    self.topContentView     = [[TopContentView alloc] init];
    self.leftContentView    = [[LeftContentView alloc] init];
    self.rightContentView   = [[RightContentView alloc] init];
    self.bottomContentView  = [[BottomContentView alloc] init];
    
    [self.containerView     setBackgroundColor:[UIColor mainBackgroundColor]];
    [self.topContentView    setBackgroundColor:[UIColor leftTableViewBackgroundColor]];
    [self.leftContentView   setBackgroundColor:[UIColor mainBackgroundColor]];
    [self.rightContentView  setBackgroundColor:[UIColor mainBackgroundColor]];
    [self.bottomContentView setBackgroundColor:[UIColor mainBackgroundColor]];
    
    [self.rightContentView setIsShow:false];
    [self.containerView     addSubview:self.topContentView];
    [self.containerView     addSubview:self.leftContentView];
    [self.containerView     addSubview:self.rightContentView];
    [self.containerView     addSubview:self.bottomContentView];
}

- (void)addGesture {
//    [self.bottomContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didContentViewClick:)]];
    
    //    [self.rightContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didContentViewClick:)]];
    //    UILongPressGestureRecognizer *dTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didContentViewClick:)];
    //    dTap.minimumPressDuration = 0.5f;
    //    [self.rightContentView addGestureRecognizer:dTap];
    
    //    [self.leftContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didContentViewClick:)]];
//    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]
//                                              initWithTarget:self action:@selector(didContentViewClick:)];
//    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.leftContentView addGestureRecognizer:swipeGesture];
}

- (void)addSubAction {
    [self.bottomContentView.hiddenButton addTarget:self action:@selector(didHiddenButtonViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftContentView.hiddenButton addTarget:self action:@selector(didHiddenButtonViewClick:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)setUpConstraints {
//    [self changeState];
////    [self.containerView layoutIfNeeded];
//}

#pragma status change action
- (void)changeContentViewState:(ContentView *)contentView {
    Boolean isShow = [contentView isShow];
    [contentView setIsShow:!isShow];
}

- (void)didHiddenButtonViewClick:(id)sender {
    if (sender == bottomContentView.hiddenButton) {
        [self changeContentViewState:bottomContentView];
    }
    if (sender == leftContentView.hiddenButton) {
        [self changeContentViewState:leftContentView];
    }
    [self changeState];
}

- (void)didContentViewClick:(UITapGestureRecognizer *)gesture {
    
    ContentView *view = (ContentView *)gesture.view;
    
    if (gesture.view == bottomContentView) {
        [self changeContentViewState:view];
    }
    
    if (gesture.view == leftContentView) {
        [self changeContentViewState:view];
    }
    
    //    if (gesture.view == rightContentView) {
    //        [self changeContentViewState:view];
    //    }
    [self changeState];
}

- (void)changeState {
    [self.containerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self updateLayoutState];
    [self setUpLayout];
    [self.containerView layoutIfNeeded];
}

- (void)updateLayoutState {
    int tempState = ConstraintLayoutNone;
    if ([topContentView isShow]) {
        tempState |= ConstraintLayoutTop;
    }
    if ([bottomContentView isShow]) {
        tempState |= ConstraintLayoutBottom;
    }
    if ([leftContentView isShow]) {
        tempState |= ConstraintLayoutLeft;
    }
    if ([rightContentView isShow]) {
        //        tempState |= ConstraintLayoutRight;
        //若右边显示，则全屏
        tempState |= ConstraintLayoutEnlarge;
    }
    currentLayoutState = tempState;
}


#pragma public Function
- (void)enlargeRightView {
    [self changeContentViewState:rightContentView];
    [self changeState];
}

- (void)tradeStatusView {
    [bottomContentView setIsShow:false];
    [self changeState];
}

- (void)showBottomView {
    [bottomContentView setIsShow:true];
    [self changeState];
}

- (void)showLeftView {
    [leftContentView setIsShow:true];
    [self changeState];
}

- (void)showPhonePinView {
    if (_phonePinBackgroundView == nil) {
        [self initPhonePinBackgroundView];
    }
    [_phonePinBackgroundView resetValue];
    [self.containerView.superview addSubview:_phonePinBackgroundView];
}

- (void)removePhonePinView {
    [_phonePinBackgroundView removeFromSuperview];
}

- (void)initPhonePinBackgroundView {
    _phonePinBackgroundView = [[PhonePinBackgroundView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

#pragma mark layout

- (void)setUpLayout {
    __block Boolean topIsShow = (currentLayoutState & ConstraintLayoutTop) == ConstraintLayoutTop;
    __block Boolean bottomIsShow = (currentLayoutState & ConstraintLayoutBottom) == ConstraintLayoutBottom;
    __block Boolean leftIsShow = (currentLayoutState & ConstraintLayoutLeft) == ConstraintLayoutLeft;
    __block Boolean rightIsShow = (currentLayoutState & ConstraintLayoutRight) == ConstraintLayoutRight;
    
    [self removeAllContraints];
    [self rightViewContraintIsShow:rightIsShow];
    [self topViewContraintIsShow:topIsShow];
    [self bottomViewContraintIsShow:bottomIsShow];
    [self leftViewContraintIsShow:leftIsShow];
    
    //    if (_isInited) {
    //        [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:NormalScreenStatus];
    //    }
    
    
    if (bottomIsShow) {
        [bottomContentView setContentViewHidden:!bottomIsShow];
    }
    
    if (leftIsShow) {
        [leftContentView setContentViewHidden:!leftIsShow];
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        //        [self.containerView setNeedsLayout];
        [self.containerView layoutIfNeeded];
        [self.leftContentView setNeedsLayout];
        [self.leftContentView layoutIfNeeded];
        [self.rightContentView setNeedsLayout];
        [self.rightContentView layoutIfNeeded];
        [self.topContentView setNeedsLayout];
        [self.topContentView layoutIfNeeded];
        [self.bottomContentView setNeedsLayout];
        [self.bottomContentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (!bottomIsShow) {
            [bottomContentView setContentViewHidden:!bottomIsShow];
        }
        
        if (!leftIsShow) {
            [leftContentView setContentViewHidden:!leftIsShow];
        }
    }];
}

- (void)removeAllContraints {
    [self.containerView autoRemoveConstraintsAffectingView];
    
    [self.topContentView removeConstraints:self.topContentView.constraints];
    [self.bottomContentView removeConstraints:self.bottomContentView.constraints];
    [self.leftContentView removeConstraints:self.leftContentView.constraints];
    [self.rightContentView removeConstraints:self.rightContentView.constraints];
    
}

- (void)topViewContraintIsShow:(Boolean)isShow {
    if ((currentLayoutState & ConstraintLayoutEnlarge) == ConstraintLayoutEnlarge) {
        [self.topContentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-(SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR) + 20];
        //        [self.topContentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.rightContentView withOffset:contentViewEadge];
        [self.topContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
        [self.topContentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
        [self.topContentView autoSetDimension:ALDimensionHeight toSize:SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR];
        [self.topContentView setHidden:true];
    } else {
        [self.topContentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
        [self.topContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
        [self.topContentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
        [self.topContentView autoSetDimension:ALDimensionHeight toSize:SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR];
        [self.topContentView setHidden:false];
    }
}

- (void)leftViewContraintIsShow:(Boolean)isShow {
    if ((currentLayoutState & ConstraintLayoutEnlarge) == ConstraintLayoutEnlarge) {
        [self.leftContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:- LeftContentWidth];
        [self.leftContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topContentView withOffset:contentViewEadge];
        [self.leftContentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomContentView withOffset:0.0f];
        [self.leftContentView autoSetDimension:ALDimensionWidth toSize:LeftContentWidth];
        [self.leftContentView setHidden:true];
    } else {
        if (isShow) {
            [self.leftContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
        } else {
            [self.leftContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:-LeftContentWidth + LeftHiddenWidth];
        }
        [self.leftContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topContentView withOffset:contentViewEadge];
        [self.leftContentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomContentView withOffset:0.0f];
        [self.leftContentView autoSetDimension:ALDimensionWidth toSize:LeftContentWidth];
        
        [self.leftContentView setHidden:false];
    }
}

- (void)rightViewContraintIsShow:(Boolean)isShow {
    //    if ((currentLayoutState & ConstraintLayoutEnlarge) == ConstraintLayoutEnlarge) {
    //        [self.rightContentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    //        [self.rightContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
    //        [self.rightContentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
    //        [self.rightContentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    ////        [self.rightContentView setHidden:true];
    //    } else {
    [self.rightContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topContentView withOffset:contentViewEadge];
    [self.rightContentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomContentView withOffset:0.0f];
    [self.rightContentView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.leftContentView withOffset:contentViewEadge];
    [self.rightContentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
    //    }
}

- (void)bottomViewContraintIsShow:(Boolean)isShow {
    if ((currentLayoutState & ConstraintLayoutEnlarge) == ConstraintLayoutEnlarge) {
        //        [self.bottomContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeTrailing ofView:self.rightContentView withOffset:contentViewEadge];
        [self.bottomContentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-bottomHeight];
        [self.bottomContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
        [self.bottomContentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
        [self.bottomContentView autoSetDimension:ALDimensionHeight toSize:bottomHeight];
        [self.bottomContentView setHidden:true];
    } else {
        if (isShow) {
            [self.bottomContentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
        } else {
            [self.bottomContentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-bottomHeight + BottomHiddenHeight];
        }
        
        [self.bottomContentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0f];
        [self.bottomContentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0f];
        [self.bottomContentView autoSetDimension:ALDimensionHeight toSize:bottomHeight];
        
        [self.bottomContentView setHidden:false];
    }
}

- (void)dealloc {
    [self.bottomContentView destroy];
    self.bottomContentView = nil;
    self.topContentView = nil;
    self.leftContentView = nil;
    self.rightContentView = nil;
    self.containerView = nil;
}

@end
