//
//  OrderPositionCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPositionCellView : UIView{
    IBOutlet UILabel *_ticketLabel;
    IBOutlet UILabel *_typeLabel;
    IBOutlet UILabel *_timeLabel;
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_tradeDirLabel;
    IBOutlet UILabel *_amountLabel;
    
    IBOutlet UIView  *_limitPriceView;
    
    IBOutlet UILabel *_limitNameLabel;
    IBOutlet UILabel *_limitPriceLabel;
    IBOutlet UILabel *_ocoLabel;
    IBOutlet UILabel *_stopNameLabel;
    IBOutlet UILabel *_stopPriceLabel;
    IBOutlet UILabel *_stopMoveNameLabel;
    IBOutlet UILabel *_stopMoveValueLabel;
    IBOutlet UILabel *_limitDistanceLabel;
    IBOutlet UILabel *_stopDistanceLabel;
    IBOutlet UILabel *_IDTLimitNameLabel;
    IBOutlet UILabel *_IDTLimitValueLabel;
    IBOutlet UILabel *_IDTStopNameLabel;
    IBOutlet UILabel *_IDTStopValueLabel;
    
//    IBOutlet UILabel *_marketPrice;
}

@property (nonatomic, retain) UILabel *ticketLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *typeLabel;
@property (nonatomic, retain) UILabel *instrumentLabel;
@property (nonatomic, retain) UILabel *tradeDirLabel;
@property (nonatomic, retain) UILabel *amountLabel;

@property (nonatomic, retain) UIView  *limitPriceView;

@property (nonatomic, retain) UILabel *limitNameLabel;
@property (nonatomic, retain) UILabel *limitPriceLabel;
@property (nonatomic, retain) UILabel *ocoLabel;
@property (nonatomic, retain) UILabel *stopNameLabel;
@property (nonatomic, retain) UILabel *stopPriceLabel;
@property (nonatomic, retain) UILabel *stopMoveNameLabel;
@property (nonatomic, retain) UILabel *stopMoveValueLabel;
@property (nonatomic, retain) UILabel *limitDistanceLabel;
@property (nonatomic, retain) UILabel *stopDistanceLabel;
@property (nonatomic, retain) UILabel *IDTLimitNameLabel;
@property (nonatomic, retain) UILabel *IDTLimitValueLabel;
@property (nonatomic, retain) UILabel *IDTStopNameLabel;
@property (nonatomic, retain) UILabel *IDTStopValueLabel;

//@property (nonatomic, retain) UILabel *marketPrice;

+ (OrderPositionCellView *)newInstance;

@end
