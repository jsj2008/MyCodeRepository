//
//  PositionSumTableViewLeftCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionSumTableViewLeftCell : UITableViewCell

@property IBOutlet UILabel *instrumentLabel;
@property IBOutlet UILabel *buySellLabel;
@property IBOutlet UILabel *positionSumLabel;
@property IBOutlet UILabel *floatPLSumLabel;

@property Boolean isAddListener;

@end