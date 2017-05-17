//
//  PositionSumTableViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionSumTableViewContentCell : UITableViewCell

@property IBOutlet UILabel *buyAmountLabel;
@property IBOutlet UILabel *buyAvgLabel;
@property IBOutlet UILabel *buyFloatPLLabel;
@property IBOutlet UILabel *sellMKTPriceLabel;

@property IBOutlet UILabel *sellAmountLabel;
@property IBOutlet UILabel *sellAvgLabel;
@property IBOutlet UILabel *sellFloatPLLabel;
@property IBOutlet UILabel *buyMKTPriceLabel;

@property Boolean isAddListener;

@end
