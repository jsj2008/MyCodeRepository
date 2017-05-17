//
//  KDJContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "KDJContentView.h"
#import "LangCaptain.h"
#import "IosLayoutDefine.h"
#import "TiArgumentConfig.h"
#import "UIFormat.h"
#import "ImageUtils.h"
#import "KZColorPicker.h"
#import "LeftViewController.h"
#import "AbstractTiContent.h"

@interface KDJContentView()<AbstractTiContent> {
    UIButton *_currentButton;
}

@end

@implementation KDJContentView

@synthesize kdjPeriodLabel      = _kdjPeriodLabel;
@synthesize kdjPeriodSlider     = _kdjPeriodSlider;
@synthesize kdjPeriodValueLabel = _kdjPeriodValueLabel;

@synthesize kLineWidthLabel     = _kLineWidthLabel;
@synthesize kLineWidthSlider    = _kLineWidthSlider;
@synthesize kLineWidthValueLabel= _kLineWidthValueLabel;

@synthesize kLineColorLabel     = _kLineColorLabel;
@synthesize kLineColorButton    = _kLineColorButton;

@synthesize dLineWidthLabel     = _dLineWidthLabel;
@synthesize dLineWidthSlider    = _dLineWidthSlider;
@synthesize dLineWidthValueLabel= _dLineWidthValueLabel;

@synthesize dLineColorLabel     = _dLineColorLabel;
@synthesize dLineColorButton    = _dLineColorButton;

@synthesize jLineWidthLabel     = _jLineWidthLabel;
@synthesize jLineWidthSlider    = _jLineWidthSlider;
@synthesize jLineWidthValueLabel= _jLineWidthValueLabel;

@synthesize jLineColorLabel     = _jLineColorLabel;
@synthesize jLineColorButton    = _jLineColorButton;


+ (KDJContentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"KDJContentView" owner:self options:nil];
    KDJContentView *view = (KDJContentView *)[nib objectAtIndex:0];
    [view initContentView];
    return view;
}

