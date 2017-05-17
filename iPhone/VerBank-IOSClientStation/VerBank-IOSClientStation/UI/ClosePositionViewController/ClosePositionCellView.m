//
//  ClosePositionCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/6.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ClosePositionCellView.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"
#import "CustomFont.h"

#define LeftAdge 10
#define LineWidth 1.5f


@interface ClosePositionCellView(){
    Boolean _isSelected;
}

@end

@implementation ClosePositionCellView

@synthesize ticketLabel;
@synthesize tradeTimeLabel;
@synthesize ticketLabelBackgroundView;

@synthesize instrumentLabel;
@synthesize amountLabel;
@synthesize floatPLLabel;
@synthesize instrumentBackgroundView;

@synthesize buyOrSellLabel;
@synthesize closePriceLabel;
@synthesize buyOrSellBackgroundView;

@synthesize bottomLineView;
@synthesize topLineView;

- (id)init{
    if (self = [super init]) {
        _isSelected = false;
        [self initComponent];
        [self initLayout];
        [self initBottomLine];
        [self initTopLine];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _isSelected = false;
        [self initComponent];
        [self initLayout];
        [self initBottomLine];
        [self initTopLine];
    }
    return self;
}

- (void)setIsNeedTopLine:(Boolean)need{
    [topLineView setHidden:!need];
}

- (void)setIsNeedBottomLine:(Boolean)need{
    [bottomLineView setHidden:!need];
}

- (void)initTopLine{
    CGRect f = self.frame;
    f.size.height += LineWidth;
    self.frame = f;
    
    topLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, LineWidth)];
    if (_isSelected) {
        topLineView.backgroundColor = [UIColor backgroundColor];
    } else {
        topLineView.backgroundColor = [UIColor whiteColor];
    }
    
    topLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self setIsNeedTopLine:true];
    [self addSubview:topLineView];
}

- (void)initBottomLine{
    CGRect f = self.frame;
    f.size.height += LineWidth;
    self.frame = f;
    
    bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 65.0f - LineWidth, self.frame.size.width, LineWidth)];
    if (_isSelected) {
        bottomLineView.backgroundColor = [UIColor backgroundColor];
    } else {
        bottomLineView.backgroundColor = [UIColor whiteColor];
    }
    
    bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self setIsNeedBottomLine:false];
    [self addSubview:bottomLineView];
}

