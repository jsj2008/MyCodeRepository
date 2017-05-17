//
//  MarginCallHisViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/5/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MarginCallHisViewCell.h"

@implementation MarginCallHisViewCell

@synthesize accountLabel;
@synthesize timeLabel;
@synthesize typeLabel;
@synthesize amountLabel;

- (void)awakeFromNib {
    [self.contentView setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
