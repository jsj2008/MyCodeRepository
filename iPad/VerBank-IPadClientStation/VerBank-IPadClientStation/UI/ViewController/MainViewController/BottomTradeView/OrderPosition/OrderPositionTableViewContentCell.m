//
//  OrderPositionTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderPositionTableViewContentCell.h"

@implementation OrderPositionTableViewContentCell

@synthesize limitPriceLabel;
@synthesize stopPriceLabel;
@synthesize IDTLimitPriceLabel;
@synthesize IDTStopPriceLabel;
@synthesize valueTimeTypeLabel;
@synthesize valueEndTimeLabel;
@synthesize orderTimeLabel;
@synthesize ticketLabel;

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
