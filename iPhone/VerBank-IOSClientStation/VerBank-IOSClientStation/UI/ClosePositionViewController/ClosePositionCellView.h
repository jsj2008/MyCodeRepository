//
//  ClosePositionCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/6.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClosePositionCellView : UIView

@property (nonatomic, retain)UILabel *ticketLabel;
@property (nonatomic, retain)UILabel *tradeTimeLabel;
@property (nonatomic, retain)UIView *ticketLabelBackgroundView;

@property (nonatomic, retain)UILabel *instrumentLabel;
@property (nonatomic, retain)UILabel *amountLabel;
@property (nonatomic, retain)UILabel *floatPLLabel;
@property (nonatomic, retain)UIView *instrumentBackgroundView;

@property (nonatomic, retain)UILabel *buyOrSellLabel;
@property (nonatomic, retain)UILabel *closePriceLabel;
@property (nonatomic, retain)UIView *buyOrSellBackgroundView;

@property (nonatomic, retain)UIView *bottomLineView;
@property (nonatomic, retain)UIView *topLineView;

//- (void)setIsSelected:(Boolean)isSelect;
- (void)setIsNeedTopLine:(Boolean)need;
- (void)setIsNeedBottomLine:(Boolean)need;

@end
