//
//  OpenOrderOCOView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"
#import "ButtonPanelView.h"
#import "TradeActionProtocol.h"
#import "ValueTimeButton.h"

@interface OpenOrderOCOView : UIView

@property IBOutlet UILabel          *limitPriceLabel;
@property IBOutlet UITextField      *limitPriceTextField;

@property IBOutlet UILabel          *stopPriceLabel;
@property IBOutlet UITextField      *stopPriceTextField;

@property IBOutlet UILabel          *amountLabel;
@property IBOutlet UITextField      *amountTextField;

@property IBOutlet UILabel          *stopMoveLabel;
@property IBOutlet UITextField      *stopMoveTextField;

@property IBOutlet UILabel          *valueTimeLabel;
@property IBOutlet ValueTimeButton  *valueTimeButton;

@property IBOutlet UIButton         *showTimeButton;

@property IBOutlet ButtonPanelView  *buttonPanelView;

//@property IBOutlet UIButton         *commitButton;
//@property IBOutlet UIButton         *cancelButton;

@end
