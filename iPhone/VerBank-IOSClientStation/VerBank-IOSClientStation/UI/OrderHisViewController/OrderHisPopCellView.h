//
//  OrderHisPopCellView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHisPopCellView : UIView{
    IBOutlet UILabel *_limitPriceNameLabel;
    IBOutlet UILabel *_limitPriceValueLabel;
    IBOutlet UILabel *_ocoLabel;
    IBOutlet UILabel *_stopPriceNameLabel;
    IBOutlet UILabel *_stopPriceValueLabel;
    IBOutlet UILabel *_moveStopNameLabel;
    IBOutlet UILabel *_moveStopValueLabel;
    IBOutlet UILabel *_IDTLimitNameLabel;
    IBOutlet UILabel *_IDTLimitValueLabel;
    IBOutlet UILabel *_IDTStopNameLabel;
    IBOutlet UILabel *_IDTStopValueLabel;
    IBOutlet UILabel *_timeNameLabel;
    IBOutlet UILabel *_timeTypeLabel;
}


@property (nonatomic, retain) UILabel *limitPriceNameLabel;
@property (nonatomic, retain) UILabel *limitPriceValueLabel;
@property (nonatomic, retain) UILabel *ocoLabel;
@property (nonatomic, retain) UILabel *stopPriceNameLabel;
@property (nonatomic, retain) UILabel *stopPriceValueLabel;
@property (nonatomic, retain) UILabel *moveStopNameLabel;
@property (nonatomic, retain) UILabel *moveStopValueLabel;
@property (nonatomic, retain) UILabel *IDTLimitNameLabel;
@property (nonatomic, retain) UILabel *IDTLimitValueLabel;
@property (nonatomic, retain) UILabel *IDTStopNameLabel;
@property (nonatomic, retain) UILabel *IDTStopValueLabel;
@property (nonatomic, retain) UILabel *timeNameLabel;
@property (nonatomic, retain) UILabel *timeTypeLabel;

+ (OrderHisPopCellView *)newInstance;

@end
