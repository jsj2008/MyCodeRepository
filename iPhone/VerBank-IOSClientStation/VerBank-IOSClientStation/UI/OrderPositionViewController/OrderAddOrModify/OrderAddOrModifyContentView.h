//
//  OrderModifyContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FloatPLStatus.h"
#import "QuoteSegmentControl.h"
#import "ThirdSegmentControl.h"
#import "TOrder.h"

@interface OrderAddOrModifyContentView : UIView {
    IBOutlet FloatPLStatus *_floatPLStatus;
    IBOutlet QuoteSegmentControl *_quoteSegmentControl;
    
    IBOutlet UILabel *_accountLabel;
    IBOutlet UILabel *_instrumentLabel;
    IBOutlet UILabel *_timeLabel;
    
    IBOutlet ThirdSegmentControl *_thirdSegmentControl;
    
    IBOutlet UIView *_limitView;
    IBOutlet UIView *_stopView;
    IBOutlet UIView *_ocoView;
    
    // limitView
    IBOutlet UILabel *_limitPrice_limitLabel;
    IBOutlet UILabel *_amount_limitLabel;
    IBOutlet UILabel *_IDTlimit_limitLabel;
    IBOutlet UILabel *_IDTStop_limitLabel;
    IBOutlet UILabel *_valueTime_limitLabel;
    
    IBOutlet UITextField *_limitPrice_limitField;
    IBOutlet UITextField *_amount_limitField;
    IBOutlet UITextField *_IDTlimit_limitField;
    IBOutlet UITextField *_IDTStop_limitField;
    IBOutlet UIButton *_valueTime_limitButton;
//    IBOutlet UITextField *_valueTime_limitField;
    
    // stopView
    IBOutlet UILabel *_stopPrice_stopLabel;
    IBOutlet UILabel *_amount_stopLabel;
    IBOutlet UILabel *_IDTlimit_stopLabel;
    IBOutlet UILabel *_IDTStop_stopLabel;
    IBOutlet UILabel *_valueTime_stopLabel;
    
    
    IBOutlet UITextField *_stopPrice_stopField;
    IBOutlet UITextField *_amount_stopField;
    IBOutlet UITextField *_IDTlimit_stopField;
    IBOutlet UITextField *_IDTStop_stopField;
//    IBOutlet UITextField *_valueTime_stopField;
    IBOutlet UIButton *_valueTime_stopButton;
    
    // ocoView
    IBOutlet UILabel *_limitPrice_ocoLabel;
    IBOutlet UILabel *_stopPrice_ocoLabel;
    IBOutlet UILabel *_amount_ocoLabel;
    IBOutlet UILabel *_valueTime_ocoLabel;
    
    IBOutlet UITextField *_limitPrice_ocoField;
    IBOutlet UITextField *_stopPrice_ocoField;
    IBOutlet UITextField *_amount_ocoField;
//    IBOutlet UITextField *_valueTime_ocoField;
    IBOutlet UIButton *_valueTime_ocoButton;
    
    TOrder *_order;
    NSString *_instrument;
}

@property (nonatomic, retain) TOrder *order;
@property (nonatomic, retain) NSString *instrument;

@property (nonatomic, retain) FloatPLStatus *floatPLStatus;
@property (nonatomic, retain) QuoteSegmentControl *quoteSegmentControl;

@property (nonatomic, retain) UILabel *accountLabel;
@property (nonatomic, retain) UILabel *instrumentLabel;
@property (nonatomic, retain) UILabel *timeLabel;

@property (nonatomic, retain) ThirdSegmentControl *thirdSegmentControl;

@property (nonatomic, retain) UIView *limitView;
@property (nonatomic, retain) UIView *stopView;
@property (nonatomic, retain) UIView *ocoView;

// limitView
@property (nonatomic, retain) UILabel *limitPrice_limitLabel;
@property (nonatomic, retain) UILabel *amount_limitLabel;
@property (nonatomic, retain) UILabel *IDTlimit_limitLabel;
@property (nonatomic, retain) UILabel *IDTStop_limitLabel;
@property (nonatomic, retain) UILabel *valueTime_limitLabel;

@property (nonatomic, retain) UITextField *limitPrice_limitField;
@property (nonatomic, retain) UITextField *amount_limitField;
@property (nonatomic, retain) UITextField *IDTlimit_limitField;
@property (nonatomic, retain) UITextField *IDTStop_limitField;
//@property (nonatomic, retain) UITextField *valueTime_limitField;
@property (nonatomic, retain) UIButton *valueTime_limitButton;

// stopView
@property (nonatomic, retain) UILabel *stopPrice_stopLabel;
@property (nonatomic, retain) UILabel *amount_stopLabel;
@property (nonatomic, retain) UILabel *IDTlimit_stopLabel;
@property (nonatomic, retain) UILabel *IDTStop_stopLabel;
@property (nonatomic, retain) UILabel *valueTime_stopLabel;

@property (nonatomic, retain) UITextField *stopPrice_stopField;
@property (nonatomic, retain) UITextField *amount_stopField;
@property (nonatomic, retain) UITextField *IDTlimit_stopField;
@property (nonatomic, retain) UITextField *IDTStop_stopField;
//@property (nonatomic, retain) UITextField *valueTime_stopField;
@property (nonatomic, retain) UIButton *valueTime_stopButton;

// ocoView
@property (nonatomic, retain) UILabel *limitPrice_ocoLabel;
@property (nonatomic, retain) UILabel *stopPrice_ocoLabel;
@property (nonatomic, retain) UILabel *amount_ocoLabel;
@property (nonatomic, retain) UILabel *valueTime_ocoLabel;

@property (nonatomic, retain) UITextField *limitPrice_ocoField;
@property (nonatomic, retain) UITextField *stopPrice_ocoField;
@property (nonatomic, retain) UITextField *amount_ocoField;
//@property (nonatomic, retain) UITextField *valueTime_ocoField;
@property (nonatomic, retain) UIButton *valueTime_ocoButton;

+ (OrderAddOrModifyContentView *)newInstance;
//- (void)addKChartView;

- (void)addListener;
- (void)removeListener;

@end
