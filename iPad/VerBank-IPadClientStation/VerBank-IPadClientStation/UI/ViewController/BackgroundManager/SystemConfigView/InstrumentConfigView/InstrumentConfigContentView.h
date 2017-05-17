//
//  InstrumentConfigContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"
#import "ReorderTableView.h"

@interface InstrumentConfigContentView : LayoutContentView

@property IBOutlet UILabel          *titleLabel;

@property IBOutlet UIButton         *backButton;

@property IBOutlet UIButton         *leftButton;
@property IBOutlet UIButton         *middleButton;
@property IBOutlet UIButton         *rightButton;
@property IBOutlet ReorderTableView *reorderView;

@end
