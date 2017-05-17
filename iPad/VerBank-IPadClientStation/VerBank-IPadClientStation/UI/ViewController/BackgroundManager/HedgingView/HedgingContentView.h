//
//  HedgingContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"
#import "HedgingSubView.h"
#import "ListenerProtocol.h"

@interface HedgingContentView : LayoutContentView<ListenerProtocol>

@property IBOutlet UILabel          *titleLabel;
@property IBOutlet UILabel          *instrumentLabel;
@property IBOutlet HedgingSubView   *leftHedgingSubView;
@property IBOutlet HedgingSubView   *rightHedgingSubView;
@property IBOutlet UIButton         *commitButton;
@property IBOutlet UIButton         *cancelButton;

- (void)doHedgingTrade;

@end
