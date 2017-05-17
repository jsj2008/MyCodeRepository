//
//  OrderHisBackContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"
#import "SelectSliderView.h"
#import "OrderHisTableView.h"

@interface OrderHisBackContentView : LayoutContentView

@property IBOutlet UILabel *titleLabel;
@property IBOutlet SelectSliderView *sliderView;
@property IBOutlet UIView *orderHisTableView;
@property IBOutlet UIButton *backButton;

@end
