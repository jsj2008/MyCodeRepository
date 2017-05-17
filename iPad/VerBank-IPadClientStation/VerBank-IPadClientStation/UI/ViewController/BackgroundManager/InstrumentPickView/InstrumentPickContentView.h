//
//  InstrumentPickContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"

@interface InstrumentPickContentView : LayoutContentView

@property IBOutlet UILabel      *titleLabel;
@property IBOutlet UIPickerView *pickerView;
@property IBOutlet UIButton     *okButton;

@property NSArray *instrumentArray;

@end
