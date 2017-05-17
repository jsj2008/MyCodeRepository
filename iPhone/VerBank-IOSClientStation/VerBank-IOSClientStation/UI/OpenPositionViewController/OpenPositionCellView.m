//
//  OpenPositionCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OpenPositionCellView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "CustomFont.h"

#define LeftAdge 10
#define LineWidth 1.0f


@interface OpenPositionCellView(){
    Boolean _isSelected;
}

@end

@implementation OpenPositionCellView

@synthesize ticketLabel;
@synthesize tradeTimeLabel;
@synthesize ticketLabelBackgroundView;

@synthesize instrumentLabel;
@synthesize amountLabel;
@synthesize floatPLLabel;
@synthesize instrumentBackgroundView;

@synthesize buyOrSellLabel;
@synthesize openPriceLabel;
@synthesize mktPriceLabel;
@synthesize buyOrSellBackgroundView;

@synthesize limitPriceLabel;
@synthesize stopPriceLabel;
@synthesize moveStopPriceLabel;
//@synthesize priceBackgroundView;
@synthesize priceBackgroundButton;

@synthesize bottomLineView;
@synthesize topLineView;

@synthesize leftClickView;
@synthesize rightClickView;

- (id)init{
    if (self = [super init]) {
        _isSelected = false;
        [self initComponent];
        [self initLayout];
        //        [self initBottomLine];
        [self initTopLine];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    // 寬度不適配， 在這適配一下， 以後修改
    frame.size.width = SCREEN_WIDTH;
    if (self = [super initWithFrame:frame]) {
        _isSelected = false;
        [self initComponent];
        [self initLayout];
        [self initTopLine];
        //        [self initBottomLine];
    }
    return self;
}

- (void)initBottomLine{
    CGRect f = self.frame;
    f.size.height += LineWidth;
    self.frame = f;
    
    bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 80.0f - LineWidth, SCREEN_WIDTH - 20.0f, LineWidth)];
    if (_isSelected) {
        bottomLineView.backgroundColor = [UIColor backgroundColor];
    } else {
        bottomLineView.backgroundColor = [UIColor whiteColor];
    }
    
    bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:bottomLineView];
}

- (void)initTopLine{
    CGRect f = self.frame;
    f.size.height += LineWidth;
    self.frame = f;
    
    topLineView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0f, SCREEN_WIDTH - 20.0f, LineWidth)];
    if (_isSelected) {
        topLineView.backgroundColor = [UIColor backgroundColor];
    } else {
        topLineView.backgroundColor = [UIColor whiteColor];
    }
    
    topLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:topLineView];
}

//- (void)setIsSelected:(Boolean)isSelected{
//    _isSelected = isSelected;
//    if (_isSelected) {
//        bottomLineView.backgroundColor = [UIColor backgroundColor];
//    } else {
//        bottomLineView.backgroundColor = [UIColor whiteColor];
//    }
//}

- (void)initComponent{
    ticketLabel = [[UILabel alloc] init];
    tradeTimeLabel = [[UILabel alloc] init];
    ticketLabelBackgroundView = [[UIView alloc] init];
    
    instrumentLabel = [[UILabel alloc] init];
    amountLabel = [[UILabel alloc] init];
    floatPLLabel = [[UILabel alloc] init];
    instrumentBackgroundView = [[UIView alloc] init];
    
    buyOrSellLabel = [[UILabel alloc] init];
    openPriceLabel = [[UILabel alloc] init];
    mktPriceLabel = [[UILabel alloc] init];
    buyOrSellBackgroundView = [[UIView alloc] init];
    
    limitPriceLabel = [[UILabel alloc] init];
    stopPriceLabel = [[UILabel alloc] init];
    moveStopPriceLabel = [[UILabel alloc] init];
    //    priceBackgroundView = [[UIView alloc] init];
    priceBackgroundButton = [[UIButton alloc] init];
    
    leftClickView = [[UIView alloc] init];
    rightClickView = [[UIView alloc] init];
}

