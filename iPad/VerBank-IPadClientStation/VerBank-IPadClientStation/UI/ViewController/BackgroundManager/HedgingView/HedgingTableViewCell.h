//
//  HedgingTableViewCell.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKeyboardView.h"

@interface HedgingTableViewCell : UITableViewCell

@property IBOutlet UILabel *ticketLabel;
@property IBOutlet UILabel *amountLabel;
@property IBOutlet UILabel *openPriceLabel;
@property IBOutlet UITextField *openAmountTextField;

@property ZLKeyboardView *inputView;

@property Boolean isAddListener;

@end