- (void)initContentView {
    [self setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 30 * 2)];
    
    [_kdjPeriodSlider addTarget:self
                         action:@selector(updateValue:)
               forControlEvents:UIControlEventValueChanged];
    [_kLineWidthSlider addTarget:self
                          action:@selector(updateValue:)
                forControlEvents:UIControlEventValueChanged];
    [_dLineWidthSlider addTarget:self
                          action:@selector(updateValue:)
                forControlEvents:UIControlEventValueChanged];
    [_jLineWidthSlider addTarget:self
                          action:@selector(updateValue:)
                forControlEvents:UIControlEventValueChanged];
    
    [_kLineColorButton addTarget:self
                          action:@selector(showColorPicker:)
                forControlEvents:UIControlEventTouchUpInside];
    [_dLineColorButton addTarget:self
                          action:@selector(showColorPicker:)
                forControlEvents:UIControlEventTouchUpInside];
    [_jLineColorButton addTarget:self
                          action:@selector(showColorPicker:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [_kdjPeriodLabel    setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"Period"]]];
    [_kLineWidthLabel   setText:[NSString stringWithFormat:@"K%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineWidth"]]];
    [_dLineWidthLabel   setText:[NSString stringWithFormat:@"D%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineWidth"]]];
    [_jLineWidthLabel   setText:[NSString stringWithFormat:@"J%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineWidth"]]];
    [_kLineColorLabel   setText:[NSString stringWithFormat:@"K%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    [_dLineColorLabel   setText:[NSString stringWithFormat:@"D%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    [_jLineColorLabel   setText:[NSString stringWithFormat:@"J%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    
    [_kLineColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                         forState:UIControlStateNormal];
    [_dLineColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                         forState:UIControlStateNormal];
    [_jLineColorButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                         forState:UIControlStateNormal];
    
    [UIFormat initButtonStyle:_kLineColorButton];
    [UIFormat initButtonStyle:_dLineColorButton];
    [UIFormat initButtonStyle:_jLineColorButton];
    
    [self checkInit];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)checkInit {
    int defaultKDJPeriodValue = [[[TiArgumentConfig getInstance] kdjPeriod] intValue];
    _kdjPeriodSlider.value = defaultKDJPeriodValue;
    [_kdjPeriodValueLabel setText:[@(defaultKDJPeriodValue) stringValue]];
    
    int defaultKLineWidthValue = [[[TiArgumentConfig getInstance] kLineWidth] intValue];
    _kLineWidthSlider.value = defaultKLineWidthValue;
    [_kLineWidthValueLabel setText:[@(defaultKLineWidthValue) stringValue]];
    
    UIColor *defaultKLineColorValue = [[TiArgumentConfig getInstance] kLineColor];
    [_kLineColorButton setBackgroundColor:defaultKLineColorValue];
    
    int defaultDLineWidthValue = [[[TiArgumentConfig getInstance] dLineWidth] intValue];
    _dLineWidthSlider.value = defaultDLineWidthValue;
    [_dLineWidthValueLabel setText:[@(defaultDLineWidthValue) stringValue]];
    
    UIColor *defaultDLineColorValue = [[TiArgumentConfig getInstance] dLineColor];
    [_dLineColorButton setBackgroundColor:defaultDLineColorValue];
    
    int defaultJLineWidthValue = [[[TiArgumentConfig getInstance] jLineWidth] intValue];
    _jLineWidthSlider.value = defaultJLineWidthValue;
    [_jLineWidthValueLabel setText:[@(defaultJLineWidthValue) stringValue]];
    
    UIColor *defaultJLineColorValue = [[TiArgumentConfig getInstance] jLineColor];
    [_jLineColorButton setBackgroundColor:defaultJLineColorValue];
}

- (void)resetArgument {
    int defaultKDJPeriodValue = DefaultkdjPeriod;
    _kdjPeriodSlider.value = defaultKDJPeriodValue;
    [_kdjPeriodValueLabel setText:[@(defaultKDJPeriodValue) stringValue]];
    
    int defaultKLineWidthValue = DefaultkLineWidth;
    _kLineWidthSlider.value = defaultKLineWidthValue;
    [_kLineWidthValueLabel setText:[@(defaultKLineWidthValue) stringValue]];
    
    UIColor *defaultKLineColorValue = DefaultkLineColor;
    [_kLineColorButton setBackgroundColor:defaultKLineColorValue];
    
    int defaultDLineWidthValue = DefaultdLineWidth;
    _dLineWidthSlider.value = defaultDLineWidthValue;
    [_dLineWidthValueLabel setText:[@(defaultDLineWidthValue) stringValue]];
    
    UIColor *defaultDLineColorValue = DefaultdLineColor;
    [_dLineColorButton setBackgroundColor:defaultDLineColorValue];
    
    int defaultJLineWidthValue = DefaultjLineWidth;
    _jLineWidthSlider.value = defaultJLineWidthValue;
    [_jLineWidthValueLabel setText:[@(defaultJLineWidthValue) stringValue]];
    
    UIColor *defaultJLineColorValue = DefaultjLineColor;
    [_jLineColorButton setBackgroundColor:defaultJLineColorValue];
}


- (void)updateValue:(id)sender {
    if (sender == _kdjPeriodSlider) {
        int value = floor(_kdjPeriodSlider.value);
        [_kdjPeriodValueLabel setText:[@(value) stringValue]];
        _kdjPeriodSlider.value = value;
    }
    
    if (sender == _kLineWidthSlider) {
        int value = floor(_kLineWidthSlider.value);
        [_kLineWidthValueLabel setText:[@(value) stringValue]];
        _kLineWidthSlider.value = value;
    }
    
    if (sender == _dLineWidthSlider) {
        int value = floor(_dLineWidthSlider.value);
        [_dLineWidthValueLabel setText:[@(value) stringValue]];
        _dLineWidthSlider.value = value;
    }
    
    if (sender == _jLineWidthSlider) {
        int value = floor(_jLineWidthSlider.value);
        [_jLineWidthValueLabel setText:[@(value) stringValue]];
        _jLineWidthSlider.value = value;
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
//    [[TiArgumentConfig getInstance] setKdjPeriod:[[NSNumber alloc] initWithInt:_kdjPeriodSlider.value]];
//    [[TiArgumentConfig getInstance] setKLineWidth:[[NSNumber alloc] initWithInt:_kLineWidthSlider.value]];
//    [[TiArgumentConfig getInstance] setKLineColor:_kLineColorButton.backgroundColor];
//    [[TiArgumentConfig getInstance] setDLineWidth:[[NSNumber alloc] initWithInt:_dLineWidthSlider.value]];
//    [[TiArgumentConfig getInstance] setDLineColor:_dLineColorButton.backgroundColor];
//    [[TiArgumentConfig getInstance] setJLineWidth:[[NSNumber alloc] initWithInt:_jLineWidthSlider.value]];
//    [[TiArgumentConfig getInstance] setJLineColor:_jLineColorButton.backgroundColor];
//    [[TiArgumentConfig getInstance] saveConfigData];
}

- (void)resetTiArgument {
    [self resetArgument];
}

@end