- (void)setIsSelected:(Boolean)isSelected{
    _isSelected = isSelected;
    if (_isSelected) {
        bottomLineView.backgroundColor = [UIColor backgroundColor];
    } else {
        bottomLineView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)initComponent{
    ticketLabel = [[UILabel alloc] init];
    tradeTimeLabel = [[UILabel alloc] init];
    ticketLabelBackgroundView = [[UIView alloc] init];
    
    instrumentLabel = [[UILabel alloc] init];
    amountLabel = [[UILabel alloc] init];
    floatPLLabel = [[UILabel alloc] init];
    instrumentBackgroundView = [[UIView alloc] init];
    
    buyOrSellLabel = [[UILabel alloc] init];
    closePriceLabel = [[UILabel alloc] init];
    buyOrSellBackgroundView = [[UIView alloc] init];
}

- (void)initLayout{
    CGRect ticketLabelBackgroundViewRect = CGRectMake(LeftAdge, 3.0f, SCREEN_WIDTH - 2 *LeftAdge, 15.0f);
    CGRect ticketLabelRect = CGRectMake(0.0f, 0.0f, ticketLabelBackgroundViewRect.size.width / 2, 15.0f);
    CGRect tradeTimeLabelRect = CGRectMake(ticketLabelBackgroundViewRect.size.width / 2, 0.0f, ticketLabelBackgroundViewRect.size.width / 2, 15.0f);
    
    CGRect instrumentBackgroundViewRect = CGRectMake(LeftAdge, 20.0f, SCREEN_WIDTH - 2 *LeftAdge, 25.0f);
    CGRect instrumentLabelRect = CGRectMake(0.0f, 0.0f, instrumentBackgroundViewRect.size.width / 4, 20.0f);
    CGRect amountLabelRect = CGRectMake(instrumentBackgroundViewRect.size.width / 4, 0.0f, instrumentBackgroundViewRect.size.width / 3, 20.0f);
    CGRect floatPLLabelRect = CGRectMake(instrumentBackgroundViewRect.size.width / 12 * 7, 0.0f, instrumentBackgroundViewRect.size.width / 12 *5, 20.0f);
    
    CGRect buyOrSellBackgroundViewRect = CGRectMake(LeftAdge, 45.0f, SCREEN_WIDTH - 2 *LeftAdge, 20.0f);
    CGRect buyOrSellLabelRect = CGRectMake(0.0f, 0.0f, buyOrSellBackgroundViewRect.size.width / 4, 18.0f);
    CGRect openPriceLabelRect = CGRectMake(buyOrSellBackgroundViewRect.size.width / 4, 0.0f, buyOrSellBackgroundViewRect.size.width / 3, 15.0f);
    
    // frame
    [ticketLabelBackgroundView setFrame:ticketLabelBackgroundViewRect];
    [ticketLabel setFrame:ticketLabelRect];
    [tradeTimeLabel setFrame:tradeTimeLabelRect];
    
    [instrumentBackgroundView setFrame:instrumentBackgroundViewRect];
    [instrumentLabel setFrame:instrumentLabelRect];
    [amountLabel setFrame:amountLabelRect];
    [floatPLLabel setFrame:floatPLLabelRect];
    
    [buyOrSellBackgroundView setFrame:buyOrSellBackgroundViewRect];
    [buyOrSellLabel setFrame:buyOrSellLabelRect];
    [closePriceLabel setFrame:openPriceLabelRect];
    
    //layout
    [ticketLabel setTextAlignment:NSTextAlignmentLeft];
    [tradeTimeLabel setTextAlignment:NSTextAlignmentRight];
    
    [instrumentLabel setTextAlignment:NSTextAlignmentLeft];
    [amountLabel setTextAlignment:NSTextAlignmentRight];
    [floatPLLabel setTextAlignment:NSTextAlignmentRight];
    
    [buyOrSellLabel setTextAlignment:NSTextAlignmentLeft];
    [closePriceLabel setTextAlignment:NSTextAlignmentRight];
    
    //font
    [ticketLabel        setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [tradeTimeLabel     setFont:[CustomFont getCNNormalWithSize:10.0f]];
    
    [instrumentLabel    setFont:[CustomFont getCNNormalWithSize:15.0f]];
    [amountLabel        setFont:[CustomFont getCNNormalWithSize:18.0f]];
    [floatPLLabel       setFont:[CustomFont getCNNormalWithSize:18.0f]];
    
    [buyOrSellLabel     setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [closePriceLabel    setFont:[CustomFont getCNNormalWithSize:13.0f]];
    
    // color
    [ticketLabel setTextColor:[UIColor whiteColor]];
    [tradeTimeLabel setTextColor:[UIColor whiteColor]];
    
    [instrumentLabel setTextColor:[UIColor whiteColor]];
    [amountLabel setTextColor:[UIColor whiteColor]];
    [floatPLLabel setTextColor:[UIColor whiteColor]];
    
    [buyOrSellLabel setTextColor:[UIColor buySellLabelColor]];
    [closePriceLabel setTextColor:[UIColor whiteColor]];
    
    //add subview
    [self addSubview:ticketLabelBackgroundView];
    [ticketLabelBackgroundView addSubview:ticketLabel];
    [ticketLabelBackgroundView addSubview:tradeTimeLabel];
    
    [self addSubview:instrumentBackgroundView];
    [instrumentBackgroundView addSubview:instrumentLabel];
    [instrumentBackgroundView addSubview:amountLabel];
    [instrumentBackgroundView addSubview:floatPLLabel];
    
    [self addSubview:buyOrSellBackgroundView];
    [buyOrSellBackgroundView addSubview:buyOrSellLabel];
    [buyOrSellBackgroundView addSubview:closePriceLabel];
    
    [self setBackgroundColor:[UIColor backgroundColor]];
    
}


@end
