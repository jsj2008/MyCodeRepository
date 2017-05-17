//
//  KChartToolBar.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/9.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarChooseView.h"

const static CGFloat KChartToolBarHeight = 40.0f;

@interface KChartToolBar : UIView

@property UIButton *backButton;
@property UIButton *kChartTypeButton;
@property UIButton *cycleTypeButton;
@property UIButton *technologyTypeButton;
@property UIButton *clearAllButton;
@property UIButton *drawLineButton;
@property UIButton *addOrderButton;

@property ToolBarChooseView *chooseView;

@end
