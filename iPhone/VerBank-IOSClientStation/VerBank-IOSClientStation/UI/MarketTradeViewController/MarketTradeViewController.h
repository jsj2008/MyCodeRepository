//
//  MarketTradeViewController.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LeftViewController.h"



@interface MarketTradeViewController : LeftViewController

+ (void)setInstrumentName:(NSString *)instrument;
+ (void)setBuySell:(int)buySell;

@end
