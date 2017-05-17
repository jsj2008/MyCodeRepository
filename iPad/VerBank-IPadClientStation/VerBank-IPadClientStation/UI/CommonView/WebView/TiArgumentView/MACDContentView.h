//
//  MACDContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiSuperContentView.h"

@interface MACDContentView : TiSuperContentView {
    IBOutlet UILabel    *_macdShortPeriodLabel;
    IBOutlet UISlider   *_macdShortPeriodSlider;
    IBOutlet UILabel    *_macdShortPeriodValueLabel;
    IBOutlet UIStepper  *_macdShortPeriodSteper;
    
    IBOutlet UILabel    *_macdLongPeriodLabel;
    IBOutlet UISlider   *_macdLongPeriodSlider;
    IBOutlet UILabel    *_macdLongPeriodValueLabel;
    IBOutlet UIStepper  *_macdLongPeriodSteper;
    
    IBOutlet UILabel    *_macdPeriodSignalLabel;
    IBOutlet UISlider   *_macdPeriodSignalSlider;
    IBOutlet UILabel    *_macdPeriodSignalValueLabel;
    
    IBOutlet UILabel    *_macdDiffLineWidthLabel;
    IBOutlet UISlider   *_macdDiffLineWidthSlider;
    IBOutlet UILabel    *_macdDiffLineWidthValueLabel;
    
    IBOutlet UILabel    *_macdDiffLineColorLabel;
    IBOutlet UIButton   *_macdDiffLineColorButton;
    
    IBOutlet UILabel    *_macdDemLineWidthLabel;
    IBOutlet UISlider   *_macdDemLineWidthSlider;
    IBOutlet UILabel    *_macdDemLineWidthValueLabel;
    
    IBOutlet UILabel    *_macdDemLineColorLabel;
    IBOutlet UIButton   *_macdDemLineColorButton;
    
    IBOutlet UILabel    *_macdPositiveColorLabel;
    IBOutlet UIButton   *_macdPositiveColorButton;
    
    IBOutlet UILabel    *_macdNegativeColorLabel;
    IBOutlet UIButton   *_macdNegativeColorButton;
}

@property UILabel   *macdShortPeriodLabel;
@property UISlider  *macdShortPeriodSlider;
@property UILabel   *macdShortPeriodValueLabel;
@property UIStepper *macdShortPeriodSteper;

@property UILabel   *macdLongPeriodLabel;
@property UISlider  *macdLongPeriodSlider;
@property UILabel   *macdLongPeriodValueLabel;
@property UIStepper *macdLongPeriodSteper;

@property UILabel   *macdPeriodSignalLabel;
@property UISlider  *macdPeriodSignalSlider;
@property UILabel   *macdPeriodSignalValueLabel;

@property UILabel   *macdDiffLineWidthLabel;
@property UISlider  *macdDiffLineWidthSlider;
@property UILabel   *macdDiffLineWidthValueLabel;

@property UILabel   *macdDiffLineColorLabel;
@property UIButton  *macdDiffLineColorButton;

@property UILabel   *macdDemLineWidthLabel;
@property UISlider  *macdDemLineWidthSlider;
@property UILabel   *macdDemLineWidthValueLabel;

@property UILabel   *macdDemLineColorLabel;
@property UIButton  *macdDemLineColorButton;

@property UILabel   *macdPositiveColorLabel;
@property UIButton  *macdPositiveColorButton;

@property UILabel   *macdNegativeColorLabel;
@property UIButton  *macdNegativeColorButton;

@end
