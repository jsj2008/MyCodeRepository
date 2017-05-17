//
//  uoteSubButton.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QuoteSubButton.h"
#import "DebugUtil.h"

@interface QuoteSubButton() {
    // 暂时没有附加小数位
    int _extraDigit;
}

@end

@implementation QuoteSubButton

@synthesize mainView = _mainView;

@synthesize leftLabel = _leftLabel;
@synthesize middleLabel = _middleLabel;
@synthesize rightLabel = _rightLabel;

@synthesize buySellLabel = _buySellLabel;

@synthesize buySellType;

@synthesize backgroundButton = _backgroundButton;

- (void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"QuoteSubButton" owner:self options:nil];
    [self addSubview:self.mainView];
    [self setDefault];
}

- (void)setDefault {
    [self.mainView      setBackgroundColor:[UIColor clearColor]];
    
    [self.leftLabel     setTextColor:[UIColor whiteColor]];
    [self.middleLabel   setTextColor:[UIColor whiteColor]];
    [self.rightLabel    setTextColor:[UIColor whiteColor]];
    [self.buySellLabel  setTextColor:[UIColor whiteColor]];
    
    [self.leftLabel     setText:@"0000"];
    [self.middleLabel   setText:@"0.0"];
    [self.rightLabel    setText:@""];
    
    _extraDigit = 0;
    
    [self setUserInteractionEnabled:false];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainView setFrame:self.bounds];
}

- (void)setExtraDigit:(int)extraDigit {
    _extraDigit = extraDigit;
}

- (void)updateValue:(NSString *)value {
    // 没有附加小数位
    NSMutableString *mutableValue = [NSMutableString stringWithString:value];
    NSRange range = [mutableValue rangeOfString:@"."];
    int totleLength = (int)[mutableValue length];
    
    if (totleLength - range.location == 2) {
        [self decimalInMiddle:[mutableValue copy]];
    } else {
        [self decimalNotInMiddle:[mutableValue copy]];
    }
}

- (void)decimalInMiddle:(NSMutableString *)value {
    int totleLength = (int)[value length];
    [self.leftLabel setText:[value substringWithRange:NSMakeRange(0, totleLength - 3)]];
    [self.middleLabel setText:[value substringWithRange:NSMakeRange(totleLength - 3, 3)]];
}

- (void)decimalNotInMiddle:(NSMutableString *)value {
    int totleLength = (int)[value length];
    [self.leftLabel setText:[value substringWithRange:NSMakeRange(0, totleLength - 2)]];
    [self.middleLabel setText:[value substringWithRange:NSMakeRange(totleLength - 2, 2)]];
}

@end
