//
//  MACDContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "MACDContentView.h"

#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "TiArgumentConfig.h"
#import "KZColorPicker.h"

@interface MACDContentView() {
    UIButton *_currentButton;
    //    TiArgumentConfig *_config;
}

@end

@implementation MACDContentView

@synthesize macdShortPeriodLabel        = _macdShortPeriodLabel;
@synthesize macdShortPeriodSlider       = _macdShortPeriodSlider;
@synthesize macdShortPeriodValueLabel   = _macdShortPeriodValueLabel;
@synthesize macdShortPeriodSteper       = _macdShortPeriodSteper;

@synthesize macdLongPeriodLabel         = _macdLongPeriodLabel;
@synthesize macdLongPeriodSlider        = _macdLongPeriodSlider;
@synthesize macdLongPeriodValueLabel    = _macdLongPeriodValueLabel;
@synthesize macdLongPeriodSteper        = _macdLongPeriodSteper;

@synthesize macdPeriodSignalLabel       = _macdPeriodSignalLabel;
@synthesize macdPeriodSignalSlider      = _macdPeriodSignalSlider;
@synthesize macdPeriodSignalValueLabel  = _macdPeriodSignalValueLabel;

@synthesize macdDiffLineWidthLabel      = _macdDiffLineWidthLabel;
@synthesize macdDiffLineWidthSlider     = _macdDiffLineWidthSlider;
@synthesize macdDiffLineWidthValueLabel = _macdDiffLineWidthValueLabel;

@synthesize macdDiffLineColorLabel      = _macdDiffLineColorLabel;
@synthesize macdDiffLineColorButton     = _macdDiffLineColorButton;

@synthesize macdDemLineWidthLabel       = _macdDemLineWidthLabel;
@synthesize macdDemLineWidthSlider      = _macdDemLineWidthSlider;
@synthesize macdDemLineWidthValueLabel  = _macdDemLineWidthValueLabel;

@synthesize macdDemLineColorLabel       = _macdDemLineColorLabel;
@synthesize macdDemLineColorButton      = _macdDemLineColorButton;

@synthesize macdPositiveColorLabel      = _macdPositiveColorLabel;
@synthesize macdPositiveColorButton     = _macdPositiveColorButton;

@synthesize macdNegativeColorLabel      = _macdNegativeColorLabel;
@synthesize macdNegativeColorButton     = _macdNegativeColorButton;

+ (MACDContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MACDContentView" owner:self options:nil];
    MACDContentView *view = (MACDContentView *)[nib objectAtIndex:0];
    [view initContentView];
    return view;
}

