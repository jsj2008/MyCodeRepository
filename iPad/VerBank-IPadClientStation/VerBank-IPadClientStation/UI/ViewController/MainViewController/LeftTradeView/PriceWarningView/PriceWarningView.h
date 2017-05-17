//
//  PriceWarningView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftTradeContentView.h"
#import "UIView+ViewFromXib.h"
#import "QuoteView.h"
#import "LHSlideView.h"
#import "ButtonPanelView.h"
#import "TypeDefine.h"
#import "TradeActionProtocol.h"
#import "ValueTimeButton.h"
#import "PriceWarning.h"

@interface PriceWarningView : LeftTradeContentView<TradeActionProtocol>

@property IBOutlet UILabel      *accountLabel;
@property IBOutlet UILabel      *instrumentLabel;
@property IBOutlet UILabel      *timeLabel;

@property IBOutlet QuoteView    *quoteView;
@property IBOutlet LHSlideView  *lhSlideView;

@property IBOutlet UILabel      *pushPriceLabel;
@property IBOutlet UITextField  *pushPriceTextField;

@property IBOutlet UILabel      *valueTimeLabel;
@property IBOutlet ValueTimeButton *valueTimeButton;
@property IBOutlet UIButton     *showTimeButton;

@property IBOutlet ButtonPanelView  *buttonPanelView;

@property NSString *instrumentName;
@property int digist;

- (void)initAddOrModify:(AddOrModifyType)type;
- (void)initWithPriceWarning:(PriceWarning *)priceWarning;
- (void)resetInputValue;
@end
