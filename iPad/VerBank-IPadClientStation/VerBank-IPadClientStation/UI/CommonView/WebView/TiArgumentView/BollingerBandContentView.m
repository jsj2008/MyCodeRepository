//
//  BollingerBandContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "BollingerBandContentView.h"

#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "TiArgumentConfig.h"
#import "UIFormat.h"
#import "KZColorPicker.h"
#import "ColorFullButton.h"

@interface BollingerBandContentView() {
    TiArgumentConfig *_config;
}

@end

@implementation BollingerBandContentView

@synthesize BBPeriodLabel           = _BBPeriodLabel;
@synthesize BBPeriodSlider          = _BBPeriodSlider;
@synthesize BBPeriodValueLabel      = _BBPeriodValueLabel;
@synthesize BBPeriodSteper          = _BBPeriodSteper;

@synthesize BBKLabel                = _BBKLabel;
@synthesize BBKSlider               = _BBKSlider;
@synthesize BBKValueLabel           = _BBKValueLabel;

@synthesize BBLineWidthLabel        = _BBLineWidthLabel;
@synthesize BBLineWidthSlider       = _BBLineWidthSlider;
@synthesize BBLineWidthValueLabel   = _BBLineWidthValueLabel;

@synthesize BBLineColorLabel        = _BBLineColorLabel;
@synthesize BBLineColorButton       = _BBLineColorButton;

@synthesize BBFillColorLabel        = _BBFillColorLabel;
@synthesize BBFillColorButton       = _BBFillColorButton;

- (void)initContent {
    [self setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 30 * 2)];
    
    [_BBPeriodSlider addTarget:self
                        action:@selector(updateValue:)
              forControlEvents:UIControlEventValueChanged];
    [_BBPeriodSteper addTarget:self
                        action:@selector(updateValue:)
              forControlEvents:UIControlEventValueChanged];
    
    [_BBKSlider addTarget:self
                   action:@selector(updateValue:)
         forControlEvents:UIControlEventValueChanged];
    [_BBLineWidthSlider addTarget:self
                           action:@selector(updateValue:)
                 forControlEvents:UIControlEventValueChanged];
    
    [_BBLineColorButton addTarget:self
                           action:@selector(showColorPicker:)
                 forControlEvents:UIControlEventTouchUpInside];
    [_BBFillColorButton addTarget:self
                           action:@selector(showColorPicker:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [_BBPeriodLabel             setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"Period"]]];
    [_BBKLabel                  setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"K"]]];
    [_BBLineWidthLabel          setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"EdgeLineWidth"]]];
    [_BBLineColorLabel          setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"EdgeLineColor"]]];
    [_BBFillColorLabel          setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"FillColor"]]];
    
    [_BBLineColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                          forState:UIControlStateNormal];
    [_BBFillColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                          forState:UIControlStateNormal];
    
//    [UIFormat initButtonStyle:_BBLineColorButton];
//    [UIFormat initButtonStyle:_BBFillColorButton];
    [self initPickButton:_BBLineColorButton];
    [self initPickButton:_BBFillColorButton];
//    
//    [self checkInit];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)setTiArgumentConfig:(TiArgumentConfig *)config withIndex:(int)index {
    _config = config;
    
    int defaultBBPeriodValue = [[config bollingerBandPeriod] intValue];
    _BBPeriodSlider.value = defaultBBPeriodValue;
    _BBPeriodSteper.value = defaultBBPeriodValue;
    [_BBPeriodValueLabel setText:[@(defaultBBPeriodValue) stringValue]];
    
    int defaultBBKValue = [[config bollingerBandK] intValue];
    _BBKSlider.value = defaultBBKValue;
    [_BBKValueLabel setText:[@(defaultBBKValue) stringValue]];
    
    int defaultBBLineWidthValue = [[config bollingerBandLineWidth] intValue];
    _BBLineWidthSlider.value = defaultBBLineWidthValue;
    [_BBLineWidthValueLabel setText:[@(defaultBBLineWidthValue) stringValue]];
    
    UIColor *defaultBBLineColorValue = [config bollingerBandLineColor];
    [_BBLineColorButton setBackgroundColor:defaultBBLineColorValue];
    
    UIColor *defaultBBFillColorValue = [config bollingerBandFillColor];
    [_BBFillColorButton setBackgroundColor:defaultBBFillColorValue];
}

