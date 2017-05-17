//
//  BollingerBandContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiSuperContentView.h"

@interface BollingerBandContentView : TiSuperContentView {
    IBOutlet UILabel    *_BBPeriodLabel;
    IBOutlet UISlider   *_BBPeriodSlider;
    IBOutlet UILabel    *_BBPeriodValueLabel;
    IBOutlet UIStepper  *_BBPeriodSteper;
    
    IBOutlet UILabel    *_BBKLabel;
    IBOutlet UISlider   *_BBKSlider;
    IBOutlet UILabel    *_BBKValueLabel;
    
    IBOutlet UILabel    *_BBLineWidthLabel;
    IBOutlet UISlider   *_BBLineWidthSlider;
    IBOutlet UILabel    *_BBLineWidthValueLabel;
    
    IBOutlet UILabel    *_BBLineColorLabel;
    IBOutlet UIButton   *_BBLineColorButton;
    
    IBOutlet UILabel    *_BBFillColorLabel;
    IBOutlet UIButton   *_BBFillColorButton;
}

@property UILabel   *BBPeriodLabel;
@property UISlider  *BBPeriodSlider;
@property UILabel   *BBPeriodValueLabel;
@property UIStepper *BBPeriodSteper;

@property UILabel   *BBKLabel;
@property UISlider  *BBKSlider;
@property UILabel   *BBKValueLabel;

@property UILabel   *BBLineWidthLabel;
@property UISlider  *BBLineWidthSlider;
@property UILabel   *BBLineWidthValueLabel;

@property UILabel   *BBLineColorLabel;
@property UIButton  *BBLineColorButton;

@property UILabel   *BBFillColorLabel;
@property UIButton  *BBFillColorButton;

@end
