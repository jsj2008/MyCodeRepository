//
//  OpenPositionTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OpenPositionTableViewContentCell.h"

@implementation OpenPositionTableViewContentCell

//@synthesize instrumentLabel;
//@synthesize buySellLabel;
//@synthesize amountLabel;
//@synthesize dealPriceLabel;
@synthesize marginRateLabel;
@synthesize limitPriceOrderLabel;
@synthesize stopPriceOrderLabel;
@synthesize stopMovePriceLabel;
@synthesize floatPLOriLabel;
@synthesize floatPLDollarLabel;
@synthesize openTimeLabel;
@synthesize ticketLabel;

@synthesize isAddListener;

- (void)awakeFromNib {
    // Initialization code
    self.isAddListener = false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
