//
//  MAContentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "MAContentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "KZColorPicker.h"
#import "UIColor+CustomColor.h"
#import "ImageUtils.h"
#import "LeftViewController.h"
#import "AbstractTiContent.h"
#import "UIColor+CustomColor.h"
#import "TiArgumentConfig.h"
#import "UIFormat.h"
#import "KChartParam.h"
#import "TiSaveData.h"
#import "MAData.h"

@interface MAContentView()<AbstractTiContent> {
    int _maArrayIndex;
}

@end

@implementation MAContentView

@synthesize periodLabel = _periodLabel;
@synthesize periodSlider = _periodSlider;
@synthesize periodValueLabel = _periodValueLabel;
@synthesize periodSteper = _periodSteper;

@synthesize lineWidthLabel = _lineWidthLabel;
@synthesize lineWidthSlider = _lineWidthSlider;
@synthesize lineWidthValueLabel = _lineWidthValueLabel;

@synthesize colorLabel = _colorLabel;
@synthesize colorPickButton = _colorPickButton;

+ (MAContentView *)newInstanceWithIndex:(int)index {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MAContentView" owner:self options:nil];
    MAContentView *view = (MAContentView *)[nib objectAtIndex:0];
    [view initContentViewWithIndex:index];
    return view;
}

- (void)initContentViewWithIndex:(int)index {
    [self setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 30 * 2)];
    
    [_periodSlider addTarget:self
                      action:@selector(updateValue:)
            forControlEvents:UIControlEventValueChanged];
    
    [_lineWidthSlider addTarget:self
                         action:@selector(updateValue:)
               forControlEvents:UIControlEventValueChanged];
    
    [_colorPickButton addTarget:self
                         action:@selector(showColorPicker)
               forControlEvents:UIControlEventTouchUpInside];
    
    [_periodSteper addTarget:self
                      action:@selector(updateValue:)
            forControlEvents:UIControlEventValueChanged];
    
    [_lineWidthLabel    setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineWidth"]]];
    [_periodLabel       setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"Period"]]];
    [_colorLabel        setText:[NSString stringWithFormat:@"%@ : ", [[LangCaptain getInstance] getLangByCode:@"LineColor"]]];
    [_colorPickButton   setTitle:[[LangCaptain getInstance] getLangByCode:@"ColorPick"]
                        forState:UIControlStateNormal];
    
    [UIFormat initButtonStyle:_colorPickButton];
    _maArrayIndex = index;
    [self checkInit];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)checkInit {
    //    NSDictionary *dic = [[[KChartParam getInstance] getTiConfigDic] objectForKey:[@(ma) stringValue]];
    NSString *key = [NSString stringWithFormat:@"%@%d", [@(ma) stringValue], _maArrayIndex];
    NSDictionary *dic = [[[[TiSaveData getInstance] tiClientMap] objectForKey:[[KChartParam getInstance] instrumentName]] objectForKey:key];
    if (dic == nil) {
        [self resetArgument];
    } else {
        int defaultMaPeriodValue = [[dic objectForKey:@"period"] intValue];
        _periodSlider.value = defaultMaPeriodValue;
        [_periodValueLabel setText:[@(defaultMaPeriodValue) stringValue]];
        [_periodSteper setValue:defaultMaPeriodValue];
        
        int defaultMaWidthValue = [[dic objectForKey:@"maLineWidth"] intValue];
        _lineWidthSlider.value = defaultMaWidthValue;
        [_lineWidthValueLabel setText:[@(defaultMaWidthValue) stringValue]];
        
        NSString *colorString = [dic objectForKey:@"maLineColorRgba"];
        NSArray *colorArray = [colorString componentsSeparatedByString:@","];
        UIColor *defaultMaColorValue = RGBAlpha([colorArray[0] intValue], [colorArray[1] intValue], [colorArray[2] intValue], [colorArray[3] intValue]);
        [_colorPickButton setBackgroundColor:defaultMaColorValue];
        //        RGBAlpha(r, g, b, a)
    }
    
    //    UIColor *defaultMaColorValue = [[dic objectForKey:@"maLineWidth"] intValue];
    //    [_colorPickButton setBackgroundColor:defaultMaColorValue];
    
    //    int defaultMaPeriodValue = [[[TiArgumentConfig getInstance] maPeriod] intValue];
    //    _periodSlider.value = defaultMaPeriodValue;
    //    [_periodValueLabel setText:[@(defaultMaPeriodValue) stringValue]];
    //
    //    int defaultMaWidthValue = [[[TiArgumentConfig getInstance] maWidth] intValue];
    //    _lineWidthSlider.value = defaultMaWidthValue;
    //    [_lineWidthValueLabel setText:[@(defaultMaWidthValue) stringValue]];
    //
    //    UIColor *defaultMaColorValue = [[TiArgumentConfig getInstance] maColor];
    //    [_colorPickButton setBackgroundColor:defaultMaColorValue];
    
    
}

