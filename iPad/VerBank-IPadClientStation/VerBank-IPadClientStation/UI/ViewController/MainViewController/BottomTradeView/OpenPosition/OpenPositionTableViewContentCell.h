//
//  OpenPositionTableViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenPositionTableViewContentCell : UITableViewCell

//@property IBOutlet UILabel *instrumentLabel;
//@property IBOutlet UILabel *buySellLabel;
//@property IBOutlet UILabel *amountLabel;
//@property IBOutlet UILabel *dealPriceLabel;
@property IBOutlet UILabel *marginRateLabel;
@property IBOutlet UILabel *limitPriceOrderLabel;
@property IBOutlet UILabel *stopPriceOrderLabel;
@property IBOutlet UILabel *stopMovePriceLabel;
@property IBOutlet UILabel *floatPLOriLabel;
@property IBOutlet UILabel *floatPLDollarLabel;
@property IBOutlet UILabel *openTimeLabel;
@property IBOutlet UILabel *ticketLabel;

@property Boolean isAddListener;


@end
