//
//  OrderPositionTableViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPositionTableViewContentCell : UITableViewCell

@property IBOutlet UILabel *limitPriceLabel;
@property IBOutlet UILabel *stopPriceLabel;
@property IBOutlet UILabel *IDTLimitPriceLabel;
@property IBOutlet UILabel *IDTStopPriceLabel;
@property IBOutlet UILabel *valueTimeTypeLabel;
@property IBOutlet UILabel *valueEndTimeLabel;
@property IBOutlet UILabel *orderTimeLabel;
@property IBOutlet UILabel *ticketLabel;

@property Boolean isAddListener;

@end