- (void)resetArgument {
    int defaultMaPeriodValue = DefaultMaPeriod;
    _periodSlider.value = defaultMaPeriodValue;
    _periodSteper.value = defaultMaPeriodValue;
    [_periodValueLabel setText:[@(defaultMaPeriodValue) stringValue]];
    
    int defaultMaWidthValue = DefaultMaWidth;
    _lineWidthSlider.value = defaultMaWidthValue;
    [_lineWidthValueLabel setText:[@(defaultMaWidthValue) stringValue]];
    
    UIColor *defaultMaColorValue = DefaultMaColor;
    [_colorPickButton setBackgroundColor:defaultMaColorValue];
}

- (void)updateValue:(id)sender {
    if (sender == _periodSlider) {
        int value = floor(_periodSlider.value);
        [_periodValueLabel setText:[@(value) stringValue]];
        [_periodSteper setValue:value];
        _periodSlider.value = value;
    }
    
    if (sender == _lineWidthSlider) {
        int value = floor(_lineWidthSlider.value);
        [_lineWidthValueLabel setText:[@(value) stringValue]];
        _lineWidthSlider.value = value;
    }
    
    if (sender == _periodSteper) {
        int value = _periodSteper.value;
        [_periodValueLabel setText:[@(value) stringValue]];
        [_periodSlider setValue:value];
    }
}

- (void)showColorPicker {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage *backImage = [ImageUtils imageWithView:self.superview];
    UIImage *backgroundImage = [backImage blurredImageWithRadius:kDefaultRadius
                                                      iterations:kDefaultIterations
                                                       tintColor:[UIColor blackColor]];
    container.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    KZColorPicker *picker = [[KZColorPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
    [picker setCenter:container.center];
    picker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //    picker.selectedColor = self.selectedColor;
    //    picker.oldColor = self.selectedColor;
    [picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, SCREEN_HEIGHT - 40, 70, 30)];
    [commitBtn addTarget:self action:@selector(colorChange:) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
    [UIFormat setCorner:UIRectCornerAllCorners WithUIView:commitBtn];
    [UIFormat setComplexBlueButtonColor:commitBtn];
    
    [container addSubview:commitBtn];
    [container addSubview:picker];
    [self.superview addSubview:container];
}

- (void)colorChange:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        [[((UIButton *)sender) superview] removeFromSuperview];
    }
}

- (void) pickerChanged:(KZColorPicker *)cp {
    [_colorPickButton setBackgroundColor:cp.selectedColor];
}

- (void)commitTiArgument {
    //    [[TiArgumentConfig getInstance] setMaPeriod:[[NSNumber alloc] initWithInt:[_periodValueLabel.text intValue]]];
    //    [[TiArgumentConfig getInstance] setMaWidth:[[NSNumber alloc] initWithInt:[_lineWidthValueLabel.text intValue]]];
    //    [[TiArgumentConfig getInstance] setMaColor:_colorPickButton.backgroundColor];
    
    MAData *data = [[MAData alloc] init];
    [data setMaPeriod:[[NSNumber alloc] initWithInt:[_periodValueLabel.text intValue]]];
    [data setMaWidth:[[NSNumber alloc] initWithInt:[_lineWidthValueLabel.text intValue]]];
    [data setMaColor:_colorPickButton.backgroundColor];
    NSMutableArray *maArray = [[TiArgumentConfig getInstance] maDataArray];
    [maArray replaceObjectAtIndex:_maArrayIndex withObject:data];
}

- (void)resetTiArgument {
    //    [self checkInit];
    [self resetArgument];
}

@end
