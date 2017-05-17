//
//  DataPickContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"
#import "ValueTimeButton.h"
#import "DatePickPanel.h"

@interface DatePickContentView : LayoutContentView

@property IBOutlet UILabel          *titleLabel;
@property IBOutlet DatePickPanel    *datePickPanel;
@property IBOutlet UIButton         *okButton;

@end
