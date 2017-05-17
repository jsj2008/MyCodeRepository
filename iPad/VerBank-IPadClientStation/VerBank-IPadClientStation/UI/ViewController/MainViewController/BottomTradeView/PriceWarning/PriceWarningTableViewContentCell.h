//
//  PriceWarningTableViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceWarningTableViewContentCell : UITableViewCell

@property IBOutlet UILabel *statusLabel;
@property IBOutlet UILabel *priceReachTimeLabel;
@property IBOutlet UILabel *instrumentLabel;
@property IBOutlet UILabel *warningPriceLabel;
@property IBOutlet UILabel *validTypeLabel;
@property IBOutlet UILabel *validTimeLabel;
@property IBOutlet UILabel *inputTimeLabel;

@property Boolean isAddListener;

@end
