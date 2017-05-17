//
//  ClosePositionContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/31.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"
#import "ListenerProtocol.h"

@interface ClosePositionContentView : LayoutContentView<ListenerProtocol>

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *instrumentLabel;
@property IBOutlet UILabel *amountLabel;
@property IBOutlet UILabel *buySellLabel;
@property IBOutlet UILabel *priceLabel;

@property IBOutlet UIButton *commitButton;
@property IBOutlet UIButton *cancelButton;

- (void)doCloseTrade;

@end
