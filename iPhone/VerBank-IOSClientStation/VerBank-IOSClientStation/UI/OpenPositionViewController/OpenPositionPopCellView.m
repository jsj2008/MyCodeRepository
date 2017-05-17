//
//  OpenPositionPopCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OpenPositionPopCellView.h"
#import "UIFormat.h"
#import "UIColor+CustomColor.h"
#import "LangCaptain.h"

#define LineWidth 1.0f

@implementation OpenPositionPopCellView

@synthesize bottomLineView;
@synthesize hedgingButton;

- (id)init{
    if (self = [super init]) {
        [self initComponent];
        [self initLayout];
        [self initBottomLine];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
        [self initLayout];
        [self initBottomLine];
    }
    return self;
}

- (void)initBottomLine{
//    CGRect f = self.frame;
//    f.size.height += LineWidth;
//    self.frame = f;
//    
//    bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 30.0f - LineWidth, self.frame.size.width - 20.0f, LineWidth)];
//    bottomLineView.backgroundColor = [UIColor whiteColor];
//    bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    [self addSubview:bottomLineView];
}

- (void)initComponent{
    hedgingButton = [[UIButton alloc] init];
}

- (void)initLayout{
    CGRect heidgingButtonViewRect = CGRectMake(10, 2, self.frame.size.width - 20, 22.0f);
    [hedgingButton setFrame:heidgingButtonViewRect];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:hedgingButton withCorner:8.0f];
    [UIFormat setComplexBlueButtonColor:hedgingButton];
    [hedgingButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Hedging"] forState:UIControlStateNormal];
    [self addSubview:hedgingButton];
    [self setBackgroundColor:[UIColor backgroundColor]];
}


@end
