//
//  PositionSumTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PositionSumTableViewContentCell.h"

@implementation PositionSumTableViewContentCell

@synthesize buyAmountLabel;
@synthesize buyAvgLabel;
@synthesize buyFloatPLLabel;
@synthesize sellMKTPriceLabel;

@synthesize sellAmountLabel;
@synthesize sellAvgLabel;
@synthesize sellFloatPLLabel;
@synthesize buyMKTPriceLabel;

@synthesize isAddListener;

- (void)awakeFromNib {
    [self setDefault];
}

- (void)setDefault {
    self.isAddListener = false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
