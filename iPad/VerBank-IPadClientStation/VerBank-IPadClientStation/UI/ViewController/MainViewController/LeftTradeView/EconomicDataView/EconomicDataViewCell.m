//
//  EconomicDataViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/12.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "EconomicDataViewCell.h"
#import "UIFormat.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@implementation EconomicDataViewCell

@synthesize timeLabel;
@synthesize countryLabel;

@synthesize monthLabel;
@synthesize forecastsLabel;
@synthesize beforeLabel;

@synthesize titleLabel;

@synthesize backImageView;

@synthesize actionButton;

@synthesize levelLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
