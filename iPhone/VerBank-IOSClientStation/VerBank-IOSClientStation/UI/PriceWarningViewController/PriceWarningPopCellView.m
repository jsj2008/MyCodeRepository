//
//  PriceWarningPopCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PriceWarningPopCellView.h"
#import "UIFormat.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"

@implementation PriceWarningPopCellView

@synthesize modifyButton = _modifyButton;
@synthesize deleteButton = _deleteButton;

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
    self.modifyButton = [[UIButton alloc] init];
    self.deleteButton = [[UIButton alloc] init];
}

- (void)initLayout{
    CGFloat width = (self.frame.size.width - 24) / 2;
    CGRect modifyButtonRect = CGRectMake(10, 2, width, 22.0f);
    CGRect deleteButtonRect = CGRectMake(width + 14, 2, width, 22.0f);
    
    [self.modifyButton setFrame:modifyButtonRect];
    [self.deleteButton setFrame:deleteButtonRect];
    
    [UIFormat  setCorner:UIRectCornerAllCorners WithUIView:self.modifyButton withCorner:8.0f];
    [UIFormat  setCorner:UIRectCornerAllCorners WithUIView:self.deleteButton withCorner:8.0f];
    
    [UIFormat setComplexBlueButtonColor:self.modifyButton];
    [UIFormat setComplexBlueButtonColor:self.deleteButton];
    
    [self.modifyButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Modify"] forState:UIControlStateNormal];
    [self.deleteButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Delete"] forState:UIControlStateNormal];
    
    [self addSubview:self.deleteButton];
    [self addSubview:self.modifyButton];
    
    [self setBackgroundColor:[UIColor backgroundColor]];
}


@end
