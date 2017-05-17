//
//  PriceWarningTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "PriceWarningTableViewContentCell.h"

@implementation PriceWarningTableViewContentCell

@synthesize statusLabel;
@synthesize priceReachTimeLabel;
@synthesize instrumentLabel;
@synthesize warningPriceLabel;
@synthesize validTypeLabel;
@synthesize validTimeLabel;
@synthesize inputTimeLabel;

@synthesize isAddListener;

- (void)awakeFromNib {
    [self setDefault];
}

- (void)setDefault {
    isAddListener = false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
