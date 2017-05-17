//
//  MAContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiSuperContentView.h"

@interface MAContentView : TiSuperContentView {
    IBOutlet UILabel    *_periodLabel;
    IBOutlet UISlider   *_periodSlider;
    IBOutlet UILabel    *_periodValueLabel;
    IBOutlet UIStepper  *_periodSteper;
    
    IBOutlet UILabel    *_lineWidthLabel;
    IBOutlet UISlider   *_lineWidthSlider;
    IBOutlet UILabel    *_lineWidthValueLabel;
    
    IBOutlet UILabel    *_colorLabel;
    IBOutlet UIButton   *_colorPickButton;
}

@property UILabel *periodLabel;
@property UISlider *periodSlider;
@property UILabel *periodValueLabel;

@property UILabel *lineWidthLabel;
@property UISlider *lineWidthSlider;
@property UILabel *lineWidthValueLabel;

@property UILabel *colorLabel;
@property UIButton *colorPickButton;
@property UIStepper *periodSteper;

@end
