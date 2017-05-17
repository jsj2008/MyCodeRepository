//
//  EconomicCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/6/13.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "EconomicCellView.h"

@implementation EconomicCellView

@synthesize timeLabel;
@synthesize countryLabel;
@synthesize monthLabel;
@synthesize forecastsLabel;
@synthesize beforeLabel;
@synthesize titleLabel;

@synthesize backgroundImageView;
@synthesize actionButton;

@synthesize levelLabel;

+ (EconomicCellView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EconomicCellView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

@end
