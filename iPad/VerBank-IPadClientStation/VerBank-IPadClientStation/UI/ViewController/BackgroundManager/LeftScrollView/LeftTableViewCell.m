//
//  LeftTableViewCell.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

@synthesize iconView = _iconView;
@synthesize nameLabel = _nameLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
