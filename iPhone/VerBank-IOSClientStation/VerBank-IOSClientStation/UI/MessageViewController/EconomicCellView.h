//
//  EconomicCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/6/13.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EconomicCellView : UIView

@property IBOutlet UILabel *timeLabel;
@property IBOutlet UILabel *countryLabel;
@property IBOutlet UILabel *monthLabel;
@property IBOutlet UILabel *forecastsLabel;
@property IBOutlet UILabel *beforeLabel;
@property IBOutlet UILabel *titleLabel;

@property IBOutlet UIImageView *backgroundImageView;
@property IBOutlet UIButton *actionButton;

@property IBOutlet UILabel *levelLabel;

+ (EconomicCellView *)newInstance;

@end
