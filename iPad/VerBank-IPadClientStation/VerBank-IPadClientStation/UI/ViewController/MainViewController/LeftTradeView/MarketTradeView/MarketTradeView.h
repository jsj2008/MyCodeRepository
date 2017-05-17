//
//  OpenPositionView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftTradeContentView.h"
#import "QuoteView.h"
#import "LHSlideView.h"
#import "UIView+ViewFromXib.h"

@interface MarketTradeView : LeftTradeContentView

@property IBOutlet UILabel      *accountLabel;
@property IBOutlet UILabel      *instrumentLabel;
@property IBOutlet UILabel      *timeLabel;

@property IBOutlet QuoteView    *quoteView;
@property IBOutlet LHSlideView  *lhSlideView;

@property IBOutlet UILabel      *amountLabel;
@property IBOutlet UITextField  *amountTextField;
@property IBOutlet UILabel      *marginCallLabel;
@property IBOutlet UIButton     *commitButton;
@property IBOutlet UIButton     *cancelButton;

- (void)doMKTTrade;

@end
