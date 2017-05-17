//
//  MessageViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/20.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "MessageViewCell.h"
#import "UIFormat.h"

@implementation MessageViewCell

@synthesize timeLabel;
@synthesize titleLabel;
@synthesize backgroundView;

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setRead:(Boolean)isRead {
    if (isRead) {
        [self.backImageView setImage:[[UIImage alloc] init]];
    } else {
        [self.backImageView setImage:[UIFormat getComplexGrayImageView]];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [UIFormat setCorner:UIRectCornerAllCorners
             WithUIView:self.backImageView
             withCorner:10.0f];
    self.backImageView.layer.cornerRadius = 10.0f;
    self.backImageView.layer.borderWidth = 1.0f;
    self.backImageView.layer.borderColor = [[UIColor whiteColor]CGColor];
}

@end
