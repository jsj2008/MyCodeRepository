//
//  RSIContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "RSIContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "ImageUtils.h"
#import "LeftViewController.h"
#import "KZColorPicker.h"
#import "AbstractTiContent.h"
#import "UIColor+CustomColor.h"
#import "TiArgumentConfig.h"
#import "UIFormat.h"

@interface RSIContentView()<AbstractTiContent>{
    UIButton *_currentButton;
}

@end

@implementation RSIContentView

@synthesize shortPeriodLabel                = _shortPeriodLabel;
@synthesize shortPeriodSlider               = _shortPeriodSlider;
@synthesize shortPeriodValueLabel           = _shortPeriodValueLabel;

@synthesize rsiShortLineWidthLabel          = _rsiShortLineWidthLabel;
@synthesize rsiShortLineWidthSlider         = _rsiShortLineWidthSlider;
@synthesize rsiShortLineWidthValueLabel     = _rsiShortLineWidthValueLabel;

@synthesize rsiShortLineColorLabel          = _rsiShortLineColorLabel;
@synthesize rsiShortLineColorButton         = _rsiShortLineColorButton;

@synthesize rsiLongLineWidthLabel           = _rsiLongLineWidthLabel;
@synthesize rsiLongLineWidthSlider          = _rsiLongLineWidthSlider;
@synthesize rsiLongLineWidthValueLabel      = _rsiLongLineWidthValueLabel;

@synthesize longPeriodLabel                 = _longPeriodLabel;
@synthesize longPeriodSlider                = _longPeriodSlider;
@synthesize longPeriodValueLabel            = _longPeriodValueLabel;

@synthesize rsiLongLineColorLabel           = _rsiLongLineColorLabel;
@synthesize rsiLongLineColorButton          = _rsiLongLineColorButton;

+ (RSIContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"RSIContentView" owner:self options:nil];
    RSIContentView *view = (RSIContentView *)[nib objectAtIndex:0];
    [view initContentView];
    return view;
}

- (void)initContentView {
    [self setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 30 * 2)];
    
    [_shortPeriodSlider addTarget:self
                           action:@selector(updateValue:)
                 forControlEvents:UIControlEventValueChanged];
    
    [_rsiShortLineWidthSlider addTarget:self
                                 action:@selector(updateValue:)
                       forControlEvents:UIControlEventValueChanged];
    
    [_rsiShortLineColorButton addTarget:self
                                 action:@selector(showColorPicker:)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [_longPeriodSlider addTarget:self
                          action:@selector(updateValue:)
                forControlEvents:UIControlEventValueChanged];
    
    [_rsiLongLineWidthSlider addTarget:self
                                action:@selector(updateValue:)
                      forControlEvents:UIControlEventValueChanged];
    
    [_rsiLongLineColorButton addTarget:self
                                action:@selector(showColorPicker:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [_shortPeriodLabel setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"ShortPeriod"]]];
    [_rsiShortLineWidthLabel setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"ShortWidth"]]];
    [_rsiShortLineColorLabel setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"ShortColor"]]];
    [_rsiShortLineColorButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"] forState:UIControlStateNormal];
    
    [_longPeriodLabel setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"LongPeriod"]]];
    [_rsiLongLineWidthLabel setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"LongWidth"]]];
    [_rsiLongLineColorLabel setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"LongColor"]]];
    [_rsiLongLineColorButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"] forState:UIControlStateNormal];
    
    [_rsiShortLineColorButton.layer setCornerRadius:5.0f];
    [_rsiShortLineColorButton.layer setBorderWidth:1.0f];
    [_rsiShortLineColorButton.layer setBorderColor:[UIColor grayColor].CGColor];
    [_rsiLongLineColorButton.layer setCornerRadius:5.0f];
    [_rsiLongLineColorButton.layer setBorderWidth:1.0f];
    [_rsiLongLineColorButton.layer setBorderColor:[UIColor grayColor].CGColor];
    
    [self checkInit];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)checkInit {
    int defaultRsiShortPeriodValue = [[[TiArgumentConfig getInstance] rsiShortPeriod] intValue];
    _shortPeriodSlider.value = defaultRsiShortPeriodValue;
    [_shortPeriodValueLabel setText:[@(defaultRsiShortPeriodValue) stringValue]];
    
    int defaultRsiShortWidthValue = [[[TiArgumentConfig getInstance] rsiShortWidth] intValue];
    _rsiShortLineWidthSlider.value = defaultRsiShortWidthValue;
    [_rsiShortLineWidthValueLabel setText:[@(defaultRsiShortWidthValue) stringValue]];
    
    UIColor *defaultRsiShortColorValue = [[TiArgumentConfig getInstance] rsiShortColor];
    [_rsiShortLineColorButton setBackgroundColor:defaultRsiShortColorValue];
    
    int defaultRsiLongPeriodValue = [[[TiArgumentConfig getInstance] rsiLongPeriod] intValue];
    _longPeriodSlider.value = defaultRsiLongPeriodValue;
    [_longPeriodValueLabel setText:[@(defaultRsiLongPeriodValue) stringValue]];
    
    int defaultRsiLongWidthValue = [[[TiArgumentConfig getInstance] rsiLongWidth] intValue];
    _rsiLongLineWidthSlider.value = defaultRsiLongWidthValue;
    [_rsiLongLineWidthValueLabel setText:[@(defaultRsiLongWidthValue) stringValue]];
    
    UIColor *defaultRsiLongColorValue = [[TiArgumentConfig getInstance] rsiLongColor];
    [_rsiLongLineColorButton setBackgroundColor:defaultRsiLongColorValue];
}

