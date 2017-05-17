//
//  ClosePositionPopCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/6.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ClosePositionPopCellView.h"
#import "IosLayoutDefine.h"
#import "UIColor+CustomColor.h"
#import "CustomFont.h"

#define LeftAdge 10
#define LineWidth 1.5f

@implementation ClosePositionPopCellView

@synthesize popCellView;
@synthesize openPriceName;
@synthesize openPriceValueName;
@synthesize closeTime;
@synthesize bottomLineView;

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
        [self initLayout];
        [self initBottomLine];
    }
    return self;
}

- (void)setIsNeedBottomLine:(Boolean)need{
    [bottomLineView setHidden:!need];
}

- (void)initBottomLine{
    CGRect f = self.frame;
    f.size.height += LineWidth;
    self.frame = f;
    
    bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 30.0f - LineWidth, self.frame.size.width, LineWidth)];
    bottomLineView.backgroundColor = [UIColor whiteColor];
    
    bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self setIsNeedBottomLine:false];
    [self addSubview:bottomLineView];
}

- (void)initComponent{
    openPriceName = [[UILabel alloc] init];
    openPriceValueName = [[UILabel alloc] init];
    closeTime = [[UILabel alloc] init];
    popCellView = [[UIView alloc] init];
}

- (void)initLayout{
    CGRect popCellViewRect = CGRectMake(LeftAdge, 0.0f, SCREEN_WIDTH - 2 *LeftAdge, 25.0f);
    CGRect openPriceNameRect = CGRectMake(0.0f, 0.0f, popCellViewRect.size.width / 3, 25.0f);
    CGRect openPriceValueNameRect = CGRectMake(popCellViewRect.size.width / 3, 0.0f, popCellViewRect.size.width / 4, 25.0f);
    CGRect closeTimeRect = CGRectMake(popCellViewRect.size.width / 12 * 7, 0.0f, popCellViewRect.size.width / 12 * 5, 25.0f);
    
    // frame
    [popCellView setFrame:popCellViewRect];
    [openPriceName setFrame:openPriceNameRect];
    [openPriceValueName setFrame:openPriceValueNameRect];
    [closeTime setFrame:closeTimeRect];
    
    //layout
    [openPriceName setTextAlignment:NSTextAlignmentLeft];
    [openPriceValueName setTextAlignment:NSTextAlignmentRight];
    [closeTime setTextAlignment:NSTextAlignmentRight];
    
    //font
    [openPriceName      setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [openPriceValueName setFont:[CustomFont getCNNormalWithSize:13.0f]];
    [closeTime          setFont:[CustomFont getCNNormalWithSize:10.0f]];
    
    // color
    [openPriceName setTextColor:[UIColor whiteColor]];
    [openPriceValueName setTextColor:[UIColor whiteColor]];
    [closeTime setTextColor:[UIColor whiteColor]];
    
    //add subview
    [self addSubview:popCellView];
    [popCellView addSubview:openPriceName];
    [popCellView addSubview:openPriceValueName];
    [popCellView addSubview:closeTime];
    
    [self setBackgroundColor:[UIColor closePositionPopCellColor]];
    
}

@end