- (void)initContentView {
    [self setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 30 * 2)];
    
    [_macdShortPeriodSlider addTarget:self
                               action:@selector(updateValue:)
                     forControlEvents:UIControlEventValueChanged];
    [_macdShortPeriodSteper addTarget:self
                               action:@selector(updateValue:)
                     forControlEvents:UIControlEventValueChanged];
    [_macdLongPeriodSlider addTarget:self
                              action:@selector(updateValue:)
                    forControlEvents:UIControlEventValueChanged];
    [_macdLongPeriodSteper addTarget:self
                              action:@selector(updateValue:)
                    forControlEvents:UIControlEventValueChanged];
    [_macdPeriodSignalSlider addTarget:self
                                action:@selector(updateValue:)
                      forControlEvents:UIControlEventValueChanged];
    [_macdDiffLineWidthSlider addTarget:self
                                 action:@selector(updateValue:)
                       forControlEvents:UIControlEventValueChanged];
    [_macdDiffLineWidthSlider addTarget:self
                                 action:@selector(updateValue:)
                       forControlEvents:UIControlEventValueChanged];
    [_macdDemLineWidthSlider addTarget:self
                                action:@selector(updateValue:)
                      forControlEvents:UIControlEventValueChanged];
    
    [_macdDiffLineColorButton addTarget:self
                                 action:@selector(showColorPicker:)
                       forControlEvents:UIControlEventTouchUpInside];
    [_macdDemLineColorButton addTarget:self
                                action:@selector(showColorPicker:)
                      forControlEvents:UIControlEventTouchUpInside];
    [_macdPositiveColorButton addTarget:self
                                 action:@selector(showColorPicker:)
                       forControlEvents:UIControlEventTouchUpInside];
    [_macdNegativeColorButton addTarget:self
                                 action:@selector(showColorPicker:)
                       forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [_macdShortPeriodLabel      setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"ShortPeriod"]]];
    [_macdLongPeriodLabel       setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"LongPeriod"]]];
    [_macdPeriodSignalLabel     setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"PeriodSignal"]]];
    [_macdDiffLineWidthLabel    setText:[NSString stringWithFormat:@"Diff%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineWidth"]]];
    [_macdDiffLineColorLabel    setText:[NSString stringWithFormat:@"Diff%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    [_macdDemLineWidthLabel     setText:[NSString stringWithFormat:@"Dem%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineWidth"]]];
    [_macdDemLineColorLabel     setText:[NSString stringWithFormat:@"Dem%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    [_macdPositiveColorLabel    setText:[NSString stringWithFormat:@"MACD+%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    [_macdNegativeColorLabel    setText:[NSString stringWithFormat:@"MACD-%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    
    [_macdDiffLineColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                                forState:UIControlStateNormal];
    [_macdDemLineColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                               forState:UIControlStateNormal];
    [_macdPositiveColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                                forState:UIControlStateNormal];
    [_macdNegativeColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                                forState:UIControlStateNormal];
    
    [self initPickButton:_macdDiffLineColorButton];
    [self initPickButton:_macdDemLineColorButton];
    [self initPickButton:_macdPositiveColorButton];
    [self initPickButton:_macdNegativeColorButton];
    
    //    [self checkInit];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)setTiArgumentConfig:(TiArgumentConfig *)config withIndex:(int)index {
    self.config = config;
    int defaultMacdShortPeriodValue = [[config macdShortPeriod] intValue];
    _macdShortPeriodSlider.value = defaultMacdShortPeriodValue;
    _macdShortPeriodSteper.value = defaultMacdShortPeriodValue;
    [_macdShortPeriodValueLabel setText:[@(defaultMacdShortPeriodValue) stringValue]];
    
    int defaultMacdLongPeriodValue = [[config macdLongPeriod] intValue];
    _macdLongPeriodSlider.value = defaultMacdLongPeriodValue;
    _macdLongPeriodSteper.value = defaultMacdLongPeriodValue;
    [_macdLongPeriodValueLabel setText:[@(defaultMacdLongPeriodValue) stringValue]];
    
    int defaultMacdPeriodSignalValue = [[config macdPeriodSignal] intValue];
    _macdPeriodSignalSlider.value = defaultMacdPeriodSignalValue;
    [_macdPeriodSignalValueLabel setText:[@(defaultMacdPeriodSignalValue) stringValue]];
    
    int defaultMacdDiffLineWidthValue = [[config macdDiffLineWidth] intValue];
    _macdDiffLineWidthSlider.value = defaultMacdDiffLineWidthValue;
    [_macdDiffLineWidthValueLabel setText:[@(defaultMacdDiffLineWidthValue) stringValue]];
    
    UIColor *defaultMacdDiffLineColorValue = [config macdDiffLineColor];
    [_macdDiffLineColorButton setBackgroundColor:defaultMacdDiffLineColorValue];
    
    int defaultMacdDemLineWidthValue = [[config macdDemLineWidth] intValue];
    _macdDemLineWidthSlider.value = defaultMacdDemLineWidthValue;
    [_macdDemLineWidthValueLabel setText:[@(defaultMacdDemLineWidthValue) stringValue]];
    
    UIColor *defaultMacdDemLineColorValue = [config macdDemLineColor];
    [_macdDemLineColorButton setBackgroundColor:defaultMacdDemLineColorValue];
    
    UIColor *defaultMacdPositiveColorValue = [config macdPositiveColor];
    [_macdPositiveColorButton setBackgroundColor:defaultMacdPositiveColorValue];
    
    UIColor *defaultMacdNegativeColorValue = [config macdNegativeColor];
    [_macdNegativeColorButton setBackgroundColor:defaultMacdNegativeColorValue];
    
}

- (void)resetArgument {
    int defaultMacdShortPeriodValue = DefaultmacdShortPeriod;
    _macdShortPeriodSlider.value = defaultMacdShortPeriodValue;
    _macdShortPeriodSteper.value = defaultMacdShortPeriodValue;
    [_macdShortPeriodValueLabel setText:[@(defaultMacdShortPeriodValue) stringValue]];
    
    int defaultMacdLongPeriodValue = DefaultmacdLongPeriod;
    _macdLongPeriodSlider.value = defaultMacdLongPeriodValue;
    _macdLongPeriodSteper.value = defaultMacdLongPeriodValue;
    [_macdLongPeriodValueLabel setText:[@(defaultMacdLongPeriodValue) stringValue]];
    
    int defaultMacdPeriodSignalValue = DefaultmacdPeriodSignal;
    _macdPeriodSignalSlider.value = defaultMacdPeriodSignalValue;
    [_macdPeriodSignalValueLabel setText:[@(defaultMacdPeriodSignalValue) stringValue]];
    
    int defaultMacdDiffLineWidthValue = DefaultmacdDiffLineWidth;
    _macdDiffLineWidthSlider.value = defaultMacdDiffLineWidthValue;
    [_macdDiffLineWidthValueLabel setText:[@(defaultMacdDiffLineWidthValue) stringValue]];
    
    UIColor *defaultMacdDiffLineColorValue = DefaultmacdDiffLineColor;
    [_macdDiffLineColorButton setBackgroundColor:defaultMacdDiffLineColorValue];
    
    int defaultMacdDemLineWidthValue = DefaultmacdDemLineWidth;
    _macdDemLineWidthSlider.value = defaultMacdDemLineWidthValue;
    [_macdDemLineWidthValueLabel setText:[@(defaultMacdDemLineWidthValue) stringValue]];
    
    UIColor *defaultMacdDemLineColorValue = DefaultmacdDemLineColor;
    [_macdDemLineColorButton setBackgroundColor:defaultMacdDemLineColorValue];
    
    UIColor *defaultMacdPositiveColorValue = DefaultmacdPositiveColor;
    [_macdPositiveColorButton setBackgroundColor:defaultMacdPositiveColorValue];
    
    UIColor *defaultMacdNegativeColorValue = DefaultmacdNegativeColor;
    [_macdNegativeColorButton setBackgroundColor:defaultMacdNegativeColorValue];
    
}

- (void)updateValue:(id)sender {
    
    if (sender == _macdShortPeriodSlider) {
        int value = floor(_macdShortPeriodSlider.value);
        [_macdShortPeriodValueLabel setText:[@(value) stringValue]];
        _macdShortPeriodSlider.value = value;
        _macdShortPeriodSteper.value = value;
    }
    
    if (sender == _macdShortPeriodSteper) {
        [_macdShortPeriodValueLabel setText:[@(_macdShortPeriodSteper.value) stringValue]];
        _macdShortPeriodSlider.value = _macdShortPeriodSteper.value;
    }
    
    if (sender == _macdLongPeriodSlider) {
        int value = floor(_macdLongPeriodSlider.value);
        [_macdLongPeriodValueLabel setText:[@(value) stringValue]];
        _macdLongPeriodSlider.value = value;
        _macdLongPeriodSteper.value = value;
    }
    
    if (sender == _macdLongPeriodSteper) {
        [_macdLongPeriodValueLabel setText:[@(_macdLongPeriodSteper.value) stringValue]];
        _macdLongPeriodSlider.value = _macdLongPeriodSteper.value;
    }
    
    if (sender == _macdPeriodSignalSlider) {
        int value = floor(_macdPeriodSignalSlider.value);
        [_macdPeriodSignalValueLabel setText:[@(value) stringValue]];
        _macdPeriodSignalSlider.value = value;
    }
    
    if (sender == _macdDiffLineWidthSlider) {
        int value = floor(_macdDiffLineWidthSlider.value);
        [_macdDiffLineWidthValueLabel setText:[@(value) stringValue]];
        _macdDiffLineWidthSlider.value = value;
    }
    
    if (sender == _macdDemLineWidthSlider) {
        int value = floor(_macdDemLineWidthSlider.value);
        [_macdDemLineWidthValueLabel setText:[@(value) stringValue]];
        _macdDemLineWidthSlider.value = value;
    }
}

//- (void)showColorPicker:(id)sender {
//    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    UIImage *backImage = [ImageUtils imageWithView:self.superview];
////    UIImage *backgroundImage = [backImage blurredImageWithRadius:kDefaultRadius
////                                                      iterations:kDefaultIterations
////                                                       tintColor:[UIColor blackColor]];
//    container.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
//
//    KZColorPicker *colorPicker = [[KZColorPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
//    [colorPicker setCenter:container.center];
//    colorPicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [colorPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
//
//    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, SCREEN_HEIGHT - 40, 70, 30)];
//    [commitBtn addTarget:self action:@selector(colorChange:) forControlEvents:UIControlEventTouchUpInside];
//    [commitBtn setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
////    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:commitBtn];
////    [UIFormat setComplexBlueButtonColor:commitBtn];
//
//    _currentButton = sender;
//
//    [container addSubview:commitBtn];
//    [container addSubview:colorPicker];
//    [self.superview addSubview:container];
//}

- (void)colorChange:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        [[((UIButton *)sender) superview] removeFromSuperview];
    }
}

- (void) pickerChanged:(KZColorPicker *)cp {
    [_currentButton setBackgroundColor:cp.selectedColor];
}

- (void)commitArgument {
    [self.config setMacdShortPeriod:[[NSNumber alloc] initWithInt:_macdShortPeriodSlider.value]];
    [self.config setMacdLongPeriod:[[NSNumber alloc] initWithInt:_macdLongPeriodSlider.value]];
    [self.config setMacdPeriodSignal:[[NSNumber alloc] initWithInt:_macdPeriodSignalSlider.value]];
    [self.config setMacdDiffLineWidth:[[NSNumber alloc] initWithInt:_macdDiffLineWidthSlider.value]];
    [self.config setMacdDiffLineColor:_macdDiffLineColorButton.backgroundColor];
    [self.config setMacdDemLineWidth:[[NSNumber alloc] initWithInt:_macdDemLineWidthSlider.value]];
    [self.config setMacdDemLineColor:_macdDemLineColorButton.backgroundColor];
    [self.config setMacdPositiveColor:_macdPositiveColorButton.backgroundColor];
    [self.config setMacdNegativeColor:_macdNegativeColorButton.backgroundColor];
    //    [config saveConfigData];
}

- (void)resetTiArgument {
    [self resetArgument];
}

@end
