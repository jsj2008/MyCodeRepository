//
//  ClosePositionHisBackContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"
#import "SelectSliderView.h"
#import "ClosePositionTableView.h"

@interface ClosePositionHisBackContentView : LayoutContentView

@property IBOutlet UILabel *titleLabel;
@property IBOutlet SelectSliderView *sliderView;
@property IBOutlet UIView *closePositionTableView;
@property IBOutlet UILabel *positionSumNameLabel;
@property IBOutlet UILabel *positionSumValueLabel;
@property IBOutlet UILabel *fillLabel;
@property IBOutlet UIButton *backButton;


@end
