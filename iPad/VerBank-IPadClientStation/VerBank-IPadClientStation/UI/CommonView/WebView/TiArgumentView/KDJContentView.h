//
//  KDJContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiSuperContentView.h"

@interface KDJContentView : TiSuperContentView {
    IBOutlet UILabel    *_kdjPeriodLabel;
    IBOutlet UISlider   *_kdjPeriodSlider;
    IBOutlet UILabel    *_kdjPeriodValueLabel;
    
    IBOutlet UILabel    *_kLineWidthLabel;
    IBOutlet UISlider   *_kLineWidthSlider;
    IBOutlet UILabel    *_kLineWidthValueLabel;
    
    IBOutlet UILabel    *_kLineColorLabel;
    IBOutlet UIButton   *_kLineColorButton;
    
    IBOutlet UILabel    *_dLineWidthLabel;
    IBOutlet UISlider   *_dLineWidthSlider;
    IBOutlet UILabel    *_dLineWidthValueLabel;
    
    IBOutlet UILabel    *_dLineColorLabel;
    IBOutlet UIButton   *_dLineColorButton;
    
    IBOutlet UILabel    *_jLineWidthLabel;
    IBOutlet UISlider   *_jLineWidthSlider;
    IBOutlet UILabel    *_jLineWidthValueLabel;
    
    IBOutlet UILabel    *_jLineColorLabel;
    IBOutlet UIButton   *_jLineColorButton;
}

@property UILabel   *kdjPeriodLabel;
@property UISlider  *kdjPeriodSlider;
@property UILabel   *kdjPeriodValueLabel;

@property UILabel   *kLineWidthLabel;
@property UISlider  *kLineWidthSlider;
@property UILabel   *kLineWidthValueLabel;

@property UILabel   *kLineColorLabel;
@property UIButton  *kLineColorButton;

@property UILabel   *dLineWidthLabel;
@property UISlider  *dLineWidthSlider;
@property UILabel   *dLineWidthValueLabel;

@property UILabel   *dLineColorLabel;
@property UIButton  *dLineColorButton;

@property UILabel   *jLineWidthLabel;
@property UISlider  *jLineWidthSlider;
@property UILabel   *jLineWidthValueLabel;

@property UILabel   *jLineColorLabel;
@property UIButton  *jLineColorButton;

@end
