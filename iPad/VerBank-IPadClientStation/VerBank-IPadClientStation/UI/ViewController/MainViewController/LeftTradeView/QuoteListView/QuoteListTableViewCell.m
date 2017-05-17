//
//  QuoteListTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/26.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QuoteListTableViewCell.h"
#import "UIFormat.h"
#import "LangCaptain.h"

@interface QuoteListTableViewCell() {
}

@end

@implementation QuoteListTableViewCell

@synthesize isAddListener;

@synthesize quoteView = _quoteView;

@synthesize instrumentLabel     = _instrumentLabel;
@synthesize timeLabel           = _timeLabel;
@synthesize lowPirceLabel       = _lowPriceLabel;
@synthesize highPriceLabel      = _highPriceLabel;
@synthesize upDownLabel         = _upDownLabel;

@synthesize leftButton          = _leftButton;
@synthesize rightButton         = _rightButton;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)awakeFromNib {
    [self setDefault];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    [_quoteView setFrame:_quoteView.bounds];
    [_quoteView.mainView setFrame:_quoteView.bounds];
    //    [_quoteView.mainView layoutIfNeeded];
//    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self.leftButton withCorner:15.0f];
//    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:self.rightButton withCorner:15.0f];
//    
//    [self.quoteView setNeedsLayout];
//    [self.quoteView layoutIfNeeded];
//    
//    [self.leftButton setNeedsLayout];
//    [self.leftButton layoutIfNeeded];
//    [self.rightButton setNeedsLayout];
//    [self.rightButton layoutIfNeeded];
}

- (void)setDefault {
    self.isAddListener = false;
    [self                   setBackgroundColor:[UIColor clearColor]];
    [self.contentView       setBackgroundColor:[UIColor clearColor]];
    
    [self.instrumentLabel   setTextColor:[UIColor whiteColor]];
    [self.timeLabel         setTextColor:[UIColor whiteColor]];
    [self.lowPirceLabel     setTextColor:[UIColor whiteColor]];
    [self.upDownLabel       setTextColor:[UIColor whiteColor]];
    [self.highPriceLabel    setTextColor:[UIColor whiteColor]];
    [self.leftButton        setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton       setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    [UIFormat setComplexBlueButtonColor:self.leftButton];
//    [UIFormat setComplexBlueButtonColor:self.rightButton];
    
    [self.leftButton setTitle:[[LangCaptain getInstance] getLangByCode:@"OrderPosition"] forState:UIControlStateNormal];
    [self.rightButton setTitle:[[LangCaptain getInstance] getLangByCode:@"PriceWarning"] forState:UIControlStateNormal];
}

@end
