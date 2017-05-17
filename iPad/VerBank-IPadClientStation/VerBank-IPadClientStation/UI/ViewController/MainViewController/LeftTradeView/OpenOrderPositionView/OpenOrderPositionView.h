//
//  OpenOrderPositionView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/6.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftTradeContentView.h"
#import "QuoteView.h"
#import "CustomSegmentControl.h"
#import "OpenOrderOCOPageView.h"

@interface OpenOrderPositionView : LeftTradeContentView<TradeActionProtocol>

@property IBOutlet UILabel              *accountLabel;
@property IBOutlet UILabel              *instrumentLabel;
@property IBOutlet UILabel              *timeLabel;

@property IBOutlet QuoteView            *quoteView;
@property IBOutlet CustomSegmentControl *segmentControl;
@property IBOutlet OpenOrderOCOPageView *ocoPageView;

@property NSString                      *instrumentName;
@property NSUInteger                    digist;

- (void)doAddOpenOrderTrade;
- (void)doModifyOpenOrderTrade;
- (void)doDelete;

@end
