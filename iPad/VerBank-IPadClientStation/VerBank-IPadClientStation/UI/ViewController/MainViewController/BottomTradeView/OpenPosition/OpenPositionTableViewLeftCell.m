//
//  OpenPositionLeftTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenPositionTableViewLeftCell.h"

@implementation OpenPositionTableViewLeftCell

@synthesize instrumentLabel;
@synthesize buySellLabel;
@synthesize dealPriceLabel;
@synthesize amountLabel;

@synthesize isAddListener;

- (void)awakeFromNib {
    // Initialization code
    [self setDefault];
}

- (void)setDefault {
    self.isAddListener = false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
