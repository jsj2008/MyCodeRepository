//
//  HedgingTopNameView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "HedgingTopNameView.h"
#import "LangCaptain.h"

@implementation HedgingTopNameView

@synthesize mainView;
@synthesize ticketLabel;
@synthesize amountLabel;
@synthesize openPriceLabel;
@synthesize closePriceLabel;

- (void)awakeFromNib {
    // Initialization code
    [[NSBundle mainBundle] loadNibNamed:@"HedgingTopNameView" owner:self options:nil];
    [self addSubview:self.mainView];
    [self setDefault];
}

- (void)setDefault {
    [self.mainView          setBackgroundColor:[UIColor blackColor]];
    [self.ticketLabel       setText:[[LangCaptain getInstance] getLangByCode:@"Ticket"]];
    [self.amountLabel       setText:[[LangCaptain getInstance] getLangByCode:@"Amount"]];
    [self.openPriceLabel    setText:[[LangCaptain getInstance] getLangByCode:@"OpenPrice"]];
    [self.closePriceLabel   setText:[[LangCaptain getInstance] getLangByCode:@"CloseAmount"]];
}

@end