- (void)resetArgument {
    int defaultRsiShortPeriodValue = DefaultRsiShortPeriod;
    _shortPeriodSlider.value = defaultRsiShortPeriodValue;
    [_shortPeriodValueLabel setText:[@(defaultRsiShortPeriodValue) stringValue]];
    
    int defaultRsiShortWidthValue = DefaultRsiShortWidth;
    _rsiShortLineWidthSlider.value = defaultRsiShortWidthValue;
    [_rsiShortLineWidthValueLabel setText:[@(defaultRsiShortWidthValue) stringValue]];
    
    UIColor *defaultRsiShortColorValue = DefaultRsiShortColor;
    [_rsiShortLineColorButton setBackgroundColor:defaultRsiShortColorValue];
    
    int defaultRsiLongPeriodValue = DefaultRsiLongPeriod;
    _longPeriodSlider.value = defaultRsiLongPeriodValue;
    [_longPeriodValueLabel setText:[@(defaultRsiLongPeriodValue) stringValue]];
    
    int defaultRsiLongWidthValue = DefaultRsiLongWidth;
    _rsiLongLineWidthSlider.value = defaultRsiLongWidthValue;
    [_rsiLongLineWidthValueLabel setText:[@(defaultRsiLongWidthValue) stringValue]];
    
    UIColor *defaultRsiLongColorValue = DefaultRsiLongColor;
    [_rsiLongLineColorButton setBackgroundColor:defaultRsiLongColorValue];
}

- (void)updateValue:(id)sender {
    if (sender == _shortPeriodSlider) {
        int value = floor(_shortPeriodSlider.value);
        [_shortPeriodValueLabel setText:[@(value) stringValue]];
        _shortPeriodSlider.value = value;
    }
    
    if (sender == _rsiShortLineWidthSlider) {
        int value = floor(_rsiShortLineWidthSlider.value);
        [_rsiShortLineWidthValueLabel setText:[@(value) stringValue]];
        _rsiShortLineWidthSlider.value = value;
    }
    
    if (sender == _longPeriodSlider) {
        int value = floor(_longPeriodSlider.value);
        [_longPeriodValueLabel setText:[@(value) stringValue]];
        _longPeriodSlider.value = value;
    }
    
    if (sender == _rsiLongLineWidthSlider) {
        int value = floor(_rsiLongLineWidthSlider.value);
        [_rsiLongLineWidthValueLabel setText:[@(value) stringValue]];
        _rsiLongLineWidthSlider.value = value;
    }
}

- (void)showColorPicker:(id)sender {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage *backImage = [ImageUtils imageWithView:self.superview];
    UIImage *backgroundImage = [backImage blurredImageWithRadius:kDefaultRadius
                                                      iterations:kDefaultIterations
                                                       tintColor:[UIColor blackColor]];
    container.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    KZColorPicker *colorPicker = [[KZColorPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
    [colorPicker setCenter:container.center];
    colorPicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [colorPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, SCREEN_HEIGHT - 40, 70, 30)];
    [commitBtn addTarget:self action:@selector(colorChange:) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:commitBtn];
    [UIFormat setComplexBlueButtonColor:commitBtn];
    
    _currentButton = sender;
    
    [container addSubview:commitBtn];
    [container addSubview:colorPicker];
    [self.superview addSubview:container];
}

- (void)colorChange:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        [[((UIButton *)sender) superview] removeFromSuperview];
    }
}

- (void) pickerChanged:(KZColorPicker *)cp {
    [_currentButton setBackgroundColor:cp.selectedColor];
}

- (void)commitTiArgument {
//    [[TiArgumentConfig getInstance] setRsiShortPeriod:[[NSNumber alloc] initWithInt:_shortPeriodSlider.value]];
//    [[TiArgumentConfig getInstance] setRsiShortWidth:[[NSNumber alloc] initWithInt:_rsiShortLineWidthSlider.value]];
//    [[TiArgumentConfig getInstance] setRsiShortColor:_rsiShortLineColorButton.backgroundColor];
//    [[TiArgumentConfig getInstance] setRsiLongPeriod:[[NSNumber alloc] initWithInt:_longPeriodSlider.value]];
//    [[TiArgumentConfig getInstance] setRsiLongWidth:[[NSNumber alloc] initWithInt:_rsiLongLineWidthSlider.value]];
//    [[TiArgumentConfig getInstance] setRsiLongColor:_rsiLongLineColorButton.backgroundColor];
//    [[TiArgumentConfig getInstance] saveConfigData];
}

- (void)resetTiArgument {
//    [self checkInit];
    [self resetArgument];
}

@end
