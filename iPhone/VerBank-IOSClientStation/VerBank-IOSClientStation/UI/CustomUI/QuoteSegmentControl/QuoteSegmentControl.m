//
//  QuoteSegmentControl.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "QuoteSegmentControl.h"
#import "QuoteView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"

#define MiddleEdage 2.0f

#define DefaultStyle STYLE_NORMAL

@interface QuoteSegmentControl(){
    QuoteView *leftView;
    QuoteView *rightView;
    
    UIButton *leftButton;
    UIButton *rightButton;
    
    UILabel *leftLabel;
    UILabel *rightLabel;
}

@end

@implementation QuoteSegmentControl

@synthesize extradigit = _extradigit;

@synthesize delegate = _delegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initQuoteLayout];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initQuoteLayout];
    }
    return self;
}

- (void)initQuoteLayout {
    _style = DefaultStyle;
    _selectIndex = 0;
    _extradigit = 0;
    [self initLayout];
}

- (void)initLayout {
    
    leftButton = [[UIButton alloc] init];
    rightButton = [[UIButton alloc] init];
    
    leftView = [[QuoteView alloc] init];
    rightView = [[QuoteView alloc] init];
    
    [leftView setUserInteractionEnabled:false];
    [rightView setUserInteractionEnabled:false];
    [self addSubview:leftButton];
    [self addSubview:rightButton];
    [leftButton addSubview:leftView];
    [rightButton addSubview:rightView];
    
    [leftButton addTarget:self action:@selector(leftClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self leftClicked];
    
    leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [leftLabel setText:[[LangCaptain getInstance] getLangByCode:@"SellPrice"]];
    [rightLabel setText:[[LangCaptain getInstance] getLangByCode:@"BuyPrice"]];
    [leftLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:10.0f]]];
    [rightLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:10.0f]]];
    [leftLabel setTextColor:[UIColor whiteColor]];
    [rightLabel setTextColor:[UIColor whiteColor]];
    
    [leftLabel sizeToFit];
    [rightLabel sizeToFit];
    
    [leftButton addSubview:leftLabel];
    [rightButton addSubview:rightLabel];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)refreshSegmentAsk:(NSString *)askPrice bidPrice:(NSString *)bidPrice{
    [rightView setPrice:askPrice extraDigit:_extradigit];
    [leftView setPrice:bidPrice extraDigit:_extradigit];
}

- (void)leftClicked {
    if (_style == STYLE_RED) {
        [leftButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_red_select"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_unselect"] forState:UIControlStateNormal];
    }
    
    if (_style == STYLE_BLUE) {
        [leftButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_blue_select"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_unselect"] forState:UIControlStateNormal];
    }
    
    if (_style == STYLE_NORMAL) {
        [leftButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_red_select"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_unselect"] forState:UIControlStateNormal];
    }
    
    [leftView setColor:[UIColor whiteColor]];
    [rightView setColor:[UIColor grayColor]];
    
    if (_style == STYLE_MIX) {
        [leftButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_red_select"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_blue_select"] forState:UIControlStateNormal];
        [leftView setColor:[UIColor whiteColor]];
        [rightView setColor:[UIColor whiteColor]];
    }
    
    _selectIndex = IndexSell;
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(buttonClicked)]) {
        [_delegate buttonClicked];
    }
}

- (void)rightClicked {
    
    if (_style == STYLE_RED) {
        [leftButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_unselect"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_red_select"] forState:UIControlStateNormal];
    }
    
    if (_style == STYLE_BLUE) {
        [leftButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_unselect"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_blue_select"] forState:UIControlStateNormal];
    }
    
    if (_style == STYLE_NORMAL) {
        [leftButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_sell_unselect"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"images/normal/pair_buy_blue_select"] forState:UIControlStateNormal];
    }
    
    [leftView setColor:[UIColor grayColor]];
    [rightView setColor:[UIColor whiteColor]];
    _selectIndex = IndexBuy;
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(buttonClicked)]) {
        [_delegate buttonClicked];
    }
}

- (void)setStyle:(int)style {
    _style = style;
//    [self leftClicked];
    [self setSelectIndex:_selectIndex];
}

- (void)setSelectIndex:(int)selectIndex {
    if (selectIndex == 0) {
        [self leftClicked];
    } else {
        [self rightClicked];
    }
}

- (int)selectIndex {
    return _selectIndex;
}

- (void)layoutSubviews {
    CGRect leftRect = CGRectMake(0, 0, (self.frame.size.width - MiddleEdage )/ 2, self.frame.size.height);
    CGRect rightRect = CGRectMake(self.frame.size.width/ 2 + MiddleEdage , 0, (self.frame.size.width - MiddleEdage )/ 2, self.frame.size.height);
    [leftButton setFrame:leftRect];
    [rightButton setFrame:rightRect];
    
    CGPoint point = [leftButton center];
    point.y += [ScreenAuotoSizeScale CGAutoMakeFloat:22.0f];
    [leftView setCenter:point];
    [rightView setCenter:point];
    
    point.y = 10;
    [leftLabel setCenter:point];
    [rightLabel setCenter:point];
}

- (void)dealloc {
    rightView = nil;
    leftView = nil;
}

@end
