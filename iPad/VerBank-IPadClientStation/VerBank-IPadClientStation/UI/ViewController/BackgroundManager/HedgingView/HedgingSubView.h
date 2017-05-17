//
//  HedgingSubView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HedgingType) {
    HedgingTypeSell= 0,
    HedgingTypeBuy = 1,
    
};

@interface HedgingSubView : UIView

@property IBOutlet UIView       *mainView;
@property IBOutlet UILabel      *buySellLabel;
@property IBOutlet UITableView  *openPositionTableView;
@property IBOutlet UIView       *topNameView;
@property IBOutlet UILabel      *sumValueLabel;
@property IBOutlet UILabel      *bottomBuySellLabel;

@property IBOutlet UIView       *keyboardView;

//@property (nonatomic) HedgingType hedgingType;
- (void)setHedgingType:(HedgingType)hedgingType;

- (void)reloadDataByNotify:(Boolean)isNotify;

- (NSArray *)getTradeArray;

- (double)getSumAmount;

- (Boolean)isRemainLegal;

- (Boolean)checkAmount;

@end
