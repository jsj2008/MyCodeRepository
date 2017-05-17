//
//  QuotePopButtonView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/22.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "QuotePopButtonView.h"
#import "UIFormat.h"
#import "LangCaptain.h"

@implementation QuotePopButtonView

@synthesize rightButton;
@synthesize leftButton;

- (id)init {
    if (self = [super init]) {
        [self initButton];
    }
    return self;
}

- (void)initButton {
    self.leftButton = [[UIButton alloc] init];
    self.rightButton = [[UIButton alloc] init];
    
    [self.leftButton setTitle:[[LangCaptain getInstance] getLangByCode:@"OrderPosition"] forState:UIControlStateNormal];
    [self.rightButton setTitle:[[LangCaptain getInstance] getLangByCode:@"PriceWarning"] forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    
   
    
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)layoutSubviews {

    [self.leftButton setFrame:CGRectMake(0, 5.0f, self.frame.size.width / 2 - 2, self.frame.size.height - 5.0f)];
    [self.rightButton setFrame:CGRectMake(self.frame.size.width / 2 + 4, 5.0f, self.frame.size.width / 2 - 2, self.frame.size.height - 5.0f)];
    [UIFormat setComplexBlueButtonColor:self.leftButton];
    [UIFormat setComplexBlueButtonColor:self.rightButton];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self.leftButton withCorner:10.0f];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self.rightButton withCorner:10.0f];
}

@end
