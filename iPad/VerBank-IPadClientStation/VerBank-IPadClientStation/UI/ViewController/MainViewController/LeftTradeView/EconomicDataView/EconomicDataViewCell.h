//
//  EconomicDataViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/12.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EconomicDataViewCell : UITableViewCell

@property IBOutlet UILabel *timeLabel;
@property IBOutlet UILabel *countryLabel;

@property IBOutlet UILabel *monthLabel;
@property IBOutlet UILabel *forecastsLabel;
@property IBOutlet UILabel *beforeLabel;

@property IBOutlet UILabel *titleLabel;

@property IBOutlet UIImageView *backImageView;

@property IBOutlet UIButton *actionButton;

@property IBOutlet UILabel *levelLabel;

- (void)setRead:(Boolean)isRead;

@end
