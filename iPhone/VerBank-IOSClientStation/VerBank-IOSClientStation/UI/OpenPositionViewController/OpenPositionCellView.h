//
//  OpenPositionCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenPositionCellView : UIView

@property (nonatomic, retain)UILabel *ticketLabel;
@property (nonatomic, retain)UILabel *tradeTimeLabel;
@property (nonatomic, retain)UIView *ticketLabelBackgroundView;

@property (nonatomic, retain)UILabel *instrumentLabel;
@property (nonatomic, retain)UILabel *amountLabel;
@property (nonatomic, retain)UILabel *floatPLLabel;
@property (nonatomic, retain)UIView *instrumentBackgroundView;

@property (nonatomic, retain)UILabel *buyOrSellLabel;
@property (nonatomic, retain)UILabel *openPriceLabel;
@property (nonatomic, retain)UILabel *mktPriceLabel;
@property (nonatomic, retain)UIView *buyOrSellBackgroundView;

@property (nonatomic, retain)UILabel *limitPriceLabel;
@property (nonatomic, retain)UILabel *stopPriceLabel;
@property (nonatomic, retain)UILabel *moveStopPriceLabel;
@property (nonatomic, retain)UIButton *priceBackgroundButton;

@property (nonatomic, retain)UIView *bottomLineView;
@property (nonatomic, retain)UIView *topLineView;

@property (nonatomic, retain)UIView *leftClickView;
@property (nonatomic, retain)UIView *rightClickView;
//- (void)setIsSelected:(Boolean)isSelect;

@end
