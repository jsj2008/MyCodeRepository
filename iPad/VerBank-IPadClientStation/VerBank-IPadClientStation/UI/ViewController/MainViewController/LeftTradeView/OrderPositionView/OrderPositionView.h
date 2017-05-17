//
//  OrderPositionView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftTradeContentView.h"
#import "QuoteView.h"
#import "CustomSegmentControl.h"
#import "OrderOCOPageView.h"
#import "TradeActionProtocol.h"

@interface OrderPositionView : LeftTradeContentView<TradeActionProtocol>

@property IBOutlet UILabel              *accountLabel;
@property IBOutlet UILabel              *instrumentLabel;
@property IBOutlet UILabel              *timeLabel;

@property IBOutlet QuoteView            *quoteView;
@property IBOutlet CustomSegmentControl *segmentControl;
@property IBOutlet OrderOCOPageView     *ocoPageView;

@property NSString *instrumentName;
@property NSUInteger digist;

- (void)doAddOrderTrade;
- (void)doModifyOrderTrade;
- (void)doDelete;

@end
