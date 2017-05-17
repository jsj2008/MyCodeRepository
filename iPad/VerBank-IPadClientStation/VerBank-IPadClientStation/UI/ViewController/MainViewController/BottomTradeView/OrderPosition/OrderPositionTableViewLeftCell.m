//
//  OrderPositionTableViewLeftCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderPositionTableViewLeftCell.h"

@implementation OrderPositionTableViewLeftCell

@synthesize instrumentLabel;
@synthesize buySellLabel;
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