- (void)resetArgument {
    int defaultBBPeriodValue = DefaultbollingerBandPeriod;
    _BBPeriodSlider.value = defaultBBPeriodValue;
    _BBPeriodSteper.value = defaultBBPeriodValue;
    [_BBPeriodValueLabel setText:[@(defaultBBPeriodValue) stringValue]];
    
    int defaultBBKValue = DefaultbollingerBandK;
    _BBKSlider.value = defaultBBKValue;
    [_BBKValueLabel setText:[@(defaultBBKValue) stringValue]];
    
    int defaultBBLineWidthValue = DefaultbollingerBandLineWidth;
    _BBLineWidthSlider.value = defaultBBLineWidthValue;
    [_BBLineWidthValueLabel setText:[@(defaultBBLineWidthValue) stringValue]];
    
    UIColor *defaultBBLineColorValue = DefaultbollingerBandLineColor;
    [_BBLineColorButton setBackgroundColor:defaultBBLineColorValue];
    
    UIColor *defaultBBFillColorValue = DefaultbollingerBandFillColor;
    [_BBFillColorButton setBackgroundColor:defaultBBFillColorValue];
}

- (void)updateValue:(id)sender {
    if (sender == _BBPeriodSlider) {
        int value = floor(_BBPeriodSlider.value);
        [_BBPeriodValueLabel setText:[@(value) stringValue]];
        _BBPeriodSlider.value = value;
        _BBPeriodSteper.value = value;
    }
    
    if (sender == _BBPeriodSteper) {
        [_BBPeriodValueLabel setText:[@(_BBPeriodSteper.value) stringValue]];
        _BBPeriodSlider.value = _BBPeriodSteper.value;
    }
    
    if (sender == _BBKSlider) {
        int value = floor(_BBKSlider.value);
        [_BBKValueLabel setText:[@(value) stringValue]];
        _BBKSlider.value = value;
    }
    
    if (sender == _BBLineWidthSlider) {
        int value = floor(_BBLineWidthSlider.value);
        [_BBLineWidthValueLabel setText:[@(value) stringValue]];
        _BBLineWidthSlider.value = value;
    }
}

//- (void)showColorPicker:(id)sender {
//    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    container.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
//    
//    KZColorPicker *colorPicker = [[KZColorPicker alloc] initWithFrame:CGRectMake(0, 0, 400, 280)];
//    [colorPicker setCenter:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)];
//    colorPicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [colorPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
//    
//    ColorFullButton *commitBtn = [[ColorFullButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, SCREEN_HEIGHT - 100, 70, 30)];
//    [commitBtn setStyle:ButtonBlue];
//    [commitBtn setCorner:10.0f];
//    [commitBtn addTarget:self action:@selector(colorChange:) forControlEvents:UIControlEventTouchUpInside];
//    [commitBtn setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
//    
//    _currentButton = sender;
//    
//    [container addSubview:commitBtn];
//    [container addSubview:colorPicker];
//    [self.superview.superview addSubview:container];
//}



- (void)commitArgument {
    [_config setBollingerBandPeriod:[[NSNumber alloc] initWithInt:_BBPeriodSlider.value]];
    [_config setBollingerBandK:[[NSNumber alloc] initWithInt:_BBKSlider.value]];
    [_config setBollingerBandLineWidth:[[NSNumber alloc] initWithInt:_BBLineWidthSlider.value]];
    [_config setBollingerBandLineColor:_BBLineColorButton.backgroundColor];
    [_config setBollingerBandFillColor:_BBFillColorButton.backgroundColor];
//    [config saveConfigData];
}

- (void)resetTiArgument {
    [self resetArgument];
}

@end