- (void)initLayout{
    CGRect ticketLabelBackgroundViewRect = CGRectMake(LeftAdge, 3.0f, SCREEN_WIDTH - 2 *LeftAdge, 15.0f);
    CGRect ticketLabelRect = CGRectMake(0.0f, 0.0f, ticketLabelBackgroundViewRect.size.width / 2, 15.0f);
    CGRect tradeTimeLabelRect = CGRectMake(ticketLabelBackgroundViewRect.size.width / 2, 0.0f, ticketLabelBackgroundViewRect.size.width / 2, 15.0f);
    
    CGRect instrumentBackgroundViewRect = CGRectMake(LeftAdge, 22.0f, SCREEN_WIDTH - 2 *LeftAdge, 25.0f);
    CGRect instrumentLabelRect = CGRectMake(0.0f, 0.0f, instrumentBackgroundViewRect.size.width / 4, 20.0f);
    CGRect amountLabelRect = CGRectMake(instrumentBackgroundViewRect.size.width / 4, 0.0f, instrumentBackgroundViewRect.size.width / 3, 20.0f);
    CGRect floatPLLabelRect = CGRectMake(instrumentBackgroundViewRect.size.width / 12 * 7 - 20.0f, 0.0f, instrumentBackgroundViewRect.size.width / 12 * 5 + 20.0f, 20.0f);
    
    CGRect buyOrSellBackgroundViewRect = CGRectMake(LeftAdge, 45.0f, SCREEN_WIDTH - 2 *LeftAdge, 20.0f);
    CGRect buyOrSellLabelRect = CGRectMake(0.0f, 0.0f, buyOrSellBackgroundViewRect.size.width / 4, 18.0f);
    CGRect openPriceLabelRect = CGRectMake(buyOrSellBackgroundViewRect.size.width / 4, 3.0f, buyOrSellBackgroundViewRect.size.width / 3 , 18.0f);
    CGRect mktPriceLabelRect = CGRectMake(buyOrSellBackgroundViewRect.size.width / 12 * 7 - 20.0f, 3.0f, buyOrSellBackgroundViewRect.size.width / 12 * 5 + 20.0f, 18.0f);
    
    CGRect priceBackgroundViewRect = CGRectMake(LeftAdge, 70.0f, SCREEN_WIDTH - 2 *LeftAdge, 25.0f);
    CGRect limitPriceLabelRect =  CGRectMake(LeftAdge, 0.0f, priceBackgroundViewRect.size.width / 3, 25.0f);
    CGRect stopPriceLabelRect =  CGRectMake(priceBackgroundViewRect.size.width / 3, 0.0f, priceBackgroundViewRect.size.width / 3, 25.0f);
    CGRect moveStopPriceLabelRect =  CGRectMake(priceBackgroundViewRect.size.width / 3 * 2, 0.0f, priceBackgroundViewRect.size.width / 3 - LeftAdge, 25.0f);
    
    CGRect leftViewRect = CGRectMake(0, 0, instrumentBackgroundViewRect.size.width / 4, 60.0f);
    CGRect rightViewRect = CGRectMake(instrumentBackgroundViewRect.size.width / 4, 0, SCREEN_WIDTH - instrumentBackgroundViewRect.size.width / 4, 60.0f);
    
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
    [openPriceLabel setFrame:openPriceLabelRect];
    [mktPriceLabel setFrame:mktPriceLabelRect];
    
    //    [priceBackgroundView setFrame:priceBackgroundViewRect];
    [priceBackgroundButton setFrame:priceBackgroundViewRect];
    [limitPriceLabel setFrame:limitPriceLabelRect];
    [stopPriceLabel setFrame:stopPriceLabelRect];
    [moveStopPriceLabel setFrame:moveStopPriceLabelRect];
    
    [rightClickView setFrame:rightViewRect];
    [leftClickView setFrame:leftViewRect];
    
    //    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:priceBackgroundView withCorner:8.0f];
    //    [priceBackgroundView setBackgroundColor:[UIColor bluePriceBackgroundViewColor]];
    //    [UIFormat setComplexBlueButtonColor:priceBackgroundButton];
    [priceBackgroundButton setBackgroundColor:[UIColor bluePriceBackgroundViewColor]];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:priceBackgroundButton withCorner:8.0f];
    
    //layout
    [ticketLabel setTextAlignment:NSTextAlignmentLeft];
    [tradeTimeLabel setTextAlignment:NSTextAlignmentRight];
    
    [instrumentLabel setTextAlignment:NSTextAlignmentLeft];
    [amountLabel setTextAlignment:NSTextAlignmentRight];
    [floatPLLabel setTextAlignment:NSTextAlignmentRight];
    
    [buyOrSellLabel setTextAlignment:NSTextAlignmentLeft];
    [openPriceLabel setTextAlignment:NSTextAlignmentRight];
    [mktPriceLabel setTextAlignment:NSTextAlignmentRight];
    
    [limitPriceLabel setTextAlignment:NSTextAlignmentLeft];
    [stopPriceLabel setTextAlignment:NSTextAlignmentLeft];
    [moveStopPriceLabel setTextAlignment:NSTextAlignmentLeft];
    
    //font
    [ticketLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [tradeTimeLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
    
    [instrumentLabel setFont:[CustomFont getCNNormalWithSize:15.0f]];
    [amountLabel setFont:[CustomFont getCNNormalWithSize:18.0f]];
    [floatPLLabel setFont:[CustomFont getCNNormalWithSize:19.0f]];
    
    [buyOrSellLabel setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [openPriceLabel setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [mktPriceLabel setFont:[CustomFont getCNNormalWithSize:11.0f]];
    
    [limitPriceLabel setFont:[CustomFont getCNNormalWithSize:14.0f]];
    [stopPriceLabel setFont:[CustomFont getCNNormalWithSize:14.0f]];
    [moveStopPriceLabel setFont:[CustomFont getCNNormalWithSize:14.0f]];
    
    
//    [cellView.ticketLabel setFont:[CustomFont getCNNormalWithSize:10.0f]];
//    [cellView.tradeTimeLabel setFont:[CustomFont getENNormalWithSize:10.0f]];
//    [cellView.instrumentLabel setFont:[CustomFont getENNormalWithSize:13.0f]];
//    [cellView.amountLabel setFont:[CustomFont getENNormalWithSize:13.0f]];
//    
//    [cellView.buyOrSellLabel setFont:[CustomFont getCNNormalWithSize:11.0f]];
//    [cellView.openPriceLabel setFont:[CustomFont getENNormalWithSize:11.0f]];
//    [cellView.limitPriceLabel setFont:[CustomFont getENNormalWithSize:11.0f]];
//    [cellView.stopPriceLabel setFont:[CustomFont getENNormalWithSize:11.0f]];
//    [cellView.moveStopPriceLabel setFont:[CustomFont getENNormalWithSize:11.0f]];
    
    // color
    [ticketLabel setTextColor:[UIColor whiteColor]];
    [tradeTimeLabel setTextColor:[UIColor whiteColor]];
    
    [instrumentLabel setTextColor:[UIColor whiteColor]];
    [amountLabel setTextColor:[UIColor whiteColor]];
    [floatPLLabel setTextColor:[UIColor whiteColor]];
    
    [buyOrSellLabel setTextColor:[UIColor buySellLabelColor]];
    [openPriceLabel setTextColor:[UIColor whiteColor]];
    [mktPriceLabel setTextColor:[UIColor whiteColor]];
    
    [limitPriceLabel setTextColor:[UIColor whiteColor]];
    [stopPriceLabel setTextColor:[UIColor whiteColor]];
    [moveStopPriceLabel setTextColor:[UIColor whiteColor]];
    
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
    [buyOrSellBackgroundView addSubview:openPriceLabel];
    [buyOrSellBackgroundView addSubview:mktPriceLabel];
    

    
    //    [self addSubview:priceBackgroundView];
    //    [priceBackgroundView addSubview:limitPriceLabel];
    //    [priceBackgroundView addSubview:stopPriceLabel];
    //    [priceBackgroundView addSubview:moveStopPriceLabel];
    [self addSubview:priceBackgroundButton];
    [priceBackgroundButton addSubview:limitPriceLabel];
    [priceBackgroundButton addSubview:stopPriceLabel];
    [priceBackgroundButton addSubview:moveStopPriceLabel];
    
    [self addSubview:leftClickView];
    [self addSubview:rightClickView];
    
    [self setBackgroundColor:[UIColor backgroundColor]];
}




@end
