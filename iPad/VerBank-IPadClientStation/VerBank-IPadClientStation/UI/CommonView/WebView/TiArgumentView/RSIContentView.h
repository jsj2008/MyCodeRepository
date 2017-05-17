//
//  RSIContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiSuperContentView.h"

@interface RSIContentView : TiSuperContentView  {
    IBOutlet UILabel    *_shortPeriodLabel;
    IBOutlet UISlider   *_shortPeriodSlider;
    IBOutlet UILabel    *_shortPeriodValueLabel;
    
    IBOutlet UILabel    *_rsiShortLineWidthLabel;
    IBOutlet UISlider   *_rsiShortLineWidthSlider;
    IBOutlet UILabel    *_rsiShortLineWidthValueLabel;
    
    IBOutlet UILabel    *_rsiShortLineColorLabel;
    IBOutlet UIButton   *_rsiShortLineColorButton;
    
    IBOutlet UILabel    *_longPeriodLabel;
    IBOutlet UISlider   *_longPeriodSlider;
    IBOutlet UILabel    *_longPeriodValueLabel;
    
    IBOutlet UILabel    *_rsiLongLineWidthLabel;
    IBOutlet UISlider   *_rsiLongLineWidthSlider;
    IBOutlet UILabel    *_rsiLongLineWidthValueLabel;
    
    IBOutlet UILabel    *_rsiLongLineColorLabel;
    IBOutlet UIButton   *_rsiLongLineColorButton;
}

@property UILabel   *shortPeriodLabel;
@property UISlider  *shortPeriodSlider;
@property UILabel   *shortPeriodValueLabel;

@property UILabel   *rsiShortLineWidthLabel;
@property UISlider  *rsiShortLineWidthSlider;
@property UILabel   *rsiShortLineWidthValueLabel;

@property UILabel   *rsiShortLineColorLabel;
@property UIButton  *rsiShortLineColorButton;

@property UILabel   *longPeriodLabel;
@property UISlider  *longPeriodSlider;
@property UILabel   *longPeriodValueLabel;

@property UILabel   *rsiLongLineWidthLabel;
@property UISlider  *rsiLongLineWidthSlider;
@property UILabel   *rsiLongLineWidthValueLabel;

@property UILabel   *rsiLongLineColorLabel;
@property UIButton  *rsiLongLineColorButton;

@end
