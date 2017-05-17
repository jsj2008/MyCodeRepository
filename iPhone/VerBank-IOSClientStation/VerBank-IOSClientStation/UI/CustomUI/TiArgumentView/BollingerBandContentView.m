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
#import "ImageUtils.h"
#import "KZColorPicker.h"
#import "LeftViewController.h"
#import "AbstractTiContent.h"

@interface BollingerBandContentView()<AbstractTiContent> {
    UIButton *_currentButton;
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

+ (BollingerBandContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BollingerBandContentView" owner:self options:nil];
    BollingerBandContentView *view = (BollingerBandContentView *)[nib objectAtIndex:0];
    [view initContentView];
    return view;
}

- (void)initContentView {
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
    
    [UIFormat initButtonStyle:_BBLineColorButton];
    [UIFormat initButtonStyle:_BBFillColorButton];
    
    [self checkInit];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)checkInit {
    int defaultBBPeriodValue = [[[TiArgumentConfig getInstance] bollingerBandPeriod] intValue];
    _BBPeriodSlider.value = defaultBBPeriodValue;
    _BBPeriodSteper.value = defaultBBPeriodValue;
    [_BBPeriodValueLabel setText:[@(defaultBBPeriodValue) stringValue]];
    
    int defaultBBKValue = [[[TiArgumentConfig getInstance] bollingerBandK] intValue];
    _BBKSlider.value = defaultBBKValue;
    [_BBKValueLabel setText:[@(defaultBBKValue) stringValue]];
    
    int defaultBBLineWidthValue = [[[TiArgumentConfig getInstance] bollingerBandLineWidth] intValue];
    _BBLineWidthSlider.value = defaultBBLineWidthValue;
    [_BBLineWidthValueLabel setText:[@(defaultBBLineWidthValue) stringValue]];
    
    UIColor *defaultBBLineColorValue = [[TiArgumentConfig getInstance] bollingerBandLineColor];
    [_BBLineColorButton setBackgroundColor:defaultBBLineColorValue];
    
    UIColor *defaultBBFillColorValue = [[TiArgumentConfig getInstance] bollingerBandFillColor];
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
    [[TiArgumentConfig getInstance] setBollingerBandPeriod:[[NSNumber alloc] initWithInt:_BBPeriodSlider.value]];
    [[TiArgumentConfig getInstance] setBollingerBandK:[[NSNumber alloc] initWithInt:_BBKSlider.value]];
    [[TiArgumentConfig getInstance] setBollingerBandLineWidth:[[NSNumber alloc] initWithInt:_BBLineWidthSlider.value]];
    [[TiArgumentConfig getInstance] setBollingerBandLineColor:_BBLineColorButton.backgroundColor];
    [[TiArgumentConfig getInstance] setBollingerBandFillColor:_BBFillColorButton.backgroundColor];
//    [[TiArgumentConfig getInstance] saveConfigData];
}

- (void)resetTiArgument {
    [self resetArgument];
}

@end
