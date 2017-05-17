//
//  LimitView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFromXib.h"

#import "ButtonPanelView.h"
#import "ValueTimeButton.h"

@interface OrderLimitView : UIView

@property IBOutlet UILabel          *limitPriceLabel;
@property IBOutlet UITextField      *limitPriceTextField;

@property IBOutlet UILabel          *amountLabel;
@property IBOutlet UITextField      *amountTextField;

@property IBOutlet UILabel          *idtLimitLabel;
@property IBOutlet UITextField      *idtLimitTextField;

@property IBOutlet UILabel          *idtStopLabel;
@property IBOutlet UITextField      *idtStopTextField;

@property IBOutlet UILabel          *valueTimeLabel;
@property IBOutlet ValueTimeButton  *valueTimeButton;

@property IBOutlet UIButton         *showTimeButton;

@property IBOutlet ButtonPanelView  *buttonPanelView;
//@property IBOutlet UIButton         *commitButton;
//@property IBOutlet UIButton         *cancelButton;


@end
