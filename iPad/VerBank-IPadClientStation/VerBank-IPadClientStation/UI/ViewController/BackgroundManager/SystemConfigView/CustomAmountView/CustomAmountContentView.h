//
//  CustomAmountContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"

@interface CustomAmountContentView : LayoutContentView

@property IBOutlet UILabel      *titleLabel;
@property IBOutlet UILabel      *amountLabel;
@property IBOutlet UITextField  *amountTextField;
@property IBOutlet UIButton     *commitButton;
@property IBOutlet UIButton     *cancelButton;

@end
